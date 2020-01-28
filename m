Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F84C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E4E2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221900;
	bh=GWxwkadIlVobGboLxGw+xsL9+RnjZssd4gllY72ToZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jgs0sFx/QXJ79OL85mypbufVbOTF1/xrvMMkd7J3JbgiknqvWgPITgaMakgRnUW5s
	 xdnreau4sHIAahRvq0CvGMkXooyP0gvG8dQTd987k7rHIh9vatxPNF08VLxcXyQ+8y
	 Uxa3TPRVtog8qoB4k3+NXbUzne0D8b1k9zdH+St8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgA1Obk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733309AbgA1O1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:27:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16017207FD;
        Tue, 28 Jan 2020 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221660;
        bh=GWxwkadIlVobGboLxGw+xsL9+RnjZssd4gllY72ToZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGPz0bEyvywilTfliHEN2qt1Z6Mqb6uCbmyyp7FCV70Y2yZsWMhjxOvhk1tJQqUMJ
         BQ3KP5LQOkEemztqjXA+9vBgQ52OpkaROtRoCT7OBny1LHpzhTwZ+NN0ahEuzvNkpI
         8c/RXgbKRLmBKh0VpE1XlqsuvYLLQmEQM+vJSPDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 23/92] hwmon: (adt7475) Make volt2reg return same reg as reg2volt input
Date:   Tue, 28 Jan 2020 15:07:51 +0100
Message-Id: <20200128135812.082497945@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
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
@@ -296,9 +296,10 @@ static inline u16 volt2reg(int channel,
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
 


