Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF707C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF132207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EDNAISaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAMMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:02:32 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40482 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:02:32 -0500
Received: by mail-pf1-f176.google.com with SMTP id q8so4787507pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AfMbC/ZOFOFio5tj73UQTPEK/wtvz9P1yqZCH9t/qA=;
        b=EDNAISaqKCK16woUslxqqmwi1qx6iZg/nqQsL6z3Ha/4cFxaICe+BdLHOA4tW+4jIS
         MrLnAGtRHYvrVZrqL8zzbv3h27aUSgtzdF8xY/4c5nZlIavuff8cQDPRntgQCMDTfqeK
         mo99ScCgluBi/nJ/hIzQzP/GDpoL+Ee7mU2ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AfMbC/ZOFOFio5tj73UQTPEK/wtvz9P1yqZCH9t/qA=;
        b=oH4ArbHKl5ffb01RilhyxqHW7/7f4R08dhEwTKdwtTV76uSmBY52xA2AcB7b0m+2Y9
         NeeE1F3vX7nPJuT2mrViQNAnnWnhjewCDzqigD6Oe0EdZSuWE+GeTM8yz/tgbWTcIUgk
         WawIe0yNEUtbDtO5CGMfpp4AfYRkb7tO2GM+Ko2tCOf02hjCnQLBlAP/+MgsDhoPustL
         08VnSztZf47K2ITLI3Xn3w5ySrdS4Gt0nP1/nbsFCbbi9R/BIjjIRFdeX5Bvfui6F12k
         7M/VmqYDpEAGOjBo1szIzdzYprNdnVK9DUa1Do0/6XwjpIZFwmGxCa2S2Z70toETkkem
         d2rQ==
X-Gm-Message-State: APjAAAWxBFA7PS61svEln2aAjFk+zH6T426trweYlu6e85qlKsfn/heg
        b9TkkIlQVm9K3mt/8YilXu1oWA==
X-Google-Smtp-Source: APXvYqwivAMd495tSyJro3ZZ2R7oQzyYN2fMKk454t1RpzYRMbiqW4ipuX64UYXtaINWpLng3+vjQQ==
X-Received: by 2002:aa7:8193:: with SMTP id g19mr19325933pfi.172.1578916951355;
        Mon, 13 Jan 2020 04:02:31 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id z64sm14435324pfz.23.2020.01.13.04.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:02:30 -0800 (PST)
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
Subject: [PATCH RFC v3 3/3] x86: defconfig: enable REBOOT_HOTPLUG_CPU
Date:   Mon, 13 Jan 2020 20:01:57 +0800
Message-Id: <20200113120157.85798-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200113120157.85798-1-hsinyi@chromium.org>
References: <20200113120157.85798-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable REBOOT_HOTPLUG_CPU for x86 to hotplug CPUs before reboot if
CONFIG_HOTPLUG_CPU is set.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 59ce9ed58430..2f3e90969cb2 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -46,6 +46,7 @@ CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_RANDOMIZE_BASE=y
 CONFIG_RANDOMIZE_MEMORY=y
+CONFIG_REBOOT_HOTPLUG_CPU=y
 # CONFIG_COMPAT_VDSO is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0b9654c7a05c..196d1329ee68 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -43,6 +43,7 @@ CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_RANDOMIZE_BASE=y
 CONFIG_RANDOMIZE_MEMORY=y
+CONFIG_REBOOT_HOTPLUG_CPU=y
 # CONFIG_COMPAT_VDSO is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
-- 
2.25.0.rc1.283.g88dfdc4193-goog

