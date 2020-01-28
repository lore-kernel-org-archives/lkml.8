Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49637C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178EC24690
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220024;
	bh=MO0ELrj1KzxjSS2xdC5JTxinYO/0bCr9wfQgQ9rxuBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FtdnmC74mAqDDuvbrRfNtsOL9lnNAv7XKWle+B/HemmetXJomMy9SRxI15YT66NMn
	 xHJFYKyARhF2fzvffZhcwvJ0QnhFV1orRvVtlwH021TvnefesKxKG/f+hCj8OvBqqD
	 nz49M5m5FrFw8PEBequusWy9co1/agRtVfQCbcjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA1OAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgA1OAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:00:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755D324697;
        Tue, 28 Jan 2020 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220021;
        bh=MO0ELrj1KzxjSS2xdC5JTxinYO/0bCr9wfQgQ9rxuBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0RsG+JoaKirwGdkNK5o+rN2R3xrdhA4mXP6iwrljZjyZ8xrZtaWsut24bmCn9ezjb
         255+i8kCitm8hH3ILgd2x/jwJlnPNW7iN8WN+zbV61x+mAZZt7e+QdrW6F98oS0cDl
         dY6O56l3vKX9BFangzykiL2e5T0hQ2ZAepjyAZQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 27/46] Input: pm8xxx-vib - fix handling of separate enable register
Date:   Tue, 28 Jan 2020 14:58:01 +0100
Message-Id: <20200128135753.320495327@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit 996d5d5f89a558a3608a46e73ccd1b99f1b1d058 upstream.

Setting the vibrator enable_mask is not implemented correctly:

For regmap_update_bits(map, reg, mask, val) we give in either
regs->enable_mask or 0 (= no-op) as mask and "val" as value.
But "val" actually refers to the vibrator voltage control register,
which has nothing to do with the enable_mask.

So we usually end up doing nothing when we really wanted
to enable the vibrator.

We want to set or clear the enable_mask (to enable/disable the vibrator).
Therefore, change the call to always modify the enable_mask
and set the bits only if we want to enable the vibrator.

Fixes: d4c7c5c96c92 ("Input: pm8xxx-vib - handle separate enable register")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200114183442.45720-1-stephan@gerhold.net
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/pm8xxx-vibrator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -98,7 +98,7 @@ static int pm8xxx_vib_set(struct pm8xxx_
 
 	if (regs->enable_mask)
 		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
-					on ? regs->enable_mask : 0, val);
+					regs->enable_mask, on ? ~0 : 0);
 
 	return rc;
 }


