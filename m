Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2682FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A7B20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDxm68x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgGFNfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgGFNeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8DC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so39374163wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuuvgBdpWU3P+bBrTu/2KsiGO4ss74gkTJhNI/l0mkY=;
        b=tDxm68x6EEuzSyF8zb1P7MNnLA1RLSLV7ALNXgP2jbhLbdEirodV/LE4bXzaJbsPRg
         SUs25JhonwmI4Zqrwaw4zG1N8CYo4lAXlnF26lpK/OFRkQCBCsW93WEi1lCMj5UWQUmj
         QMnuck2Ci0chN7EEaR5qWLPh9Nag2b7j1MCcb9/mrCXgV+WBZ7ijQZzXPdT8Hjg0PTNS
         goxdYPMOU0X2sc2aE1VXEpQk/0hLVxQjbMvmUCXhN28efa29/LuSc8kkdAhJT0CG2LUK
         rVz1fvRtUKDbzGwTdNfqJrgIE5j/IDqenQl2BErSZqG2pPSnQFEsUwi3TsrnXUWaGjxc
         gQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuuvgBdpWU3P+bBrTu/2KsiGO4ss74gkTJhNI/l0mkY=;
        b=FnllDHtLViCR5IwY3bqJDi3GOz4MzTjRaue1CJK1xkcVjUn7+IQTY3Bsz6d2tG0gB1
         LFIWwMSPj5sX+3YIzlQ/XMdtM/EK9wib8zN738KRvQqoWjS4P0IIVIlYhmjdhlimdlb9
         mlhRtmOYOTtHJyVLxSs2VCGDJlIwvvi2wx4ikR7kXthsy2jqvu3jde1h2nV1U1jB9+D/
         /i2tiW194VrnIGdfTAPEwuqpdnR4vzhq8KGawNFkYg+UtkVEIJN+2TjKO8gkV86xWIyv
         s41jWZgpqOzOBek9tpWaT+vjARDwdbwf1s+m1igPPMPvouLzE7cF85QsXSDMhft0ZxBV
         sz5w==
X-Gm-Message-State: AOAM530XOTz1U7c2y/P18Xb6fHTg+JqHyzLMo91DoeCwcSxiXnq7LgSR
        pI7Q8MfElXTRu1RdiygdIzgbIw==
X-Google-Smtp-Source: ABdhPJzuzYNNW71b23BvSLPHgO5D0LojminjFAQt3G/egnKeifhMWhpTDqlAyYc41PSyJlYXg/HnVQ==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr50012638wma.13.1594042454380;
        Mon, 06 Jul 2020 06:34:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yinghai Lu <yhlu.kernel@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH 25/32] usb: early: ehci-dbgp: Remove set but never checked variable 'ret'
Date:   Mon,  6 Jul 2020 14:33:34 +0100
Message-Id: <20200706133341.476881-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' hasn't  been checked since the driver's inception in 2009.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/early/ehci-dbgp.c: In function ‘early_dbgp_write’:
 drivers/usb/early/ehci-dbgp.c:915:13: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 915 | int chunk, ret;
 | ^~~

Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/early/ehci-dbgp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
index 775cf70cfb3ed..b075dbfad730f 100644
--- a/drivers/usb/early/ehci-dbgp.c
+++ b/drivers/usb/early/ehci-dbgp.c
@@ -912,7 +912,7 @@ int __init early_dbgp_init(char *s)
 
 static void early_dbgp_write(struct console *con, const char *str, u32 n)
 {
-	int chunk, ret;
+	int chunk;
 	char buf[DBGP_MAX_PACKET];
 	int use_cr = 0;
 	u32 cmd, ctrl;
@@ -951,8 +951,8 @@ static void early_dbgp_write(struct console *con, const char *str, u32 n)
 			buf[chunk] = *str;
 		}
 		if (chunk > 0) {
-			ret = dbgp_bulk_write(USB_DEBUG_DEVNUM,
-				      dbgp_endpoint_out, buf, chunk);
+			dbgp_bulk_write(USB_DEBUG_DEVNUM,
+					dbgp_endpoint_out, buf, chunk);
 		}
 	}
 	if (unlikely(reset_run)) {
-- 
2.25.1

