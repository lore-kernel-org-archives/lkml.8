Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2017CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C22206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="NBNc97xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgHaQLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:11:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67A0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:11:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so6483483wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=G+oTI16jpIyMqmxVK05lUQK2/4ddickm1Vhjew7XNmE=;
        b=NBNc97xkrKU+b8CPNgbvpPqZh+x7oF5iFQV3U76RydQUejst1n4IyDabwPR9IYr8lw
         uDluRmW98hCyyAdCbr6nLi0v5ZbBWR8Qi8GN94UZA8rZkPwAzDaoqPvTTHTWkLoWyFEb
         2FzQXLx9JsFFCOQ+nT4zWRPTVHAuxjTaPpClnx6frAzs2ZRH0lpCfu3h9DnNVPBa51uf
         nYqabF4y49N19aP/80lxBMrwlvaI++d9zMhMUiuWNe8Ufglu6rQnLAoghr/rsbeWaoS0
         vA3D2JYufPuUKOB9r43lREtfulqjBtFGs2r1np/2s2rQVx/s/oNgKTyM8HxBrFxNe93L
         QZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G+oTI16jpIyMqmxVK05lUQK2/4ddickm1Vhjew7XNmE=;
        b=bFvLtEla/lv5MYHm1nDi+SnHJ3BsqQ6sSrCR0O7tx2Leo8Eh+KlRpiidHTxhdB+MXM
         9LDe8I4ULrdxTB08TtCvf9r1CKI+smDXixzhjOEQ36lAqma3BleEd5RfwPhnM6tiEU0Q
         PudhX/SykrYzLgreVoLpUpFhcWCYWCIeH2AgsOPiMqvLbG4XnXL0+nFwiMlUmFX5/kxS
         Pj4AIN0xCV8T5rThLxmhsjSUvdG8pxaPSL9yuS7QAE+p+YPLDGw0kbwmEvOxb2ewzsq5
         rwj4Jdej8X+RX+hDWhhIAOrsCWQ2yQ1JNgg+IEuB6/foxRDiyhD/hHRH5RoKmjQ/DXr5
         /uSw==
X-Gm-Message-State: AOAM530luQ/3x0/NLP7bZrjVZ0+u3/TGR+xdSU1EiP445Fm+9M1nxdS7
        L/o6O1CuY5m0vNTG9TZdg33IIw==
X-Google-Smtp-Source: ABdhPJxABgjSWNLfVp8y3qD9VxUJvb/F5tvNop2o9oL+iVE3OgPSXU7VwWFEVy5UmkBg/xudep0UBA==
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr2267933wrf.171.1598890266467;
        Mon, 31 Aug 2020 09:11:06 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id a82sm35008wmc.45.2020.08.31.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 09:11:05 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, jens.wiklander@linaro.org,
        rdunlap@infradead.org
Cc:     sumit.garg@linaro.org, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, ricardo@foundries.io
Subject: [PATCHv2] drivers: optee: fix i2c build issue
Date:   Mon, 31 Aug 2020 18:11:02 +0200
Message-Id: <20200831161102.14735-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the optee driver is compiled into the kernel while the i2c core
is configured as a module, the i2c symbols are not available.

This commit addresses the situation by disabling the i2c support for
this use case while allowing it in all other scenarios:

 i2c=y, optee=y
 i2c=m, optee=m
 i2c=y, optee=m
 i2c=m, optee=y (not supported)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
  v2: uses IS_REACHABLE instead of macro combination

  This patch applies on top of
  https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=optee-i2c-for-v5.10 

 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 64a206c56264..1e3614e4798f 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -50,7 +50,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 }
 
-#if IS_ENABLED(CONFIG_I2C)
+#if IS_REACHABLE(CONFIG_I2C)
 static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 					     struct optee_msg_arg *arg)
 {
-- 
2.17.1

