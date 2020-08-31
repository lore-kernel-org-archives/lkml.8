Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89705C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3E2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bW3Lj8rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHaGXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgHaGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:23:15 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC46C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:23:14 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y30so1208449ooj.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbJ5Hs8Go54qaX9o9nvt0zalvbQlaohZX3ktFtQIhJM=;
        b=bW3Lj8rPY+hgDSKzDnkZKzb2rzVSHvKAzvm/CUdjCUU1alxrKCmRILRRcMXNrKeQ4d
         q5KfMa2DaXOaUWi8IbZfJvVdi/fPxTGsL6DTFGxkhXkQWL02MVDQeQOfpnt/optrVk8A
         D0trqwu6j4z/Dg6VpPTMSV4lM3INHDGgfB3TKyN72M51PbRFchxXomFItvMaXI00RpgF
         fHm0eIBJWbJuWQu3JrRUWpL6+gRwZe1WbglizSDOll4XHwVHREUyAEDjQvQUpKuIy+8d
         2O5AKxB7eqQ2yiFVE3B3kuROaPRz+FOPHStlb75fOkANWQI/6MFCir8/caG2tUtk/bex
         1MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbJ5Hs8Go54qaX9o9nvt0zalvbQlaohZX3ktFtQIhJM=;
        b=J+miGoJHKe3d+vQfAvJ3NwXKcWLD17kbkS9BhsL9CaKy6RET5PEm+jlSrG6B0mr6yN
         B8AeStX83cxCjQzMSILjfHKxVdl6FJ5ovSGSlj/4y6X9Roz1Rus9L0Xv1r63Jw3zE1U6
         FhQg60YXGha/+6fc7dDhz9ftj+j0bRgNVlN/PtRBILNR9yE/l0Ww328/piw9A65pBp2R
         hdQCYhWJ/GdWlBkSF3zVhzzWj3DQwS8xy5FaLV4sB++Ni+7yiWnQ0rrzIMPXkX3fPFM5
         6Nu87cTlvfVM+h3hvvn52llwfVeRXf/N2neZq+2Ie+8cIF0f7gOnnSyXcCnitfx1LYyh
         iiQA==
X-Gm-Message-State: AOAM530XLvPbmfC2S1tD0WT67N/4ONQ+UFm9wuoH67ZKPY6wznHjwfpm
        iIinO9/pNCGwjXh8luPV0M0EjXuvA8PjKZcPovPkgA==
X-Google-Smtp-Source: ABdhPJyvSwceRQnFolO9a+Wkc3jWzFwQGFT+dAzvh8Jj1LUOLOC5Dp1WbUOgl+Gcntu5sqgfWij2gq0kShYLolnXcmU=
X-Received: by 2002:a4a:dc03:: with SMTP id p3mr6991429oov.63.1598854993144;
 Sun, 30 Aug 2020 23:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598598459.git.zong.li@sifive.com> <ee6a18d118b65cca0602e32bbb8be092f63ae8b6.1598598459.git.zong.li@sifive.com>
 <CAOJsxLHuX-nXFS6Dp+X=_hOrbT=-FUvWF_oM+6q508r=MNnFrQ@mail.gmail.com>
In-Reply-To: <CAOJsxLHuX-nXFS6Dp+X=_hOrbT=-FUvWF_oM+6q508r=MNnFrQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Aug 2020 14:23:02 +0800
Message-ID: <CANXhq0paq5a3A02gg=UJFKgDO71jprPKSSpjued2DavNTJEn4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: Add cache information in AUX vector
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 4:01 PM Pekka Enberg <penberg@gmail.com> wrote:
>
> On Fri, Aug 28, 2020 at 10:09 AM Zong Li <zong.li@sifive.com> wrote:
> > +uintptr_t get_cache_geometry(u32 level, enum cache_type type)
> > +{
> > +       struct cacheinfo *this_leaf = get_cacheinfo(level, type);
> > +       uintptr_t ret = (this_leaf->ways_of_associativity << 16 |
> > +                        this_leaf->coherency_line_size);
>
> You are dereferencing "this_leaf" without checking if it's NULL here.
>

oh yeah, it should check the pointer first here. Fix it in the next
version, thanks.

> > +
> > +       return this_leaf ? ret : 0;
> > +}
>
> - Pekka
