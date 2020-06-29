Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF8EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71B0206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhjCZd7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbgF2VRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbgF2Swv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35348C02E2D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so3783955wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFg/20zEaYelN+bfrfecs/17poyLmNxtGMsllJMhgRc=;
        b=UhjCZd7WNhGjoLDr5PyNeZnltRSCoPXKyAHQgfTsZnaLk96ITbriliBHRl55k0eDJx
         lc3n3EKymPGCS7unDwOE063XuLFpjB1iQAYFZTgz6tyySvF4yoaosDvst4ifsKgVhmN0
         LNPrO6GKlT5E6LwyirkIJorC2j5C4qh6EJoyY465J+R2Xs4hziqKqz1uaTVzlsA+pn3z
         gcTXxqlLkpSrB2zUsNjQzVNKBajJz1mQaknOq5scO/mQ6+uWRfqEMbL8jlgwOjLK2+sR
         LzTx5lmYPk/Hf2baptXHP4/mApmazi/TAZpWe3byTGbgwYtrag7D56WH3ZziZygGlE1v
         oGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFg/20zEaYelN+bfrfecs/17poyLmNxtGMsllJMhgRc=;
        b=PbW73mK3NupxI1JYibQUpNax2L04GQU1Z/QNHsDASX5zvvzJEBoHObFzYbKUHZgU76
         4Wp39VENDMzmSYiQ1/XH4phkaGcZRKF4qMqmfucHKncM5JNQwI7ItYaPVP9g5+5HhLOy
         iny3L74d42XZj3avKlHiZ3iCH/e6JjGwMYWPUHeG8/0CRswTVsbNGF0EeeuVIuN/e4fB
         kLTb7zDMOG/Xsw+c+6Ro/47p2o1teRx6u3Df8b5Wd834/zzKup1L4QqdlgjAbacPT5bJ
         /gfgOjAz/t3qq0E4LDQgk5u9l/RgLUu3GHdXv6p9uZJuOw83h5WXgyJwhAsvmi/MwNga
         8IeA==
X-Gm-Message-State: AOAM532cdZpbFqhgh9UcupVrll7u4KikJULOloJ9f2PGHdcSm8A2oov5
        fx8300BxQMAy2auz1Q4URo4fFQ==
X-Google-Smtp-Source: ABdhPJxVASpcY0mI0vJ1KMxWvt8KciiXaLwY9KmwNnvFBmpGV0B9lPz9rGOhshF5HA/le49SFgxcpw==
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr16716253wmu.55.1593439497936;
        Mon, 29 Jun 2020 07:04:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 10/20] misc: habanalabs: gaudi: gaudi_security: Repair incorrectly named function arg
Date:   Mon, 29 Jun 2020 15:04:32 +0100
Message-Id: <20200629140442.1043957-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audi_pb_set_block()'s argument 'base' was incorrectly named 'block' in
its function header.

Fixes the following W=1 kernel build warning(s):

 drivers/misc/habanalabs/gaudi/gaudi_security.c:454: warning: Function parameter or member 'base' not described in 'gaudi_pb_set_block'
 drivers/misc/habanalabs/gaudi/gaudi_security.c:454: warning: Excess function parameter 'block' description in 'gaudi_pb_set_block'

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/gaudi/gaudi_security.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 6a351e31fa6af..abdd5ed8f2cf6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -447,8 +447,7 @@ static u64 gaudi_rr_hbw_mask_high_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
  * gaudi_set_block_as_protected - set the given block as protected
  *
  * @hdev: pointer to hl_device structure
- * @block: block base address
- *
+ * @base: block base address
  */
 static void gaudi_pb_set_block(struct hl_device *hdev, u64 base)
 {
-- 
2.25.1

