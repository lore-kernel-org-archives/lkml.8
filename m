Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A732C207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRq9tkO9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmlOq4+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgG2Juz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgG2Juy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:50:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC22C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:50:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596016252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEp89+etIGJZdpdVKttldSzJgWyllaXhBDptvwj7oJA=;
        b=cRq9tkO98RD8oRNAY8eZmj9a9Xw2bHDfLEjua9fNYEQqSO1kiOHipiLyeo7nyuIMsYTGsR
        Hsc0++6tdusDpyt+bHUooW5YLZR5W5Sk2cHD+hlLjDLQLY6sAbxmJza5/arfrxdN86DtIT
        Tml2XGbHBpmYY5YUo2EYX56iHjzEsuKnO0GnrC0s7SWRtzJ8fXBR38tRHKXmbphWoB/Oqq
        27omrcPWl3qrLfap1YyeN9ZZMKVSb3JFyjyBKcLL/DXNf4cJMWmJwnSRT4lds+4JXJ1wPA
        3dxsKs8Lj5bPaBrxJ0Y+7JoY+RUXRXPWacv/36rU4ug0CR7H4yB5CeEU14arFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596016252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEp89+etIGJZdpdVKttldSzJgWyllaXhBDptvwj7oJA=;
        b=DmlOq4+6WAcU1nUqOjhBQLvwpDF/xtuzHXxgUwE0NbH/QW+b+9yCiZSi0+7WYnQBH3V7Cb
        IMcaS2z10nZczzCw==
To:     Scott Branden <scott.branden@broadcom.com>, bp@alien8.de,
        x86@kernel.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
In-Reply-To: <cc298d3e-9a14-d3e1-025b-6bb1f8bfb4ae@broadcom.com>
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com> <87h7tsbs1n.fsf@nanos.tec.linutronix.de> <e0ce41cd-9149-e43e-f4ca-e75503cb82e3@broadcom.com> <87blk0aw1k.fsf@nanos.tec.linutronix.de> <cc298d3e-9a14-d3e1-025b-6bb1f8bfb4ae@broadcom.com>
Date:   Wed, 29 Jul 2020 11:50:41 +0200
Message-ID: <87y2n2abv2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott,

Scott Branden <scott.branden@broadcom.com> writes:
> On 2020-07-28 1:22 a.m., Thomas Gleixner wrote:
>> Scott Branden <scott.branden@broadcom.com> writes:
>>> Bios now updated to latest.=C2=A0 Same kernel panic issue.=C2=A0 Log be=
low.
>>>
>>> I think it is related to power cycling quickly.
>>> Should APIC work if PC power cycled in a few seconds or is that the
>>> problem?
>> Yes, emphasis on should. Just to clarify, if you reboot it works and
>> cold start works as well if power was off long enough?
>>
> So far I have only been able to reproduce the issue by cold start with po=
wer off for only a few seconds
> before re-powering the system.=C2=A0 It has not failed via reboot yet tha=
t I remember.
> Will have to keep my eye on whether using reboot is an issue or not.
> And also keeping power off longer when doing a cold start.

Weird.

> Please find attached the failed console log with ignore_loglevel.

Aside of the differences caused by the BIOS update there is nothing
related to the APIC/IO-APIC setup which is different between the working
and failing boot.

TBH, I have no idea what's going wrong there. Maybe Tom has one.

Thanks,

        tglx
