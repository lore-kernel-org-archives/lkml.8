Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3179EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E0920836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7IxkQgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgFZNFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgFZNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FFC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so9419998wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9egOal3uN/e6e9MaOrNvFSxzzJuszdkWNRmQ29ZgoU=;
        b=V7IxkQgf7wGz0DpEojoH/IUl8uhIPCLkWJcfgONzZXJQVqVWNiIkbffuTbRAzPsnaG
         9B1MG1NxVnNlGAQ7Mb2IRUomTjwKPNYs/NNjEMEg5Ell+59PWbiub25e5fGlfIp/zm8d
         mkSITkB56G89qfu4DsDCxXOi8Q2tgL3PdogZGF0I5DSPiZZV4vA2RJoR60lJKfOViKoQ
         O7Xt6Wgb2yb9DxMOZMKMif7av87+AOB42O+/wDA2KleCph7PaR4mGo4p0BssrOUq94Ou
         ONN2LOo2d1+N81ZKjzCA3lxoXNmQe0K9vq4z09zwrnMSFncvknsqjTeShfjj2Rcv99s+
         u/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9egOal3uN/e6e9MaOrNvFSxzzJuszdkWNRmQ29ZgoU=;
        b=LE9aL4Y5I4cd6zg+ZURzf5IOG9CG90U1tod1v36/2QOMnE9aQhN3OqpLSHZex4baCL
         buH0diqmaFEq/ArpHGQVN4MSP0b1PMjC1HBxCO16x5OwjMpVw2ge5Uq73mcmRHZuqme6
         Ip1izRLoLNjOSrFNR9SWAJfJ3sJrY6M6kxTZEoJ+sFKITtr9Osol7MMmUx3sL6bm+Nnw
         DQfowyVIvH+3z/4rdpqb+ChJ3ml362Oqx5HmDnyT/WQ+2qIKTF7tS0/UKEH791dyFLNC
         +XQ/ohcRYWHHa95gSZk2coEAbiFN60BIdUUE1YP3P84JhAKx8cscloqzn1yY7oQSYtel
         1hjQ==
X-Gm-Message-State: AOAM531Q66RwsSDt/UwtD39dhbOC2hDhqFusQ+vZtOZksICDYCtmwlwm
        c+znfIKxCbi/1Ex1j2bqK6AieQ==
X-Google-Smtp-Source: ABdhPJwm4pLJby/llKlKk2pTQRstc6jX1VxdYEZilS6bFSSooSi0Sw/2PixW9k4WiLO2WnWEAkMYKw==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr3716291wrv.155.1593176736454;
        Fri, 26 Jun 2020 06:05:36 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 06/10] misc: eeprom: eeprom_93cx6: Repair function arg descriptions
Date:   Fri, 26 Jun 2020 14:05:21 +0100
Message-Id: <20200626130525.389469-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy-paste issue.  Looks like the kerneldoc style descriptions for
these functions were taken from existing functions with slightly
different argument names.

Fixes the following W=1 warnings:

 drivers/misc/eeprom/eeprom_93cx6.c:239: warning: Function parameter or member 'byte' not described in 'eeprom_93cx6_readb'
 drivers/misc/eeprom/eeprom_93cx6.c:239: warning: Excess function parameter 'word' description in 'eeprom_93cx6_readb'
 drivers/misc/eeprom/eeprom_93cx6.c:280: warning: Function parameter or member 'bytes' not described in 'eeprom_93cx6_multireadb'
 drivers/misc/eeprom/eeprom_93cx6.c:280: warning: Excess function parameter 'words' description in 'eeprom_93cx6_multireadb'

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/eeprom/eeprom_93cx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eeprom_93cx6.c
index 36a2eb837371b..9627294fe3e95 100644
--- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(eeprom_93cx6_multiread);
 /**
  * eeprom_93cx6_readb - Read a byte from eeprom
  * @eeprom: Pointer to eeprom structure
- * @word: Byte index from where we should start reading
+ * @byte: Byte index from where we should start reading
  * @data: target pointer where the information will have to be stored
  *
  * This function will read a byte of the eeprom data
@@ -270,7 +270,7 @@ EXPORT_SYMBOL_GPL(eeprom_93cx6_readb);
  * @eeprom: Pointer to eeprom structure
  * @byte: Index from where we should start reading
  * @data: target pointer where the information will have to be stored
- * @words: Number of bytes that should be read.
+ * @bytes: Number of bytes that should be read.
  *
  * This function will read all requested bytes from the eeprom,
  * this is done by calling eeprom_93cx6_readb() multiple times.
-- 
2.25.1

