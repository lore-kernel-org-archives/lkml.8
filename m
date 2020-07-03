Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29742084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wq2eX9jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgGCRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGCRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D02C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so22419995wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrkMNgFq6kjSqpaCA+XSVAlQbJi5HEny4uddp4894Fo=;
        b=wq2eX9jGfiXqkmXfLTj6mEEM2DpZg01ZXm7M/28lM017rbrQHv08Hx3W5hVLkdvmFs
         cvQdic5dr1Kq+Q9SQvJOlJ0Um9yIR+Y5uLRgIgCiIyPKB+8SrlN67FMkH9I8POq9Tl99
         +hMw+MdBOJx/zy0bvat2TNmCBkFSWbZmsToJ9vMSa5EOAXM8Car+SJkpsfivOXFgNdE/
         6OAuqi/2/eHEu3UadPeyfjssCvcTNhCKm7ljorj8hYXKdL8F5lln2bdGPwryANInysfn
         p6uUI7Z/tSUbPtLZ/HmaXeu93dZ6mryZK5EOYSHV/jxy8VcCQlvYpf7cgzBj9yLjwsAv
         LKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrkMNgFq6kjSqpaCA+XSVAlQbJi5HEny4uddp4894Fo=;
        b=BSBjxIdk6cpBfENcpQLvJUmtqJUrIyBI1pl/neSViyaGK7r2PM1MUm9RXaUg3cIm7Y
         DyKy93wjYCFdChYrHjMXc33x6kvZjMlPre7Jy+DZdbdtIlmk1vprhAt6OezAd2CaUVK5
         IgIWvQgPygfJPzsKxdeoMwYP7VR75Yxz+AZC+sAZkqyp32r+YsuS5Jvq/RJ29zAo5Xxo
         x8BUmHaIjk7i1HK5kDUtvwEXe70EJ26IJDSKSOsEG3fOFJ2YYhC9Fnul5f4rFvzkHLNA
         FD8XwbZt/BiQJrjkEDKbloJs9MfufekdN8TbWAR6vi/+gr8J31l1f2a0LVvf1S6ednmU
         aVQg==
X-Gm-Message-State: AOAM531BTKURfnJXzTWx3+12bwtmBxsB9zMuFhsh+S+yFMh02lqA0BfS
        w5xeRnfL1chexXtpiFTYzGOLpw==
X-Google-Smtp-Source: ABdhPJxF4+w/X3XbjJY6K8JuqOts4/0aCaGlb0DEvCdqQgBeAb0DrB1QpZ3cPKmGntf65MNAAWWkgQ==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr39858082wmc.56.1593798132797;
        Fri, 03 Jul 2020 10:42:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>
Subject: [PATCH 09/30] usb: chipidea: otg: Fix kerneldoc issues relating to description of 'ci'
Date:   Fri,  3 Jul 2020 18:41:27 +0100
Message-Id: <20200703174148.2749969-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly we add some missing descriptions.  Then we fix some formatting
issues.  Kerneldoc expects arguments to be in the format '@.*: '.  If
either the '@' or ':' is omitted, kerneldoc gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/otg.c:29: warning: Function parameter or member 'ci' not described in 'hw_read_otgsc'
 drivers/usb/chipidea/otg.c:82: warning: Function parameter or member 'ci' not described in 'hw_write_otgsc'
 drivers/usb/chipidea/otg.c:235: warning: Function parameter or member 'ci' not described in 'ci_hdrc_otg_init'
 drivers/usb/chipidea/otg.c:254: warning: Function parameter or member 'ci' not described in 'ci_hdrc_otg_destroy'

Cc: Peter Chen <Peter.Chen@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/otg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index be63924ea82ef..d3aada3ce7ec2 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -23,6 +23,7 @@
 
 /**
  * hw_read_otgsc returns otgsc register bits value.
+ * @ci: the controller
  * @mask: bitfield mask
  */
 u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
@@ -75,6 +76,7 @@ u32 hw_read_otgsc(struct ci_hdrc *ci, u32 mask)
 
 /**
  * hw_write_otgsc updates target bits of OTGSC register.
+ * @ci: the controller
  * @mask: bitfield mask
  * @data: to be written
  */
@@ -229,7 +231,7 @@ static void ci_otg_work(struct work_struct *work)
 
 /**
  * ci_hdrc_otg_init - initialize otg struct
- * ci: the controller
+ * @ci: the controller
  */
 int ci_hdrc_otg_init(struct ci_hdrc *ci)
 {
@@ -248,7 +250,7 @@ int ci_hdrc_otg_init(struct ci_hdrc *ci)
 
 /**
  * ci_hdrc_otg_destroy - destroy otg struct
- * ci: the controller
+ * @ci: the controller
  */
 void ci_hdrc_otg_destroy(struct ci_hdrc *ci)
 {
-- 
2.25.1

