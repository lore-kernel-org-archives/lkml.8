Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E30C3B185
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1E020725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pTR/tzq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgBQK1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:27:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgBQK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:27:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so18234406lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZVl3yBWWm7MyQqJEcWXXzI1xt9p90ifeGv9DuPBNzAg=;
        b=pTR/tzq9m4PXx63b4TbTT6GWij0RLB4OJW9RvLUcWxI+tPq1LkgXzr414lQ6RNWJgS
         nb46suJtnt6XZcqKcVLGHopyrTNoC8KIXwASX7pHOIb8r+i7cGxE/grweun6/ZNlmXIk
         vgWhkzP7QlpVi/K3ZFTyrvhaUltEs906sU/6RvnNgxgVn4ganVg53mcd7y9geThqocag
         qGQTR/RBoGQTjXeaKkk6NobmH4sjudZsh/JlJjKxk/uBLiKWmo/5hZBIz2DwN15uUtfM
         dUPNoRV9dnigmvy63DE+Y8Fg07St2R8izgj1Jl2F582qcuRxr57Eif0X7V1oAmewYYrc
         NveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVl3yBWWm7MyQqJEcWXXzI1xt9p90ifeGv9DuPBNzAg=;
        b=kckLvkShDkz8FPiWLZ07BwWjTDgetRE0Kuh5HNQS3arBs5ZcLWCvDaXsqOYnEo5isV
         /LSnYaL4dsX9sIHTyVvHLXdviLFU8wkOPpHt4+u6XUhqgxy/XbBJ0WCAE7aKZKxHravr
         oeTDiUYcU4JVaKMB2GEsfMmeJxjiXt1JCHvLKiTX1It0bhYzU7uincnaEmpzg5nT3mxk
         A318wc3hVoedktqwlS7b1e2joFXwGR4WuNRur9VJL0wzuUa6jjxf/JjZ82Q1UcihprRc
         vZG3N2p2N/y+6YElIe0RDidv35QK0P6Aa6w2N2boe1wSqPWmLJs0dUkEt5GEQPofZVYa
         nEEA==
X-Gm-Message-State: APjAAAXH5Rb++BX81/m/6Mfck62npsgn6DXtbj6n1WlGpNtNXlW6OXpx
        NnDiMlamHlfS55SHYN6XEpxTLA==
X-Google-Smtp-Source: APXvYqy/hXXiB9yxXp02xHbKZSUay4iWke71ToKoCypS+ZInT1oZHxH8Fgns9tAwgIOlH7ZCC6nlpg==
X-Received: by 2002:a2e:9d3:: with SMTP id 202mr9648045ljj.60.1581935223504;
        Mon, 17 Feb 2020 02:27:03 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m24sm113416ljb.81.2020.02.17.02.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 02:27:02 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8820B100F93; Mon, 17 Feb 2020 13:27:27 +0300 (+03)
Date:   Mon, 17 Feb 2020 13:27:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCH 4/5] mm/vma: Replace all remaining open encodings with
 vma_set_anonymous()
Message-ID: <20200217102727.cmd74il6nxfgzvkh@box>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
 <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581915833-21984-5-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:33:52AM +0530, Anshuman Khandual wrote:
> This replaces all remaining open encodings with vma_set_anonymous().
> 
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/misc/mic/scif/scif_mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mic/scif/scif_mmap.c b/drivers/misc/mic/scif/scif_mmap.c
> index a151d416f39c..1f0dec5df994 100644
> --- a/drivers/misc/mic/scif/scif_mmap.c
> +++ b/drivers/misc/mic/scif/scif_mmap.c
> @@ -580,7 +580,7 @@ static void scif_munmap(struct vm_area_struct *vma)
>  	 * The kernel probably zeroes these out but we still want
>  	 * to clean up our own mess just in case.
>  	 */
> -	vma->vm_ops = NULL;
> +	vma_set_anonymous(vma);
>  	vma->vm_private_data = NULL;
>  	kref_put(&vmapvt->ref, vma_pvt_release);
>  	scif_delete_vma(ep, vma);

This is misleading. The VMA doesn't become anonymous here. This is undo of
the previously overwritten vm_ops. I think we should leave it opencodded.

-- 
 Kirill A. Shutemov
