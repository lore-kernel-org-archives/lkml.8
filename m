Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C12DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429FF20707
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OhiFuqL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391628AbgEZV5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:57:12 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63630 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389257AbgEZV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:57:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590530231; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=Lx+JlsYWqs8sfPrQRTmH7W6Ju5CUj4LarP9b9J9tMIM=; b=OhiFuqL884sUy4VJsoO6MwbcPoU6ckp5T9xSYQBue688BgQhAY2/EzQu9ubxbj2MV0I+ng6L
 hywkEjsXWdgRxYfNZAiAHy79Dk0tgnjMxwqcWKaUidIxvEYVvI6hBdYVJkdAj7ydsZIewvrU
 zAlRLVGVuPaEU4moWtHX2HHRR/c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ecd90b6809d904967d341b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 21:57:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3277C433A0; Tue, 26 May 2020 21:57:10 +0000 (UTC)
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 074FDC433C6;
        Tue, 26 May 2020 21:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 074FDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        "'Guenter Roeck'" <linux@roeck-us.net>
Cc:     "'Will Deacon'" <will@kernel.org>, <linux-hexagon@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Masahiro Yamada'" <masahiroy@kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Arnd Bergmann'" <arnd@arndb.de>, <sidneym@codeaurora.org>
References: <20200526153004.GA74229@roeck-us.net> <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
In-Reply-To: <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
Subject: RE: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
Date:   Tue, 26 May 2020 16:57:07 -0500
Message-ID: <04ca01d633a8$9abb8070$d0328150$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKN1vNw91W6igT881KSGz5ZWBjxSQIw8CjPpzoaY0A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Nick Desaulniers
...
> On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> =
wrote:
> >
> > On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> > > It is very rare to see versions of GCC prior to 4.8 being used to
> > > build the mainline kernel. These old compilers are also known to
> > > have codegen issues which can lead to silent miscompilation:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58145
> > >
> > > Raise the minimum GCC version to 4.8 for building the kernel and
> > > remove some tautological Kconfig dependencies as a consequence.
> >
> > My hexagon compiler is v4.6.1, and I have been unable to find a more
> > recent version. Does anyone happen to have a pointer to a hexagon
> > toolchain with gcc 4.8 or later ?
>=20
> IIUC, hexagon moved to LLVM, though that target still has issues =
building the
> kernel.
> =
https://github.com/ClangBuiltLinux/linux/issues?q=3Dis%3Aopen+is%3Aissue+=
lab
> el%3A%22%5BARCH%5D+hexagon%22

Indeed, we did move to llvm.  The build works with the clang_rt-builtins =
lib.  But that issue indicates that it's an unnecessary wart to require =
that.  From what I understand, other arches contribute these builtins =
content to the kernel build, so we'll do the same.

I'll prioritize this update.

-Brian

