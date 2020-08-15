Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F6FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E33F20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUm0fiOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgHOWHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgHOVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C31C0612EC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:39:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so5480650pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQLY4f6KN8LbrgYUCIeblK2oZZloekPRvT4S8CUV7zA=;
        b=KUm0fiOoGYxXYDE8SrU26PWn/FyBoqPjrUirL3CsGHSobKV27iBkVPzwQiO9ySZTK2
         lMncaQFoCBNDy3UKbrh1YVlZle/ruEGG8OX7XObSgvqsEfWnvP4Wdk2vc5Y55w/Lfiqy
         TK1xpzXpj0wVjYj3F2B5+3klxFYNvSF6khTtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQLY4f6KN8LbrgYUCIeblK2oZZloekPRvT4S8CUV7zA=;
        b=FJqMYueNjgagM3BylqBkPSvqjOLOqZc1+R0TnMVckh5T49NFCq650AR0ObPY62MffC
         56g8QiEXc6XcJatx6nm7d1EPj7YeiGmvskbXtkKU9+8EN2MsjXWTT9HE++iS3KiztwSz
         7kA2spkeGrAjomc8N6Jdvc1/33VU417mCvf8UOPKjMCJB7f6zfbeD28ljayHu1bNP2li
         zH2xKCGD9QuYC6fodwp6vnZKOXLzpXVW+K2rLHdIO4O+EnQjX8II8qjjHTMCOErmFxjH
         zfM35EDM8YGJgduW6D3dMETv1TkHLuF2C4KHB3PCx7Pq85h05EL67kyxC4ePAaa3qSLG
         wIDg==
X-Gm-Message-State: AOAM5309JZ/T0r0G2hw4+kdhugXKH3bRo6mBBW/2FdrzAP/QTQuwel5W
        aeV1EvbkxySbOgtOomRopfsLN9u4NGQOMg==
X-Google-Smtp-Source: ABdhPJy9OTdghmRGxVH35DBW5ZHlztcFwvzQtBaPZTB5vwaSanatugYDASgPUvECg+v6lBg4Zx8l2A==
X-Received: by 2002:a62:5c84:: with SMTP id q126mr3999847pfb.324.1597462757372;
        Fri, 14 Aug 2020 20:39:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id x4sm10845428pff.112.2020.08.14.20.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 20:39:16 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     rrangel@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: cros_ec: Add fields to command traces
Date:   Fri, 14 Aug 2020 20:39:08 -0700
Message-Id: <20200815033908.3108730-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ftrace, add more fields to the cros_ec command event:
- Add size of commands to check if they are properly set.
- Add offset (in case an EC is cascaded being another EC),
to allow proper command output

With:
echo 1 > events/cros_ec/cros_ec_cmd/enable
We now have (on samus)

invalid command for the sensor stack:
ectool-6942  [002] ....  3082.783116: cros_ec_request_done: version: 3,
 offset: 0, command: EC_CMD_MOTION_SENSE_CMD, outsize: 2, insize: 19,
 ec result: EC_RES_INVALID_PARAM, retval: 0

powerd accessing PD EC being the main EC:
powerd-1272  [002] ....    40.644026: cros_ec_request_done: version: 0,
 offset: 1, command: EC_CMD_USB_PD_POWER_INFO, outsize: 1, insize: 16,
 ec result: EC_RES_SUCCESS, retval: 16

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_trace.h | 27 +++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
index e9fb05f89ef07..f744b21bc655f 100644
--- a/drivers/platform/chrome/cros_ec_trace.h
+++ b/drivers/platform/chrome/cros_ec_trace.h
@@ -23,14 +23,22 @@ TRACE_EVENT(cros_ec_request_start,
 	TP_ARGS(cmd),
 	TP_STRUCT__entry(
 		__field(uint32_t, version)
+		__field(uint32_t, offset)
 		__field(uint32_t, command)
+		__field(uint32_t, outsize)
+		__field(uint32_t, insize)
 	),
 	TP_fast_assign(
 		__entry->version = cmd->version;
-		__entry->command = cmd->command;
+		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(1);
+		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(1);
+		__entry->outsize = cmd->outsize;
+		__entry->insize = cmd->insize;
 	),
-	TP_printk("version: %u, command: %s", __entry->version,
-		  __print_symbolic(__entry->command, EC_CMDS))
+	TP_printk("version: %u, offset: %d, command: %s, outsize: %u, insize: %u",
+		  __entry->version, __entry->offset,
+		  __print_symbolic(__entry->command, EC_CMDS),
+		  __entry->outsize, __entry->insize)
 );
 
 TRACE_EVENT(cros_ec_request_done,
@@ -38,19 +46,26 @@ TRACE_EVENT(cros_ec_request_done,
 	TP_ARGS(cmd, retval),
 	TP_STRUCT__entry(
 		__field(uint32_t, version)
+		__field(uint32_t, offset)
 		__field(uint32_t, command)
+		__field(uint32_t, outsize)
+		__field(uint32_t, insize)
 		__field(uint32_t, result)
 		__field(int, retval)
 	),
 	TP_fast_assign(
 		__entry->version = cmd->version;
-		__entry->command = cmd->command;
+		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(1);
+		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(1);
+		__entry->outsize = cmd->outsize;
+		__entry->insize = cmd->insize;
 		__entry->result = cmd->result;
 		__entry->retval = retval;
 	),
-	TP_printk("version: %u, command: %s, ec result: %s, retval: %d",
-		  __entry->version,
+	TP_printk("version: %u, offset: %d, command: %s, outsize: %u, insize: %u, ec result: %s, retval: %u",
+		  __entry->version, __entry->offset,
 		  __print_symbolic(__entry->command, EC_CMDS),
+		  __entry->outsize, __entry->insize,
 		  __print_symbolic(__entry->result, EC_RESULT),
 		  __entry->retval)
 );
-- 
2.28.0.220.ged08abb693-goog

