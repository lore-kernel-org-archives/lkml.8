Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA30220722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPh31ANm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgGAIcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgGAIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC8EC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so622931wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Vgj6mJ007ffR2XpxkUWmsRKmQ1//Tce8MuBu+oPzlU=;
        b=HPh31ANmeeDeHGVS/PDby+fvRPUjuW1dvyVoN2jot/X3auKYJnWW2kekKLwwXImcIo
         48xveaLgyBpmf6K5MzTmqTWlG10uhYmkpyi8oAaxlpmzKdY6IoJHmmro7GTcfKN4zxKF
         CgnX0dt5jWBLrtiegPVPik0wlmhWZguW9C/kgbqsFloBEyZjmVBgwjgZK/CGv/0KzCOz
         gJCMu8C/3kM5/ZNO5e5VJy8CZtKPwrhm+JYN2vSPHjZh2kBd4SuqErd37eOX/2MjF4K6
         WaUX1p3OPLXrOU4gzNUSuXeZuqkwjm4u1XPu8KRPNDlS3PXRaFX8uFi7UaqMxs5d2rgT
         KtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Vgj6mJ007ffR2XpxkUWmsRKmQ1//Tce8MuBu+oPzlU=;
        b=iDkDGbHlJqn+Zo55RqQfVPCYIuaqWBjPrfw46Vkz0ldcjzG6dLPvWHsCO7KLtovBaO
         T1iHOn0w1WdkkorEdGkIqc7hRan9zTCbuQ0DIYTscyha5fFkA2dAhdNwm3r6u2BLLINA
         9Bm1jLK7EHCRDF1f15GHCLdsf9b13sMvv/wUUAn/os8f8+ggqa+TJgWoV/9fSTb1TVcI
         9xeoZiF6P1fDVX/1IBhrpx5oFj5pjmMtFsHVSt543h3SZQFQXIVNob0GmmG5SXeRR8m9
         y4DhL4PtmtcRd2WjhEuT0cATbIpO5y0MlHgVfprufjTp+DCSFyO7cbfXh01Xy8zG748r
         Fbnw==
X-Gm-Message-State: AOAM530I9BoFMFZINmYEchFyhB/6bIgUNgX37qBIF0P2xo8fuRnvftmE
        NPBL1gz5o4khhDl45lgC/U3P8Q==
X-Google-Smtp-Source: ABdhPJzXrU6xi3un+vaiH9VQd76pcfKtWsT2/yo8NWT84QcdHIZ/yaxBnLz5FgKSV89oRtxVPzsRJQ==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr27438749wru.182.1593592315293;
        Wed, 01 Jul 2020 01:31:55 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 27/30] misc: cxl: hcalls: Demote half-assed kerneldoc attempt
Date:   Wed,  1 Jul 2020 09:31:15 +0100
Message-Id: <20200701083118.45744-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function headers will need a lot of work before they reach the
standards expected of kerneldoc.  Demote them down to basic
comments/headers, for now at least.

