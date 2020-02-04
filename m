Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A01C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAC22166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgLuP3Py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBDNAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:00:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34556 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgBDNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:00:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so9643741pgi.1;
        Tue, 04 Feb 2020 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z/n271TAMQxCbZpsrlX1gBILEvIghmkAvstnFg0FQQ=;
        b=CgLuP3PyPtFcgaIolDBsY0o+eSnuY9GxD5O6/Mc7PIRmYc1csipQF1Mdm4S9CsnXVc
         O6H+JC3N9IpMlEZ20jyH40LuuBJ0vQrWQq1xLk8nJZvE/kkECltlG4wIKgOVCRX6Otpf
         gDoZP2TaGmfRyiB1JZj/IzAagC8fOjJtGSEHc2gOnzxfH86K1HTNW9ZPkcIcDyv5nxYV
         WGMNYtDPJ2cWB913/KtN6JY2vXrUoj/iSE05kpSGx/sl0Mzhuvl9xYpR2SPlN4kvFJvu
         1XvN9IlyTU/OM8YZxSrSZg6inYxmvbJvNRMuCN/oOnYE4lBnSbS72PBDB4v6Dfp+Yp5C
         6Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z/n271TAMQxCbZpsrlX1gBILEvIghmkAvstnFg0FQQ=;
        b=NbdQZpUDWuCH2lUEMFj8aNPGAzicBs3iZtGvxEu/jqqKmaQTFhIC0hCU7htXtjAyyt
         pRp84Zo5IX/MupNMgpCwu/LW6um7dFk1y93HOiWBGXPs9shrRZOsxbQkNqQiD5Ctzob6
         o/ZkxRs/zrDuluxaWfJpxkD5+CHTlDJbh+Fx7VAnWxdwGF3yu5T/30GLD5i43LRePAp7
         WR1TdBbpF/pIWni99o+czAEXHV6wInnC9toBi3OG0yZWaHX3jAO/9HDk9IDSv8TSBqhW
         GJCnk0T9czXkABxMNgABZ3/aUW8mTlLVSeHBfl+Jhn5zxfJVVT4IhLCFgOatb93bEGqd
         WaUA==
X-Gm-Message-State: APjAAAUETiXjEEvLgbHlGwkZYAgf/NuiAJvgAAdWHRte+ZsYL8YDqF1y
        vRh3+eN3sLKxeX4f8W6RzvknIk3GJ6k=
X-Google-Smtp-Source: APXvYqw07Yi/iWKd2J+nJaNFJzxZXAlBDFtVoeCHvkOjMSisR5Y830ivlYfZm2P7P1eADaZja20VVQ==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr7140683pgi.374.1580821216573;
        Tue, 04 Feb 2020 05:00:16 -0800 (PST)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id e26sm5812312pfl.59.2020.02.04.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 05:00:15 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] thermal: doc: Add cooling device documentation to Sphinx TOC tree
Date:   Tue,  4 Feb 2020 21:00:06 +0800
Message-Id: <20200204130006.12882-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds cpu-idle-cooling.rst into Sphinx TOC tree and fixes
some warnings and style issues.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../driver-api/thermal/cpu-idle-cooling.rst   | 27 ++++++++++---------
 Documentation/driver-api/thermal/index.rst    |  1 +
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
index 9f0016ee4cfb..698fcadbecee 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -1,6 +1,9 @@
+================
+CPU Idle Cooling
+================
 
-Situation:
-----------
+Situation
+---------
 
 Under certain circumstances a SoC can reach a critical temperature
 limit and is unable to stabilize the temperature around a temperature
@@ -24,8 +27,8 @@ with a power less than the requested power budget and the next OPP
 exceeds the power budget. An intermediate OPP could have been used if
 it were present.
 
-Solutions:
-----------
+Solutions
+---------
 
 If we can remove the static and the dynamic leakage for a specific
 duration in a controlled period, the SoC temperature will
@@ -45,12 +48,12 @@ idle state target residency, we lead to dropping the static and the
 dynamic leakage for this period (modulo the energy needed to enter
 this state). So the sustainable power with idle cycles has a linear
 relation with the OPP’s sustainable power and can be computed with a
-coefficient similar to:
+coefficient similar to::
 
 	    Power(IdleCycle) = Coef x Power(OPP)
 
-Idle Injection:
----------------
+Idle Injection
+--------------
 
 The base concept of the idle injection is to force the CPU to go to an
 idle state for a specified time each control cycle, it provides
@@ -136,7 +139,7 @@ Power considerations
 --------------------
 
 When we reach the thermal trip point, we have to sustain a specified
-power for a specific temperature but at this time we consume:
+power for a specific temperature but at this time we consume::
 
  Power = Capacitance x Voltage^2 x Frequency x Utilisation
 
@@ -145,7 +148,7 @@ wrong in the system setup). The ‘Capacitance’ and ‘Utilisation’ are a
 fixed value, ‘Voltage’ and the ‘Frequency’ are fixed artificially
 because we don’t want to change the OPP. We can group the
 ‘Capacitance’ and the ‘Utilisation’ into a single term which is the
-‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have:
+‘Dynamic Power Coefficient (Cdyn)’ Simplifying the above, we have::
 
  Pdyn = Cdyn x Voltage^2 x Frequency
 
@@ -154,7 +157,7 @@ in order to target the sustainable power defined in the device
 tree. So with the idle injection mechanism, we want an average power
 (Ptarget) resulting in an amount of time running at full power on a
 specific OPP and idle another amount of time. That could be put in a
-equation:
+equation::
 
  P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
 			(Trunning + Tidle)
@@ -165,7 +168,7 @@ equation:
 
 At this point if we know the running period for the CPU, that gives us
 the idle injection we need. Alternatively if we have the idle
-injection duration, we can compute the running duration with:
+injection duration, we can compute the running duration with::
 
  Trunning = Tidle / ((P(opp)running / P(opp)target) - 1)
 
@@ -188,7 +191,7 @@ However, in this demonstration we ignore three aspects:
    target residency, otherwise we end up consuming more energy and
    potentially invert the mitigation effect
 
-So the final equation is:
+So the final equation is::
 
  Trunning = (Tidle - Twakeup ) x
 		(((P(opp)dyn + P(opp)static ) - P(opp)target) / P(opp)target )
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 5ba61d19c6ae..4cb0b9b6bfb8 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -8,6 +8,7 @@ Thermal
    :maxdepth: 1
 
    cpu-cooling-api
+   cpu-idle-cooling
    sysfs-api
    power_allocator
 
-- 
2.24.0

