Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CB4C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9090720772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEpbLZ6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCZHUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:20:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53728 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgCZHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:20:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so5332906wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=udY4IxAu4+qBI0VVKoFSj5VQzPLtjOmL74dmx17lD1U=;
        b=BEpbLZ6XT3fHzXgdnVfXkTmNBXDa6UAEYn4FOV/LwqEXXg2tc6UbIV86xAZPGDiDrG
         1de7vV2LABFiGVyHP74oIuuzNqY1SLzxkyOZEVs9AqFqhdhoCL6ePEpOahO3pWNjY6rD
         YuxfREhfec8qU9JviGWcdntXLrNVFBj6hQZdsAakbJFYT4buJOOZEwvlkBNW4cIjInLd
         vfYQRytF5Y056gU124I4U51o1Dbhoe6O/jPPhjRNN+KbCXgBNwB1oeypmknKitdRZxL0
         rjtvwQncKst3+kgPdVubfMahgLp4wXYSC/QYoTFE+P3h53T/3C+aARhrdN9pBRKDKnmz
         Hjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=udY4IxAu4+qBI0VVKoFSj5VQzPLtjOmL74dmx17lD1U=;
        b=WPy9xXWqRY+TgxQBOLo3Hxd1cQJOBlUBoNVLIH3ZX50Ib8MUeQNQlKwY8T0PXK140U
         DmfY+GAyHWyvj6ebyspyemWcN0g41PseSQW8qY3LOi6tmaT1IQKiCmXTRXs7BOK43SNK
         YtU1K6ZjxAwqY0LaRm3w7aCldSTZoZBcZHOe4pGgPvVeTdFUWqRP2KX4tYsq8DnNUptW
         ccRD00C3IM0CdhOGZJbIKe4NoG36vBzOi76kQsG1PSGk/8fdxHsbAUdbMh6kYqEbnSyv
         JqxJUxMVhiKyFBppC3QpsmnCQVgL0HVAZhfx5xGuJC4Y7OSN3LNMG3GvY6jaA3mXxyXi
         YX4A==
X-Gm-Message-State: ANhLgQ1fPm+HPTTMyQN3mLwvATQo5wpNy3WTtsa4N2j2WFEXEXYnOcGy
        Vam96BOgGJibzTwCFgUIef66pH44VsV0XBKBKZU=
X-Google-Smtp-Source: ADFU+vvQEBhAU7ND16P7NOyZPA8RvhuFNLqp7LcJBtkXT/DY6/gdim+O/mf1U6mhyqA/FLaGt5G65FqLM4fapjkUyAg=
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1657330wmb.127.1585207198626;
 Thu, 26 Mar 2020 00:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200324201123.3118-1-thomas_os@shipmail.org> <20200324201123.3118-2-thomas_os@shipmail.org>
In-Reply-To: <20200324201123.3118-2-thomas_os@shipmail.org>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 26 Mar 2020 08:19:47 +0100
Message-ID: <CAM9Jb+i=r5RuSruFgYomoDMBgkqw=+ff-VmBfVByY_DPT2_2VA@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] fs: Constify vma argument to vma_is_dax
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Thomas Hellstrom (VMware)" <thomas_os@shipmail.org>
>
> The function is used by upcoming vma_is_special_huge() with which we want
> to use a const vma argument. Since for vma_is_dax() the vma argument is
> only dereferenced for reading, constify it.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Thomas Hellstrom (VMware) <thomas_os@shipmail.org>
> Reviewed-by: Roland Scheidegger <sroland@vmware.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..2b38ce5b73ad 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3391,7 +3391,7 @@ static inline bool io_is_direct(struct file *filp)
>         return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host=
);
>  }
>
> -static inline bool vma_is_dax(struct vm_area_struct *vma)
> +static inline bool vma_is_dax(const struct vm_area_struct *vma)
>  {
>         return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
>  }
> --
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.21.1
>
>