Fixes the following W=1 kernel build warnings:

 drivers/misc/cxl/hcalls.c:175: warning: Function parameter or member 'unit_address' not described in 'cxl_h_detach_process'
 drivers/misc/cxl/hcalls.c:175: warning: Function parameter or member 'process_token' not described in 'cxl_h_detach_process'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'unit_address' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'op' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'p1' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'p2' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'p3' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'p4' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:207: warning: Function parameter or member 'out' not described in 'cxl_h_control_function'
 drivers/misc/cxl/hcalls.c:245: warning: Function parameter or member 'unit_address' not described in 'cxl_h_reset_afu'
 drivers/misc/cxl/hcalls.c:258: warning: Function parameter or member 'unit_address' not described in 'cxl_h_suspend_process'
 drivers/misc/cxl/hcalls.c:258: warning: Function parameter or member 'process_token' not described in 'cxl_h_suspend_process'
 drivers/misc/cxl/hcalls.c:271: warning: Function parameter or member 'unit_address' not described in 'cxl_h_resume_process'
 drivers/misc/cxl/hcalls.c:271: warning: Function parameter or member 'process_token' not described in 'cxl_h_resume_process'
 drivers/misc/cxl/hcalls.c:284: warning: Function parameter or member 'unit_address' not described in 'cxl_h_read_error_state'
 drivers/misc/cxl/hcalls.c:284: warning: Function parameter or member 'state' not described in 'cxl_h_read_error_state'
 drivers/misc/cxl/hcalls.c:300: warning: Function parameter or member 'unit_address' not described in 'cxl_h_get_afu_err'
 drivers/misc/cxl/hcalls.c:300: warning: Function parameter or member 'offset' not described in 'cxl_h_get_afu_err'
 drivers/misc/cxl/hcalls.c:300: warning: Function parameter or member 'buf_address' not described in 'cxl_h_get_afu_err'
 drivers/misc/cxl/hcalls.c:300: warning: Function parameter or member 'len' not described in 'cxl_h_get_afu_err'
 drivers/misc/cxl/hcalls.c:320: warning: Function parameter or member 'unit_address' not described in 'cxl_h_get_config'
 drivers/misc/cxl/hcalls.c:320: warning: Function parameter or member 'cr_num' not described in 'cxl_h_get_config'
 drivers/misc/cxl/hcalls.c:320: warning: Function parameter or member 'offset' not described in 'cxl_h_get_config'
 drivers/misc/cxl/hcalls.c:320: warning: Function parameter or member 'buf_address' not described in 'cxl_h_get_config'
 drivers/misc/cxl/hcalls.c:320: warning: Function parameter or member 'len' not described in 'cxl_h_get_config'
 drivers/misc/cxl/hcalls.c:333: warning: Function parameter or member 'unit_address' not described in 'cxl_h_terminate_process'
 drivers/misc/cxl/hcalls.c:333: warning: Function parameter or member 'process_token' not described in 'cxl_h_terminate_process'
 drivers/misc/cxl/hcalls.c:351: warning: Function parameter or member 'unit_address' not described in 'cxl_h_collect_vpd'
 drivers/misc/cxl/hcalls.c:351: warning: Function parameter or member 'record' not described in 'cxl_h_collect_vpd'
 drivers/misc/cxl/hcalls.c:351: warning: Function parameter or member 'list_address' not described in 'cxl_h_collect_vpd'
 drivers/misc/cxl/hcalls.c:351: warning: Function parameter or member 'num' not described in 'cxl_h_collect_vpd'
 drivers/misc/cxl/hcalls.c:351: warning: Function parameter or member 'out' not described in 'cxl_h_collect_vpd'
 drivers/misc/cxl/hcalls.c:362: warning: Function parameter or member 'unit_address' not described in 'cxl_h_get_fn_error_interrupt'
 drivers/misc/cxl/hcalls.c:362: warning: Function parameter or member 'reg' not described in 'cxl_h_get_fn_error_interrupt'
 drivers/misc/cxl/hcalls.c:374: warning: Function parameter or member 'unit_address' not described in 'cxl_h_ack_fn_error_interrupt'
 drivers/misc/cxl/hcalls.c:374: warning: Function parameter or member 'value' not described in 'cxl_h_ack_fn_error_interrupt'
 drivers/misc/cxl/hcalls.c:386: warning: Function parameter or member 'unit_address' not described in 'cxl_h_get_error_log'
 drivers/misc/cxl/hcalls.c:386: warning: Function parameter or member 'value' not described in 'cxl_h_get_error_log'
 drivers/misc/cxl/hcalls.c:399: warning: Function parameter or member 'unit_address' not described in 'cxl_h_collect_int_info'
 drivers/misc/cxl/hcalls.c:399: warning: Function parameter or member 'process_token' not described in 'cxl_h_collect_int_info'
 drivers/misc/cxl/hcalls.c:399: warning: Function parameter or member 'info' not described in 'cxl_h_collect_int_info'
 drivers/misc/cxl/hcalls.c:440: warning: Function parameter or member 'unit_address' not described in 'cxl_h_control_faults'
 drivers/misc/cxl/hcalls.c:440: warning: Function parameter or member 'process_token' not described in 'cxl_h_control_faults'
 drivers/misc/cxl/hcalls.c:440: warning: Function parameter or member 'control_mask' not described in 'cxl_h_control_faults'
 drivers/misc/cxl/hcalls.c:440: warning: Function parameter or member 'reset_mask' not described in 'cxl_h_control_faults'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'unit_address' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'op' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'p1' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'p2' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'p3' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'p4' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:480: warning: Function parameter or member 'out' not described in 'cxl_h_control_facility'
 drivers/misc/cxl/hcalls.c:516: warning: Function parameter or member 'unit_address' not described in 'cxl_h_reset_adapter'
 drivers/misc/cxl/hcalls.c:532: warning: Function parameter or member 'unit_address' not described in 'cxl_h_collect_vpd_adapter'
 drivers/misc/cxl/hcalls.c:532: warning: Function parameter or member 'list_address' not described in 'cxl_h_collect_vpd_adapter'
 drivers/misc/cxl/hcalls.c:532: warning: Function parameter or member 'num' not described in 'cxl_h_collect_vpd_adapter'
 drivers/misc/cxl/hcalls.c:532: warning: Function parameter or member 'out' not described in 'cxl_h_collect_vpd_adapter'
 drivers/misc/cxl/hcalls.c:561: warning: Function parameter or member 'unit_address' not described in 'cxl_h_download_facility'
 drivers/misc/cxl/hcalls.c:561: warning: Function parameter or member 'op' not described in 'cxl_h_download_facility'
 drivers/misc/cxl/hcalls.c:561: warning: Function parameter or member 'list_address' not described in 'cxl_h_download_facility'
 drivers/misc/cxl/hcalls.c:561: warning: Function parameter or member 'num' not described in 'cxl_h_download_facility'
 drivers/misc/cxl/hcalls.c:561: warning: Function parameter or member 'out' not described in 'cxl_h_download_facility'
 drivers/misc/cxl/hcalls.c:626: warning: Function parameter or member 'unit_address' not described in 'cxl_h_download_adapter_image'
 drivers/misc/cxl/hcalls.c:626: warning: Function parameter or member 'list_address' not described in 'cxl_h_download_adapter_image'
 drivers/misc/cxl/hcalls.c:626: warning: Function parameter or member 'num' not described in 'cxl_h_download_adapter_image'
 drivers/misc/cxl/hcalls.c:626: warning: Function parameter or member 'out' not described in 'cxl_h_download_adapter_image'
 drivers/misc/cxl/hcalls.c:639: warning: Function parameter or member 'unit_address' not described in 'cxl_h_validate_adapter_image'
 drivers/misc/cxl/hcalls.c:639: warning: Function parameter or member 'list_address' not described in 'cxl_h_validate_adapter_image'
 drivers/misc/cxl/hcalls.c:639: warning: Function parameter or member 'num' not described in 'cxl_h_validate_adapter_image'

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/cxl/hcalls.c | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index b7c57f67f4f52..aba5e20eeb1f5 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -167,7 +167,7 @@ long cxl_h_attach_process(u64 unit_address,
 	}
 }
 
