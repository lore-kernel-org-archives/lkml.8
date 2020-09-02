Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF26C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5630E2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuUvb1ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgIBOqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgIBOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:45:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D9CC061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:45:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o21so4858491wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id;
        bh=trC+40amJNG14lv80NaTqEGrWJguvBTuJIKnt0HFTWo=;
        b=UuUvb1ZQJouxwRU/HXqW9dHiS30iASaxqJjgk+w1tpi4HyUUIX2fNzwPMnWJHzalpe
         J7WcK1U5ItiNENw048BbwT7TDVzFVxU9jfX9UYaTBNAjSKerOPx7XzSCm1Q068p4G76F
         9mCHwzsBwdiPTwdh2EvzG65kFQNAb1gwG36hIA9i8xJI4joIJcS8TqF+VZAzQgF4u5m8
         XdnJSd8bfwZgCDfiDJ8DEq52ELnLljPVUTuG36yrTRmiqI1uNZfAC0ID/IL/D2BnlQy8
         FJG337atTlQ7NVITyreqN840FO9EsYfXk4XE91gFALELbWgGpUwtZRRDgz3PYK/BPrMo
         G1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id;
        bh=trC+40amJNG14lv80NaTqEGrWJguvBTuJIKnt0HFTWo=;
        b=Knqk4mGtTHl/v73DH2FlkO5OVYZzrNTTsTqy+aZaffvHhVusANi+53G7/ft4m6VEjV
         3MVYcbA33v3cBk8iCaJaalkM11hB4h48/2+PL1osJVrz2MH+gM32Pc/2AqMipMbI2Z7E
         S2bi70rYpBc79GNcE7FbwoRB/X+cEAnUG4149d29pUrOJWjh/xAHmZ5JqsZRtYR+x5MS
         T7XZ4gy8XeaO5q2/kJiQDu7a0x3vmMwt5JwwbpsRxBYWsXhxc5HocaSIIzrSqPsbPj/1
         ELuFWICA+QFuHatv9e1wTC0RK/tDJtdPpoJ3Om9/RrrgvdODIMUkyLVezkhPcOC2csiD
         557w==
X-Gm-Message-State: AOAM532j2ebVgPLAuBaw4oMBeBPKfrZVC6oucs70qgAwFc5M7YlK2N2e
        GBCJyYakZzJkx1kgEdo34NM=
X-Google-Smtp-Source: ABdhPJx94O6MeIlkVwYmIRsWeilEwSrrQgV4ldM0qKrQu3yGGZ99pQxkt6aNAwHqm43x5VuFtGtPVw==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr988200wmb.63.1599057936242;
        Wed, 02 Sep 2020 07:45:36 -0700 (PDT)
Received: from gmail.com (254.68.10.185.ro.ovo.sc. [185.10.68.254])
        by smtp.gmail.com with ESMTPSA id v6sm7740106wrt.90.2020.09.02.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:45:35 -0700 (PDT)
Subject: [PATCH] trivial: docs: Section number should be "8.2"
Date:   Wed, 2 Sep 2020 14:45:00 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <19f80e640076482fac86f57b41211faa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/kbuild/makefiles.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index b81b8913a5a3..da6a708164c4 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1411,7 +1411,7 @@ When kbuild executes, the following steps are followed (roughly):
 	that may be shared between individual architectures.
 	The recommended approach how to use a generic header file is
 	to list the file in the Kbuild file.
-	See "7.2 generic-y" for further info on syntax etc.
+	See "8.2 generic-y" for further info on syntax etc.
 
 7.11 Post-link pass
 -------------------
-- 
2.22.0

