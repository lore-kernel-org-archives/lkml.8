Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424AC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1ED6206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 03:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF6SuAD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgASDw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 22:52:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46709 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgASDw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:52:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so13710889pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 19:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=btELW0aVdENtiHQfPBXo2Jo9tXu8fqSJd1sAuN+cQlA=;
        b=EF6SuAD+V07QXPyDtN8sLfQHP0ferSjMAY1s5OlUxBnjFVaSw/RZgnhpJ9ISmW3Nk6
         a6+RchmuHdy57ia3QGNprmpVBncCxGyIScYCBk7OG82nVCs4MmHrpUU0h0R8tGPdZUE6
         /GgOfVlTFn3inUkSeMSFp0MnDKG3LbaqiLbb5TmMtY3GqFYEsp/Yj1zQZqsojBhTO8Zb
         2IWXK2+dvVVA5Z/6Yh6/CPlye2NJi7Qeo+uRiKuIwKARJZa6Uzvjb/2iP/wKvXETVBWP
         FiivJjsnSloibiJepig3dsh6UII3msWFeKmjOhmNB96x23WYXhgGRxzDcK6qMQGX01Yq
         QaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=btELW0aVdENtiHQfPBXo2Jo9tXu8fqSJd1sAuN+cQlA=;
        b=D87X4r0Ih2LQpOqBh4SZArpAeHb2gr+wO8xreJnpj4kGLsXmaomOI6INMe8kEWq9Jh
         g+1XDPDvA6HLrQt1ZpaUFp3xJetz5T7FzxBSOg51vIr41yRoqirLHIFePRFn9EOS7+fD
         j52Eze7pWwdNCMmGZTivLNbWY+Ugk/jJMO2t3hUlYyPSZRVU8tLo0CQfcnDnPILRt7Au
         GGTKPFBT8U0Kme4D22c/ugYOzWM4N+d6UtJLKzJJ3jJUujamQ0O4Ieia6RTXQTEB2YHz
         sgcjvhPuWU3YPsmN8J4+9k4a813+qiFD9P32mGmXfXS8LSsPyPBlSUj2ECuXFQLrXmpb
         Q1bw==
X-Gm-Message-State: APjAAAXwLoMmINgAhTW3kfYOFNa9qCVvY1myPNoK8Z1seOvVssbwAhq0
        t5iav2F7KjeiuImW1SmcvK4=
X-Google-Smtp-Source: APXvYqwTJFbHk45l0Fulxs4JHrXqQBCxR58FqHRtbwwGsWIU5+2J88F+7/50sSaUvAcy10t7YDDiXw==
X-Received: by 2002:a63:214e:: with SMTP id s14mr52957124pgm.428.1579405976633;
        Sat, 18 Jan 2020 19:52:56 -0800 (PST)
Received: from localhost.localdomain (n11923789033.netvigator.com. [119.237.89.33])
        by smtp.gmail.com with ESMTPSA id 100sm12601617pjo.17.2020.01.18.19.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 19:52:55 -0800 (PST)
From:   Simon Fong <simon.fongnt@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Simon Fong <simon.fongnt@gmail.com>
Subject: [PATCH 3/3] Staging: comedi: usbdux: cleanup long line and align it
Date:   Sun, 19 Jan 2020 11:52:43 +0800
Message-Id: <20200119035243.7819-1-simon.fongnt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up long line and align it

Signed-off-by: Simon Fong <simon.fongnt@gmail.com>
---
 drivers/staging/comedi/drivers/usbdux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
index 0350f303d557..b9c0b1a1d86e 100644
--- a/drivers/staging/comedi/drivers/usbdux.c
+++ b/drivers/staging/comedi/drivers/usbdux.c
@@ -204,7 +204,8 @@ struct usbdux_private {
 	struct mutex mut;
 };
 
-static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)
+static void usbdux_unlink_urbs(struct urb **urbs,
+			       int num_urbs)
 {
 	int i;
 
-- 
2.17.1

