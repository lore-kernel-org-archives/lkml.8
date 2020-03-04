Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE054C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0C2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583348662;
	bh=hJurs/av6t9EdSglXfHGBNi3KPMs5TYGjABwzZDQpvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RofdppZ3Z4WJonatciXkPP2z1rf7AMJiYxZ6Bn31HxUL1aNt3AdftNi6tIaQd9Hnd
	 PNRA5L0NlD+bLVDQIB9e73gBGEReYM3Kc2VQMBn7XStm14+4VTY+NVSwefJGivI0tA
	 gDXkVeoJHg8E3cD58gjsTU/I75XzTfWAZ2cjd2A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgCDTES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbgCDTER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:04:17 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B0524677
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583348657;
        bh=hJurs/av6t9EdSglXfHGBNi3KPMs5TYGjABwzZDQpvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QIqc975YYSbTdnPOs8FNUDH6hSs32LUwNkUIKDwZt0hy5IENjOq+mLlbMqqfA2YFJ
         46bOeKDC0ID/iz2t431gDQPHKTv3A6ikLMV5+kUCteYRzOjDy3VNbmW5kTwpCDBWHg
         kYya9bod/N6YiVWt8jo7/AmHpzQ1Zlk0TOl8DneE=
Received: by mail-wr1-f43.google.com with SMTP id j7so3801375wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:04:16 -0800 (PST)
X-Gm-Message-State: ANhLgQ0BDf741kQiKn7/pFHjVGSL4lr8LVov7w7VF108eQ8phBQh7c3P
        s44vNM6rIh0e62VOYVVHOYKMn7mdqHkMP0u3asH88A==
X-Google-Smtp-Source: ADFU+vvNwUmp7UUfbaV0t7YWCbx3o1VoR36mkm9WU2rUlP6aAWyjGRVGsnHUEBD6CsLghQhpGlsvblBIBoa0uLJRlY8=
X-Received: by 2002:adf:e742:: with SMTP id c2mr5384523wrn.262.1583348655022;
 Wed, 04 Mar 2020 11:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu> <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan> <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan>
In-Reply-To: <20200304185042.GA281042@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 20:04:04 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
Message-ID: <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in populate_pud
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 19:50, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 07:44:50PM +0100, Ard Biesheuvel wrote:
> >
> > I've tried a couple of different ways, but I can't seem to get my
> > memory map organized in the way that will trigger the error.
>
> What does yours look like? efi_merge_regions doesn't merge everything
> that will eventually be mapped the same way, so if there are some
> non-conventional memory regions scattered over the address space, it
> might be breaking up the mappings to the point where this doesn't
> trigger.

I have a region

[    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |  |  |  |
 |   |WB|WT|WC|UC] range=[0x0000000001400000-0x00000000b9855fff]
(2948MB)

which gets covered correctly

[    0.401766] 0x0000000000a00000-0x0000000040000000        1014M
RW         PSE         NX pmd
[    0.403436] 0x0000000040000000-0x0000000080000000           1G
RW         PSE         NX pud
[    0.404645] 0x0000000080000000-0x00000000b9800000         920M
RW         PSE         NX pmd
[    0.405844] 0x00000000b9800000-0x00000000b9a00000           2M
RW                     NX pte
[    0.407436] 0x00000000b9a00000-0x00000000baa00000          16M
ro         PSE         x  pmd
[    0.408591] 0x00000000baa00000-0x00000000bbe00000          20M
RW         PSE         NX pmd
[    0.409751] 0x00000000bbe00000-0x00000000bc000000           2M
RW                     NX pte
[    0.410821] 0x00000000bc000000-0x00000000be600000          38M
RW         PSE         NX pmd

However, the fact that you can provide a case where it does fail
should be sufficient justification for taking this patch. I was just
trying to give more than a regression-tested-by
