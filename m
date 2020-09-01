Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB07C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4D52098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 03:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="G3MpYmtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIADAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgIAC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:59:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C5C06136D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s3so6461647ybi.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=w1UiPTD/f2UFRqEkkMxcTUrZKSmEPHz0i7r6iATF5vY=;
        b=G3MpYmtFbtXFRcbsDt+y9S/+m7BwADYJFG8KG+QB5h40UyAGiV3wAs94o21M1nV5Fa
         qOtxuwmKmBaG8gjnnq+FkKuGU/sIixa4qn+o7IVur5TiSWoCyFmJYL+I8L8nbyuvz7i8
         PJbi8gDn26msam4r5OtqtOxhx6Y0qHBDaYvoV0sTACydbrraBj+GJFtyf7f2Zmjbi74H
         TEugzcbhkEzlyvXOH1SbzVp7DLwZfiYLNPhYPj8IB7/nQKWbvNkUULpHb7nYF2zbCfLq
         xvnsDCwas3+TdPFkBLcrmVCg+vc+KGQBwiZ+WY7g33VoFWn2gvCkL7FZPS/e8z1sF7hi
         0IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w1UiPTD/f2UFRqEkkMxcTUrZKSmEPHz0i7r6iATF5vY=;
        b=sUwj5AhXEptVN80BJ61NjljSooMKW3HQawk/Hvn34HxwVIiWwxmJtP2NWJ8yOc/yjZ
         yjFt+VTsqV0ZsQHjvU6KjadcOQzqf7SxXIoomG0H/Lj8XQMohov9ZmuETlpDO/pkeO4B
         UAuqjv2jSyZFE2gtxjwTAHuY2BQAhMVKpyotkIUCSh1nv08eLM4cM8c9urGxep5fGOju
         3bYmwe83es8Eaj0BpTlYD2W+yp4CjUbRPwVTEtFlWHrCKJlzT+aiENMMeU5YCXjDw990
         lbhCC1fxa+6N4bQTe5PqEf64Cd6ozpwzIObQq+V20ceNYuCtivVyMfnxunGDc7sRAq5s
         ct7A==
X-Gm-Message-State: AOAM531afu0pKTcfw1gW3aVLvb1qBMwdThdgvxN9SEiBMxETGlXHADas
        QVQv+gsgjTrgTjL3LF90ow4ADy1YlOY=
X-Google-Smtp-Source: ABdhPJwQjHinBxBt8p8BKihksjE00T0PQQJ9IyBSLc9nBjjZB++N8UlO7oksDt+RthLvFqAn7YYYXDXLpvg=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a05:6902:100c:: with SMTP id
 w12mr6741192ybt.488.1598929178400; Mon, 31 Aug 2020 19:59:38 -0700 (PDT)
Date:   Mon, 31 Aug 2020 19:59:17 -0700
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Message-Id: <20200901025927.3596190-5-badhri@google.com>
Mime-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v6 04/14] usb: typec: tcpci: Add a getter method to retrieve
 tcpm_port reference
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow chip level drivers to retrieve reference to tcpm_port.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Change since v1:
- Changing patch version to v6 to fix version number confusion.
---
 drivers/usb/typec/tcpm/tcpci.c | 6 ++++++
 drivers/usb/typec/tcpm/tcpci.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 7d9491ba62fb..b960fe5a0f28 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -38,6 +38,12 @@ struct tcpci_chip {
 	struct tcpci_data data;
 };
 
+struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci)
+{
+	return tcpci->port;
+}
+EXPORT_SYMBOL_GPL(tcpci_get_tcpm_port);
+
 static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
 {
 	return container_of(tcpc, struct tcpci, tcpc);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index cf9d8b63adcb..04c49a0b0368 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -150,4 +150,6 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
 void tcpci_unregister_port(struct tcpci *tcpci);
 irqreturn_t tcpci_irq(struct tcpci *tcpci);
 
+struct tcpm_port;
+struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
 #endif /* __LINUX_USB_TCPCI_H */
-- 
2.28.0.402.g5ffc5be6b7-goog

