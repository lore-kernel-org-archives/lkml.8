Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4357C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C752468A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221487;
	bh=rz9au/x2/LhW2l2P+rOP9AVynizyhC9avk5oBjR3xvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G+XSZrghY0gkqde3iBjUObiDUlV1qwU29NboQAf7+7gsk32liDHEstbRKWXRc2dSg
	 l5k9Om6CQX2+Yb3wBA0IKW3wykULD/ddzBrv5BsxK/9mZLvKn8eHyF5FEibVZ/tmD3
	 ZMYKhjEXeApC4gspsvQR2rf2DI58gWlyug+Pka2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbgA1OYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732370AbgA1OYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:24:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1526B24686;
        Tue, 28 Jan 2020 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221482;
        bh=rz9au/x2/LhW2l2P+rOP9AVynizyhC9avk5oBjR3xvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tq9/JJHRXKXfdRf8S2IO9gOU/4Mod38jzESjnLUkEQ8Xfs8u5xWW4+Q41ckhgDGc1
         4CpukFcisw9iQC1vDJlvdEibMvM+kQOvOjk0C1CmzTVUhVfrm6AXLrGM6vBnt9G7ga
         N8CtmCWZZdfSYXXSpRYqYnqtJ9o2tJVeNwhkGtGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 243/271] hwmon: (adt7475) Make volt2reg return same reg as reg2volt input
Date:   Tue, 28 Jan 2020 15:06:32 +0100
Message-Id: <20200128135910.618534426@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>

commit cf3ca1877574a306c0207cbf7fdf25419d9229df upstream.

reg2volt returns the voltage that matches a given register value.
Converting this back the other way with volt2reg didn't return the same
register value because it used truncation instead of rounding.

This meant that values read from sysfs could not be written back to sysfs
to set back the same register value.

With this change, volt2reg will return the same value for every voltage
previously returned by reg2volt (for the set of possible input values)

Signed-off-by: Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191205231659.1301-1-luuk.paulussen@alliedtelesis.co.nz
cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/adt7475.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -268,9 +268,10 @@ static inline u16 volt2reg(int channel,
 	long reg;
 
 	if (bypass_attn & (1 << channel))
-		reg = (volt * 1024) / 2250;
+		reg = DIV_ROUND_CLOSEST(volt * 1024, 2250);
 	else
-		reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
+		reg = DIV_ROUND_CLOSEST(volt * r[1] * 1024,
+					(r[0] + r[1]) * 2250);
 	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
 


