Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7796A2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qusWOtvo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQNrVnCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGHT3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:29:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:29:54 -0400
Message-Id: <20200708192804.911958542@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594236593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=09cNi+ya/8B7RJmmC0E8V+/roSs8mduHpnGmmws4aaE=;
        b=qusWOtvobklnRP1ntJFsERlbaM4LWnsRbWqkvAHTduQVfH/+AL44CDJjK7veiJy50JnJRH
        d9QXuGF2J7vU4P/Vpm/xI5Viv5vr2yIJtrNIWmZ7ff+JEPaaAJvk27lcOFIjEatfxsvmRu
        oe4GguQWWESsjJKIB98HSyz+SDTJHe00h/V6/7NVXJEumLws1pQ+PcjytTxQCHSJtX+f4m
        cPL1l90henvXCE7lgKYYabxRYMbZiCYsmcth6T+lC0kSDdVFTfrISW5L3ndEhrO8wXZ/OR
        suvz94cIimZatM748DUK+LvMeY+KLAk0rxAZda74yxwn7Pu4HpoHnmFWLFgOmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594236593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=09cNi+ya/8B7RJmmC0E8V+/roSs8mduHpnGmmws4aaE=;
        b=hQNrVnCTfVG5GEAplyg0jtJvcAs5dzLuLCeubFk5dCDBIBGvzrlXO/gBfJnuS6xEDn+hqA
        1aRDraQ942VPGuCg==
Date:   Wed, 08 Jul 2020 21:28:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 0/3] x86/entry: A couple of small fixes
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Syzbot reported a missing local_irq_disable() in exc_alignment_check()
 - A missing noinstr annotation
 - Make a function static which is not longer used from ASM code

Thanks,

	tglx

