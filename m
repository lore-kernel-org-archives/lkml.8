Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7909C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911232193E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XphMBp2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGNDg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgGNDgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:36:25 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:36:25 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h10so11709704qtc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QRGV21zDsqgReRz8UhXO3hb4yh7SnqqrmCjjSQRfV8I=;
        b=XphMBp2T7rn+hqKSzkbTANp5kYe95a79kEgcFT+LoKklRhZiEDcYtPZNqpe4AV2gmA
         MsLZ1AtT+o8cbj/r3syUri/JyYmwDfagrzEc95+MRqkmlYHUZXXQb7//kN5fzv0pl2lE
         Uk/S/2A90wmxcm7YYxLhvymp2CphBVmvYk0YNmn1l6MQqxZUgJv721/zruOk3mP+VszF
         8JUfUqfHKkbzozRA/WuxjeLL0OQoIOsZPa+XCm0yn5mQKqwoG+uH73K+ioWE0O4GsyK4
         sF6RNN4ngo6iu9K/bx7Fb8i3obmzLl50TPQiJ83t7oaQp5fOYVTGOx4J9/EtYz06EPA7
         Arjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QRGV21zDsqgReRz8UhXO3hb4yh7SnqqrmCjjSQRfV8I=;
        b=DoGzUTPZK4MMlwMFFaG6lMt28h1ZH7UXPqS5FKP1bVFIawT+A4PfCT7Vx6aoK9V7W+
         wPoAXfy9zFHceGoD/4x7JriGjiXGMGcPE/cQQBhpgbgjym3f3qhRFj1but/dO6YDMQCk
         AFKVSWYPElYzZhlCejHUK06VBRErwabTOlDKy9uMBXckVWp33OtyfkNBmVx8iBXxGf3d
         FVR4VZvuFGupKzPDYPywXIYKY+a1DxY4RpzgPVAKo23mPzWJAJaRxEJRTKeBkvY554gR
         tI0mLR+RH3kqyviLEj6qUkGuCqnqgp4dgWIqgHEUoHxHKnXNPpeAoj610bW90IanTa82
         erIw==
X-Gm-Message-State: AOAM5339GAsAiUvQpWkCurjt+c2CVMjKqlmZRkjuV0W8TWndd6Xn/YFb
        7f81IEd/fd62Iw3CqgJcAyxPxVvBqRMU
X-Google-Smtp-Source: ABdhPJyFtn7bk8z0unulWpf4PvIfSuun4DmAwO4sGFV2nov6DXVCdYqv3+LLV3oM6Vf+C+/j+J5qVRvbE4AZ
X-Received: by 2002:a0c:cd84:: with SMTP id v4mr2554450qvm.35.1594697784025;
 Mon, 13 Jul 2020 20:36:24 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:34:53 +0800
In-Reply-To: <20200714033453.4044482-1-kyletso@google.com>
Message-Id: <20200714033453.4044482-3-kyletso@google.com>
Mime-Version: 1.0
References: <20200714033453.4044482-1-kyletso@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 2/2] usb: typec: tcpm: Error handling for tcpm_register_partner_altmodes
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_partner_register_altmode returns ERR_PTR. Reset the pointer
altmode to NULL on failure.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 82b19ebd7838..a6d4b03ec250 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1061,9 +1061,11 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
 	for (i = 0; i < modep->altmodes; i++) {
 		altmode = typec_partner_register_altmode(port->partner,
 						&modep->altmode_desc[i]);
-		if (!altmode)
+		if (IS_ERR(altmode)) {
 			tcpm_log(port, "Failed to register partner SVID 0x%04x",
 				 modep->altmode_desc[i].svid);
+			altmode = NULL;
+		}
 		port->partner_altmode[i] = altmode;
 	}
 }
-- 
2.27.0.389.gc38d7665816-goog

