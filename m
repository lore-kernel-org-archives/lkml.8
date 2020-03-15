Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A7C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F2E206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCOIst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 04:48:49 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:42493 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgCOIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 04:48:49 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id EAD41102CB03D;
        Sun, 15 Mar 2020 09:48:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 829D1784E5; Sun, 15 Mar 2020 09:48:46 +0100 (CET)
Date:   Sun, 15 Mar 2020 09:48:46 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] irqchip fixes for 5.6, take #2
Message-ID: <20200315084846.h222n5pf4jvpojec@wunner.de>
References: <20200314103000.2413-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314103000.2413-1-maz@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 10:30:00AM +0000, Marc Zyngier wrote:
> This is hopefully the last irqchip update for 5.6. This time, a single
> patch working around a hardware issue on the Cavium ThunderX and its
> derivatives.

Hm, I was hoping to see the BCM2835 irqchip fix in this pull:

https://lore.kernel.org/lkml/f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de/

That patch fixes a pretty grave issue so I'd be really grateful
if anyone could pick it up (or provide feedback why it can't be
picked up just yet).

Thanks!

Lukas
