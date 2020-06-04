Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A8BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D841C206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGSSRmtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFDKBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFDKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:01:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ECBC03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:01:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so2010744plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmlB+pXtYmTxvOHVpxLinB7XLVQiN2it0eFpYDWFPp8=;
        b=IGSSRmtmpdky3rgwegSDEySfjuUJ2LVkZV2xvh9aO93mhqax8N8nuxhwVcjz0b/Gcj
         UIcAq42et3lewAn4TsiQ7+VifsxhjDGyyqPtVs5/a5XOE0WT+Bp1Pdg0AwHtH4LHE2MA
         6A2XNP2cgCaD73tESkCFaRfbF2IKmT9+QPQoH08drKD7PnzolRphdcvNbhybGzCipgIi
         yEA0I+tF7hRDBLwdKCBP3FDWVwDY2v5KqyF9F4d0EO44R7kc8AmsR003b0E1dN8ddppR
         8kCKr6SVXDDA2wMx/zghCP+uhvJZRsB0XeLQ7wyMMLdMoWQ7/mkWn8ul6E2sdKxPgklT
         n7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmlB+pXtYmTxvOHVpxLinB7XLVQiN2it0eFpYDWFPp8=;
        b=Rp7BPNTDohDOqaK7DeToQub/kFUmizUyYksWVSZMjKPXf+c4DsLKrYqxmvPXj9Foqh
         8pdv7Ts1enN7TQGb9jL2FzG9GKKUFIoep9UxeCbyIFIBCwI88L2iTuEn2Oe+jYjKaNF4
         4IHE5d5/HBu0LdNQenS3YZoQC0QF9E46yYiIfsmXmOjJU0QRReYCrSmDEB73NI5593R1
         UXVT7Nyy8lTGO/l0qqhucCL0OqupHdrvOuF7K6PfaNS+ikCUvLf6bATrfpodDdK0MSse
         zJhBxZlzE2eHwWiEpwDYdDYyiRNtf9xZcdINVM3QPKX6EWufhN+qBdoLn4DipAEywVog
         t3Jg==
X-Gm-Message-State: AOAM5311iMUDm+K7nTVEYtiHSHBwnrZmki/G9lHZ5Hmm8hJrnLyMiUCx
        CY+t+R4jX1XYPZ0ix+a5g6hSJQ==
X-Google-Smtp-Source: ABdhPJxZTc90zWLsV6P9Ws4zb95s6ky6KR+UaZDb84BhMPOjFe3tqmx/+tQh3/qZUtqlurXxgyOjng==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr3843773pla.54.1591264911843;
        Thu, 04 Jun 2020 03:01:51 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id np5sm5786992pjb.43.2020.06.04.03.01.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 03:01:50 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 2/4] kdb: Check status of console prior to invoking handlers
Date:   Thu,  4 Jun 2020 15:31:17 +0530
Message-Id: <1591264879-25920-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if a console is enabled prior to invoking corresponding write
handler.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Revieved-by: Petr Mladek <pmladek@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 2d42a02..58b7d25 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -560,6 +560,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	}
 
 	for_each_console(c) {
+		if (!(c->flags & CON_ENABLED))
+			continue;
 		c->write(c, msg, msg_len);
 		touch_nmi_watchdog();
 	}
-- 
2.7.4

