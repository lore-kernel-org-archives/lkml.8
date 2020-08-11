Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C199BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11D92076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PsJbheuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgiItwsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHKStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:49:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:49:06 -0400
Date:   Tue, 11 Aug 2020 20:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597171744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwCD0bfL2AO9ImN2u7oI41Ra7cPPPpKJOGgaL2jx1Hs=;
        b=PsJbheuLB+TB0qz3bco9sz/QmSvo6EAMMxbttJ/tIDnUitgm9vn4EI3XyivAKL0Tv4lM2E
        M+sVD2rs5XINF7tFbA0a4Q9IJnBWUiVxa+lpKtathfONCaqGnFGyl5dHDRZJi75MMrQkOT
        FNklLUkIdCij6W1B7jxgUx+ammke8172oRcgv8AZ18lx7SMpspxvoV3KxDrGSX7q6AAHA3
        K2HfO5TiZJMOFlNdt+iimniyGfhIvkvyHhh6lWQKyfID9QSYY90Q2l/5u4AA4wqR3FjMm4
        9Fzz27sfQA4fE1mwQUlXy1BzMt8lOdhpOISXK5rYMETXzw7JXPsF8/kWn3GQ7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597171744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwCD0bfL2AO9ImN2u7oI41Ra7cPPPpKJOGgaL2jx1Hs=;
        b=OgiItwsr/YUIAS8bO43cL5thnZ1bNYRQRZpkt0u7i6JfF7f4dyeXuHcB2BXS8ok+oPUo7h
        I4rXhsWeULTTVpDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Stephen Berman <stephen.berman@gmx.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200811184902.2fm4eyprmpkfon2j@linutronix.de>
References: <87ftak2kxr.fsf@rub.de>
 <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
 <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de>
 <87ft8tayic.fsf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ft8tayic.fsf@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-11 19:22:19 [+0200], Stephen Berman wrote:
> Attached.

ssdt6.dsl:
|  ThermalZone (TZ10)
|  {
=E2=80=A6
|      Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
|      {
|          Return (0x0A)
|      }
|
|      Method (_TZP, 0, Serialized)  // _TZP: Thermal Zone Polling
|      {
|          Return (0x0A)
|      }
|
|      Method (_TMP, 0, Serialized)  // _TMP: Temperature
|      {
|          \GSA1.ZRC3 ()
|          Sleep (0x03E8)
|          Notify (\_TZ.TZ10, 0x81) // Thermal Trip Point Change
|          Return (0x0B54)
|      }

So if I read this correctly then TZ10 should be polled every second
(check) and the temperature function contains a `sleep(1 second)' (which
explains the mysteries delay) followed by the Notify() (which schedules
the worker).

Now I'm curious if Windows has the same ACPI tables and if so how they
behave here. And what the actual plan here was. And where is the border
when one is actual allowed to make fun of someone. So many questions.=20

> Done as Bug 208877.

Thank you.

> Steve Berman

Sebastian
