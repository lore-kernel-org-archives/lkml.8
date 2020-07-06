Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D24C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D95F2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fw8KkupQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgGFNfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgGFNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB2C08C5E2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so39373113wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wF0TEpLE3+8aSfCpSueulEs3qt7dUTbs4ZXmnn02trY=;
        b=Fw8KkupQWP1sjuNARANgDth/I4E8Dw60dO13hOJ8P5eNzx1H61J9+oaoJEz4UW+eLB
         x1QdMZF9StP7c7hyy5JUC2MkPAqAt8qlfDb0usPVJ896zJWoOIBxIxiB9t3WJWOp41wc
         QWQfUyGB9r0pZlKQ/l7gJrP8c9Azan7WlFLNpgl++8vrM1xNTg4t8bQ7iLn1cUPL5RBW
         AG42p5PbmHJ8Frm71710QTtIrNhkU5qAvSTsYC97K1PrCm5ql9h7VGbzShVHn/cTrI73
         fL7PPdPg+3dvqO2vSDnwUP0ahpRMP1oWeMlfwjY87k/1h79BGuI02uv9lh8MDmd3wbOb
         XMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wF0TEpLE3+8aSfCpSueulEs3qt7dUTbs4ZXmnn02trY=;
        b=S7dXM5kwZCPGL4J7VCKqDFADIBy1u7Mm2MfCFB5TnZVbNaH+gyj/8q+dd5MvWnMKKs
         TnqJR30Ey7E/bFHUj26jcr51pcAvxuyqK/S6tyaazSgobIPQAUgPZYgLiUa1lDNxbh/3
         BDwTWdnfdF+Sf0FbmcD3OiHKrdtsW525BIWfrADlq6WltFezSkkBrta7JoT8t8acrQ4P
         wISRfKQ6ugN3VGIKUOgWANUFNQT4FZpICL+agpBQLdXoD7qWf+HEXk3/J60N5QQ0N3lM
         LzQicq7a70IwOT65J8VUQC+ahsN2uifXISxm/r9Y3ThK1fADN7LSLiyTxrbmmUXvdPFS
         WVTQ==
X-Gm-Message-State: AOAM532SQkmYKl/btymGA35bBgHg7qrQF+y4sgdlohe3M9mPfKfk6HAm
        K3UluDUqnCNAZMjh4gf1O327eA==
X-Google-Smtp-Source: ABdhPJxHHFnEPojgYRMIoE3DnTDn2rSpOXSQ2WwvPUtq97j/0sE7IvNfbZmEFXNMp63VwfwkukEpMg==
X-Received: by 2002:a1c:c3c5:: with SMTP id t188mr51930563wmf.53.1594042453242;
        Mon, 06 Jul 2020 06:34:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 24/32] usb: typec: ucsi: ucsi: Staticify and stop export of ucsi_init()
Date:   Mon,  6 Jul 2020 14:33:33 +0100
Message-Id: <20200706133341.476881-25-lee.jones@linaro.org>
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

It isn't called from anywhere outside of ucsi.c.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/typec/ucsi/ucsi.c:1005:5: warning: no previous prototype for ‘ucsi_init’ [-Wmissing-prototypes]
 1005 | int ucsi_init(struct ucsi *ucsi)
 | ^~~~~~~~~

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index d0c63afaf345d..affd024190c91 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1002,7 +1002,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
  *
  * Registers all ports @ucsi has and enables all notification events.
  */
-int ucsi_init(struct ucsi *ucsi)
+static int ucsi_init(struct ucsi *ucsi)
 {
 	struct ucsi_connector *con;
 	u64 command;
@@ -1078,7 +1078,6 @@ int ucsi_init(struct ucsi *ucsi)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ucsi_init);
 
 static void ucsi_init_work(struct work_struct *work)
 {
-- 
2.25.1

