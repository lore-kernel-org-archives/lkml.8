Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01960206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9EIrN7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgGFNfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgGFNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED6DC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so40921535wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNre9OCmAxyss+/an4xQhs3AGuEV6paz8+9ZDHvC1J4=;
        b=n9EIrN7G3akIgWOBqzyERxZhfzrR9fJGgAr0I5uOS7PMKd2/If2vceE3yjXA1b/eZZ
         qN3X40tIDqUzGlEgMn0NMHgN6bPz+FRCzIjbeU5YntfppHpfycT/2OcjyBD9MbXMHH02
         OAP80qDZ/zvXp0E2Jnb7TOliZnTx2ngHJYqDWJHlo/tMh8+1qQfVZkuz2a58o08kRx4M
         zF3huI5CGRipEwA6l9h/nCGNATepgZn8qDH7q91rmF3uOAt3E5xdsJAmRFnaRysZtFNy
         ShO/sIOYPlLSWlNUwKcP5X+GpzdLohe7Jl5tgxA/WU0feCd8kmHyPcohnDu2G/JQnpLS
         2TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNre9OCmAxyss+/an4xQhs3AGuEV6paz8+9ZDHvC1J4=;
        b=E1VTstNjd81a+AbxjRBDXzwFDvaTA4IxkxBSPCt8/eKFRG0btUDVTpESwCP0Zm9Cwq
         7bYbBRj96ncO7nxJsAzlKvjVxwaH1TmzJPFtJc9ATreP2+mVaHTqPdw2WU4FY99pkbc/
         uAk72Gh5UPTleMhLUrRnOB7+Zj4JWj15h+8QROHJ7GcSMRs/lhOSXG56GqVFQFiro2Kq
         PY2Tr8bgj6O364OTTWVBKMapIpXWi8aWzw+Xi0iu5vGyjXxDTXDaJJLeP4/B8xcmIjuk
         f8I2eY4GFA4lOHemxf3P0GIeVni0u7wRhYY8aJVwqMZcNXzm16UcX2UvbKtP/588f4OT
         2g5g==
X-Gm-Message-State: AOAM533I53oQrJpTJ7lsCYgEENv0byP8MoSGG42pPND7LCk6rK4WeIDx
        lnjv1BE2tpbDpJSA12mNM59B+w==
X-Google-Smtp-Source: ABdhPJx5Dq5C1EhkZdMxsgfApXgr0cOIhDoivpkexRKYjAKcjnC2QN2Yq3ue3sIKyjTLwO40wsMNQg==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr51614270wrn.143.1594042443610;
        Mon, 06 Jul 2020 06:34:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jay Monkman <jtm@lopingdog.com>
Subject: [PATCH 16/32] usb: host: imx21-hcd: Demote function header which is clearly not kerneldoc
Date:   Mon,  6 Jul 2020 14:33:25 +0100
Message-Id: <20200706133341.476881-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/imx21-hcd.c:233: warning: Function parameter or member 'imx21' not described in 'copy_to_dmem'
 drivers/usb/host/imx21-hcd.c:233: warning: Function parameter or member 'dmem_offset' not described in 'copy_to_dmem'
 drivers/usb/host/imx21-hcd.c:233: warning: Function parameter or member 'src' not described in 'copy_to_dmem'
 drivers/usb/host/imx21-hcd.c:233: warning: Function parameter or member 'count' not described in 'copy_to_dmem'

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Jay Monkman <jtm@lopingdog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/imx21-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c
index 5835f99662046..b2716cb724719 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -224,7 +224,7 @@ static void setup_etd_dword0(struct imx21 *imx21,
 		((u32) maxpacket << DW0_MAXPKTSIZ));
 }
 
-/**
+/*
  * Copy buffer to data controller data memory.
  * We cannot use memcpy_toio() because the hardware requires 32bit writes
  */
-- 
2.25.1

