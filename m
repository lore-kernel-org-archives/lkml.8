Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6169C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963792074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czh+6eJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgHYMTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgHYMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:18:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE4C061757;
        Tue, 25 Aug 2020 05:18:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a65so2165210wme.5;
        Tue, 25 Aug 2020 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uc+i0gWQ7QGFfIc1FEZg9eNWGBKxWPtFWURbOx3qDRs=;
        b=Czh+6eJo2Qf8VYMvqThSFZ6GSjx9jymp6NTRQs0c02CLpB7arXjGGyumftMRnj5Q7Q
         A0a4eDkLoRSKqfJ7RYhy4ynl6IIEQfGdsSax4F0MD6Ru8jmRR5NFxjmZKdpmLODhNDbt
         1wHyxbZJ76cUDJGXf9TwqIWb+IYiMlNReuCoy7HQnK5BxqJ4Tn+f8ImnmVpZsTfFayWI
         iPvOMT5phvsOVRgNsbmVg74w9j51/reaa4h7kMPmX4g6h/TQ3u3LPb/iHHsmwaExReo/
         yqM1UzJW34X4vpOwyQ6mFczw2h1dbBDDp6ACJIMmbHb8FZHK7xWfcRFUDc/iAfkRxquj
         5PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uc+i0gWQ7QGFfIc1FEZg9eNWGBKxWPtFWURbOx3qDRs=;
        b=kiUJZ18/QbGXSq2lEfzZCcwUmJ67oSeeG/FjIfEfoui9mlAISd7JwUrizo4jSNqFNe
         BK2zl5hr8r0tTJgtK6Gb//ilVhGmcWq1QI/yiJffJZDCAZZSUyMLUvzvGL0+XfDaeekb
         Uv5LJleWTqZJIdBFv71pyZQX+ViqfgwmulmIds2qw31WEj/1HnpKPaNfphKMG+25bYAH
         miQyRuk/Dui+AAuK6k754bP1FNNOttYE0Nr84QRhoUWVcQbIJUeA7dZSeUf+IAHtQbWP
         HGxqM2JzN9sTndTZElm2cz8gqjv7vocUAYzwopMpp7idwDdSkiclo8Pwatj6sbNrmZxw
         Uh+Q==
X-Gm-Message-State: AOAM533ReeLEBmMNtaeLt/RRYiTSON5BSntd5VQIsijLeLVP6PRO/Ek/
        w2ErtuiP/mNcfHTY1Rw+IQg=
X-Google-Smtp-Source: ABdhPJwiyHD4lFpSCzOwr3gLgkT/uJ63vFKNIs6dmUOrsougaGmmZPjsZsT2nTkNuTOp+ZHJfMgRHQ==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr1763213wmb.44.1598357934294;
        Tue, 25 Aug 2020 05:18:54 -0700 (PDT)
Received: from localhost.localdomain (dynamic-adsl-84-220-30-184.clienti.tiscali.it. [84.220.30.184])
        by smtp.gmail.com with ESMTPSA id b202sm6371158wmd.29.2020.08.25.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:18:53 -0700 (PDT)
From:   Ahmed Abdelsalam <ahabdels@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ahabdels@gmail.com, andrea.mayer@uniroma2.it
Subject: [net-next v5 2/2] seg6: Add documentation for seg6_inherit_inner_ipv4_dscp sysctl
Date:   Tue, 25 Aug 2020 12:18:44 +0000
Message-Id: <20200825121844.1576-1-ahabdels@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a documentation for seg6_inherit_inner_ipv4_dscp
sysctl into Documentation/networking/ip-sysctl.rst

Signed-off-by: Ahmed Abdelsalam <ahabdels@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 837d51f9e1fa..9dacdebeafc5 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1799,6 +1799,11 @@ seg6_flowlabel - INTEGER
 
 	Default is 0.
 
+seg6_inherit_inner_ipv4_dscp - BOOLEAN                                                                                                                                                                                                                                                                                                        
+	Enable the SRv6 encapsulation to inherit the DSCP value of the inner IPv4 packet.                                                                                                         
+
+	Default: FALSE (Do not inherit DSCP)
+
 ``conf/default/*``:
 	Change the interface-specific default settings.
 
-- 
2.17.1

