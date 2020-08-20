Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8464FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584B020724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgPWAn6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgHTRWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgHTRVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:21:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF7C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:21:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so2312995wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uWUfvcvtlbQW5JFnpOK+hjAu8lWAyrOUrT32VpIiuI=;
        b=AgPWAn6KcYpaUgZNdnQDrZpEE4Ja69FANSIymzvKytxdV0F7ganAaAA5yN5fLc9+1g
         EwliSW76cTQxHDGzRgYdb6/BBrIeQyEK9MaHHmbZbE/QnYmY0sKuZcdtUflFjjWvrn2L
         e86YlAz7w7fZatTbnRQoh7CX0Z7jK1vgQifn/i27v+z1sYX1T17I5gLLwsTiW9qi0B5O
         oCrDynXkE8FKWL8sGlM9xB4SOomoCGJnz3+ueXC7KaFLx6Rg27aDWBhB10IsqPXgcJLo
         7TR166fr4WSJK7DXxzs+7IkxABGHwvl6PfzSAP7MoY6Jr0Ts8RENSleRnPHygA+iK9Df
         nz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uWUfvcvtlbQW5JFnpOK+hjAu8lWAyrOUrT32VpIiuI=;
        b=YfNg7IfaOi78o+WB3+xAz/Z6xv+J1Kg/8TiNQ9TGfVQ8fQCdwI+5jEZEhremOYHigv
         qBQnCHJQZBng0Wy5hOcEeC3Y4asVUlDDrAsbyJoJXv5kSkqrAgFG4AqxEnzBS8hfdGMQ
         TxLJyKwhyP54sHIL10gRCbGXW/sFc6zPOnqJ/usdYFxxiXvWuYDuq6t72fGfoCYtw5j+
         hGEw/Ysz7mk2wCshlCHvcMZdSohd+QSs27v44cauzi1URo6C8RvqQWHG98Ictbtq9ZXW
         C/vMUVpjlBa8X+EGPBRRlMV6IQGUjrJFml5O7VSounguiQ9khG7SoL4vvLqWp/z5CMBs
         sYBA==
X-Gm-Message-State: AOAM530rbx7Bpu0p/gXsTloH5DgY/7wVQ1gJitnXNzEo/WIxgI+S2oc8
        /4Vy4AHbdY6XnzH1BUHOSl0=
X-Google-Smtp-Source: ABdhPJyNwdvZcCBCsA4v68ZOL1cjBR2XTgTJ6IvFAFZq/BX6AHTjYvq48ZTwTZCPpp2kEu7bST60lA==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr4173075wmi.147.1597944096808;
        Thu, 20 Aug 2020 10:21:36 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id y2sm5724061wmg.25.2020.08.20.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:21:36 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH v2] memory: brcmstb_dpfe: Fix memory leak
Date:   Thu, 20 Aug 2020 18:21:18 +0100
Message-Id: <20200820172118.781324-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In brcmstb_dpfe_download_firmware(), memory is allocated to variable fw by
firmware_request_nowarn(), but never released. Fix up to release fw on
all return paths.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
v2: Don't assign ret unnecessarily (Krzysztof)
---
 drivers/memory/brcmstb_dpfe.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 60e8633b1175..e08528b12cbd 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -647,8 +647,10 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
 
 	ret = __verify_firmware(&init, fw);
-	if (ret)
-		return -EFAULT;
+	if (ret) {
+		ret = -EFAULT;
+		goto release_fw;
+	}
 
 	__disable_dcpu(priv);
 
@@ -667,18 +669,20 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 
 	ret = __write_firmware(priv->dmem, dmem, dmem_size, is_big_endian);
 	if (ret)
-		return ret;
+		goto release_fw;
 	ret = __write_firmware(priv->imem, imem, imem_size, is_big_endian);
 	if (ret)
-		return ret;
+		goto release_fw;
 
 	ret = __verify_fw_checksum(&init, priv, header, init.chksum);
 	if (ret)
-		return ret;
+		goto release_fw;
 
 	__enable_dcpu(priv);
 
-	return 0;
+release_fw:
+	release_firmware(fw);
+	return ret;
 }
 
 static ssize_t generic_show(unsigned int command, u32 response[],
-- 
2.28.0

