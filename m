Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE32A206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTKBeOy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgGFNeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgGFNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85986C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so42148266wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8CBq5D9tY/rIxd8Q9bScU/Lf3c39zfJPjGb95MJ1ho=;
        b=vTKBeOy8iUfSZmKMM4EVVOzgbmiCgEA6KMhIW9ctG3K+ahehKKx7a1sXbFvVZtjfS6
         innuNalMpnrsqCB+v/QEOP7FDE8Ix5qjbmsU7xSdjpWQDRLoEvBKLlFRGs5HkWKupr5o
         F/sjXi24nPO0VtY4D2xhTt/xEQPYTXmWfpNum1ncVbzONuISe7B5N2oXZLn+/JAMhw5Z
         QO2Fo4cOg3XCdfDsBNaMPBVmVx+jBtFeW/lsaUdDr7JemyEnLj8QFk1YWkHg6Xu3O4lQ
         eq2usXfgODMDCtLx9nv9djz2KGH7YngG/1Y5dAF0iGn6+u6x99vRJjfYVKZCkXX4Zsir
         JK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8CBq5D9tY/rIxd8Q9bScU/Lf3c39zfJPjGb95MJ1ho=;
        b=Al8xFDP2rdTdTmvCN3aIQJSC8mmz6xiisu580oN3vetjqrgjO07sfG7KfcnCgfFnpK
         wRLK4b21HqqAdJAeVSIEaQEaZiGhbPwybZbrtHDT/lU7IEmuxcwT0HO9sDq6ETibRXef
         23IebrqxZ79UNBldfUL3M57aY8rYnBw9rcB0ypjasI1F9c5bttatXEm5DO2TMQEV8DCs
         FgSL4Ix9hdr2Tc2X9o4pNegyfh4tn/nY8iU9D6Ob48ULtICuUPxweFQSo7V8NQyGZtZx
         BLC9JUWGWXGqnnEf9B181j5vZ5CYqBa03xbIVY7nxs4/D2lbM1Mm9ZYxJcw6ILRuto2y
         N5SA==
X-Gm-Message-State: AOAM531ZVJHqZ3zttpEZZJqP+B4rJwjl17IdLB+KXPbEUXk+3q1mzXH4
        PuLNuTKGPs/41f3e3PWbWtyV0w==
X-Google-Smtp-Source: ABdhPJwGkG53Re/6SkdDHQA3k1u5KCj1bTpxlVndoEvZves+WsU//tEO5Ud0kwzSsc+dh7IMKvG2EQ==
X-Received: by 2002:a1c:2157:: with SMTP id h84mr48334366wmh.35.1594042434299;
        Mon, 06 Jul 2020 06:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 08/32] usb: typec: tcpm: tcpm: Remove dangling unused 'struct tcpm_altmode_ops'
Date:   Mon,  6 Jul 2020 14:33:17 +0100
Message-Id: <20200706133341.476881-9-lee.jones@linaro.org>
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

Looks as though a079973f462a3 ("usb: typec: tcpm: Remove tcpc_config
configuration mechanism") pulled out the only use of 'tcpm_altmode_ops'
last year.  No need to keep it around.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
 1551 | static const struct typec_altmode_ops tcpm_altmode_ops = {
 | ^~~~~~~~~~~~~~~~

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 51 -----------------------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 82b19ebd7838e..d6913eb0ea54d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1503,57 +1503,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 	return 0;
 }
 
-static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
-{
-	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
-	u32 header;
-
-	mutex_lock(&port->lock);
-	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
-	header |= VDO_OPOS(altmode->mode);
-
-	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
-	mutex_unlock(&port->lock);
-
-	return 0;
-}
-
-static int tcpm_altmode_exit(struct typec_altmode *altmode)
-{
-	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
-	u32 header;
-
-	mutex_lock(&port->lock);
-	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
-	header |= VDO_OPOS(altmode->mode);
-
-	tcpm_queue_vdm(port, header, NULL, 0);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
-	mutex_unlock(&port->lock);
-
-	return 0;
-}
-
-static int tcpm_altmode_vdm(struct typec_altmode *altmode,
-			    u32 header, const u32 *data, int count)
-{
-	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
-
-	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, count - 1);
-	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
-	mutex_unlock(&port->lock);
-
-	return 0;
-}
-
-static const struct typec_altmode_ops tcpm_altmode_ops = {
-	.enter = tcpm_altmode_enter,
-	.exit = tcpm_altmode_exit,
-	.vdm = tcpm_altmode_vdm,
-};
-
 /*
  * PD (data, control) command handling functions
  */
-- 
2.25.1

