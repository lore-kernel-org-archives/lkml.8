Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DC4207FB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593620181;
	bh=biSVuLSqQZyLre5EwX6Uvz2QqPXPFeUjqpSTrZwznjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qend+hzeoBKZSvv/3DdgDIx2ouEn1uxyxpALyfu6IrT4T14cRM9hUTGpT4e6baRKt
	 PR8SmlKJceQZVCIM4Eche4SCt5HPR5WbdGB1Al/a9Ydy2gh06/ObLFKFLQuzUhjVDd
	 cBWiUIl+h4NJqZSd3phcYYaWP/45p5dPv3zJ23cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgGAQQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbgGAQQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:16:19 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C0220760;
        Wed,  1 Jul 2020 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593620179;
        bh=biSVuLSqQZyLre5EwX6Uvz2QqPXPFeUjqpSTrZwznjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vTOyYkkPatGqGjoHMBGchOV0BardXrrM+BzIJEzXyQxiNomH2hqFL2adPpq6OToav
         Cf2JycIVfByZm7leXmWxcjfCQHnOaRQDOa5CBFXvCuj4Pu3DiTem2Pit5CeT+gq328
         HZZbrDbvyOd0P2PBditYnnsoA2OQILBqdy6qMKJw=
Date:   Wed, 1 Jul 2020 09:16:18 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     hulkcommits@huawei.com, Chao Yu <chao@kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] f2fs: make __allocate_new_segment() static
Message-ID: <20200701161618.GC1724572@google.com>
References: <20200701152858.50516-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701152858.50516-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01, Wei Yongjun wrote:
> From: Hulk Robot <hulkci@huawei.com>
> 
> From: Hulk Robot <hulkci@huawei.com>
> 
> Fix sparse build warning:
> 
> fs/f2fs/segment.c:2736:6: warning:
>  symbol '__allocate_new_segment' was not declared. Should it be static?

It was fixed.
https://lore.kernel.org/linux-f2fs-devel/20200701042222.GA1539525@google.com/T/#m9667447e4d37672e26dee7e30896d129eac1c479

> 
> Signed-off-by: Hulk Robot <hulkci@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45e473508a9..c35614d255e1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2733,7 +2733,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>  	up_read(&SM_I(sbi)->curseg_lock);
>  }
>  
> -void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
> +static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>  	unsigned int old_segno;
