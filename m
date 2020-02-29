Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFAC3F2D4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C44A246A3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ketu3fQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgB2M0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:26:22 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:33886 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgB2M0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:26:21 -0500
Received: by mail-lj1-f175.google.com with SMTP id x7so6420842ljc.1;
        Sat, 29 Feb 2020 04:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NmeW9ngS8eifN3sjrGPI1hv1F6A8Nf5uvazYyp+BS9k=;
        b=Ketu3fQ6Ze4H9aFJMlXmKKQN7tIVmjfhxYLU8gbB37F7Wx3uqV0mPGvtfLG5BKG5pS
         w3MLbR7v3B5J/+7fuwkHaE23gTJ11269NV/Bl/rBnkw+K8VaYyBkw60+3Hwki3lturdi
         eEth5epY1HMBxNhZumxrtjlIttVRIWJhRIajeJ1oHcmMJjGZgALhP0cBO1HwWA1n4ixN
         UHiJ6DGwnkUpnTOAaOdbgm6a0Ym8xYCVaohzfLrAWDFRMYlPJEVgeOfN2xaGIzQ2YieY
         U1o/MeSNdyAoWRRIz+//DsGmdufdH3VRv457vvhzXTCmi4WKLJGXvvtvZe/9L6EghIQF
         wnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NmeW9ngS8eifN3sjrGPI1hv1F6A8Nf5uvazYyp+BS9k=;
        b=QepYjhQIwSO/inzxvhQwSxVVcktNENrv8iS1yE37W5Ef8KvDlZkxM6mmyjV872tZ1c
         RGHgt2LIa822VgzYNR4BFXo3fA5eu3htdQttWlEi2MwA8gFKwlv6Rv26sZltx8cqYTmI
         oUeJT2PspSlwtWERtNrFL3iLsx1PR+nGhc2uzZMthXfN+MMd0cANhb7Yt+IWECyim/+w
         42p4dsPxP157Uq58g1YRblfCEdAUbaXkbKUbijSwQDJgT9cwxhIiExy6ZT4YG1sbEhbD
         43au7uFZXRTbsr23OnYQQAYQq98HhLsP6utafhqjefUiZLs3dof5biQ5q+Q9vg2EEK6k
         GYGw==
X-Gm-Message-State: ANhLgQ171L45Oj2ce/Ah4bjIML7KBwb4w12htLJwE7qJjtLngEtDNqd5
        HYYxVhsvJC3YZrsLJrEUSkQ=
X-Google-Smtp-Source: ADFU+vsAnBstYODjBmvZJiZ3Gr/avovYtapZ6FgPl7iPSa0uXBWmmqSC4JBhAdk+wwTrXPY2n6A4kw==
X-Received: by 2002:a2e:3202:: with SMTP id y2mr6112641ljy.132.1582979178364;
        Sat, 29 Feb 2020 04:26:18 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r10sm8950775ljk.9.2020.02.29.04.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 04:26:17 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v5 1/3] dt-bindings: add vendor prefix for SmartLabs LLC
Date:   Sat, 29 Feb 2020 16:25:22 +0400
Message-Id: <1582979124-82363-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582979124-82363-1-git-send-email-christianshewitt@gmail.com>
References: <1582979124-82363-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmartLabs LLC are a professional integrator of Interactive TV solutions
and IPTV/VOD devices [1].

[1] https://www.smartlabs.tv/en/about/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944..a34ed82 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -901,6 +901,8 @@ patternProperties:
     description: Sitronix Technology Corporation
   "^skyworks,.*":
     description: Skyworks Solutions, Inc.
+  "^smartlabs,.*":
+    description: SmartLabs LLC
   "^smsc,.*":
     description: Standard Microsystems Corporation
   "^snps,.*":
-- 
2.7.4

