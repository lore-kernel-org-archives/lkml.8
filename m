Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD38C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38A520714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBTpEDKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCWPHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:07:07 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40317 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCWPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:07:07 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so420243pjb.5;
        Mon, 23 Mar 2020 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MpbsxkMsipQtpohRydTulbwXff0/qt3sQOmvykiETg=;
        b=cBTpEDKcnhGaqQ3exc/WXly55OBJhCzB4vTUuDwDkiNniYZIRXg+HcXkH0ApjOptUZ
         IW7qelhh1g11fRGmmG8Co+qqOkllZlPon8RMbZxONvGfrNbwO7ihCZG8WOcyYwXUA+vv
         GHNg2+LUaAJjhZZsNkZABSb3PrBxq+7CT7aqQG4SSNsAdzVrcff34cYRQxUoX2CSEdhF
         IS2IdO5AtCT+97418Kspv0dMA0gJU9UGIkOs7eXlrI+qSpHPl9xFeexGM5JIS7i7ZYkX
         WBOa1ovJOPJPs6okGq3q3OZdwyrU8gvnhbucXE1eF+9Iby8mxy4uyGudMehIGIULO5SG
         zYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MpbsxkMsipQtpohRydTulbwXff0/qt3sQOmvykiETg=;
        b=Moh6JAoUzsT38ZLFEctXOYnERn3JnbryCXAy1+2tMuGLNpoHAUnvbegZijZBrl3bHS
         ROMLkPuA7VkvTa79S9CErjGdyomUxu10ETn3NyqXJZBOjCm40YXH2NbXH2SvIONWNXNg
         JXZL2nxgIczfbYYKP0lVRGdHpe+XbTYrrjPwkNW1iQZ6pKXUIyQYvTt/GYwX1DEHtTLz
         QYQKgcsfXd2X3vxjWXLxIIdZVBk/nteDxbM4xkwMCoYunxglyTSoAzTta0RU/IfjYZQZ
         LBnmPrfRPWY9cxmobbr7U9as9AfOkTxuP3MAnR4rN30resQdzDIq1AuC47M584T17gie
         oBKA==
X-Gm-Message-State: ANhLgQ1n5rleLoCtziooAOsz/yIMddNktoLOLMfk/ZvatbBEl4tWkA+l
        kQblgMB4btdQ6yad3SW1D3Q=
X-Google-Smtp-Source: ADFU+vvvPxaT4CQ43h7NdFMwkLdZHch1N0nnHVzcMOt4VAZkBHV+1Xttxe69vfei63CLU1MY8+cuCg==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr22680569plr.197.1584976025978;
        Mon, 23 Mar 2020 08:07:05 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id z12sm14729572pfj.144.2020.03.23.08.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 08:07:05 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, corbet@lwn.net,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, mchehab+samsung@kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH net-next v7 07/10] net: phy: introduce phy_read_poll_timeout macro
Date:   Mon, 23 Mar 2020 23:05:57 +0800
Message-Id: <20200323150600.21382-8-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323150600.21382-1-zhengdejin5@gmail.com>
References: <20200323150600.21382-1-zhengdejin5@gmail.com>
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
v6 -> v7:
	- adapt to a newly added parameter sleep_before_read.
	- add prefix with double underscores for the variable ret to avoid
	  any variable re-declaration or shadowing.
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
index c172747b4ab2..4f5b9dbc551d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -714,6 +714,19 @@ static inline int phy_read(struct phy_device *phydev, u32 regnum)
 	return mdiobus_read(phydev->mdio.bus, phydev->mdio.addr, regnum);
 }
 
+#define phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, \
+				timeout_us, sleep_before_read) \
+({ \
+	int __ret = read_poll_timeout(phy_read, val, (cond) || val < 0, \
+		sleep_us, timeout_us, sleep_before_read, phydev, regnum); \
+	if (val <  0) \
+		__ret = val; \
+	if (__ret) \
+		phydev_err(phydev, "%s failed: %d\n", __func__, __ret); \
+	__ret; \
+})
+
+
 /**
  * __phy_read - convenience function for reading a given PHY register
  * @phydev: the phy_device struct
-- 
2.25.0

