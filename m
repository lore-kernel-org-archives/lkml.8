Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF4720674
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXnthflo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbgEZU61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbgEZU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:58:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:58:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t8so345345pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F26zeW4GLWARSnrEORKnMOfqslBUHMfZSurQbAYAbuo=;
        b=AXnthfloxC/4AXUlFHH90V2umIGLCyr5SggMMUdHfjzW/7kgSaqq1Cba1ifxqYrMwU
         zeP5xqq6XDqWiCbT8FOZdvCZTEFjT5IX67nobdkf93pvIKdHjORCIG2xIfGrrA3pq/2X
         akiYTNWIMKaZ0lya4pHtg5xc/HQv+w9NwO7mTJ7iuEodH2AZeyMkjFzRhApvO3iXiagT
         8SICmy7Fl+S7VYeA7yZHTTX0d7KPVE8WPSObV1orm3R9AtjG3h7DhMYqgjLZmkHW+ZvU
         IBfjN6ButVSsuWTFGZkOuxo7GTaV++mxzRTPsub0CtW5Iryc2KDSgEUN96gKjsj4aAXn
         eCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F26zeW4GLWARSnrEORKnMOfqslBUHMfZSurQbAYAbuo=;
        b=q43U5s4pjV9gSVQ0QFL1O0q6GVQozUuETQbm+igq4wZ53OtYAJVCjec+RlDxA/+RGi
         rMNSzrcT8/O/eqKrwfMe41yS3H3HbUmZYlOmHo47H22R2A7Y9JmQGSwLGuGWZuEipZP0
         rWGaH8jKTGvvofDA43+305g4sHP44ZFOm3HZe903xBcmLxGbuEYaLiz4k1cRx5rTHQjD
         4l2vFSMKt/PrcpuRk+8tcyOnfKIUWpHutiNtCLZJheT3I0TcjKFzroH6UstiHPQ2vSnS
         itLvRwucS4hUZQ/lt62KDHR9HFulLKbLt78vjeBRpHcjc38ImWzyJX0+hwPjQxEODIdJ
         192w==
X-Gm-Message-State: AOAM532TLQPIEFaWvwEKl1oka1XHOvwSOyQ6wrQ1oZDAhkTLb2ttkAyg
        JvSlFpdWWPkrnK/ts+3iV8XPGmvf
X-Google-Smtp-Source: ABdhPJzIPs3U/H/hy/IdG5CS11VpSpxr/KBY8qOG3iHdT7E7cluhT5dkHhRLjCB21iwigA3gOl4U/w==
X-Received: by 2002:a17:90a:8814:: with SMTP id s20mr1174769pjn.74.1590526705804;
        Tue, 26 May 2020 13:58:25 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id i11sm383619pfq.2.2020.05.26.13.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:58:25 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] powerpc/wii: Fix declaration made after definition
Date:   Tue, 26 May 2020 13:57:57 -0700
Message-Id: <20200526205756.2952882-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200413190644.16757-1-natechancellor@gmail.com>
References: <20200413190644.16757-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 0day randconfig uncovered an error with clang, trimmed for brevity:

arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute
declaration must precede definition [-Werror,-Wignored-attributes]
        if (!machine_is(wii))
             ^

The macro machine_is declares mach_##name but define_machine actually
defines mach_##name, hence the warning.

To fix this, move define_machine after the machine_is usage.

Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/989
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* s/is_machine/machine_is/ (Nick)

* Add Nick's reviewed-by tag.

 arch/powerpc/platforms/embedded6xx/wii.c | 25 ++++++++++++------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 67e48b0a164e..a802ef957d63 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -172,19 +172,6 @@ static void wii_shutdown(void)
 	flipper_quiesce();
 }
 
-define_machine(wii) {
-	.name			= "wii",
-	.probe			= wii_probe,
-	.setup_arch		= wii_setup_arch,
-	.restart		= wii_restart,
-	.halt			= wii_halt,
-	.init_IRQ		= wii_pic_probe,
-	.get_irq		= flipper_pic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-	.machine_shutdown	= wii_shutdown,
-};
-
 static const struct of_device_id wii_of_bus[] = {
 	{ .compatible = "nintendo,hollywood", },
 	{ },
@@ -200,3 +187,15 @@ static int __init wii_device_probe(void)
 }
 device_initcall(wii_device_probe);
 
+define_machine(wii) {
+	.name			= "wii",
+	.probe			= wii_probe,
+	.setup_arch		= wii_setup_arch,
+	.restart		= wii_restart,
+	.halt			= wii_halt,
+	.init_IRQ		= wii_pic_probe,
+	.get_irq		= flipper_pic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+	.machine_shutdown	= wii_shutdown,
+};

base-commit: b0523c7b1c9d0edcd6c0fe6d2cb558a9ad5c60a8
-- 
2.27.0.rc0

