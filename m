Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF092072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qEp6lskp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgHYEWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgHYEWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9961FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:38 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a73so7626128pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nWeRgBg8Ta0JRUMqjnIe2WAINWblXQ1/8Tod3psP/Qw=;
        b=qEp6lskpZWqC4EQJ85EobO2qxMlWdWKJb/ThqSCHe/SvBlUmgrda0L1rykQdI+/aNF
         EfYKonzOKbyEeGAECfW4HAra3tDodTSOaX8EsUVhsIVDw9tLH52IRWcF5slGHj5OVpMN
         ryNRSK6ZdR4dEC0zxZnHyzopX2OzuLFI3H6cjSKVjLml3qRbrBgMUd0f2VnGN4YtpTqo
         PzQgm+/4yr/yegRzzmru3yOZ4grnL7NC+1ctWiv15hFwxJdKUXcDEUXAUdJekQE8BKx9
         QHNJcfxwXHrxZ95ROVp7JovwMhp2ds9PkiGKheTQw5c5+A/jd/cntR5yW8YOmdH7PxVg
         w0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nWeRgBg8Ta0JRUMqjnIe2WAINWblXQ1/8Tod3psP/Qw=;
        b=rJbH3a2bqJZwHhdIyHuZvkh+2/qeDRdQm2YK05F/OhWhDOMJXCId1yGSjllUfW9OGs
         VdgjcZqNz27I6h7oiZ4HEw13c1jH6uUYwnX5karMKHgTzUI4G7wO0vOSc2x9PuHKDF4X
         Kurvn4feX5AicHkDYBjaOMu7Hyg6FtTSK6tbbD15XXM6JSB4+y0QVFRUP42M/UmCPrIT
         sr0/1fhAVOs70cDe7Q/ibsVuEfmOV6ziQamvzNgEEV79aZzY46O3HxuHGRa/InoW6sq6
         nBpMv9iNcevNvoOTzLIGZuLYmhxXLs9zdKDqNYdu+DWTGaHY6BbutMbOG1JHpItkb8cf
         Djlw==
X-Gm-Message-State: AOAM531ruO0xCFrd/b6ezNm4oTNRCccbz9www/QR3/QSGUi9C5cg+XMI
        gQ9SIs7rz6vCkhPUGaq2z6W7VoVOgkU=
X-Google-Smtp-Source: ABdhPJzgqZaIyM+aghkM5fFsP3zxDfJ+c5ExAt1tqg5VtdJqpTDO9F7xYLnF4n9fsWs0V1GJ/nfPbAbWH48=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:5aa2:: with SMTP id
 n31mr48366pji.33.1598329358088; Mon, 24 Aug 2020 21:22:38 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:22:00 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-5-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 04/14 v1] usb: typec: tcpci: Add a getter method to retrieve
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
 drivers/usb/typec/tcpm/tcpci.c | 6 ++++++
 drivers/usb/typec/tcpm/tcpci.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 9e814d454d14..7b7991c8ac87 100644
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
2.28.0.297.g1956fa8f8d-goog

