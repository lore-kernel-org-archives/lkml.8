Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F3AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF365206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkluO687"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgEVXGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731212AbgEVXGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:06:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87468C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:06:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so5646700pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UDBJnpqs4guG2IKDR9m4vwvwiE5N+bg36FfcwvVlz2A=;
        b=mkluO687LVso/dsC1rAI/gRjJi44aU9fK2VWzOqz1zxKu2QZSL8xaI403RjCISmRJ8
         JL309NjnkbwPYTR79HFfVd/pRry+bzc/kwrEu+0aHHAPGcRutbjCp24Q5y/i7T4Vim1i
         oGv12zFZoKpcjMN5d3+GI21cq992zWMqViN3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDBJnpqs4guG2IKDR9m4vwvwiE5N+bg36FfcwvVlz2A=;
        b=CAsmnUVzGJAJQGEHRdrUERSocUAWJsUfVTTIPRBKa9f8op8OR/EX/wjaXjyUjNgcW8
         neHYP8/BS1CS1DaTvNnOfPf5pNNmhuOZX1AE3LJTIZMDuFpPhdEl/gjTkZW6l6rFCPyN
         mMhzVG6hIyKmPleDfFDeHrD/D58765OazxaJuK1xx552K8xwEED5EU/FeHAntJMw9mEd
         WhujUFvqt+Mv2h5tU842lTaW+Zye0Yde0gYFtaCymMv3LySkf6Jk/ZHXu8K6gTI2LlM1
         5YmMIEaHEkUklHJgWakEVSfW47wSOUnrg1e8J+8BV+NLpIDRv1bOw9cHDMbmy6wHbcMD
         d7AA==
X-Gm-Message-State: AOAM533qWoPJ//nYyKdmiXohY45Cj8JxU9nfi4ZqATX4/iujfkuFv4tj
        6V8QT+rhBNjZbIijyD1AB3/Aiq/D19IhSw==
X-Google-Smtp-Source: ABdhPJzp4FkAxbHTFWvBoWFS3oqPj6uFB0meF12cnXnWnjlJgcZ7qGqSIAEIBNTj56dt1R7JL5bBOA==
X-Received: by 2002:a17:90a:8b83:: with SMTP id z3mr7242680pjn.212.1590188800000;
        Fri, 22 May 2020 16:06:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i25sm7889358pfd.45.2020.05.22.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:06:39 -0700 (PDT)
Date:   Fri, 22 May 2020 16:06:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.orgCc:linux-kernel"@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] xfs: Replace one-element arrays with flexible-array
 members
