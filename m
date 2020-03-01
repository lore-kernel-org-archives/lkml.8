Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC304C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE93C24677
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583035552;
	bh=TgI4hILERXIbASCXQEv8m6ZbXiQzeEGpPNVCww6wUgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e8XokI5ItYyMeuZhUgQTuxlfxvI8lU61SmpttIP5+L8mHv194tK7nECe+KYmTpxEZ
	 qtLkBndiPHBVK7rMcj773oRFJKqAskvPcjPs/TZXx1WPZJiQesVPyjjP4IAH55qPK+
	 8Hx1q8KyjGldNPCW60PND2LNzmsI0/SsPVI7HMYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCAEEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:04:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgCAEEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:04:48 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF7221744;
        Sun,  1 Mar 2020 04:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583035486;
        bh=TgI4hILERXIbASCXQEv8m6ZbXiQzeEGpPNVCww6wUgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Givj2+KydQ8xlFIvRDz9loCRvtP0C5bnCTqVnyw+n/qUa4g6LYurSEEgQcrkOaTue
         MYM7EHAyvH+fS6UTeE/IrDk/WxWsyPYl4VrUBBg0BPIx7JIJ6p9sPL7t6wD4CyNm/D
         pix0u1MqRp3kUOTITj6DWpnIfsdjGPMAl/0i4ktE=
Date:   Sat, 29 Feb 2020 20:04:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/8] mm: Introduce vma_is_special_huge
Message-Id: <20200229200445.a30567add92de324fd1987f0@linux-foundation.org>
In-Reply-To: <20191203132239.5910-2-thomas_os@shipmail.org>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
        <20191203132239.5910-2-thomas_os@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 14:22:32 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> From: Thomas Hellstrom <thellstrom@vmware.com>
>=20
> For VM_PFNMAP and VM_MIXEDMAP vmas that want to support transhuge pages
> and -page table entries, introduce vma_is_special_huge() that takes the
> same codepaths as vma_is_dax().
>=20
> The use of "special" follows the definition in memory.c, vm_normal_page():
> "Special" mappings do not wish to be associated with a "struct page"
> (either it doesn't exist, or it exists but they don't want to touch it)
>=20
> For PAGE_SIZE pages, "special" is determined per page table entry to be
> able to deal with COW pages. But since we don't have huge COW pages,
> we can classify a vma as either "special huge" or "normal huge".
>=20
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2822,6 +2822,12 @@ extern long copy_huge_page_from_user(struct page *=
dst_page,
>  				const void __user *usr_src,
>  				unsigned int pages_per_huge_page,
>  				bool allow_pagefault);
> +static inline bool vma_is_special_huge(struct vm_area_struct *vma)
> +{
> +	return vma_is_dax(vma) || (vma->vm_file &&
> +				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
> +}

Some documetnation would be nice.  Not only what it does, but why it
does it.  ie, what is the *meaning* of vma_is_spacial_huge(vma)=3D=3Dtrue?


