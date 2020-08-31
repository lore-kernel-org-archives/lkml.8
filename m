Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A340C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC52072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+8263WA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgHaHAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:00:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FEBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:00:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so4389493edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mp1wlP+yLNID1XAoJHzsrmrZXmS2a5Y+F074V8aUs8=;
        b=c+8263WAZSAa+mnQUymnZ5Ed/xslJmBQIkVyLWBNzPdMVDm1QLhDTL6GZ9Rly2uBAf
         h2C1sU16fiMYqh8Es0WgnCsgHXjdT+yZk9F1cvUlfg1O4nftt8EYKcPxIOQuHaNIB/n9
         Sn5iQTqdzEyLcyfv50jUp5ZO9hHyTFLqmn5IcVMZGUGuZEACcU6ZFgnze5OjW8dtgAPO
         AmQiyWeOgC8z4wl9wveTH7ES3qcrmSL+nk82Qn3H0SOZbuqVCGSX7ON0oLXgPrY4OomY
         45FekjyQta98eYdktPlxyxra3m1CDNzDoPO35KU3H+pD7g1pjFMt1Ay5ODtJsGDCqvKk
         qnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mp1wlP+yLNID1XAoJHzsrmrZXmS2a5Y+F074V8aUs8=;
        b=N6/zbaTqeTn49ArAoWKDV+iJiY6NdtYDq9VZZ2DlgCB3gQJLJZl9BJGbvA5dCqUtpY
         OOtioGqMEtgvR63mdJDmbywzrtd0mUcyQZTCSSkKKv5kImdsElPQf7D3/Q1QwUz++PqZ
         eqcZeKkKuAaW+cUrzZ9cxiZu5N1L2uMsZbLBFKtLPIvumjqJDwdW/Bt5f+0CJhBO0Wxb
         XdbQyHDj4Mf9KZrog9vOWAjkYBtaG+AyeTrGdWEN22zrEpeZ4PkQqwygriYt1DlugdAH
         464VY7XVTYqco+hfzyAO54qr59buDKZImhJc1zjm3CtoyIKfhexk64MpFC7ifkCrz1w3
         iLlg==
X-Gm-Message-State: AOAM532HMS2xhBu/M6Juexm7jHz10v0DA+F0WZekyQ5kpYnb+PzbYpTm
        27lPwuwmYm8ViJCJ44THEZ4SsHTLQsCPc8NlMB4=
X-Google-Smtp-Source: ABdhPJxa9Pe+DZMtyiPcubMEiscjLjno1TEmJY/7bsvBWAM24vdzfr8/NI4fn4I7njlkYuuyVMiFKLF+uBl1wQdUFDk=
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr10316061edr.11.1598857233478;
 Mon, 31 Aug 2020 00:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598598459.git.zong.li@sifive.com> <3f1f693147f0b62f19f4a44b8e8ef3d5bde23352.1598598459.git.zong.li@sifive.com>
 <CAOJsxLHOvvt8WGQUynGkLxZCA4OQQ+KgxxJJD7s_iP8Pxf-Omg@mail.gmail.com> <CANXhq0r2jg_fVZJE0shquGc25QNgenL+Qq6HRUBXEYPSf=QcFQ@mail.gmail.com>
In-Reply-To: <CANXhq0r2jg_fVZJE0shquGc25QNgenL+Qq6HRUBXEYPSf=QcFQ@mail.gmail.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Mon, 31 Aug 2020 10:00:17 +0300
Message-ID: <CAOJsxLF_+0eg6zU=CFwnN+pc75jF4aqvUqog5z18wfG4WOKoDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Set more data to cacheinfo
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 31, 2020 at 9:15 AM Zong Li <zong.li@sifive.com> wrote:
> If the sets is one, it means that the cache is fully associative, then
> we don't need to fill the ways number, just keep way number as zero,
> so here we want to find the fully associative case first and make the
> if expression fail at the beginning. We might also rewrite it as
> follow:

[snip]

Thanks for the explanation! The rewritten version is much easier to
read, at least to me.

- Pekka
