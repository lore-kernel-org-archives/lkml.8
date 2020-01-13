Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457CAC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A8A207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="eJqV/Blg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgAMQdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:33:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53452 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgAMQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578933217; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=XRwA+3aV7+4LONTlYatRkwiJF+cX802eXnxLHy6lA4o=;
        b=eJqV/BlgT0xeSIjreb6BmPoU3JAB9KQa06BsJJHgn+ZLECZUIG9x5828V6bezl2/doE/m6
        c51ufp7XLIZXOoFRYraWIXcBPdAhjTBAifXa/GIi5qtWcuzJWnfT+R623nmwUfciV6fZvx
        XPvpBvB166z8puEugeeizrKzHb+hI6I=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org
Subject: ingenic-irq bugfix for 5.5-rc7
Date:   Mon, 13 Jan 2020 13:33:28 -0300
Message-Id: <20200113163329.34282-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear irqchip maintainers,

I have this patch which fixes a bug that was introduced in 5.5-rc1.
I sent the v1 for -rc3 but it never got picked up.

Could you merge it for -rc7 (if -rc7 there is)?

Thanks,
-Paul


