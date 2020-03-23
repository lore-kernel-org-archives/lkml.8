Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1446DC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC61E20753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfUesMTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCWC5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:57:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38836 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCWC5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:57:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id z25so2441204pfa.5;
        Sun, 22 Mar 2020 19:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzKNp0Bukz0SfQKbFYnotqvXt5RjOKiGdbp496IXj9s=;
        b=lfUesMTjlNPx60Mxt/CMQDqFO8n68Fw8/VgDDp3OFQrayJ3kqJZ9QcTJKsYZ24SMae
         adSIr+c2NX9B0KllH4wLrlb1IXoiEcZKwWsI8E0krisUwJ405gfBS7dkloi+dxC7j2jk
         MLQdphP2uZWADPW8tSOnMMXGEZnvbNdsYPRm7bRv1tvp9R71409DVVgYNEKOqyi/Bk0J
         Bqw4eSQ3mSDx4rxORkvxiLCsVKPgAmT9/YlXU3ZCo2gXQNBEeKU94s1FQPsLlDXMXqtB
         exmMdIi1UGfQYuooGImXVB765ml356wFCMoVAhsalI7zhvYIn6AJrGWmvvUEEa8KzWX8
         xbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzKNp0Bukz0SfQKbFYnotqvXt5RjOKiGdbp496IXj9s=;
        b=I53j9LDkuxcQc0l30dxfdsS7TDQazd65uxXvr+kQnbCL/Vzq2DI1iv1ILlrgLnxtaa
         iXB/tJ973Db3fWi2JjhOPxygbgThk84xw+B4nnKJQlo+LpBR/UdmbcDA6IIIN7DnDwEF
         MbPAnHQv2Zwk1PkIY1trwQNDgpuieYHBQIvTA9vOL02IlUnq9vkiyAjv/Ngq9l67QAEd
         0VF9j/3Rf1hxvnotdWt/+UQs4twuCpWFoL5AwoAAkQa61qS5PmonILVdBwPSHGIffLz0
         RgHO1ZrmJ3lpd8BFNEF3fYMUt160PHNOwI6vYSFL2CLlK/uXQghG/f8E/53IGNurwHzP
         JwOg==
X-Gm-Message-State: ANhLgQ0d4pq/2ivdTSj45s2Bw+bkFifF+AhPdZcNT7JUN21ubAPBKlR9
        WyPoAnq/0uu/svbca3bmtEo=
X-Google-Smtp-Source: ADFU+vszrweFVXNu6W95SNoRNuCRbsBDNVk3gSGCKWjTZnBT1DKicvz+GEPjS8Dbz1OaFgb2V18zdg==
X-Received: by 2002:a62:ce48:: with SMTP id y69mr21861018pfg.178.1584932255139;
        Sun, 22 Mar 2020 19:57:35 -0700 (PDT)
Received: from localhost (104.128.80.227.16clouds.com. [104.128.80.227])
        by smtp.gmail.com with ESMTPSA id 71sm12103932pfv.8.2020.03.22.19.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 19:57:34 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        broonie@kernel.org, tglx@linutronix.de, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v6 07/10] net: phy: introduce phy_read_poll_timeout macro
Date:   Mon, 23 Mar 2020 10:56:30 +0800
Message-Id: <20200323025633.6069-8-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323025633.6069-1-zhengdejin5@gmail.com>
References: <20200323025633.6069-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is sometimes necessary to poll a phy register by phy_read()
function until its value satisfies some condition. introduce
phy_read_poll_timeout() macros that do this.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v5 -> v6:
	- no changed.
v4 -> v5:
	- no changed.
v3 -> v4:
	- deal with precedence issues for parameter cond.
v2 -> v3:
	- modify the parameter order of newly added functions.
	  phy_read_poll_timeout(val, cond, sleep_us, timeout_us, \
				phydev, regnum)
				||
				\/
	  phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, \
				timeout_us)
v1 -> v2:
	- pass a phydev and a regnum to replace args... parameter in
	  the phy_read_poll_timeout(), and also handle the
	  phy_read() function's return error.
 
 include/linux/phy.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 42a5ec9288d5..f2e0aea13a2f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -714,6 +714,19 @@ static inline int phy_read(struct phy_device *phydev, u32 regnum)
 	return mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, regnum);
 }
 
+#define phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, timeout_us) \
+({ \
+	int ret = 0; \
+	ret = read_poll_timeout(phy_read, val, (cond) || val < 0, sleep_us, \
+				timeout_us, phydev, regnum); \
+	if (val <  0) \
+		ret = val; \
+	if (ret) \
+		phydev_err(phydev, "%s failed: %d\n", __func__, ret); \
+	ret; \
+})
+
+
 /**
  * __phy_read - convenience function for reading a given PHY register
  * @phydev: the phy_device struct
-- 
2.25.0

