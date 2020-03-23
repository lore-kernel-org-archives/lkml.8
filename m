Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D0EC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E172051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ExJOIBtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCWTGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:06:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46503 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgCWTGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:06:18 -0400
Received: from [IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372] ([IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02NJ62Fm2760285
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Mar 2020 12:06:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02NJ62Fm2760285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1584990363;
        bh=V96rP9qPNSGHB0sPwuo9BpjxTSEllPUoz1YdTWSVO8Q=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=ExJOIBtH1E/BFzx/YPt3fR+N2y8jalAjj9kEOIAghpbCp9acl6te8U+Jw5kPSfIFy
         sPVanKKWWkEPkLlc4NlU3cuKPO1pfkIvlAtStiIksCYAsugyq5zziH1d369g4P6+M9
         qgzmq1fsPYFwy7XcXWArSYXT7AB9Z3LMdLrTlvXZ607iLzKPGW4O2N0h0zSFlKd2de
         tVNDWKU7iX0KwLMuw+vbMacbHFPs5KhzJibNu5RIdZIEoa+9NshYjJhi55sQnxNyUP
         /YHpG/VUSncgYhuVNTq3GOen+ul3VtA8QcVKxFPV334dS/nSh00KR4LeIW9HHx/k9S
         wBSIvZ5KT/nDA==
Date:   Mon, 23 Mar 2020 12:05:54 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com> <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com> <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com> <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>
CC:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 23, 2020 11:54:28 AM PDT, ron minnich <rminnich@gmail=2Ecom> wrote=
:
>On Mon, Mar 23, 2020 at 11:19 AM <hpa@zytor=2Ecom> wrote:
>> Pointing to any number of memory chunks via setup_data works and
>doesn't need to be exposed to the user, but I guess the above is
>reasonable=2E
>
>so, good to go?
>
>>
>> *However*, I would also suggest adding "initrdmem=3D" across
>architectures that doesn't have the ambiguity=2E
>
>agreed=2E I can look at doing that next=2E
>
>ron

I would prefer if we could put both into the same patchset=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
