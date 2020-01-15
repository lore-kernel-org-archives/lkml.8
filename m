Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFAC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0692A2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAORtC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:49:02 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:33043 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAORtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:49:01 -0500
Received: from hyperion.localnet (unknown [193.22.133.58])
        (Authenticated sender: relay@treewalker.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 55298100004;
        Wed, 15 Jan 2020 17:48:58 +0000 (UTC)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
Date:   Wed, 15 Jan 2020 18:48:57 +0100
Message-ID: <2994787.aV6nBDHxoP@hyperion>
In-Reply-To: <1579096621.3.0@crapouillou.net>
References: <20200114150619.14611-1-paul@crapouillou.net> <8026844b-75d2-edfb-c3ed-fdabd34a9aa0@linaro.org> <1579096621.3.0@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 15 January 2020 14:57:01 CET Paul Cercueil wrote:
> Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano
> <daniel.lezcano@linaro.org> a écrit :
> > Is the JZ47xx OST really a mfd needing a regmap? (Note regmap_read
> > will take a lock).
> 
> Yes, the TCU_REG_OST_TCSR register is shared with the clocks driver.

The TCU_REG_OST_TCSR register is only used in the probe though.

To get the counter value from TCU_REG_OST_CNTL/TCU_REG_OST_CNTH you 
could technically do it by reading the register directly, if performance 
concerns make it necessary to bypass the usual kernel infrastructure for 
dealing with shared registers.

Bye,
		Maarten



