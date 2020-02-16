Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF4C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 13:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE062086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANCfJbi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgBPNJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:09:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46258 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgBPNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 08:09:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so16361104wrl.13;
        Sun, 16 Feb 2020 05:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tvEL8XnoDDDhJQlXis+I/7w3i0GDb/4zBR+iz8nChnM=;
        b=ANCfJbi3lxVWxfXdaHspdZaflNulvt7zkwgyAowutB2HsQvuU0nsGoh5Wqx+vRWPja
         kwfDa8w0uJAx9KlP8c6HjNPXWh+d5hJ/F0oyUkPbUkwXMyiLUjcHO0WRD1Qzw4SYdmbQ
         joIPP+2RopZRPNnYWKojDLP0+vLxwyaFuwDJ2KySU0UaYLy4b3hBwMzDOVX44lHqYBgj
         QDUbGfbUl4NaVRK+XbzRSifmEgn0yIKeC2XGr5IeDo3G+Jvd7uAJUjNY5UpOeD5nNE1B
         qcMuFvjPkDbA3N/nj9PHB1RQTg3t1L5OzdkU43ZxOJAJnlCu+GxEzF7RAVm8PoO9fjAG
         pueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tvEL8XnoDDDhJQlXis+I/7w3i0GDb/4zBR+iz8nChnM=;
        b=BpC0JVd1nDXf5+YWihoFbg5JizttWomoCiifAIlFKnpUtJnrLpDw5AsqyqvYBS2wFB
         OeV1xUeNutyQwlzCciS92RY8UgbuWmOPyXHQ3UDXzlnK0IuAoVwZBaWAHpSZZjgMQ5fy
         BM8uHtzQzIifS/p3P8lo6OK0ZtGJ76daW78H1jzANljM+7xnQAzYwCTAJvWdae0zR0WD
         nzETtDeB2O3FItNS07SJaFHPihxSQ/0LTilkWrwNcVI97aWWUeNMbhNn/aJlPEP1MxqW
         bz3puuCLwQJ6uPJ0tg38v+xki/i6QqTKjMaKp8opkQGJp9WPNgXCZ6HSBiOCmGgvYAv9
         OqoA==
X-Gm-Message-State: APjAAAVk1D8+IOYXAw3Y0BYXiBAtgzbhHsMVv3r69tKTXzzXpOGFE7aB
        7Tb0fnJJlk+tAza7kKbIYuA=
X-Google-Smtp-Source: APXvYqziHWt5hYUHIy4pUIFjT8JvtyU6AKXR/9w0NkI9dxoCdNmyzFFsR2OMMhFcHeJGw4h9m/JRIw==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr15424575wrv.240.1581858555439;
        Sun, 16 Feb 2020 05:09:15 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:3868:8500:68a0:3d5f:3add:6e47])
        by smtp.gmail.com with ESMTPSA id x6sm15747748wrr.6.2020.02.16.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:09:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Rob Herring <robh@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Joe Perches <joe@perches.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to stm32 timer dt-bindings conversion
Date:   Sun, 16 Feb 2020 14:08:41 +0100
Message-Id: <20200216130841.4187-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 56fb34d86e87 ("dt-bindings: mfd: Convert stm32 timers bindings
to json-schema") and commit b88091f5d84a ("dt-bindings: mfd: Convert stm32
low power timers bindings to json-schema") converted some files from txt to
yaml format in ./Documentation/devicetree/bindings/, but they missed to
adjust MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  no file matches F: Documentation/devicetree/bindings/*/stm32-*timer*
  no file matches F: Documentation/devicetree/bindings/pwm/pwm-stm32*

So, repair the MAINTAINERS entry now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Benjamin, Fabrice, please ack.
Rob, please pick this patch.
applies cleanly on current master and on next-20200214

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..9175b59e2b4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15923,8 +15923,7 @@ F:	drivers/*/stm32-*timer*
 F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 F:	Documentation/ABI/testing/*timer-stm32
-F:	Documentation/devicetree/bindings/*/stm32-*timer*
-F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
+F:	Documentation/devicetree/bindings/mfd/st,stm32-*timer*.yaml
 
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
-- 
2.17.1

