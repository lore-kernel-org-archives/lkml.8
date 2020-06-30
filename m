Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B57206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWxbFf0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgF3Unv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgF3Unv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:43:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:43:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so8962983plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2xmefk2RteGTnbCye5bI/kRpYMG9zcRY+jbKjm732i0=;
        b=oWxbFf0dWEbKgf1ijqpkDLiaARpUgLO8Yms473N+ftU2hDK0S7Sg+q1MAZbJrbqDwl
         jRk2EiiRBLa7Fpj/uVMGQYoaEVbAfTXeZIPTdL/EzyFcaSvbMX1/WphEUbAfY55+YDPH
         wW4P7EuEl7iVQRhv6g3EadgIvwbFLfBY7ChCox/euQHzbuVk3hFGuXFCte+KLZZvZJd3
         hByPirK0qMX9hPHHHtvniYveX8u+MFuE96iCRhrnGQUAqXP8jfUASfvJdIjePM9Uplb4
         sU7nkYBxfpxH20++z8JHxiWwovrmTmEMXjPOZa7ywL45+LN29uFh+jEvjZ8zt54IL30V
         A5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2xmefk2RteGTnbCye5bI/kRpYMG9zcRY+jbKjm732i0=;
        b=gMChKrrWC5yuv/sWqiFvEFsH+R9yspQ7GEo8Eay0c/GNzKI72ppx45iPg34Q2u5kkI
         xlgViVyB8SJiTnWWbXFNS2o7dH8BjNlUUo2cwnPHFsF2lcXo1M07pJiI7b4r0PMn5sY1
         ZjbQWDKfjph+7juylhrjp+FW2SAaPV4NMMxroFIzKmjJLU77zuxkUmbwKT3/P1+/kSn5
         cJFJa3xkXmJImItqmWX/WtFHqfV/wiR9LsQ0oJowqcLCyRBnW30IIOhTuGlHFRTaBMsM
         F6uw66e/IDQrTTSrUvPqMYAS0vN496i/SST2QSXK1tMAwSFWVFhhUeEUwyMpnJtrdEgZ
         PD4w==
X-Gm-Message-State: AOAM532vMyr3etUCS6dlAeIgmIKZn40VAfzgMIvQY8NNkwpYi3I9XDHo
        zOVKcHD6GdQeQga9EjCa23U=
X-Google-Smtp-Source: ABdhPJyp+Ru6ZTl+M+JBG/QDbjnICiMjZXWHbVDoVlJcwTyylQKOvHvvsr3TjHrICMJ6rQMGQTc6lQ==
X-Received: by 2002:a17:90a:fd12:: with SMTP id cv18mr17159212pjb.66.1593549830267;
        Tue, 30 Jun 2020 13:43:50 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id ia13sm3047342pjb.42.2020.06.30.13.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:43:49 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:43:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid readahead race condition
Message-ID: <20200630204348.GA2504307@ubuntu-s3-xlarge-x86>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
 <20200629202720.GA230664@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629202720.GA230664@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 01:27:20PM -0700, Jaegeuk Kim wrote:
> If two readahead threads having same offset enter in readpages, every read
> IOs are split and issued to the disk which giving lower bandwidth.
> 
> This patch tries to avoid redundant readahead calls.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v3:
>  - use READ|WRITE_ONCE
> v2:
>   - add missing code to bypass read
>  
>  fs/f2fs/data.c  | 18 ++++++++++++++++++
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/super.c |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 995cf78b23c5e..360b4c9080d97 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2296,6 +2296,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  	unsigned nr_pages = rac ? readahead_count(rac) : 1;
>  	unsigned max_nr_pages = nr_pages;
>  	int ret = 0;
> +	bool drop_ra = false;
>  
>  	map.m_pblk = 0;
>  	map.m_lblk = 0;
> @@ -2306,10 +2307,24 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  	map.m_seg_type = NO_CHECK_TYPE;
>  	map.m_may_create = false;
>  
> +	/*
> +	 * Two readahead threads for same address range can cause race condition
> +	 * which fragments sequential read IOs. So let's avoid each other.
> +	 */
> +	if (rac && readahead_count(rac)) {
> +		if (READ_ONCE(F2FS_I(inode)->ra_offset) == readahead_index(rac))
> +			drop_ra = true;
> +		else
> +			WRITE_ONCE(F2FS_I(inode)->ra_offset,
> +						readahead_index(rac));
> +	}
> +
>  	for (; nr_pages; nr_pages--) {
>  		if (rac) {
>  			page = readahead_page(rac);
>  			prefetchw(&page->flags);
> +			if (drop_ra)
> +				goto next_page;

When CONFIG_F2FS_FS_COMPRESSION is not set (i.e. x86_64 defconfig +
CONFIG_F2FS_FS=y):

$ make -skj"$(nproc)" O=out distclean defconfig fs/f2fs/data.o
../fs/f2fs/data.c: In function ‘f2fs_mpage_readpages’:
../fs/f2fs/data.c:2327:5: error: label ‘next_page’ used but not defined
 2327 |     goto next_page;
      |     ^~~~
...

Cheers,
Nathan
