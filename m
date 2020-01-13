Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A13C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E59207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JehQFxui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMMC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:02:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:02:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so4613827pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t/oatoH+9W/ChUbThl3o9bx19ftElLOYoOV7rEdqL4=;
        b=JehQFxuigo/JfJQOB2PCKa6+SMJnY2hZ1zXmgpAMdeS3lbNdN+h9U9xHyGHu+chtf7
         x3Qfy+V/n2ZxtEYoi0cqNT67JfMGMXDIRR7TchQiQFqjifYEBy7NozbpuVZ084wEwlyh
         1zRV7eV2Z0L5tFaFTnRKzuEBx7TYhLCyAX9J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t/oatoH+9W/ChUbThl3o9bx19ftElLOYoOV7rEdqL4=;
        b=S4OYW1pX90VfmxVRA/ivXwPdrj+Uu/mv+f+Sf3SNWXZpPTQ/cxtHmzkoaEuNLzSj0N
         sXZmAtZP1zWLexp/JNrVn7OODLZIbvVVb7lpmW+tLUnx7NtTCq6lio/N1vRGTWrOyhov
         AYpw2TKjreO9eQm0cTCUvYJzoSCfhjQ5D+BH3Aepln0On/gXje/RSEYMFg5U01CwvYRu
         aHb3y+fLKdWB9uVV8vlHceztYorynkb/rzY4FIlmlN2+h9/R8+ACNW2lswYZyDFWN0QO
         8OAh78/Cz2I57utie7/lpVTURbHEjr4OOD92LVTCISvzxTnM/8nDrztidkvQ07pS9LEe
         jE6Q==
X-Gm-Message-State: APjAAAWdUJsHbqV6a3h5foBqWidbvu1vewAByji7EuCCjSaFoif8kIh4
        DDpNwENwT+bzRVMlD468r6px2Q==
X-Google-Smtp-Source: APXvYqwu5xVmTAvdk3EaQ07uDoRhb18TzsYJo2Q/co0OnOdlAUVkcozR7uJ/JF/jyk6RyaqnL2LBEg==
X-Received: by 2002:a63:1b49:: with SMTP id b9mr20197979pgm.258.1578916944607;
        Mon, 13 Jan 2020 04:02:24 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z64sm14435324pfz.23.2020.01.13.04.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:02:24 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 2/3] arm64: defconfig: enable REBOOT_HOTPLUG_CPU
Date:   Mon, 13 Jan 2020 20:01:56 +0800
Message-Id: <20200113120157.85798-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200113120157.85798-1-hsinyi@chromium.org>
References: <20200113120157.85798-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable REBOOT_HOTPLUG_CPU for arm64 to hotplug CPUs before reboot if
CONFIG_HOTPLUG_CPU is set.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8409aa80e30a..9815fe0ebdb4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -687,6 +687,7 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
 CONFIG_RCAR_DMAC=y
+CONFIG_REBOOT_HOTPLUG_CPU=y
 CONFIG_RENESAS_USB_DMAC=m
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
-- 
2.25.0.rc1.283.g88dfdc4193-goog

