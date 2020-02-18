Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA5C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DDA24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="DtallBkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBRXRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:17:21 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46306 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgBRXRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:17:21 -0500
Received: by mail-pl1-f180.google.com with SMTP id y8so8693899pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 15:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HW0f7ogGgP+s4wbA1fzYPtfTD5QBVT31QoXtafUKOwE=;
        b=DtallBkSygU6YUkW8Lqhfd7+dasPA+PrmI94kCXvR8lBPBFjQPbnYT6ruik66WB5ID
         jsMr6+LHWes21i38H4ornVK/EnpbtG010Yx9Fm7CeVxjby5e8WDwLhrNBNDLd5tW7TUT
         mtLVC17LuvL0cp5GzvrA3lrUt5YI+1B1rfvarFyOEY/stdoiOvLmDS27qh69CQJXA01W
         Obyjky79phfZ7MHsS1N3xAcd1Dc3ZsmfrSYsgG2NgNk7+rFQcomSXN2nhiQyNJ+x6fCn
         zb7tO5mLN8aMaiTutkfK7RKMqs/XLH+kcxq0pUZMpVEuH2bn92yKOe5TxoxxG3xVtALL
         HgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HW0f7ogGgP+s4wbA1fzYPtfTD5QBVT31QoXtafUKOwE=;
        b=ULEw2i5Q0HyC8pf/3XVXu99pEXe6LAerBWMK/jn17kJYcTscLI2tQ2hWCVHRoCsqI0
         6Cskp2XBCLAmtrNrOc2ixoOrifhzhfJ5eBomQ+kg69YpkYMu+eRpMOBsgqZg3ogYee62
         jPxN1R3e7rWekwnjKFTPmwysIY/RUHk/RIlIqrsGnW0DJCqyzRKy6+A3c2iWYHM/a+lX
         sXhPYNvuTHSgfyUBu3Lb80czXBaIGtAtGGYGLyUxwoneirTzG9L70K7ihmTcLHVhwAIX
         0X45V+jJVFs4tOYV3RDGffDNablmUDddXVbDIbW9U3pdlGOyJcNfcFytLnptXLaxyaMF
         WKYQ==
X-Gm-Message-State: APjAAAWNb+qfeVyUc87k/u6crbaUmbH4u6gzzDcDvCHOzQugiLhJtB2L
        JwMR3ejqdZwHasZJQz4rhWUrUA==
X-Google-Smtp-Source: APXvYqy5n0AaLcuryF09nqP5kElfIhvcCpVeNbugdeP039AIvb6dnfuLDFE3tceAHX1Y93xt7wd5gw==
X-Received: by 2002:a17:90a:5d18:: with SMTP id s24mr5170247pji.141.1582067840913;
        Tue, 18 Feb 2020 15:17:20 -0800 (PST)
Received: from [10.234.160.59] (58.sub-97-41-129.myvzw.com. [97.41.129.58])
        by smtp.gmail.com with ESMTPSA id e1sm62921pff.188.2020.02.18.15.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 15:17:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] #MC mess
Date:   Tue, 18 Feb 2020 15:17:18 -0800
Message-Id: <A3AAF46E-437D-420C-BF0C-C2394B48C9F4@amacapital.net>
References: <20200218200200.GE11457@worktop.programming.kicks-ass.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20200218200200.GE11457@worktop.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 18, 2020, at 12:02 PM, Peter Zijlstra <peterz@infradead.org> wrote:=

>=20
> =EF=BB=BFOn Tue, Feb 18, 2020 at 06:20:38PM +0000, Luck, Tony wrote:
>>> Anything else I'm missing? It is likely...
>>=20
>> +    hw_breakpoint_disable();
>> +    static_key_disable(&__tracepoint_read_msr.key);
>> +    tracing_off();
>> +
>>    ist_enter(regs);
>>=20
>> How about some code to turn all those back on for a recoverable (where we=
 actually recovered) #MC?
>=20
> Then please rewrite the #MC entry code to deal with nested exceptions
> unmasking the MCE, very similr to NMI.
>=20
> The moment you allow tracing, jump_labels or anything else you can
> expect #PF, #BP and probably #DB while inside #MC, those will then IRET
> and re-enable the #MC.

Huh?  As I understand it, there is no such thing as MCE masking.  There are t=
wo states:

CR4.MCE=3D1: MCE is delivered when it occurs.

CR4.MCE=3D0: MCE causes shutdown

MC delivery sets MCE=3D0.

So, basically, without LMCE, we are irredeemably screwed.  With LMCE, we are=
 still hosed if we nest an MCE inside a recoverable MCE.  We can play some g=
ames to make the OOPS more reliable, but we are still mostly screwed.

The x86 MCE architecture sucks.

>=20
> The current situation is completely and utterly buggered.
