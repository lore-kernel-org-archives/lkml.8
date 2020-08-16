Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CADB20829
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aEz9nrCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgHPRfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHPRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:35:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C1C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DLYaepasdAjeb5hNRfAs0VZ5YHZCwzeLettMOwN8AHI=; b=aEz9nrCheqHQE/gVFCLAm73c0w
        qcaCdnPks7A+2ILLxH52KbdpfYb7q+K+XZKNvh7NsFhlVjHdPfXoLvWF4xDYFljU25tS8Ow1s3MJb
        6TKgQEdAskl7OnHszwhJ+4pkbB0lArHPkO8Q/OrtGXuB+/vpEfOnzNyudK+GH6TPHnCalvTucpfsn
        ZipVfQ9jPM2ckon2gMi6uJvSnMFJn6KFmOzhKeEW9NHiT8UV6Ddr8Tc1a3h/kK8JutsrmMaBpRuI7
        /XsGPt7ejMW1nTH7JGed3ih9zy9f5tbdf+wqPTArC/e4+rlgiKw02Fiizq0SjL8iptJvZ4lM/TOeG
        Y9ZzpC1Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7MYa-00088L-Cr; Sun, 16 Aug 2020 17:34:57 +0000
Subject: Re: [PATCH 3/3] staging: androind: Convert BUG() to WARN()
To:     Tomer Samara <tomersamara98@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
References: <cover.1597597955.git.tomersamara98@gmail.com>
 <8df6206000524d4a0043a7a1df97b2be2d277995.1597597955.git.tomersamara98@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <df5e2206-51be-3fc7-ddc2-6f318a8e5a1a@infradead.org>
Date:   Sun, 16 Aug 2020 10:34:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8df6206000524d4a0043a7a1df97b2be2d277995.1597597955.git.tomersamara98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 10:22 AM, Tomer Samara wrote:
> replace BUG() with WARN() at ion_sytem_heap.c, this
> fix the following checkpatch issue:
> Avoid crashing the kernel - try using WARN_ON &
> recovery code ratherthan BUG() or BUG_ON().
> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index eac0632ab4e8..37065a59ca69 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -30,7 +30,8 @@ static int order_to_index(unsigned int order)
>  	for (i = 0; i < NUM_ORDERS; i++)
>  		if (order == orders[i])
>  			return i;
> -	BUG();
> +
> +	WARN(1, "%s: Did not found index to order %d", __FUNCTION__, order);
>  	return -1;
>  }

Hi,
Did you look at what happens when order_to_index() returns -1
to its callers?


Also: fix spelling in Subjects: android and BUG/BUG_ON

-- 
~Randy