Message-ID: <202005221606.A1647A0@keescook>
References: <20200522215542.GA18898@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522215542.GA18898@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 04:55:42PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
> 
> This issue was found with the help of Coccinelle and audited
> _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_log_format.h | 12 ++++++------
>  fs/xfs/xfs_extfree_item.c      | 18 +++++++++---------
>  fs/xfs/xfs_ondisk.h            |  8 ++++----
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
> index e3400c9c71cdb..2864ec47eee5c 100644
> --- a/fs/xfs/libxfs/xfs_log_format.h
> +++ b/fs/xfs/libxfs/xfs_log_format.h
> @@ -571,7 +571,7 @@ typedef struct xfs_efi_log_format {
>  	uint16_t		efi_size;	/* size of this item */
>  	uint32_t		efi_nextents;	/* # extents to free */
>  	uint64_t		efi_id;		/* efi identifier */
> -	xfs_extent_t		efi_extents[1];	/* array of extents to free */
> +	xfs_extent_t		efi_extents[];	/* array of extents to free */
>  } xfs_efi_log_format_t;
>  
>  typedef struct xfs_efi_log_format_32 {
> @@ -579,7 +579,7 @@ typedef struct xfs_efi_log_format_32 {
>  	uint16_t		efi_size;	/* size of this item */
>  	uint32_t		efi_nextents;	/* # extents to free */
>  	uint64_t		efi_id;		/* efi identifier */
> -	xfs_extent_32_t		efi_extents[1];	/* array of extents to free */
> +	xfs_extent_32_t		efi_extents[];	/* array of extents to free */
>  } __attribute__((packed)) xfs_efi_log_format_32_t;
>  
>  typedef struct xfs_efi_log_format_64 {
> @@ -587,7 +587,7 @@ typedef struct xfs_efi_log_format_64 {
>  	uint16_t		efi_size;	/* size of this item */
>  	uint32_t		efi_nextents;	/* # extents to free */
>  	uint64_t		efi_id;		/* efi identifier */
> -	xfs_extent_64_t		efi_extents[1];	/* array of extents to free */
> +	xfs_extent_64_t		efi_extents[];	/* array of extents to free */
>  } xfs_efi_log_format_64_t;
>  
>  /*
> @@ -600,7 +600,7 @@ typedef struct xfs_efd_log_format {
>  	uint16_t		efd_size;	/* size of this item */
>  	uint32_t		efd_nextents;	/* # of extents freed */
>  	uint64_t		efd_efi_id;	/* id of corresponding efi */
> -	xfs_extent_t		efd_extents[1];	/* array of extents freed */
> +	xfs_extent_t		efd_extents[];	/* array of extents freed */
>  } xfs_efd_log_format_t;
>  
>  typedef struct xfs_efd_log_format_32 {
> @@ -608,7 +608,7 @@ typedef struct xfs_efd_log_format_32 {
>  	uint16_t		efd_size;	/* size of this item */
>  	uint32_t		efd_nextents;	/* # of extents freed */
>  	uint64_t		efd_efi_id;	/* id of corresponding efi */
> -	xfs_extent_32_t		efd_extents[1];	/* array of extents freed */
> +	xfs_extent_32_t		efd_extents[];	/* array of extents freed */
>  } __attribute__((packed)) xfs_efd_log_format_32_t;
>  
>  typedef struct xfs_efd_log_format_64 {
> @@ -616,7 +616,7 @@ typedef struct xfs_efd_log_format_64 {
>  	uint16_t		efd_size;	/* size of this item */
>  	uint32_t		efd_nextents;	/* # of extents freed */
>  	uint64_t		efd_efi_id;	/* id of corresponding efi */
> -	xfs_extent_64_t		efd_extents[1];	/* array of extents freed */
> +	xfs_extent_64_t		efd_extents[];	/* array of extents freed */
>  } xfs_efd_log_format_64_t;
>  
>  /*
> diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
> index b9c333bae0a12..faf1b780fe8c4 100644
> --- a/fs/xfs/xfs_extfree_item.c
> +++ b/fs/xfs/xfs_extfree_item.c
> @@ -74,7 +74,7 @@ xfs_efi_item_sizeof(
>  	struct xfs_efi_log_item *efip)
>  {
>  	return sizeof(struct xfs_efi_log_format) +
> -	       (efip->efi_format.efi_nextents - 1) * sizeof(xfs_extent_t);
> +	       efip->efi_format.efi_nextents * sizeof(xfs_extent_t);
>  }
>  
>  STATIC void
> @@ -158,7 +158,7 @@ xfs_efi_init(
>  	ASSERT(nextents > 0);
>  	if (nextents > XFS_EFI_MAX_FAST_EXTENTS) {
>  		size = (uint)(sizeof(struct xfs_efi_log_item) +
> -			((nextents - 1) * sizeof(xfs_extent_t)));
> +			nextents * sizeof(xfs_extent_t));
>  		efip = kmem_zalloc(size, 0);
>  	} else {
>  		efip = kmem_zone_zalloc(xfs_efi_zone, 0);
> @@ -186,11 +186,11 @@ xfs_efi_copy_format(xfs_log_iovec_t *buf, xfs_efi_log_format_t *dst_efi_fmt)
>  	xfs_efi_log_format_t *src_efi_fmt = buf->i_addr;
>  	uint i;
>  	uint len = sizeof(xfs_efi_log_format_t) + 
> -		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_t);  
> +		src_efi_fmt->efi_nextents * sizeof(xfs_extent_t);

I think these should all be using struct_size(), yes?

-Kees

>  	uint len32 = sizeof(xfs_efi_log_format_32_t) + 
> -		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_32_t);  
> +		src_efi_fmt->efi_nextents * sizeof(xfs_extent_32_t);
>  	uint len64 = sizeof(xfs_efi_log_format_64_t) + 
> -		(src_efi_fmt->efi_nextents - 1) * sizeof(xfs_extent_64_t);  
> +		src_efi_fmt->efi_nextents * sizeof(xfs_extent_64_t);
>  
>  	if (buf->i_len == len) {
>  		memcpy((char *)dst_efi_fmt, (char*)src_efi_fmt, len);
> @@ -253,7 +253,7 @@ xfs_efd_item_sizeof(
>  	struct xfs_efd_log_item *efdp)
>  {
>  	return sizeof(xfs_efd_log_format_t) +
> -	       (efdp->efd_format.efd_nextents - 1) * sizeof(xfs_extent_t);
> +	       efdp->efd_format.efd_nextents * sizeof(xfs_extent_t);
>  }
>  
>  STATIC void
> @@ -329,7 +329,7 @@ xfs_trans_get_efd(
>  
>  	if (nextents > XFS_EFD_MAX_FAST_EXTENTS) {
>  		efdp = kmem_zalloc(sizeof(struct xfs_efd_log_item) +
> -				(nextents - 1) * sizeof(struct xfs_extent),
> +				nextents * sizeof(struct xfs_extent),
>  				0);
>  	} else {
>  		efdp = kmem_zone_zalloc(xfs_efd_zone, 0);
> @@ -716,9 +716,9 @@ xlog_recover_efd_commit_pass2(
>  
>  	efd_formatp = item->ri_buf[0].i_addr;
>  	ASSERT((item->ri_buf[0].i_len == (sizeof(xfs_efd_log_format_32_t) +
> -		((efd_formatp->efd_nextents - 1) * sizeof(xfs_extent_32_t)))) ||
> +		efd_formatp->efd_nextents * sizeof(xfs_extent_32_t))) ||
>  	       (item->ri_buf[0].i_len == (sizeof(xfs_efd_log_format_64_t) +
> -		((efd_formatp->efd_nextents - 1) * sizeof(xfs_extent_64_t)))));
> +		efd_formatp->efd_nextents * sizeof(xfs_extent_64_t))));
>  
>  	xlog_recover_release_intent(log, XFS_LI_EFI, efd_formatp->efd_efi_id);
>  	return 0;
> diff --git a/fs/xfs/xfs_ondisk.h b/fs/xfs/xfs_ondisk.h
> index 5f04d8a5ab2a9..ceba638fd99ce 100644
> --- a/fs/xfs/xfs_ondisk.h
> +++ b/fs/xfs/xfs_ondisk.h
> @@ -113,10 +113,10 @@ xfs_check_ondisk_structs(void)
>  	/* log structures */
>  	XFS_CHECK_STRUCT_SIZE(struct xfs_buf_log_format,	88);
>  	XFS_CHECK_STRUCT_SIZE(struct xfs_dq_logformat,		24);
> -	XFS_CHECK_STRUCT_SIZE(struct xfs_efd_log_format_32,	28);
> -	XFS_CHECK_STRUCT_SIZE(struct xfs_efd_log_format_64,	32);
> -	XFS_CHECK_STRUCT_SIZE(struct xfs_efi_log_format_32,	28);
> -	XFS_CHECK_STRUCT_SIZE(struct xfs_efi_log_format_64,	32);
> +	XFS_CHECK_STRUCT_SIZE(struct xfs_efd_log_format_32,	16);
> +	XFS_CHECK_STRUCT_SIZE(struct xfs_efd_log_format_64,	16);
> +	XFS_CHECK_STRUCT_SIZE(struct xfs_efi_log_format_32,	16);
> +	XFS_CHECK_STRUCT_SIZE(struct xfs_efi_log_format_64,	16);
>  	XFS_CHECK_STRUCT_SIZE(struct xfs_extent_32,		12);
>  	XFS_CHECK_STRUCT_SIZE(struct xfs_extent_64,		16);
>  	XFS_CHECK_STRUCT_SIZE(struct xfs_log_dinode,		176);
> -- 
> 2.26.2
> 

-- 
Kees Cook
