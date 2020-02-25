Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A541EC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7898F24650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654358;
	bh=mXWUiZJkPmr1lE8uFH0V3qybqZfjUw3HgXua5XVN2cU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d4qkm5G3n8sg7/GDd/uXSOE92WClm3YKGt8Sdnk87qSrKeow5osmu6wgk22N8ftQE
	 aycTnserqmlM9C04lsVIy5BprbO4D5txBss1DB1BGAgRw0wthTUk20KUTSI73Wdgko
	 qzqeKuNmojnG2pRRmJI1REXvZzf8sTks2Ecf974M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgBYSMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgBYSMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:12:36 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C7322464
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582654355;
        bh=mXWUiZJkPmr1lE8uFH0V3qybqZfjUw3HgXua5XVN2cU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fMui7mI7qIyRMi4ekKiacJt4rF4HFT4WpEGnJTtw/GxytaWxH2e3qhX//Bj86Cp9X
         UNk4hH5PPZhW0gD9n4rbF+CK6lcM2vdrzkiYo4A+Hhv+Cso7V2PX925fbRajyv6FWn
         aVrwy653xgbTgqvTKzFjfBe3eMZJDac6HNoPKVFM=
Received: by mail-wr1-f41.google.com with SMTP id z15so7570568wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:12:35 -0800 (PST)
X-Gm-Message-State: APjAAAUgKOfOpE5PaNW2ns8gqbulg/ztoOp6xdxdqlHX0ovncK/nUqR3
        O389tbeHutKwA2ypqQYCbW01Ka8wxjbCud/Vg2Cy+Q==
X-Google-Smtp-Source: APXvYqyqT+4lqHqb1wfGC3LfI8nS+unwk420CYZlyoxCttkGv3eFgPfmPK5xORObhzEOKAXEiAmF1nZu/8bOUQXtGc0=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr417950wrw.252.1582654353845;
 Tue, 25 Feb 2020 10:12:33 -0800 (PST)
MIME-Version: 1.0
References: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
 <CAKv+Gu_FJeiaY5yw9=ER4XyBZrDFZ5L4igrqxP6hhJ7Z8easpw@mail.gmail.com>
 <9e16fed9-4399-5c78-cbfb-6be75c295f31@amd.com> <CAKv+Gu_0LUY67DwSLU1tyijuF+0mKPpvq1j3RSMy5HBxYE-3qw@mail.gmail.com>
 <96417897-8bf0-e60c-6285-7286673ecd01@amd.com>
In-Reply-To: <96417897-8bf0-e60c-6285-7286673ecd01@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 19:12:22 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-5=5bKBdO_r=Z3bAqCM36vfH=vLcCcaFtKcwYpe=AP7g@mail.gmail.com>
Message-ID: <CAKv+Gu-5=5bKBdO_r=Z3bAqCM36vfH=vLcCcaFtKcwYpe=AP7g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 19:10, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/25/20 11:58 AM, Ard Biesheuvel wrote:
> > On Tue, 25 Feb 2020 at 18:54, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 2/25/20 11:45 AM, Ard Biesheuvel wrote:
> >>> On Tue, 25 Feb 2020 at 18:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>
> >>>> When booting with SME active, EFI tables must be mapped unencrypted since
> >>>> they were built by UEFI in unencrypted memory. Update the list of tables
> >>>> to be checked during early_memremap() processing to account for new EFI
> >>>> tables.
> >>>>
> >>>> This fixes a bug where an EFI TPM log table has been created by UEFI, but
> >>>> it lives in memory that has been marked as usable rather than reserved.
> >>>>
> >>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>>>
> >>>> ---
> >>>> Changes since v1:
> >>>> - Re-spun against EFI tree
> >>>
> >>> Which one? Surely not the one in the link I included?
> >>
> >> I did a git clone of
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> >>
> >> and checked out branch next. Not sure what I missed...
> >>
> >
> > Weird. Do you see commit 5d288dbd88606d8f215c7138b10649115d79cadd on
> > that branch? It removes rng_seed from struct efi, hence my request to
> > rebase your patch.
>
> I had just assumed you wanted a cleaner version and didn't realize that
> rng_seed was removed from struct efi. My bad for not building.
>
> >
> > IMO, best is to simply drop the 'static' from rng_seed, rename it to
> > efi_rng_seed, and drop an extern declaration in linux/efi.h so it is
> > accessible from your code. I'm reluctant to put it back in struct efi.
>
> Ok, I'll re-work the patch.
>

OK

Btw if you want the TPM part of the fix to go to -stable, better to
split them in two (and I'll put a cc:stable on the tpm one)
