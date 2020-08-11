Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39950C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140FB20658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Juf+yHfc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1exNlk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgHKN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgHKN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:29:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0AC06174A;
        Tue, 11 Aug 2020 06:29:58 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:29:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597152596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZ6A5/kzMkXWVeJuDcoHcY5nM0zkWDNna3e2uRXqHQA=;
        b=Juf+yHfcBkYe6bAfw6WxOQvpirc4lfDCFnOiR3YHRhxqVbcbAnvxjivxZcAb2NLzf4IWpn
        g5wCEEEn2ky3uRxYzrCbA2K19IGnq49RJaJSeQ0RWi0LDudzEZDowRWgl2cojdcfibZING
        Qlxce+3bSp1fmBVQ+aSIiGqKB5bap3TJAIZeo7w92OnASXavrrYc0hVNz+Rn4/kwdqdOR4
        4vScdIuS/El2L6GkaRSsrPICGPIZTaMwuXPHZwHycT/hgZPpXQ8dwLghyoxbhgyWNz3GnJ
        nVjIDEICgVhPQwHlbul6pw8Vb3UHkAtRKIiwQaEMSAUFJ9/4fXbM2XkVxqtFeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597152596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZ6A5/kzMkXWVeJuDcoHcY5nM0zkWDNna3e2uRXqHQA=;
        b=y1exNlk+0HMDA7+aAsA1SBk9R7OQJG5nnMW8Napf6I8zRqjeRc57Gd/EvsyXRjwXtx8nGH
        TGI9uok3a2ngGRDg==
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
Message-ID: <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
References: <871rmesqkk.fsf@gmx.net>
 <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net>
 <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de>
 <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de>
 <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87imdp5r80.fsf@rub.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-11 13:58:39 [+0200], Stephen Berman wrote:
> him about your workaround of adding 'thermal.tzp=300' to the kernel
> commandline, and he replied that this works for him too.  And it turns
> out we have similar motherboards: I have a Gigabyte Z390 M Gaming
> Rev. 1001 board and he has Gigabyte Z390 Designare rev 1.0.

Yes. Based on latest dmesg, the ACPI tables contain code which schedules
the worker and takes so long. It is possible / likely that his board
contains the same tables which leads to the same effect. After all those
two boards are very similar from the naming part :)
Would you mind to dump the ACPI tables and send them? There might be
some hints.

It might be possible that a BIOS update fixes the problem but I would
prefer very much to fix this in kernel to ensure that such a BIOS does
not lead to this problem again.

> Steve Berman

Sebastian
