Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF4C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B9122464
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib/ipaTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBWXSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35874 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgBWXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so8240078wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JsFjKcOu7jW/M1qrYTdBQPFBg6qfbgh2FpuNfUuXtg=;
        b=Ib/ipaTmEoXe9NTmOlqz8W7PT38FAENFsjMIGAsVjg0W6UlWPO4+jbIJSv6XxMsBCO
         zZzj4A7rmOCqAa6sMqPaNgPBOCv2z2Us8/cSMNmjtCSeBWYpzENgrLlXlTSfZQF2kfR9
         cfRg7jXaU8VY56kT/ak2YgSdY6cnGhyDZUDLWKFxYPijI4kewwoap4UlC1O+rrx4zJPz
         Nlc0S2kzqpV0rqkKYh+yM+/mtXplVppLtisfT2Vxj+zUUyCkcMDLZuNH80f1/0hdTGzV
         sJfazOx6VfBJBvB877pyNRW20Ko/pbROOEg+rclygzDMLnhPovnDbJBXXzcS06v73pO9
         REgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JsFjKcOu7jW/M1qrYTdBQPFBg6qfbgh2FpuNfUuXtg=;
        b=YJgBANlkK896qj3BBVydVBbvcHsbLViJHVW1nrSW8dBGYL6Ct/IHB4Jg1DcUaJN333
         So4zHOeZRs/yRv1qGlu3/AolIHTLhjG2lhQ9zlolJzxGxT9b7K8MtfQumjfE23+2KQcM
         xjLy+OElmI35ub0gd7M//pFppR5ts/tYLZ2W00eb8CuV7NN9FDNsnjLNc6hKJkPzSx8m
         YCxw9U0wLr7Gn0Fg4FBKLXxDpPw4qktQ7CumPaM+T3+jRnKV6o+PtyPuz0FNVVul1fXm
         BYE0Xy/GKXUs0NqZIVoU4vFd7uWr1pBRSKWEOTHVJ+7uKB6T7szMl+SUNqWudvs4pQkn
         9sUw==
X-Gm-Message-State: APjAAAWbBimEl3MXrOWlkYP6epMRPVSV3V7yIMJd8nWOvDpnN1vE6Hcu
        kpJ/xz9FOLjonbk8TO2FkyHy7dtlYL+w
X-Google-Smtp-Source: APXvYqwJdi6xigWsNZ2RU+hwdKtpaD4ZKfpvLJf4GZNTJsaOlEPPTKtS2G1+BcqPM54FUtkYtD5uqw==
X-Received: by 2002:a05:6000:114f:: with SMTP id d15mr36435712wrx.130.1582499915766;
        Sun, 23 Feb 2020 15:18:35 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:35 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 29/30] sgi-xp: Add missing annotation for xpc_disconnect_channel()
Date:   Sun, 23 Feb 2020 23:17:10 +0000
Message-Id: <20200223231711.157699-30-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at xpc_disconnect_channel()
warning: context imbalance in xpc_disconnect_channel() - unexpected unlock
The root cause is a missing annotation at xpc_disconnect_channel()
Add the missing __must_hold(&ch->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/misc/sgi-xp/xpc_channel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/sgi-xp/xpc_channel.c b/drivers/misc/sgi-xp/xpc_channel.c
index 8e6607fc8a67..a1e92488e9bc 100644
--- a/drivers/misc/sgi-xp/xpc_channel.c
+++ b/drivers/misc/sgi-xp/xpc_channel.c
@@ -752,6 +752,7 @@ xpc_initiate_disconnect(int ch_number)
 void
 xpc_disconnect_channel(const int line, struct xpc_channel *ch,
 		       enum xp_retval reason, unsigned long *irq_flags)
+	__must_hold(&ch->lock)
 {
 	u32 channel_was_connected = (ch->flags & XPC_C_CONNECTED);
 
-- 
2.24.1

