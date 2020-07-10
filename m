Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D18D206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHhl70xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGJVlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:41:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E47C08C5DC;
        Fri, 10 Jul 2020 14:41:22 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so3270563qvb.11;
        Fri, 10 Jul 2020 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Da2tkZhxp36WWIM5SU4wWRnWrL+fbZs7REwsgJam7ZQ=;
        b=VHhl70xJKGvDmkqn9+GFeBcUZmC518WJVEFdfy8ur5HqlFExf0rxCQqHtur+CxOaqb
         iC/aDjq4YILIXcE9snn6uUpJEJSctpWWeSIcBd1gpIwKFbv+erXR9MKTWreSo0dOQKMo
         +S2JOme4t+ViPdBBTh2LgOFP78FdMRVZa/KvKW3P12B3HMV4vmIDdLoL79AnN3/2ZMDp
         GI/pYYdntjQ8qmt2ICS6qw2mjW85VFeM86w2EtTA4jwe+uQ4Zgt9eXxcDc8W1JL+247M
         SDWh+bYC/tB5vjOXT2GObQ3uC1A7k3UDT3aCQI4VnJ9IcFq51Wrp+jeuyastgyymV+A4
         D/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Da2tkZhxp36WWIM5SU4wWRnWrL+fbZs7REwsgJam7ZQ=;
        b=JO7KY24cK6qlP+MaJXUMypghc1aH8DTWDqJLMAP2hSUm1CP0JyM00cFr0dWO8fj6yx
         MKpLOCnbRDRvajPppP/Zn9I2bjdwpGs5SJxIsQ+PyMra93TKxP3CYUe93B2tnwSA24hP
         yNsQ+c6mCAVIE+/OPEeCAM9Oax20Hbi6sUtLDhCfiWqC24ZGpBQzonFUYmLM7Oo/m/97
         6qqcFvNKG/KSsrqLC767tnsHZ7FS9THuhabQY3QGDlbaQqJ09WaQr06VhBINpXwFRMQb
         4hDEZwxNlEfoA9pvPDlviFD954YryCcULumfG1S0+VPGpQTd68UujzgTMxftE9nOAZqN
         08bg==
X-Gm-Message-State: AOAM532jxGiq47B/utf5vJ2tVW+v/3GLPyBqqRnreKq81c9dnGhcc0Gm
        eK+CggF9QIpAEFKJ1k0kZw==
X-Google-Smtp-Source: ABdhPJwg0Bs8T3eqvmOkVd+YCSi+G7i0B+ClGVozwdpkm7Ok6mUVGyf25q1e54in3JRQd8S88Lf8gg==
X-Received: by 2002:a0c:ab55:: with SMTP id i21mr71409390qvb.139.1594417281580;
        Fri, 10 Jul 2020 14:41:21 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id 2sm8652249qka.42.2020.07.10.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 14:41:21 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH 1/2] net/bluetooth: Prevent out-of-bounds read in hci_inquiry_result_evt()
Date:   Fri, 10 Jul 2020 17:39:18 -0400
Message-Id: <3f69f09d6eb0bc1430cae2894c635252a1cb09e1.1594414498.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check `num_rsp` before using it as for-loop counter.

Cc: stable@vger.kernel.org
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 03a0759f2fc2..8b3736c83b8e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2517,7 +2517,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
-	if (!num_rsp)
+	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
-- 
2.25.1

