Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758DCC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0972071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp5vOfr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgCQKUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:20:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41982 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgCQKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:20:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so22119500ljc.8;
        Tue, 17 Mar 2020 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGynCl+wfPeR4qb/AG3pyJyPwdo3k8wHw+AwHbtPDSo=;
        b=gp5vOfr4E7mqJYwNhg7/IIR8w1lDuNJON4+f9eMbKOf/7Amusv/O2Tvh9K8HEoSlpe
         xiMIASpuj2uiVqkt6a6mTnyqETDiZoFFalrBXBnVggQYun6llahJlZ+XO7h7dwb79Rjh
         1vL+qRTUS06BicP3SfkSNZRLvdgWBEVNYPQwdHD8Fqmv1qqs67v9n/59uxtlst137v8J
         XsOSGyw2DQ9ze9cAeb3OyMMiIQGeeFsJZGp1riG6UQiRBh6AX0oPxg/YgTQjsl4Xmq7Z
         +RtoO4y8XFCs+yR5Ar7bSh04yMxFlmljjs/sNYm4NPlHHOQhsOVMPPInqh12Un2rdooc
         XFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WGynCl+wfPeR4qb/AG3pyJyPwdo3k8wHw+AwHbtPDSo=;
        b=Rz3GMdH51jHg5vw/H7Cnf8KVa9T8Iucf6qd32kMJ0r0wG78ZwQulsVALMJ6wm1axr5
         lOHNs7fibGojWUOLVRk10WjzY3t96xKW+O7rTfcqLbBX2tL3TwCYnyH1sLW5WWDNSa/w
         SldZxG3ANw26OBCdiSktI5ssYGr1m/CMSSYciKz7Q3+YbnBT3qiS4RbGD48iGk07KeV6
         paUcGnUG3/TCWegM53oNtYRBikCBmOk3bba5GmJH99M5/hOsUyO0Z44YGcRyzJ9ah/73
         /DO6iNA7yqIad1hMvFeZ+ad3OUvJqgQFiiMXQ2ZCj9OcEXGP0b3r5TWgVaOzxTTfvxmq
         wYQg==
X-Gm-Message-State: ANhLgQ2J38mzlQQ8aUCcOuqpi99JJkcPmYPTkPVSIzB09Pndr1by4CoI
        lzfab1xu4rvd90LKWG8PKrQ=
X-Google-Smtp-Source: ADFU+vtY35x2PkeN39BHTb3sRwtOAYWhTE1k0pSIWTXjVyFc5Yh/KLkKzaQCsDKkUAvWZnyLNwLqRg==
X-Received: by 2002:a2e:9797:: with SMTP id y23mr2322272lji.183.1584440412020;
        Tue, 17 Mar 2020 03:20:12 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id w22sm1962649ljm.58.2020.03.17.03.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 03:20:11 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/5] dt-bindings: input: Dual license input.h adding MIT
Date:   Tue, 17 Mar 2020 12:19:46 +0200
Message-Id: <20200317101947.27250-4-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317101947.27250-1-igor.opaniuk@gmail.com>
References: <20200317101947.27250-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Dual license header adding MIT license, which will permit to re-use
dependent device tree sources that include this header
in other non-GPL OSS projects.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 include/dt-bindings/input/input.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/input/input.h b/include/dt-bindings/input/input.h
index bcf0ae100f21..c3cf5d034025 100644
--- a/include/dt-bindings/input/input.h
+++ b/include/dt-bindings/input/input.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * This header provides constants for most input bindings.
  *
-- 
2.17.1

