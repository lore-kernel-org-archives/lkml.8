Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE3C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DCD206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daemons-net.20150623.gappssmtp.com header.i=@daemons-net.20150623.gappssmtp.com header.b="jHpY8l5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503244AbgDPJA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503089AbgDPI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:57:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:57:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d17so1353849pgo.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daemons-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WhoZsJiZov2jfSxLGEtmiUut+TNZxfA/4UuVClNzr0=;
        b=jHpY8l5EA3+YW5OG9e0VYhz/NzapK19wtLTeBckhDS8G0iv/JnvFI3KhBgA8HT2kUm
         RO5bKx47ZhsvpuMwnd2IJwj42Dhl33PVwuPNE0XV3HKVl+qOreRwv9BsZI1Vs69c5qjt
         gi2UdrnPZ2bnv4UmSfjz8GQQMZBIGSHi4oYN9Paocq9BJBmgwxcmLwcN7T859cjKUjhk
         SmIrs9QoojeRFbklXMWVouoeyvytOMMuz2kZKnk/P8HH7EBnnQlNIIuo4+geFzJ7EapO
         P3N4mUBxWGjasviGxpAW1cGtu3IQoi9LX90RCU11vvuIY7MLRqBwK+9rDpNdc5Gt+XXE
         hjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WhoZsJiZov2jfSxLGEtmiUut+TNZxfA/4UuVClNzr0=;
        b=Dkukpm+ZlGPO0tsxBXsCJY7w89CMb2BSrFTkZjLhV+sD0/xTSl5LZbb8qYvL0QSXz1
         9hJbFqhr+e5pe2QdQcdp1H/OE7yikbI8KRzZY5psSWRzs1b25OACn46ThPNg3fBC6nLx
         aeeLWI9niPsnxFmPEjAmjRcvhFleWpMsHDQVQt6Xirbnr4YHX6Do4CVGJWiw7bmPLjK2
         jmluRYz0GiJmVcr10oR2eGTxfU09aJ087j80kc3zx+S6BSXZ7jwHW7k8OEQWwCrgunc/
         1YOWOFCaNnTZlXOLRGce2cFHXV9yhoOdiQkwzdJCQcT5NvA3wW/aHp8lur6aDIm/AkO+
         wYmg==
X-Gm-Message-State: AGi0Pub7+Np6IOVgOnBiGHJ757yC4oGgu+IERC3i0Z6ufwspp1y3eY8b
        b5oeOhOtkjuKvVVw1SdMX9VG
X-Google-Smtp-Source: APiQypLtw7jKrx1finbL2m0OXLHS4c3y7qRzSB9kUcdRDN8RB6LcSHAIJ0x1AUc/8C91ijJiX9g75w==
X-Received: by 2002:a63:6f84:: with SMTP id k126mr31197858pgc.391.1587027473270;
        Thu, 16 Apr 2020 01:57:53 -0700 (PDT)
Received: from localhost.localdomain ([47.156.151.166])
        by smtp.googlemail.com with ESMTPSA id x10sm88957pgq.79.2020.04.16.01.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:57:52 -0700 (PDT)
From:   Clay McClure <clay@daemons.net>
Cc:     Clay McClure <clay@daemons.net>,
        "David S. Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: cpts: Condition WARN_ON on PTP_1588_CLOCK
Date:   Thu, 16 Apr 2020 01:56:26 -0700
Message-Id: <20200416085627.1882-1-clay@daemons.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPTS_MOD merely implies PTP_1588_CLOCK; it is possible to build cpts
without PTP clock support. In that case, ptp_clock_register() returns
NULL and we should not WARN_ON(cpts->clock) when downing the interface.
The ptp_*() functions are stubbed without PTP_1588_CLOCK, so it's safe
to pass them a null pointer.

Signed-off-by: Clay McClure <clay@daemons.net>
---
 drivers/net/ethernet/ti/cpts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index fd214f8730a9..daf4505f4a70 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -646,7 +646,7 @@ EXPORT_SYMBOL_GPL(cpts_register);
 
 void cpts_unregister(struct cpts *cpts)
 {
-	if (WARN_ON(!cpts->clock))
+	if (IS_REACHABLE(PTP_1588_CLOCK) && WARN_ON(!cpts->clock))
 		return;
 
 	ptp_clock_unregister(cpts->clock);
-- 
2.20.1

