Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C760C2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8932076F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="rrNk6Kcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgCYSMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:12:05 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:40505 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCYSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:12:03 -0400
Received: by mail-ed1-f99.google.com with SMTP id w26so3721246edu.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KKpKhLhaC9HGAwcc/wCEo8PVI3BgJbUGYTvCaeR49Ok=;
        b=rrNk6KcxURyxMqPmDLj2w7bRmiDPMbUI0d/kn5MoPrEUo33YzVn3zrxcuD85NeIErE
         +uGfzC7ut3SYcHQaLhmVWeUTDF73/vZGMa7Ku0Mz/KEWdWqxjWZHRLrkQP0RfXWMGD0m
         g8VbKMTkYncsJmDzeZV4BiiiM5zYJmPUIi2Cs4pHzaY5pWLRtjTfZVHxHP9YFhI9gv2h
         /soDGEdt35MheO4BaZk6KhmtRX4IfSR4z5IKnqcXCOr/49iFIdKQh5jwWJD6BMQDXElL
         to2vidpfeVH7HdXqu2o5MY3gopz3yUWfxHW8arc0tljoE4wT5MR3wxtPfBk3kpMziCWj
         MZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KKpKhLhaC9HGAwcc/wCEo8PVI3BgJbUGYTvCaeR49Ok=;
        b=FO99ZDjixh+imycVc0MxOstci9D/wtkzcWxeNt05jH2kU9aGxPpDd6U5iF+woI6XVO
         XdqEeIfgZxpGnbGQSGFwIo/A5e5Nzt5o8Cv8h3eM0laSvV3Dlz9n8UP/L1byabXN+ZQo
         72UnK9bzmN8gLyo7mWRoqt5x82/gO8z77l/3eTHBu9fnA23elIl5Xrcwm6z1G7G2Sptu
         ogvkWAwGxIIpZFE71/LKqsy9wtk9ZmnjRGvoeg14FRvg2TDWmWC6xkp9hUWC47h0IZ6R
         9/DUhGaGBKl7GAGPX2WWRkFPsWjVqfAlai52cdUYxkQWJcY1J6+3tJnCEqIS3C7Q4IRK
         JS0Q==
X-Gm-Message-State: ANhLgQ1F+b82ZetHaKvze+E8GA1+wMuk/NSMgNujD/ol5UAFGTADEdP4
        PKrJfiCFjKeJWFDh3Qdl7pmvdg8i8MwyIqrpW4aaO52yyjqy
X-Google-Smtp-Source: ADFU+vuep+cArUuYfyT4aIlU+oz4LwkVg1M9a67K8D0RfGmqdTIIjC4kRTkukTB5EAVMq2zHqSjAPESSkERj
X-Received: by 2002:a17:906:1cc9:: with SMTP id i9mr2034588ejh.0.1585159920479;
        Wed, 25 Mar 2020 11:12:00 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id x25sm182281edl.7.2020.03.25.11.12.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 11:12:00 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.190] (port=39524 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jHAVT-0003Oy-U9; Wed, 25 Mar 2020 19:12:00 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 3/4] dt-bindings: fec: document the new gpr property.
Date:   Wed, 25 Mar 2020 19:11:58 +0100
Message-Id: <1585159919-11491-4-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585159919-11491-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1585159919-11491-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows the gpr register bit to be defined
for wake on lan support.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index 5b88fae0..ff8b0f2 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -22,6 +22,8 @@ Optional properties:
 - fsl,err006687-workaround-present: If present indicates that the system has
   the hardware workaround for ERR006687 applied and does not need a software
   workaround.
+- gpr: phandle of SoC general purpose register mode. Required for wake on LAN
+  on some SoCs
  -interrupt-names:  names of the interrupts listed in interrupts property in
   the same order. The defaults if not specified are
   __Number of interrupts__   __Default__
-- 
1.9.1

