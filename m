Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4231FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17764205CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfgxS87Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGFXKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGFXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:10:15 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD73C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 16:10:15 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t4so21248853iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ankP85bIZrb6kR5tlukQkQix+FYTJlMioaJsg3D4qUg=;
        b=ZfgxS87Yj5mTWgguF2sLLEwgcR2OMZg2YrsgKJZzPAUklYJUviai2HniNxuzv5BXSQ
         z1hKHdjcAvXhgFlt8qm0jdY2rjoWnRw0e7GYq/SFL5jh2yw++uLiA3tsHsZMhIQegrU2
         HqA19kP9oE5Ytq5e35trGzc84KNWaW34MrUzyLgIqQQ3an+ImttrBcp2t49sf3EPr4VV
         uWgRh41z9HSHYIoCNwaV8sn2SuT8ao5ylLvJJ8R5teg9tA4Gb+px0X+UY7oUNso/+v/J
         8JvJHLuq+OrYCNc5LeoJNuHgqqlBZBGyjCUeMuw7xgIQmu8r6xUkQpjHO7pJvyNoWvsk
         UIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ankP85bIZrb6kR5tlukQkQix+FYTJlMioaJsg3D4qUg=;
        b=TaNEv7IPw4O8tGym49f32+1CmL0K92KcV3NDgzMk2W38LemY8hWckT9lwwsMEu1OzY
         QXr1ojPPXCmXuGlNREYzsOJ54LdOX2YackGFQRmBNTYatdzSHKzn/Jfo041Ezm12DSfS
         Q/lHaZzUaXFceA7js6dlFu/59qR3PjP2TCzS5p65yX0nQ/L2qenuzqT4L/04lhaVjhIk
         4eKQ80wVmKM2xqET7SenKhB4MHWqdE3wWgQRMK3H+symto1RUUOVxz8WaeuCpyUMAOXr
         1H+jFDeJPXmzF861JnyEOCD2UCPBz4x1yO6jnHuX+jZrX3P9rhQPGl4DXu0noFHAbe7E
         Lgnw==
X-Gm-Message-State: AOAM531yLDGlOT0D6flXvc2/vJz/Zc8wjDOQe6BcC295yhWQqxGAI6zv
        MkohTLmpQuzUTHVdwxgrPLB7Fw==
X-Google-Smtp-Source: ABdhPJzFS6HUm7W85SQeRq3pHf+n4/EkzbMuZuY3e8JKKDsG1YKYFw+5ngFIaiFfxegQZ1eYxddcGg==
X-Received: by 2002:a05:6e02:682:: with SMTP id o2mr30589234ils.188.1594077014526;
        Mon, 06 Jul 2020 16:10:14 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w16sm11523029iom.27.2020.07.06.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:10:14 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: ipa: fix QMI structure definition bugs
Date:   Mon,  6 Jul 2020 18:10:08 -0500
Message-Id: <20200706231010.1233505-2-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706231010.1233505-1-elder@linaro.org>
References: <20200706231010.1233505-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with "W=1" did exactly what it was supposed to do, namely
point out some suspicious-looking code to be verified not to contain
bugs.

Some QMI message structures defined in "ipa_qmi_msg.c" contained
some bad field names (duplicating the "elem_size" field instead of
defining the "offset" field), almost certainly due to copy/paste
errors that weren't obvious in a scan of the code.  Fix these bugs.

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_qmi_msg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
index 03a1d0e55964..73413371e3d3 100644
--- a/drivers/net/ipa/ipa_qmi_msg.c
+++ b/drivers/net/ipa/ipa_qmi_msg.c
@@ -119,7 +119,7 @@ struct qmi_elem_info ipa_driver_init_complete_rsp_ei[] = {
 			sizeof_field(struct ipa_driver_init_complete_rsp,
 				     rsp),
 		.tlv_type	= 0x02,
-		.elem_size	= offsetof(struct ipa_driver_init_complete_rsp,
+		.offset		= offsetof(struct ipa_driver_init_complete_rsp,
 					   rsp),
 		.ei_array	= qmi_response_type_v01_ei,
 	},
@@ -137,7 +137,7 @@ struct qmi_elem_info ipa_init_complete_ind_ei[] = {
 			sizeof_field(struct ipa_init_complete_ind,
 				     status),
 		.tlv_type	= 0x02,
-		.elem_size	= offsetof(struct ipa_init_complete_ind,
+		.offset		= offsetof(struct ipa_init_complete_ind,
 					   status),
 		.ei_array	= qmi_response_type_v01_ei,
 	},
@@ -218,7 +218,7 @@ struct qmi_elem_info ipa_init_modem_driver_req_ei[] = {
 			sizeof_field(struct ipa_init_modem_driver_req,
 				     platform_type_valid),
 		.tlv_type	= 0x10,
-		.elem_size	= offsetof(struct ipa_init_modem_driver_req,
+		.offset		= offsetof(struct ipa_init_modem_driver_req,
 					   platform_type_valid),
 	},
 	{
-- 
2.25.1

