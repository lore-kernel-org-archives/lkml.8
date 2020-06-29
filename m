Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63922206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnISCPiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgF2VR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbgF2Swu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1223C02E2CA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so15495528wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5YQ/t8dSO0QYHudXebIYH68IYouA3ghRaFXxhzcpiAg=;
        b=AnISCPiRzH9TAyM1Yh/eas5uDZIiRrIXjaz84GZW0n+uAi8a26gU+tSqm77U3+rVZP
         NdV4xzJw8f2Ev9nBOarM/NU/yZ8KySVqMtpo3QQ1EKVUhnvFx8JQmbwFYaNaJD7/Zyn3
         Fug4WDcUWHR/wmveZO01FVAC27cp7Td1Q2ZhMbVo9fhVF4NQKi7z4zbDrVALYLrK0vpQ
         DzQ4jCYTUc6B2LXvBglJpu+atdKccTXXJ0T5cB/0Y90m3fGPF0BSXSj22obJPWKVIXtO
         K7ih9N4L+20HHUOZqdVFp2be+ozko5YAMI4wvpWO/UUYO3n1Z/FyxYD3OqqVbwuvwC5C
         gEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5YQ/t8dSO0QYHudXebIYH68IYouA3ghRaFXxhzcpiAg=;
        b=Zdv+fm36DBzFHZ/xFsiyfiYivMiCnYZst3fufEhJkTwvzkWysveuAC0lg2dwtdoo9i
         Mbk3fO6xDBgzDmkuqirT8bm6yFhRfxlFM1YrwasQUguTyz8a4fJxnM/KYi4gyT6zW4E5
         aYDOvJrEarntlhAG/3AJIaZ5yhOjcHsKAKgoRwqM1FlOW+jTGUopE18aVQOiElr5bW40
         qeEo0KEs2xlLsILrhjn/bCSlxnsZfvQpaw1KvZPIzcj8ZXFR13/VrsEbhPLNTO6h0d91
         4huaHMg9hyuDDCz1QGptuio5d11qf1+JL8+XNA7PNwdHyy27SGNxs6+Ertv/Mn1Hr0Rx
         jnhw==
X-Gm-Message-State: AOAM531/WoJk4zSbsAco7ShordVmXGk8kR8HkU0BcfhC0kdqx2poWvSw
        eFzn05/WKqPvf+haIQozm7ZqvQ==
X-Google-Smtp-Source: ABdhPJzklT/ar5KuBB0weZ4AZeRlCfm6aQdYK/f0/bnGvB3j51na/D665sOuUJB8nwyHym/s0z/zlw==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr16500903wmj.20.1593439488384;
        Mon, 29 Jun 2020 07:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        J Freyensee <james_p_freyensee@linux.intel.com>
Subject: [PATCH 02/20] misc: pti: Remove unparsable empty line in function header
Date:   Mon, 29 Jun 2020 15:04:24 +0100
Message-Id: <20200629140442.1043957-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerneldoc tooling/parsers/validators get confused if non-
standard formatting is used.  The first line after the kerneldoc
identifier '/**' must not be blank else the following warnings
will be issued:

 drivers/misc/pti.c:902: warning: Cannot understand  *
 on line 902 - I thought it was a doc line

Cc: J Freyensee <james_p_freyensee@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/pti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index e19988766aa69..7236ae527b19e 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -898,7 +898,6 @@ static struct pci_driver pti_pci_driver = {
 };
 
 /**
- *
  * pti_init()- Overall entry/init call to the pti driver.
  *             It starts the registration process with the kernel.
  *
-- 
2.25.1

