Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0FCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B680A2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCIjmonq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHZRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgHZRBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:01:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B79C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:59 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id v2so2407243ilq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iifl+SrM927K50PeABJCPm1vnXa9Xbx3f5/rhAuv9Uk=;
        b=UCIjmonqsdoZZADUxRAJErxSCQ15XXBm5g2t7eD7umbVbTkt95mBhxnPcyoiqdMx/f
         4ZgPZTFwDWxO/9ZVmGdf9LPDnJXCKtig3T2BQcWEgkreb/2mFIu5yG4B33T7PobYhe50
         pLHQtCBOOSU9LEyJAIyaFrcb3ZI31jI5GxIcB21o6zVS3IFo3vJEBmWPPqIcvc0hwf7N
         EqkpOyj1qz4FmuO2LG2ehBAzEsIiauUHZcqh1e5ESjJdRZ0CUFyxdJqfG3oGzZ/+zJbj
         HGGUi22gfUelU1RgtqRjp3N1HZgSOyM2PZQZdMQkkjFM/694y+SxzKI3B8Z3sq5Pbkm+
         3/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iifl+SrM927K50PeABJCPm1vnXa9Xbx3f5/rhAuv9Uk=;
        b=qFuYs1yXnIE56Gp0e+EekIM2c7h3O0X41h5PyNALrpkJ+YQPHa4VBnoSnn4qsItkt0
         DlYHEITJNxFwJvcqrg5BT8NQY1ukYbqsA3c/5Y+/VwKkyDlRq6aZQDJ4G4mUJD4tTMUs
         VS3OpppYySVR5OXivWvVPBpsvYOB/Vy0NHPC9OCPq9orspPDg2q3HqYpJTesUCc6xxNO
         ohLlND2C+Rp1hfGS6x5nAltvBgCDt+cuhwEwTYRxEwpVYr0CN5J8mxu1USfqd7zuJQj8
         gaU1/uPa0mdTNKCD4N9gT+nA7K6BX9v6oPSmOc8/F152C4MT4B2+F3e0OfNVMJHBLjyQ
         ksKA==
X-Gm-Message-State: AOAM532OVCexqGrS/7Bc844jn7ApDOfv0WAR55RwSFI2otp5jT0nvpVa
        ix0R6+0aDibJpctJLyX57lsHp7vanW+28bek
X-Google-Smtp-Source: ABdhPJxBi1zHiX32RRVtEu9X620S7bHDX1wd9DIE9g9VRWFTCA6+Ytp4dwOPtFz82AaD5G33jga18w==
X-Received: by 2002:a92:d0c7:: with SMTP id y7mr14347265ila.224.1598461258562;
        Wed, 26 Aug 2020 10:00:58 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id p78sm1479606iod.0.2020.08.26.10.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:00:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] i915: POC use dynamic_debug_exec_queries to control pr_debugs in gvt
Date:   Wed, 26 Aug 2020 11:00:41 -0600
Message-Id: <20200826170041.2497546-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826170041.2497546-1-jim.cromie@gmail.com>
References: <20200826170041.2497546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gvt component of this driver has ~120 pr_debugs, in 9 "classes".
Add a "knob", like drm.debug, to map bits to these classes.

bash-5.0# echo 0x01 > /sys/module/i915/parameters/debug_dyn
 set_dyndbg: result:0x1 from 0x01
 dyndbg: query 0: "format='^gvt: cmd: ' +p"
 dyndbg: entry, buf:'format='^gvt: cmd: ' +p'
 dyndbg: start-of-word:0 'format='^gvt: cmd: ' +p'
 dyndbg: start-of-word:1 ''^gvt: cmd: ' +p'
 dyndbg: start-of-word:2 '+p'
 dyndbg: split into words: "format" "^gvt: cmd: " "+p"
 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff
 dyndbg: key:'format' arg:'^gvt: cmd: '
 dyndbg: parsed: func="" file="" module="i915" format="^gvt: cmd: " lineno=0-0
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:3081 [i915]init_cmd_table =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:1376 [i915]gen8_check_mi_display_flip =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:1373 [i915]gen8_check_mi_display_flip =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:745 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:744 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:742 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:733 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:729 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:722 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:716 [i915]parser_exec_state_dump =p
 dyndbg: changed drivers/gpu/drm/i915/gvt/cmd_parser.c:691 [i915]print_opcode =p
 dyndbg: applied: func="" file="" module="i915" format="^gvt: cmd: " lineno=0-0
 dyndbg: processed 1 queries, with 11 matches, 0 errs
 change ct:11 on format='gvt: cmd: '
 change ct:11

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/i915_params.c | 76 ++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 8d8db9ff0a48..4e1f01ab4865 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -255,3 +255,79 @@ void i915_params_free(struct i915_params *params)
 	I915_PARAMS_FOR_EACH(FREE);
 #undef FREE
 }
+
+/* POC for callback -> dynamic_debug_exec_queries */
+unsigned long __new_knob;
+EXPORT_SYMBOL(__new_knob);
+
+static char *pr_debug_classes[] = {
+	"gvt: cmd: ",
+	"gvt: core: ",
+	"gvt: dpy: ",
+	"gvt: el: ",
+	"gvt: irq: ",
+	"gvt: mm: ",
+	"gvt: mmio: ",
+	"gvt: render: ",
+	"gvt: sched: "
+};
+#define NUM_CLASSES	ARRAY_SIZE(pr_debug_classes)
+#define OUR_QUERY_SIZE	128 /* we need about 20 */
+
+#include <linux/module.h>
+
+static int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
+{
+	static unsigned long int old_val;
+        unsigned int val;
+	unsigned long int changes, result;
+	int rc, chgct = 0, totct = 0, bitpos;
+	char query[OUR_QUERY_SIZE];
+
+	rc = kstrtouint(instr, 0, &val);
+	if (rc) {
+		pr_err("set_dyndbg: failed\n");
+		return -EINVAL;
+	}
+	result = val;
+	pr_info("set_dyndbg: result:0x%lx from %s\n", result, instr);
+
+	changes = result ^ old_val;
+
+	for_each_set_bit(bitpos, &changes, NUM_CLASSES) {
+
+		sprintf(query, "format='^%s' %cp", pr_debug_classes[bitpos],
+			test_bit(bitpos, &result) ? '+' : '-');
+
+		chgct = dynamic_debug_exec_queries(query, "i915");
+		totct += chgct;
+		pr_info("change ct:%d on format='%s'\n", chgct,
+			pr_debug_classes[bitpos]);
+	}
+	old_val = result;
+	pr_info("change ct:%d\n", totct);
+	return 0;
+}
+static int param_get_dyndbg(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%u\n",
+			 *((unsigned int *)kp->arg));
+}
+static const struct kernel_param_ops param_ops_dyndbg = {
+	.set = param_set_dyndbg,
+	.get = param_get_dyndbg,
+};
+
+MODULE_PARM_DESC(debug_dyn, " enable dynamic-debug by format-string classifications.\n"
+		 "\t\twhich are:"
+		 "\n\t\t gvt: cmd:"
+		 "\n\t\t gvt: core:"
+		 "\n\t\t gvt: dpy:"
+		 "\n\t\t gvt: el:"
+		 "\n\t\t gvt: irq:"
+		 "\n\t\t gvt: mm:"
+		 "\n\t\t gvt: mmio:"
+		 "\n\t\t gvt: render:"
+		 "\n\t\t gvt: sched:" "\n");
+
+module_param_cb(debug_dyn, &param_ops_dyndbg, &__new_knob, 0644);
-- 
2.26.2