-/**
+/*
  * cxl_h_detach_process - Detach a process element from a coherent
  *                        platform function.
  */
@@ -197,7 +197,7 @@ long cxl_h_detach_process(u64 unit_address, u64 process_token)
 	}
 }
 
-/**
+/*
  * cxl_h_control_function - This H_CONTROL_CA_FUNCTION hypervisor call allows
  *                          the partition to manipulate or query
  *                          certain coherent platform function behaviors.
@@ -238,7 +238,7 @@ static long cxl_h_control_function(u64 unit_address, u64 op,
 	}
 }
 
-/**
+/*
  * cxl_h_reset_afu - Perform a reset to the coherent platform function.
  */
 long cxl_h_reset_afu(u64 unit_address)
@@ -249,7 +249,7 @@ long cxl_h_reset_afu(u64 unit_address)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_suspend_process - Suspend a process from being executed
  * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
  *              process was attached.
@@ -262,7 +262,7 @@ long cxl_h_suspend_process(u64 unit_address, u64 process_token)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_resume_process - Resume a process to be executed
  * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
  *              process was attached.
@@ -275,7 +275,7 @@ long cxl_h_resume_process(u64 unit_address, u64 process_token)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_read_error_state - Checks the error state of the coherent
  *                          platform function.
  * R4 contains the error state
@@ -288,7 +288,7 @@ long cxl_h_read_error_state(u64 unit_address, u64 *state)
 				state);
 }
 
