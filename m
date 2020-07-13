Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7797AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ACD2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcjaFOmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGMIIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgGMIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:08:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC68CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:08:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so14818522wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=n0kxcs6gNGs9FJbIs3Lc7T0KsS0d3xL066fOjGqZegk=;
        b=pcjaFOmOWH7bFsme46lfUzgiDMH76YUAcKrxY/kWWwAMFaTOK1EmHZlPDKfvD4LqAH
         4blcM1nrhzcvamHkZjtv2KCa8he/ylRAPTPVNfVLgziX8YdA5pQEVv+w0J+RydwcGzm6
         tw5AdBLeQ5Uz7FGfe2vzx7v9sDfeGtYZw3CoEau0WOf8iCRpchJ23m65JR+oRaH4Y1mw
         0QHtR3c2QqUHhCTy/ClyvX16VoddM0RzMmyhglPZl+vYVY82+IhZoTzQIXpBZ6At7W5S
         y2zcFt6XbooWaVXBLQBVPdlskr+GaxmNnedVbh6QcQVOBMIsmyTwfR9/uMQ96jY3BZOQ
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :content-language:thread-index;
        bh=n0kxcs6gNGs9FJbIs3Lc7T0KsS0d3xL066fOjGqZegk=;
        b=Oz9zJ6YgNu+CtG0NrEsPElUI5rV81H5h1xK9Im38LYta0TpgEIBRwqtXg/Ge5f8Rj3
         WZLrCkZKJjZ898uLEIh97Pzvjy39zaFT2BwFD/1io2InPpliMLWUMQGCFqLy6GKrjCUw
         u1OFqcBDvdQK30y6RZL5tGBc8mNWbNgazDkAUfHELZ8Irg7hYsCIAx2+K9IxWzRTK9V8
         vjeapucAcFH+LWI9C3oTk9J5M/3oybYbf5GjXNKS6gTRAfajktXrtNTKGs7a+01/SWcJ
         6mDqgQ9KvRhOmMNpoBK/+tCoEtof8QDP9zXjgCBZyYeCQsKAMKhpCdJ8Vsn9auDGVBMW
         oTWg==
X-Gm-Message-State: AOAM5338YXIlCUUwcJjen0Js8dNzOIGPg/MoJ4fzDikaye2b4koYq0JH
        R5ZhQhFEjAXV/KZlI+zD9h8=
X-Google-Smtp-Source: ABdhPJytfL/cIdT+33/hj/QLy5PvtlQ6lTN3tAN0bJF3PHbH20eU5KnmkWKiks/uAreR0c/RFyjo9Q==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr76883891wrs.353.1594627687426;
        Mon, 13 Jul 2020 01:08:07 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id v3sm22686177wrq.57.2020.07.13.01.08.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 01:08:06 -0700 (PDT)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     "'Souptick Joarder'" <jrdr.linux@gmail.com>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
Cc:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        "'John Hubbard'" <jhubbard@nvidia.com>,
        "'Paul Durrant'" <xadimgnik@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com> <1594525195-28345-2-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1594525195-28345-2-git-send-email-jrdr.linux@gmail.com>
Subject: RE: [PATCH v3 1/3] xen/privcmd: Corrected error handling path
Date:   Mon, 13 Jul 2020 09:08:04 +0100
Message-ID: <003801d658ec$bd526c70$37f74550$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQGQUUjbM0hB7euxJ1kpRMo6FNfk+gI2hbljqX+CmZA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Souptick Joarder <jrdr.linux@gmail.com>
> Sent: 12 July 2020 04:40
> To: boris.ostrovsky@oracle.com; jgross@suse.com; sstabellini@kernel.org
> Cc: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org; Souptick Joarder
> <jrdr.linux@gmail.com>; John Hubbard <jhubbard@nvidia.com>; Paul Durrant <xadimgnik@gmail.com>
> Subject: [PATCH v3 1/3] xen/privcmd: Corrected error handling path
> 
> Previously, if lock_pages() end up partially mapping pages, it used
> to return -ERRNO due to which unlock_pages() have to go through
> each pages[i] till *nr_pages* to validate them. This can be avoided
> by passing correct number of partially mapped pages & -ERRNO separately,
> while returning from lock_pages() due to error.
> 
> With this fix unlock_pages() doesn't need to validate pages[i] till
> *nr_pages* for error scenario and few condition checks can be ignored.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Paul Durrant <xadimgnik@gmail.com>

Reviewed-by: Paul Durrant <paul@xen.org>

> ---
>  drivers/xen/privcmd.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 5dfc59f..b001673 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -579,13 +579,13 @@ static long privcmd_ioctl_mmap_batch(
> 
>  static int lock_pages(
>  	struct privcmd_dm_op_buf kbufs[], unsigned int num,
> -	struct page *pages[], unsigned int nr_pages)
> +	struct page *pages[], unsigned int nr_pages, unsigned int *pinned)
>  {
>  	unsigned int i;
> 
>  	for (i = 0; i < num; i++) {
>  		unsigned int requested;
> -		int pinned;
> +		int page_count;
> 
>  		requested = DIV_ROUND_UP(
>  			offset_in_page(kbufs[i].uptr) + kbufs[i].size,
> @@ -593,14 +593,15 @@ static int lock_pages(
>  		if (requested > nr_pages)
>  			return -ENOSPC;
> 
> -		pinned = get_user_pages_fast(
> +		page_count = get_user_pages_fast(
>  			(unsigned long) kbufs[i].uptr,
>  			requested, FOLL_WRITE, pages);
> -		if (pinned < 0)
> -			return pinned;
> +		if (page_count < 0)
> +			return page_count;
> 
> -		nr_pages -= pinned;
> -		pages += pinned;
> +		*pinned += page_count;
> +		nr_pages -= page_count;
> +		pages += page_count;
>  	}
> 
>  	return 0;
> @@ -610,13 +611,8 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>  {
>  	unsigned int i;
> 
> -	if (!pages)
> -		return;
> -
> -	for (i = 0; i < nr_pages; i++) {
> -		if (pages[i])
> -			put_page(pages[i]);
> -	}
> +	for (i = 0; i < nr_pages; i++)
> +		put_page(pages[i]);
>  }
> 
>  static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
> @@ -629,6 +625,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
>  	struct xen_dm_op_buf *xbufs = NULL;
>  	unsigned int i;
>  	long rc;
> +	unsigned int pinned = 0;
> 
>  	if (copy_from_user(&kdata, udata, sizeof(kdata)))
>  		return -EFAULT;
> @@ -682,9 +679,11 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
>  		goto out;
>  	}
> 
> -	rc = lock_pages(kbufs, kdata.num, pages, nr_pages);
> -	if (rc)
> +	rc = lock_pages(kbufs, kdata.num, pages, nr_pages, &pinned);
> +	if (rc < 0) {
> +		nr_pages = pinned;
>  		goto out;
> +	}
> 
>  	for (i = 0; i < kdata.num; i++) {
>  		set_xen_guest_handle(xbufs[i].h, kbufs[i].uptr);
> --
> 1.9.1


