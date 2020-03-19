Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA16C43333
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C5620782
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGNCWsxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCSWMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:12:17 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:40935 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgCSWMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:12:15 -0400
Received: by mail-wr1-f73.google.com with SMTP id d17so1671064wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ec1QNNZB9RdZOPOOrrZEv520YKl8QD3P6+7VUng4a2o=;
        b=wGNCWsxxzE05P/opJCYnv1N8zFwNt6cTq4ckyZiz9oQ5890qOacNIWKpN7Y++MLt6+
         +YKxBiZXwSFk1IGTSnQFc06R14nY8UWmBgLdcbf7MdFyRG1MvL6T6rd8RP3yB53TVKyf
         +Uc3R9oxRBqgWKVz/QSvUAel4ej1J8si1HLNu0Rai083j03ODYzNjaVZf5T0XtF/kjJh
         LwTg7zhgbj4V9RDUcQo4mmHihgfAC9ymlc6F/1mRhJPaKXIcT7VSTgKS++nhSDDRJStp
         Lp/miL7zNG4MdaM7dB/m1BK/l18wytSw5UL2GhIyw3LNguhr0wHydS463Cf5gI+Zqiwl
         CXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ec1QNNZB9RdZOPOOrrZEv520YKl8QD3P6+7VUng4a2o=;
        b=jP8uRdl71ib7DFh11UPBeUCFPQuMJIeZFjoj4xmQqt15I8AN18xLMyvNg+kiILx8Cd
         PBIhlVqM2RPMEfcmQnLCM9skP15U3q+3lB2EXkiXmOMm+TJ+04AXbWK4y7LN6FWjTFXF
         35Z3OpZB7dUjHpy5ltcoX+BS8+E2YdLSBeusluuW/CAziewvZosPM0UP128miLa2mfY4
         /lb8miGngOqMNltWW9WUEsJsIefx2pfejBHzwqzUdixfPB0/9Po2YYpTNuzVpcYpWMSo
         yPWIUt8Y3A2ArOK4pQYW9d2e3RP0kmgMhRiUTnWaeNBlh9HIhBWHI/jA5VVJC+AK2F8r
         LwVg==
X-Gm-Message-State: ANhLgQ3sM3buPB9X8r2LraXqfcKjY9LjCVd3h8u8jJND6l63hNiM64Eq
        iWMHbgxpEY6to4/XnW4nSkMWNGuZsCHYpyty
X-Google-Smtp-Source: ADFU+vushxI8BnYkgZABMFdSfaL5+yV3YI3la2gcdZ5v3T5GugDgvBJQPNjSNj8fkPYEaoYtd6RE48XYpmoP4A7m
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr6989126wrs.96.1584655933185;
 Thu, 19 Mar 2020 15:12:13 -0700 (PDT)
Date:   Thu, 19 Mar 2020 23:11:41 +0100
In-Reply-To: <cover.1584655448.git.andreyknvl@google.com>
Message-Id: <2821d497ac1cdc0efb5e00df30271e4a67fc8009.1584655448.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1584655448.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 7/7] usb: core: kcov: collect coverage from usb complete callback
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start/stop() callbacks around the urb
complete() callback that is executed in softirq context when dummy_hcd
is in use. As the result, kcov can be used to collect coverage from those
callbacks, which is used to facilitate coverage-guided fuzzing with
syzkaller.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index aa45840d8273..de624c47e190 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
+#include <linux/kcov.h>
 
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
@@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
+	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
+	kcov_remote_stop();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
-- 
2.25.1.696.g5e7596f4ac-goog

