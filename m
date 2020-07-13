Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD0DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229452073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L61FhwCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGMIKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgGMIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:10:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A13C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:10:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so12244966wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=nT2xE2I/1laRy3/n8/6HWxHbLx8UbAkaa/McJbaY/Go=;
        b=L61FhwCCvRDKQLIKdnXaGxMEL0Cgg8QW8GHZ/v5d4/c4Ig9855dnDAK7hZ3Wq81MI4
         qGwEokCjqapm8wRSgtkuMyucU0k+p2FetZQCLUDsTltZ8fg/4F8NpNvovCKRb/bXP7HX
         Ue3VEO//CgeIoEbLfWpRHvErKA0kri+aNdUQpz2B8nobBdvqjM1WD3qY428QfYJLtQ5G
         pAp6MyLRE3O84pp8zBWGe0tmiF0pXOzRvP0P/NL1gPzbUd48IENUBf4oZDwTXuy+4osv
         a+z0Rj6AUbKa9a63yMQNqYKWMMD1iBcAdVyr7vILDMeuHZuN6+EL57okjFctAnUNbBsK
         1Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
         :subject:date:message-id:mime-version:content-transfer-encoding
         :content-language:thread-index;
        bh=nT2xE2I/1laRy3/n8/6HWxHbLx8UbAkaa/McJbaY/Go=;
        b=CqUaJp7FNhYCvyyFLBqhmnnHsYNEd3mE5uBXMdMQufdw9ngxN0yJiRYTRW+ivVIXFa
         IzsTvK5gGV0iK5LsmEgTXsgUVwk2sz+3dY8uNYJtQix1g+NdWivsTKwKxbikCSCK52HD
         YRJalJISQ1+ukq5qb7u90Mm/YZQLGag+cqcCCvzwlAH+ucuKfgx+j8d6mwfktUSJ3KIW
         qDtobfuAZuPW4T5GS24oFlaJI+CfI8/VCmKLSvqCc8FHnmrxrd5VUavUi5HYx9YUs6Zp
         Q6Iw7+baObauvLX+ckX75NjvotEdvDTN4s2HA7QXiOlMRaMl8C4soH953aF6B5dWm/u5
         HWWA==
X-Gm-Message-State: AOAM530OOob2zJpVo0IQE7rouyQtILnX1pqzr5IyQJgwFZl4RKiypg0b
        Cv+ciKjVRiXZ3ZtYQrT23Vw=
X-Google-Smtp-Source: ABdhPJygTefIsKyZlBfTQwg8Ok+6EIMpEHdvDLG1LGMonu/CaPUYSMBvfx4mgduaPCPtD/3iCo0qvQ==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr18552307wmj.160.1594627839822;
        Mon, 13 Jul 2020 01:10:39 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id n17sm21674581wrs.2.2020.07.13.01.10.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 01:10:39 -0700 (PDT)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
Reply-To: <paul@xen.org>
To:     "'Souptick Joarder'" <jrdr.linux@gmail.com>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
Cc:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        "'John Hubbard'" <jhubbard@nvidia.com>,
        "'Paul Durrant'" <xadimgnik@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com> <1594525195-28345-4-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1594525195-28345-4-git-send-email-jrdr.linux@gmail.com>
Subject: RE: [PATCH v3 3/3] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Mon, 13 Jul 2020 09:10:38 +0100
Message-ID: <003a01d658ed$1858e220$490aa660$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQGQUUjbM0hB7euxJ1kpRMo6FNfk+gGYi24xqYRzHNA=
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
> Subject: [PATCH v3 3/3] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
> 
> In 2019, we introduced pin_user_pages*() and now we are converting
> get_user_pages*() to the new API as appropriate. [1] & [2] could
> be referred for more information. This is case 5 as per document [1].
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>         https://lwn.net/Articles/807108/
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Paul Durrant <xadimgnik@gmail.com>

Reviewed-by: Paul Durrant <paul@xen.org>

> ---
>  drivers/xen/privcmd.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 079d35b..63abe6c 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -593,7 +593,7 @@ static int lock_pages(
>  		if (requested > nr_pages)
>  			return -ENOSPC;
> 
> -		page_count = get_user_pages_fast(
> +		page_count = pin_user_pages_fast(
>  			(unsigned long) kbufs[i].uptr,
>  			requested, FOLL_WRITE, pages);
>  		if (page_count < 0)
> @@ -609,13 +609,7 @@ static int lock_pages(
> 
>  static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>  {
> -	unsigned int i;
> -
> -	for (i = 0; i < nr_pages; i++) {
> -		if (!PageDirty(pages[i]))
> -			set_page_dirty_lock(pages[i]);
> -		put_page(pages[i]);
> -	}
> +	unpin_user_pages_dirty_lock(pages, nr_pages, true);
>  }
> 
>  static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
> --
> 1.9.1


