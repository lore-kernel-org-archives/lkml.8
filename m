Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D500C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFAD206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkzyBtZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbgF3Nvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbgF3Nv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080FAC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so18897529wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekub7s2tFsF3z7X9QKVOCDCBJvabEEOsb/caCUw91kQ=;
        b=VkzyBtZbCjJJvhPGehZwLMGCthflX3/XiLaEsXmprAcJVpo80+gSoG8rwFsE+weyh4
         ktuEsHJwHeeliHVIBqZbZHfxKTIhxooQjcRWF/IRKDYzwE0+BxanVd9NYSfhyIWiG53s
         tCxie/X8WcL0U9Vj/0ZNtTRsbOsvDazA5kboXlz+kHELQbXY/ZUAToaYVXd5H8spQ0Ou
         rwE4U1QYKcOnU7H3cbJIWJX1fKQ2wKeHi3V0r0eQQ4rkLM4VTLOYwWKNhDeT+4tOUam6
         RIuizvWzQw2rQii5W+le77E6a2DZZCX6R8CQv+5LcI3fDCgBy3EW/p2Aahnk/Ui+KABm
         1nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekub7s2tFsF3z7X9QKVOCDCBJvabEEOsb/caCUw91kQ=;
        b=o6/d9iUzbbr4lXey7p1jQ/o8koMTYyAIfN+Zyaiwfn6ofmNpupcXKhbIni1891/WDN
         o0wEl0FZu3nmN81Wc+rbH7RJSZxomIECwqVVe+h+rokWCqkdyGEuXhjqJOAWqAcWa+Ux
         lr/uzQDaSNSYA/b7vvuLerBOsa4SydWffVsQn2CsiJ/2fxiLbHOODIB2mbu+m95Q7P9F
         cQ52w2vzzfjHqz0D5ElE93fdbfjW1VXgwdTFFjwd6yzr4Lcg5e3Etp4CaxyJZ/CBUjzE
         G2XFC3AZs9QvuxcWmnzh+FcVkcAwaroJLqlxY1eHRbuaah73hipejjAaBiV78jn+9eaU
         iuxw==
X-Gm-Message-State: AOAM531Ag69ZzXFk8dw8/W1PNdvVirVshoepK4a/obKZGRYT6UvRDDjV
        VTPf85r+1oyy5kKNnwiOdnTYqQ==
X-Google-Smtp-Source: ABdhPJzXnmpgLmFJj/trdGQhzlz4Fmuvb3Xl3DNNCpx4ncsMeB/kuKfjKKh6mqpcjRvSFV0zFJrmIA==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr21474519wmb.21.1593525084780;
        Tue, 30 Jun 2020 06:51:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH 10/30] misc: ibmasm: dot_command: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:50 +0100
Message-Id: <20200630135110.2236389-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/ibmasm/dot_command.c:18: warning: Function parameter or member 'sp' not described in 'ibmasm_receive_message'
 drivers/misc/ibmasm/dot_command.c:18: warning: Function parameter or member 'message' not described in 'ibmasm_receive_message'
 drivers/misc/ibmasm/dot_command.c:18: warning: Function parameter or member 'message_size' not described in 'ibmasm_receive_message'
 drivers/misc/ibmasm/dot_command.c:55: warning: Function parameter or member 'sp' not described in 'ibmasm_send_driver_vpd'
 drivers/misc/ibmasm/dot_command.c:111: warning: Function parameter or member 'sp' not described in 'ibmasm_send_os_state'
 drivers/misc/ibmasm/dot_command.c:111: warning: Function parameter or member 'os_state' not described in 'ibmasm_send_os_state'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/dot_command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmasm/dot_command.c b/drivers/misc/ibmasm/dot_command.c
index 70273a4cb3527..df389bd4c9df7 100644
--- a/drivers/misc/ibmasm/dot_command.c
+++ b/drivers/misc/ibmasm/dot_command.c
@@ -10,7 +10,7 @@
 #include "ibmasm.h"
 #include "dot_command.h"
 
-/**
+/*
  * Dispatch an incoming message to the specific handler for the message.
  * Called from interrupt context.
  */
@@ -48,7 +48,7 @@ void ibmasm_receive_message(struct service_processor *sp, void *message, int mes
 #define INIT_BUFFER_SIZE 32
 
 
-/**
+/*
  * send the 4.3.5.10 dot command (driver VPD) to the service processor
  */
 int ibmasm_send_driver_vpd(struct service_processor *sp)
@@ -99,7 +99,7 @@ struct os_state_command {
 	unsigned char			data;
 };
 
-/**
+/*
  * send the 4.3.6 dot command (os state) to the service processor
  * During driver init this function is called with os state "up".
  * This causes the service processor to start sending heartbeats the
-- 
2.25.1

