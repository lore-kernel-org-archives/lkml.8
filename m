Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8C7C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446C214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583307036;
	bh=yXbKC32hYikH+Y6iOqAYkto1iApXG/+ZDVtzPLhDxcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1FDVTOlObKkv2cBzjgESgPAdcCqMkE3DoerMKdUHTDN0X31LzakiHweyfVQqScUk0
	 Z15NI7w0X7eNbxoIBVILW0/6HoPkHsb5DVKdiHYjym4cxPMtvlY33Ll3pBF5FyVZDP
	 zpebZGKEYqxNERcZO1hw7ONAZKifaPGmnDQYubVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgCDHaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgCDHae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:30:34 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12A52166E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 07:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583307034;
        bh=yXbKC32hYikH+Y6iOqAYkto1iApXG/+ZDVtzPLhDxcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tqbC00iy+DNya5rs/jGwyyYVkti7AdUBoSwr3dgm54D8yR8q3c25dBsoQYBz2ykmL
         iUueu0FAG7GhyeZBk4I2+kTNVeJgdCqSTfuwTC7pskoyQHdUkx5xyrFc4y4rH/X9T1
         7aY0DwgoyPlPeJiPRlmO9tvn2arFgE6UpIqv++j8=
Received: by mail-wm1-f53.google.com with SMTP id 6so717306wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:30:33 -0800 (PST)
X-Gm-Message-State: ANhLgQ2VWnggHtQklbIfDp79C2c/CkIyoSxTmQQx7VFNPwZ/wfpkusKC
        YSFyougrwOz9rn88qsokCxw+X42WGTWb0vPL6Kubkw==
X-Google-Smtp-Source: ADFU+vtLuCOHLk82GA40C/ISCavxvNKBN90/osmseO1/AgH6pFIZrGWN4o3Fj4A2Ssy4f1YSOZnnATZ1Rdd30VKp7zg=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr2129718wmj.1.1583307031690;
 Tue, 03 Mar 2020 23:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu> <20200303221205.4048668-6-nivedita@alum.mit.edu>
 <CAKv+Gu9LON5SeJ7UMTeHxP1OcSkz_eGGunpXx_csjh_fp1PhDA@mail.gmail.com> <20200303233457.GA154112@rani.riverdale.lan>
In-Reply-To: <20200303233457.GA154112@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 08:30:20 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9GLik3VZBZg8VQKFBs3GtV+QB7KQSVfiKcCNtyYjW0XQ@mail.gmail.com>
Message-ID: <CAKv+Gu9GLik3VZBZg8VQKFBs3GtV+QB7KQSVfiKcCNtyYjW0XQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] efi/x86: Don't relocate the kernel unless necessary
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 00:35, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 12:08:33AM +0100, Ard Biesheuvel wrote:
> > On Tue, 3 Mar 2020 at 23:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > Add alignment slack to the PE image size, so that we can realign the
> > > decompression buffer within the space allocated for the image.
> > >
> > > Only relocate the kernel if it has been loaded at an unsuitable address:
> > > * Below LOAD_PHYSICAL_ADDR, or
> > > * Above 64T for 64-bit and 512MiB for 32-bit
> > >
> > > For 32-bit, the upper limit is conservative, but the exact limit can be
> > > difficult to calculate.
> > >
> >
> > Could we get rid of the call to efi_low_alloc_above() in
> > efi_relocate_kernel(), and just allocate top down with the right
> > alignment? I'd like to get rid of efi_low_alloc() et al if we can.
> >
>
> But we don't have a top-down allocator, do we? ALLOCATE_MAX_ADDRESS
> guarantees the maximum, but it doesn't guarantee that you'll be as high
> as possible.

Good point. We do have a top-down allocator in practice, but it is not
guaranteed by the API.
