Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA40246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583135431;
	bh=O5/tiRCv2lf9UHdd/8DRCYM/sJBi0xsnMZYl0LPjZxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ss+lUN6GNw25b4W3qeeEGlpSJ0snbwoMVmPXufQ5T+sqEq9gdfY1/XgBBQBlkre6v
	 /cCYg3I8efWgcevSsqORWNVoV1U4VV76RPaIGH7oJ8w1pNaDOKLpwsnRgq/s5Jwgo0
	 ctPkkeFU723DF0S8VcR5fUXvaQfhLbEQVvZaWits=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCBHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBHu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:50:29 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5DF246B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 07:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135429;
        bh=O5/tiRCv2lf9UHdd/8DRCYM/sJBi0xsnMZYl0LPjZxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JOGApCtYJxE4Bp7Tx9mQhzkU0NSJCYIk/smGF0puvITGXyxkA1qegfgg1eVwL/WOn
         uCgyeIa4xlMnmDD5AzBYvU3I7rNDe7o6NdJ74tEahB9g0jYTqQp0DHmx4CD9LblZQG
         TvfxXQK3DyIGsrzdAGVNdV4uqus1vxVMbsb5MNtA=
Received: by mail-wr1-f52.google.com with SMTP id v4so11178705wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:50:29 -0800 (PST)
X-Gm-Message-State: APjAAAVzBAgUgAk7Vf8IE1qGfUVG3EMK6L/YFiAzb7aqFG4gKl6jwfU1
        6jdTvA/OhX4ZHbQJGUhYAMKha8/u9AbZzbURyKAtcg==
X-Google-Smtp-Source: APXvYqy8mIonbGGBiIESjdyLQUcHAeyZfK5neJ4zgPtMWWhUKLOq/2BTrVQxQFpIPPy3Us8MOlJj8NvfptmH0iuxtMw=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr21307603wrw.252.1583135427687;
 Sun, 01 Mar 2020 23:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Mar 2020 08:50:16 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_USvAxcT7qFUvMoM_5Q=rHad4WJw5uqX1shk3vdau0Gg@mail.gmail.com>
Message-ID: <CAKv+Gu_USvAxcT7qFUvMoM_5Q=rHad4WJw5uqX1shk3vdau0Gg@mail.gmail.com>
Subject: Re: [PATCH 0/5] efi/x86 cleanups and one bugfix
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 00:04, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> First 3 patches are misc. beautifications to the new compat PE entry
> code.
>
> Next patch stops EFI stub using code32_start field to communicate the
> address of startup_32, instead returning it directly to efi_stub_entry.
>
> Last patch is a bugfix for x86/boot/head code to use unsigned
> comparisons on addresses rather than signed.
>
> Based on tip:efi/core
>
> Arvind Sankar (5):
>   efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
>   efi/x86: Respect 32-bit ABI in efi32_pe_entry
>   efi/x86: Make efi32_pe_entry more readable
>   efi/x86: Avoid using code32_start
>   x86/boot: Use unsigned comparison for addresses
>

Thanks Arvind. This looks really good, as usual. I had one question,
the rest looks good to go.
