Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E60C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2767220829
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICR5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:57:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64673 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICR5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:57:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bj7mX08rVz9vG1Z;
        Thu,  3 Sep 2020 19:57:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id czc54Tj7o-AE; Thu,  3 Sep 2020 19:56:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bj7mW6QXJz9vG1Y;
        Thu,  3 Sep 2020 19:56:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB9F48B805;
        Thu,  3 Sep 2020 19:57:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GvL1dM65fFS4; Thu,  3 Sep 2020 19:57:01 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6350C8B803;
        Thu,  3 Sep 2020 19:57:01 +0200 (CEST)
Subject: Re: [PATCH] /dev/zero: also implement ->read
To:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20200903155922.1111551-1-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1bc34841-f1a3-8a9b-cb48-10930ec55d71@csgroup.eu>
Date:   Thu, 3 Sep 2020 19:51:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903155922.1111551-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2020 à 17:59, Christoph Hellwig a écrit :
> Christophe reported a major speedup due to avoiding the iov_iter
> overhead, so just add this trivial function.  Note that /dev/zero
> already implements both an iter and non-iter writes so this just
> makes it more symmetric.
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/char/mem.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index abd4ffdc8cdebc..1dc99ab158457a 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -726,6 +726,27 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
>   	return written;
>   }
>   
> +static ssize_t read_zero(struct file *file, char __user *buf,
> +			 size_t count, loff_t *ppos)
> +{
> +	size_t cleared = 0;
> +
> +	while (count) {
> +		size_t chunk = min_t(size_t, count, PAGE_SIZE);
> +
> +		if (clear_user(buf + cleared, chunk))
> +			return cleared ? cleared : -EFAULT;
> +		cleared += chunk;
> +		count -= chunk;
> +
> +		if (signal_pending(current))
> +			return cleared ? cleared : -ERESTARTSYS;
> +		cond_resched();
> +	}
> +
> +	return cleared;
> +}
> +
>   static int mmap_zero(struct file *file, struct vm_area_struct *vma)
>   {
>   #ifndef CONFIG_MMU
> @@ -921,6 +942,7 @@ static const struct file_operations zero_fops = {
>   	.llseek		= zero_lseek,
>   	.write		= write_zero,
>   	.read_iter	= read_iter_zero,
> +	.read		= read_zero,

Wondering if .read should be before .write, so that we get in order 
read, write, read_iter, write_iter.

>   	.write_iter	= write_iter_zero,
>   	.mmap		= mmap_zero,
>   	.get_unmapped_area = get_unmapped_area_zero,
> 

Christophe
