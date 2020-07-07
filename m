Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A7820775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY/Y6rRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGGOBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGGOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1159C08C5E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:01:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so46661244wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cqZIdFqcpIXxhTbwotqjldLYbQ1H9RlyQjCdSkXyGs=;
        b=DY/Y6rRCsOjNTJ4MkMoPwBn+t6tp8Ea3aR3cwKW07HPMrJatmNWyjsxXWn8QkYDC9A
         MjrEbwgrbgZZxlHsmKUvipQUvak0bqLJ9f+zQwDGAQFTgW54RkqkMz/JGF+4e5i78Q/c
         2KBqbs2XOY808AW/smRWfFkGiaf9aMa713477C90tUkPIRj74nGwK2SRjYtBnft1e8i3
         IVkvAi1yYxYJ37bqk704jsA8Ompe5sVbx1WP9CxrdUjsqIps8siu/zYqjiAuTHQrJdCb
         41vt5Gk8sl8yd0WJ0DpcW5y/WTCY7ErzeiiIJe2KAXO8GRuw9+Oe0ws8P8hbK/NUezih
         UwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cqZIdFqcpIXxhTbwotqjldLYbQ1H9RlyQjCdSkXyGs=;
        b=KzTVoYxNwzNRaIma3x+wbkhOvBDwkAhWG4AEma92tVvzbRg3e9x9VPfaJumh03KGXD
         iIzPonbCvFe5odTueDQpwrEvtWmHaWYkheZExJ9qroyt9701Vwij4StA8NW+fE006eOP
         ImoIgT3B00OvsRKuN/BNkbXvFDPuO60kU5ImK6npxcFpzS19sL7kPykGipYbshj87Qve
         iJDFJ4TA9B1Gymzl/RQuMYQH77tZhftM649aaI0qHswyV0RQslxRHws0REUsMgUusnN+
         UtwX0cpyc5NjMTLHsmaDf0yatPLz0puJF1PZq6kLSuZWlLeIBK+gYMBMXdLLT2e26ppM
         oJ4Q==
X-Gm-Message-State: AOAM5308yby5qxzDtM4qKq6KHBriKYaRSpR9Nhs6NPk7poUSGbs4QphW
        JH12Mf8e6PNw+53UEmu+7HK3RA7v6t0=
X-Google-Smtp-Source: ABdhPJxcwcKHBS+Zqr7hOZ8rG07HC55gAhjiOhogcm4iiP2hTlX4x1wCiARK/E88lw9mjx75xGrnpA==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr4610085wma.13.1594130462391;
        Tue, 07 Jul 2020 07:01:02 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z25sm1102823wmk.28.2020.07.07.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:01:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/10] scsi: fdomain: Mark 'fdomain_pm_ops' as __maybe_unused
Date:   Tue,  7 Jul 2020 15:00:48 +0100
Message-Id: <20200707140055.2956235-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707140055.2956235-1-lee.jones@linaro.org>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all source files which include 'fdomain.h' make use of 'fdomain_pm_ops'
leaving them defined but unused.  Mark it as __maybe_unused to tell the
compiler this is not only acceptable, but expected.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/scsi/pcmcia/fdomain_cs.c:16:
 drivers/scsi/fdomain.h:106:32: warning: ‘fdomain_pm_ops’ defined but not used [-Wunused-const-variable=]
 106 | static const struct dev_pm_ops fdomain_pm_ops;
 | ^~~~~~~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fdomain.h b/drivers/scsi/fdomain.h
index 6f63fc6b0d127..93afcee207aed 100644
--- a/drivers/scsi/fdomain.h
+++ b/drivers/scsi/fdomain.h
@@ -103,7 +103,7 @@ enum {
 #define REG_FIFO_COUNT		14	/* R: FIFO Data Count */
 
 #ifdef CONFIG_PM_SLEEP
-static const struct dev_pm_ops fdomain_pm_ops;
+static const struct dev_pm_ops __maybe_unused fdomain_pm_ops;
 #define FDOMAIN_PM_OPS	(&fdomain_pm_ops)
 #else
 #define FDOMAIN_PM_OPS	NULL
-- 
2.25.1

