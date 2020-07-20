Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D139CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFF622C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ykIsIdVy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRkBAS/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGTPfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:35:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgGTPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:35:04 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595259302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufuggYevdsxiEsM6XXjzZH3T4aQwv57H04VOD0n80js=;
        b=ykIsIdVy6iTVunurqGW6mvQzrsfYH8VAN+cS3RxVHx0+qNMCiIX9gYOdEHRD41S69Ajgwa
        NkIE8mbpV+65xIY6v3Wb5Jjvq/L+iwvgqUdRCdmbBkrd6wfAwizRWBs1FHwQB02KydPXDF
        XWAqKwvgX0oZq50FFF5uJDmN1vLtzNE145DVPHi1cCeNPtJWHoBef3nbEt+KPJQJYPbo12
        lxDUEvD/q6D/rCs1mAPMpNsPvJzyIhj+L40wpsE+yiNpSV5Uuten2f9YRQhairr30pV3+2
        WDmx6Oq8iE/uXUZov/8tUAtk6rq1L0CRcyG17iUSMiYxfYboMB3HHaU3Kzvv/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595259302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufuggYevdsxiEsM6XXjzZH3T4aQwv57H04VOD0n80js=;
        b=HRkBAS/x+gIamYfN5EbFxuu5i87i8FA/tuz+aMwEfMys6qT91oIp9W9ec/sW1xVDfFU6ar
        ojWiuAh4KStjgAAw==
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] fs/namespace: use percpu_rw_semaphore for writer holding
In-Reply-To: <20200719014954.GH2786714@ZenIV.linux.org.uk>
References: <20200702154646.qkrzchuttrywvuud@linutronix.de> <20200719014954.GH2786714@ZenIV.linux.org.uk>
Date:   Mon, 20 Jul 2020 17:41:01 +0206
Message-ID: <877duyryhm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> The MNT_WRITE_HOLD flag is used to manually implement a rwsem.
>
> Could you show me where does it currently sleep?  Your version does,
> unless I'm misreading it...

You are reading it correctly. This patch introduces new possible
sleeping for__mnt_want_write() when writers for a superblock are being
held.

The RFCv1 [0] is a variant that does not introduce sleeping, but instead
reverts back to per-cpu spinlocks.

Sebastian and I are requesting comments on these two possible
solutions. Or perhaps you have an idea how to solve the potential live
lock situation.

John Ogness

[0] https://lkml.kernel.org/r/20200617104058.14902-2-john.ogness@linutronix.de
