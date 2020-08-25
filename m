Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E31820782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMUuOUL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYQpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:45:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:45:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so13420690wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPskAvLifc96WxMvEHrqO3WG83JsEikfA6CDpIiedvE=;
        b=NMUuOUL9yG7frK9aGSFR2hgeYAnv1enxnqaXLB0H3iymqTUaWQmiC5YuGaEpLYZaix
         EFUf5fpJ998vpqAbvayO71pWNmFfD6ujgBvYWUWGymrcGJU3XpYo1Aqfgk55Ct1jRUQX
         E+Pw2F+uhaGJ96DkHBqS1MMBSvtrhYJGZ4qA7tZXsPDLDfhJ7R3rZsdSWo3hVHX9fEif
         Ec3iHHjsR/VsHJP4OBuwQlwcEZk7/qDgTFp7T62e/IhlOfrzJQROVSunjO4DKpfL9ZjV
         ZC8KnMIj7EhPCVRrhuLY26aGCnVY+Y+XeCkLCG4nPYOYIjTrAHSSS7XaNaV5OcD6ADz/
         IT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPskAvLifc96WxMvEHrqO3WG83JsEikfA6CDpIiedvE=;
        b=kz2JX77GSeF5adOmEdIXo8I+tTe1yFJ9gRBArbiL8EIdyB0zR6HTqPiXk6fnUpRrdK
         UdwK3SvfG7WU3NLPN4uqtjEr9r3NLyJI2z77OgpT44RIirAMuAn4NP17aFeb0byXp5Y9
         H9UxA9GnbmNRfn0iou/sqz2z5dvlHlyo5bgXYDf+0p0oHaxqg77na7NLAHdX20wp83wU
         Q7glkuDxjAxMuSuVRZ4fqg2kFYGGqbW8tebdQN06W3BrCHdtdPz5OOPy2vBQnOTUdlvO
         NKUurSNrGSEU2z8CWxnY5lBR/fXs8gudxCu3s73bJnsXD0RamBKZXkr7NuQhyJMPtM9P
         IaCA==
X-Gm-Message-State: AOAM532oHG2U0GqIYTpATNK2Jwb37Gyh2Ma1HS9INb12IXRWWI+HMOqL
        0ST40jPpq5rORGpUyS5iTKg=
X-Google-Smtp-Source: ABdhPJxOWxSbZ7qXQ9UaHhTc0auKatEsKttAaG5WW8+fyryCWjlDP66xvob9HKxS8Eizi9vjJtbLsg==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr10674769wrg.413.1598373928354;
        Tue, 25 Aug 2020 09:45:28 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id d14sm30455336wre.44.2020.08.25.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:45:27 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy king <acking@vmware.com>,
        George Zhang <georgezhang@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] VMCI: check return value of get_user_pages_fast() for errors
Date:   Tue, 25 Aug 2020 17:45:18 +0100
Message-Id: <20200825164522.412392-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places in qp_host_get_user_memory(),
get_user_pages_fast() is called without properly checking for errors. If
e.g. -EFAULT is returned, this negative value will then be passed on to
qp_release_pages(), which expects a u64 as input.

Fix this by only calling qp_release_pages() when we have a positive
number returned.

Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 8531ae781195..c49065887e8f 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -657,8 +657,9 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	if (retval < (int)produce_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(produce) failed (retval=%d)",
 			retval);
-		qp_release_pages(produce_q->kernel_if->u.h.header_page,
-				 retval, false);
+		if (retval > 0)
+			qp_release_pages(produce_q->kernel_if->u.h.header_page,
+					retval, false);
 		err = VMCI_ERROR_NO_MEM;
 		goto out;
 	}
@@ -670,8 +671,9 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	if (retval < (int)consume_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(consume) failed (retval=%d)",
 			retval);
-		qp_release_pages(consume_q->kernel_if->u.h.header_page,
-				 retval, false);
+		if (retval > 0)
+			qp_release_pages(consume_q->kernel_if->u.h.header_page,
+					retval, false);
 		qp_release_pages(produce_q->kernel_if->u.h.header_page,
 				 produce_q->kernel_if->num_pages, false);
 		err = VMCI_ERROR_NO_MEM;
-- 
2.28.0

