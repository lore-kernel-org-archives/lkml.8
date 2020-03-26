Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B4C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A320719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NnPN28SR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZEhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44214 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgCZEhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so4439467edy.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 21:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y20CeGQScdwXv2e5cBbGORXlmOAQqvqGM8Tbmxh+s8U=;
        b=NnPN28SRXi1uUhX29Dz/ecQfFMQ9NJKJyWfz57OCY+So4pdu/YOtIs8TLBwkfsbit8
         L86CQNndJIPSxbZw7+4McwCfFyqnS6QAt1fSE5U6H3Nkqv2JcsH+BTOz8r1B0Uc8Po1Z
         FgR6DJqLubRVXNqXIs/ECINnaIo/eKg3fGwLnsgMno5LAY1Pq7LQB8Q8gF3vAkoCcfMl
         vnzZaNxFqEbBn7VWrLnFQoq2BGEYck/v2nPHqISNO3LxmmA59JHDiQBRYPWN1ddlZtC/
         o2henSodF7cP9rrq67FXCK5UY4MkegV791GX8DXKjyZFfwDOuyMKqMfSIUGM48MvD7s8
         I4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y20CeGQScdwXv2e5cBbGORXlmOAQqvqGM8Tbmxh+s8U=;
        b=Ek8IO97t5qiY0zCPHQ9JHFNYK1dNX0WfTMB+5zGoqprlXi76512TrG5oTkYe0KO7AJ
         pC+Lbv4jGEUoHI/KDvbCuhwRy1v/8aTlsBDqGpyXxL/DErkVIL1+/65Mi83/Im/lwzjR
         CtRuiQZBvLDbWtWXSxAP+jKUm9E7z9qywAZFT5fdvMkZyjsQa6276+ZjWIz+DSUBIu+o
         b3fJNZwfD2jhUg0Q6FnEckiBXHDem/mQEvmUpcmGXFnrXOrg46T1TbHrAgpl1UGztIwn
         YXPhVnczKHESBjjCXI/8Znwnz1CU0ZWSYA3U3hFst6z1p7pmmsjVf7ztOmkUuDct4zdV
         772g==
X-Gm-Message-State: ANhLgQ14OZWfpB9eULrjIUXjpVtpt2bnJHBzuS8BAe+qcy+D+Ih+6RWb
        wHnFPGdEJSnqEyKtwQfa5xAGGI/ygi62v2Z3VkGs0jLi
X-Google-Smtp-Source: ADFU+vuEqHrADScJDNrE5jEmfQwLB6omwEtMI9r+jBDuPZsEKbUtAYrdc7Maiu+s44RUM2179JuB/uQYQyUXcglHnqw=
X-Received: by 2002:a17:906:6987:: with SMTP id i7mr6196042ejr.12.1585197418839;
 Wed, 25 Mar 2020 21:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200220122719.4302-1-thomas_os@shipmail.org> <20200220122719.4302-2-thomas_os@shipmail.org>
In-Reply-To: <20200220122719.4302-2-thomas_os@shipmail.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Mar 2020 21:36:47 -0700
Message-ID: <CAPcyv4hUGPCWrR=Mj4-dR3vOq5peSXvBWL2F4c0ktsAT+YygEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] fs: Constify vma argument to vma_is_dax
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Roland Scheidegger <sroland@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 4:27 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> The vma argument is only dereferenced for reading.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98e0349adb52..4f41fdbf402f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3367,7 +3367,7 @@ static inline bool io_is_direct(struct file *filp)
>         return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host=
);
>  }
>
> -static inline bool vma_is_dax(struct vm_area_struct *vma)
> +static inline bool vma_is_dax(const struct vm_area_struct *vma)
>  {
>         return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
>  }

Looks good to me:

Acked-by: Dan Williams <dan.j.williams@intel.com>
