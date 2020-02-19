Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF0C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF8824656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="E2h0RvnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBSPUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:20:34 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50239 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:20:34 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so215135pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Em3jvMpoG6+GJQEY9U57tV7irSY3iA8g7/S/8uwtZME=;
        b=E2h0RvnSmdG+Xc9RTK9I+ESbzpL1oOgerAy4+KlIP4tPe2pgGfWzIvV8XKj1JBYfD2
         ht/o1jltbgQoweOV2/+G2BkhEDCocFbY2R8Z/z3Ka6yplJqH5JLr4MxNajJGp+MHicBX
         G3r2CRvL/mrV7xwyR7y8JQgVgCMYzKtPD5EEDGJfZN1LlHj5Yur/EVyzqcb7OFGh7fY8
         JdTmNGM7xnEmIg+7tpPMvfIgM27q9oECblY6obxQKB8TblbwUy09kHm85JTscuw7wBpU
         VZPXxI5HtmkHcQdPeAvR9QWtfGuUlam6bNnZORisE3oMzRvk18TikBUkHpqViVzlTtSl
         LyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Em3jvMpoG6+GJQEY9U57tV7irSY3iA8g7/S/8uwtZME=;
        b=hXbLCTAUbhTn3aCFD3Mxsoykl6qTqhqFyIaZtWuvFMruxyo/eieUC7bkE9Bl6IjSqF
         UBm0eQgV12p/y8epA+lYlpbRSQ47y8hwI4NRFUzuTw7sfNjtnkpcbfEyeEaR97VtFHt4
         fdp+VlMX8n448E9ply2IkNTJwN1ZbUD/b3HRBslyibKQNbLyhaKBKgK0OXosb5az5xEd
         Xf7C53MwkMEQ5caQLUP1EFfz562w+nLFibvvWTF7U/sZq6/Ns3QqS65UikEDwbytqpuF
         qOk6EYo4Vu9qmVBS+hsrkXSMsaUzZrnKt7OovOuRHo4TeZWe/6F5D5+cQ2cCPXsrDbdy
         PcVQ==
X-Gm-Message-State: APjAAAWoZ15ZLbHKHbaOHSE28pXMcu3OkPM7DJs6RBNF8G4+0OZlz+bf
        ZPNFDanCA+F4LDUQcS03giTdqA==
X-Google-Smtp-Source: APXvYqytamY/dcnalMnx+Zoy1ctB8P7Ag79qaldpvsIRvE+RHdckRb9hBSrcE1IGndy1cr5NbaMm0g==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr9504912pjn.117.1582125633732;
        Wed, 19 Feb 2020 07:20:33 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:45ec:b255:49fb:515e? ([2601:646:c200:1ef2:45ec:b255:49fb:515e])
        by smtp.gmail.com with ESMTPSA id j8sm215331pjb.4.2020.02.19.07.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 07:20:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] #MC mess
Date:   Wed, 19 Feb 2020 07:20:31 -0800
Message-Id: <49953812-0F54-4809-9DA7-8A6EA0B57A74@amacapital.net>
References: <20200219150507.GD18400@hirez.programming.kicks-ass.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219150507.GD18400@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 19, 2020, at 7:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Wed, Feb 19, 2020 at 09:21:15AM -0500, Steven Rostedt wrote:
>>> On Wed, 19 Feb 2020 09:15:41 +0100
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>=20
>>>>>=20
>>>>> Tony, etc, can you ask your Intel contacts who care about this kind of=

>>>>> thing to stop twiddling their thumbs and FIX IT?  The easy fix is
>>>>> utterly trivial.  Add a new instruction IRET_NON_NMI.  It does
>>>>> *exactly* the same thing as IRET except that it does not unmask NMIs.
>>>>> (It also doesn't unmask NMIs if it faults.)  No fancy design work.
>>>>> Future improvements can still happen on top of this. =20
>>>=20
>>> Yes please! Of course, we're stuck with the existing NMI entry crap
>>> forever because legacy, but it would make all things NMI so much saner.
>>=20
>> What would be nice is to have a NMI_IRET, that is defined as something
>> that wont break legacy CPUs. Where it could be just a nop iret, or maybe
>> if possible a "lock iret"? That is, not have a IRET_NON_NMI, as that
>> would be all over the place, but just the iret for NMI itself. As
>> that's in one place.
>=20
> I don't think that matters much; alternatives should be able to deal
> with all that either which way around.

Agreed. That being said, kernels without alternatives could prefer the varia=
nt where a CR4 bit makes regular IRET leave NMIs masked and a new IRET instr=
uction (or LOCK IRET, I suppose) unmasks them.=
