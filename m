Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D28C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8856520747
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEvXtqqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgDBDgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 23:36:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50951 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbgDBDgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:36:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id t128so1895256wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 20:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m4LdVgh/bvsyv9ZErCSctVO5OR+focWDV/5XQQ8F7AU=;
        b=vEvXtqqAUPaUcCi3tCJN0g8gIg6t7Nzb/0+Eiawfl6fv9xfoD64GhJxFCciuDo34W7
         R3UYwsNvVPTvLPzacryiAdF+TFbL9UcXbOTvCSxeuB7q/EHtWYWutAttxgDrDfU/bluV
         TO4GKdjMbc7Wtk76OXbR0yIkPmOszbWDVh70I1jPOahJYbF1ihCMpfw38wmfSXYPcE9g
         qTtrw33USTAxbOzS7+PzffYBBrcCjqiLEJJIJQwJCrJG4fti4huyewpK68vPyX/Bln6q
         RWC9uDKmKnmzPrcZqJDQjTtLTW2GWYfpFeK5eZ242sy8AZpZshd7Ec9ELfF+8FIL5fzQ
         0r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m4LdVgh/bvsyv9ZErCSctVO5OR+focWDV/5XQQ8F7AU=;
        b=iVY1T3K/3joSzfAk0fr8zWsqI4AM1RZX4NxmVrKzNq+LPVDpa7VvDK47lwtyDPSPlM
         8cSMc/sgu4BVZxJ5fTOQpr4otXM2HpOQV1hFSP5TUTOdX1JgYRr4rSLJZfCLf3Ce9wmK
         Z6wxGgF/3IVPOaSB7pDh37bw/ZOSkdMmvyBUQ0DDEG9AlUTJCPHa4H/GSje/7Lfs//0G
         0LBSaF1m8vHdkGOhEnovW19r/W6PZdKfdLGVAKgC4OGicEGQljS44kkdCAdYwALqHmZU
         EUqBmV5l/cydkv9LtAsGUWq4xeg/uTzrcn7GYfhMd6gWubwOibnVjt3bdrXsj0EcceNv
         2WuQ==
X-Gm-Message-State: AGi0Pua0MNdEXT/RnKdIBiZtwGAMMm9PuLURjrEjKhuQplZHvpuVMQAD
        d9GwpQ8uHt5fD3AtmbEnkjqwfDGZ
X-Google-Smtp-Source: APiQypIZmgCgGltE3CfA0zMYWpj4xYNsprkY0A+5KhTVNXGpiYfRakT0Y8C9MoW/KGQjCRAb7SVV8A==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr1114554wmb.127.1585798611645;
        Wed, 01 Apr 2020 20:36:51 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n124sm5402841wma.11.2020.04.01.20.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 20:36:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, hsinyi@chromium.org,
        geert+renesas@glider.be, will@kernel.org, swboyd@chromium.org,
        robh@kernel.org, tytso@mit.edu
Subject: [PATCH] Documentation: dt-bindings: Document 'rng-seed' for /chosen
Date:   Wed,  1 Apr 2020 20:36:40 -0700
Message-Id: <20200402033640.12465-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /chosen node can have a 'rng-seed' property read as a u32 quantity
which would contain a random number provided by the boot agent. This is
useful in configurations where the kernel does not have access to a
random number generator.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/chosen.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..126b31eecfeb 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -28,6 +28,19 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
 the Linux EFI stub (which will populate the property itself, using
 EFI_RNG_PROTOCOL).
 
+rng-seed
+--------
+
+This property is used to initialize the kernel's entropy pool from a
+trusted boot agent capable of providing a random number. It is parsed
+as a u32 value, e.g.
+
+/ {
+	chosen {
+		rng-seed = <0xcafef00d>;
+	};
+};
+
 stdout-path
 -----------
 
-- 
2.17.1