-/**
+/*
  * cxl_h_get_afu_err - collect the AFU error buffer
  * Parameter1 = byte offset into error buffer to retrieve, valid values
  *              are between 0 and (ibm,error-buffer-size - 1)
@@ -304,7 +304,7 @@ long cxl_h_get_afu_err(u64 unit_address, u64 offset,
 				NULL);
 }
 
-/**
+/*
  * cxl_h_get_config - collect configuration record for the
  *                    coherent platform function
  * Parameter1 = # of configuration record to retrieve, valid values are
@@ -324,7 +324,7 @@ long cxl_h_get_config(u64 unit_address, u64 cr_num, u64 offset,
 				NULL);
 }
 
-/**
+/*
  * cxl_h_terminate_process - Terminate the process before completion
  * Parameter1 = process-token as returned from H_ATTACH_CA_PROCESS when
  *              process was attached.
@@ -337,7 +337,7 @@ long cxl_h_terminate_process(u64 unit_address, u64 process_token)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_collect_vpd - Collect VPD for the coherent platform function.
  * Parameter1 = # of VPD record to retrieve, valid values are between 0
  *              and (ibm,#config-records - 1).
@@ -355,7 +355,7 @@ long cxl_h_collect_vpd(u64 unit_address, u64 record, u64 list_address,
 				out);
 }
 
-/**
+/*
  * cxl_h_get_fn_error_interrupt - Read the function-wide error data based on an interrupt
  */
 long cxl_h_get_fn_error_interrupt(u64 unit_address, u64 *reg)
@@ -365,7 +365,7 @@ long cxl_h_get_fn_error_interrupt(u64 unit_address, u64 *reg)
 				0, 0, 0, 0, reg);
 }
 
-/**
+/*
  * cxl_h_ack_fn_error_interrupt - Acknowledge function-wide error data
  *                                based on an interrupt
  * Parameter1 = value to write to the function-wide error interrupt register
@@ -378,7 +378,7 @@ long cxl_h_ack_fn_error_interrupt(u64 unit_address, u64 value)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_get_error_log - Retrieve the Platform Log ID (PLID) of
  *                       an error log
  */
@@ -390,7 +390,7 @@ long cxl_h_get_error_log(u64 unit_address, u64 value)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_collect_int_info - Collect interrupt info about a coherent
  *                          platform function after an interrupt occurred.
  */
@@ -425,7 +425,7 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
 	}
 }
 
-/**
+/*
  * cxl_h_control_faults - Control the operation of a coherent platform
  *                        function after a fault occurs.
  *
@@ -470,7 +470,7 @@ long cxl_h_control_faults(u64 unit_address, u64 process_token,
 	}
 }
 
-/**
+/*
  * cxl_h_control_facility - This H_CONTROL_CA_FACILITY hypervisor call
  *                          allows the partition to manipulate or query
  *                          certain coherent platform facility behaviors.
@@ -509,7 +509,7 @@ static long cxl_h_control_facility(u64 unit_address, u64 op,
 	}
 }
 
-/**
+/*
  * cxl_h_reset_adapter - Perform a reset to the coherent platform facility.
  */
 long cxl_h_reset_adapter(u64 unit_address)
@@ -520,7 +520,7 @@ long cxl_h_reset_adapter(u64 unit_address)
 				NULL);
 }
 
-/**
+/*
  * cxl_h_collect_vpd - Collect VPD for the coherent platform function.
  * Parameter1 = 4K naturally aligned real buffer containing block
  *              list entries
@@ -536,7 +536,7 @@ long cxl_h_collect_vpd_adapter(u64 unit_address, u64 list_address,
 				out);
 }
 
-/**
+/*
  * cxl_h_download_facility - This H_DOWNLOAD_CA_FACILITY
  *                    hypervisor call provide platform support for
  *                    downloading a base adapter image to the coherent
@@ -616,7 +616,7 @@ static long cxl_h_download_facility(u64 unit_address, u64 op,
 	}
 }
 
-/**
+/*
  * cxl_h_download_adapter_image - Download the base image to the coherent
  *                                platform facility.
  */
@@ -629,7 +629,7 @@ long cxl_h_download_adapter_image(u64 unit_address,
 				       list_address, num, out);
 }
 
-/**
+/*
  * cxl_h_validate_adapter_image - Validate the base image in the coherent
  *                                platform facility.
  */
-- 
2.25.1

