Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1022C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9A2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MhwLj8NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgANVuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:50:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47809 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANVuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:50:50 -0500
Received: from [IPv6:2601:646:8600:3281:c828:41c1:36f7:c8af] ([IPv6:2601:646:8600:3281:c828:41c1:36f7:c8af])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 00ELoEPA1898256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 14 Jan 2020 13:50:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 00ELoEPA1898256
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019122001; t=1579038620;
        bh=rkeRfPFHTc+5NL7sN3HZXzTblD/s00mMdjqcm9nyKTE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=MhwLj8NJBq/4aXiBEyWRAf+M/jxazntx81jl8BrhzHqKRSLAVhAbsw12nppjHcdlp
         p5Tmr8oJBYG2sx3rZ9AM8tekXY3RQTpjhHZwTkeovdhY4QYZIajmw2Y+Ct7KmQzjhs
         OdEG0T72VP2hqvrGCvTlg117aERn0MI+ERapr3uzvgQ6DLGzxjZPLKsz6fLsCPBfcF
         eonoKZvL6QmMwVYewD6pOMj4Z7o/wTahjANZKX0vdwySuBInnmucnJlBdlMSkejB1I
         uxcjG4Vwasthi+L01CoMwRKO+9RbtZuKoQDsXYYHiuDZuWkhFfAv/+Z1VR3Cx/BjGu
         evChH3KtVTBDA==
Date:   Tue, 14 Jan 2020 13:50:05 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200114165135.GK31032@zn.tnic>
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu> <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
To:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>
CC:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
From:   hpa@zytor.com
Message-ID: <27433E59-971A-4885-B74C-2D6844372FE6@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2020 8:51:35 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Mon, Jan 13, 2020 at 05:53:32PM -0800, Kees Cook wrote:
>> NAK: linkers can add things at the end of =2Etext that will go missing
>from
>> the kernel if _etext isn't _outside_ the =2Etext section, truly beyond
>the
>> end of the =2Etext section=2E This patch will break Control Flow
>Integrity
>> checking since the jump tables are at the end of =2Etext=2E
>
>Err, which linkers are those? Please elaborate=2E
>
>In any case, after reading the thread, I can't help but favor the idea
>of us bumping min binutils version to 2=2E23=2E
>
>Michael (on Cc) says that the 2=2E21 was kinda broken wrt to the symbols
>fun outside of sections, 2=2E22 tried to fix it, see
>
>fd952815307f ("x86-32, relocs: Whitelist more symbols for ld bug
>workaround")
>
>which Arvind pointed out and 2=2E23 fixed it for real=2E
>
>Now, 2=2E23 is still very ancient=2E I'm looking at our releases: openSUS=
E
>12=2E1 has the minimum supported gcc version 4=2E6 by the kernel and
>also the minimum binutils version 2=2E21 which we support according to
>Documentation/process/changes=2Erst
>
>Now, openSUSE 12=2E1 is ancient and we ourselves advise people to update
>to current distros so I don't think anyone would still run it=2E
>
>So, considering that upping the binutils version would save us from all
>this trouble I say we try it after 5=2E5 releases for a maximum time of a
>full 5=2E6 release cycle and see who complains=2E
>
>Considering how no one triggered this yet until Arvind, I think no one
>would complain=2E But I might be wrong=2E
>
>So what do people think? hpa?

I'm all for dumping support for an ancient, known buggy binutils=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
