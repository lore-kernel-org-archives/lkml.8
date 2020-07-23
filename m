Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C718C206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLsIwxjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgGWHzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:55:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09087C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:55:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so4293153wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIxE2/K8ZT8HGa0OyUuojdUU2wTlacbpD6Rw4Iaq9po=;
        b=LLsIwxjQFPweu4C+1Liism3ur+kVdwoYN5/m9JW/jjEI+EE+6PRdKn5ZVrNnQ2ZiP3
         YhhKbOW/C7DIANwxetGu5TDUCfUwu3Rc42B3J0Vx4qKIOPhGH+YLizKMh3Oti/Yl46tP
         htJUVGiHr9+9ztBkJuk91rriDjsATQSU2QAbuzVkPO6Z/EDme9vKMuyEG4pGCNjV05ij
         cKLpLK3TpXEIFO+0wIi3ujer4XWcUOAeqpUgqMkR9WCzDh2yPwVMHuc+g6OWU35Ca8EX
         7baQ3LuoxDfHMs2zK9hPUAA0IEK0bntUYEA4y8zSqpSr+a8y0FYmhxT/n1JiMjUL8ddh
         Cq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIxE2/K8ZT8HGa0OyUuojdUU2wTlacbpD6Rw4Iaq9po=;
        b=Nj1EN9pPbE3tKfN3F5klPPuVBa4eyGqXKzZfRCjmmqAijC/gOmcLnxu4AfKCqHrd8T
         4ze+8Y8n+sKhjTYadczA3h8qC9z3pOUfAHQnEXG0yRcfTRhxo4dJmzcuT5b0FO4B7NV3
         glpCdDk+I53TuXAuOqHJwcAAMxLvvbeVISD3/tUtiGH7m9pC/K6WnH4VWMvvuwq52ou1
         AUdrIuznE7Iq7OYyQXe7Uz3JzQ+CLokheA1OQ88nahUfVoOS0bZLZC0UuHOj8OYSiLfL
         n1knowN3i+oFlAkRYqtBH/vu1nNBmtuwMLtZMdj8gbbF8/Zo1jXSPP6heGXZwL+Vvsya
         AXnw==
X-Gm-Message-State: AOAM530WLeF9LREhQ8KBt+nu98DrsEh/syThG3jCZN01inPKNfsdtZb3
        5tgEEQksysB22fwiJeR1Dlk=
X-Google-Smtp-Source: ABdhPJywE0fIoufrsRrMh5WwcaTne+r3tuHXkQlkocKdDiL9LpfuA5qc/eYGtzaJW/ND8eCbGKruvQ==
X-Received: by 2002:a1c:1d04:: with SMTP id d4mr3226537wmd.156.1595490942690;
        Thu, 23 Jul 2020 00:55:42 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-164.178.006.pools.vodafone-ip.de. [178.6.252.164])
        by smtp.gmail.com with ESMTPSA id j75sm2816691wrj.22.2020.07.23.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:55:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: clear alignment style issues
Date:   Thu, 23 Jul 2020 09:52:42 +0200
Message-Id: <20200723075243.21924-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear checkpatch alignment style issues in rtl8188eu_recv.c.
CHECK: Alignment should match open parenthesis

The file is now checkpatch clean.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
index 1cf8cff9a2a4..ab8313cf5bf0 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
@@ -33,7 +33,7 @@ int	rtw_hal_init_recv_priv(struct adapter *padapter)
 	if (!precvpriv->precv_buf) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-				("alloc recv_buf fail!\n"));
+			 ("alloc recv_buf fail!\n"));
 		goto exit;
 	}
 	precvbuf = precvpriv->precv_buf;
@@ -54,11 +54,11 @@ int	rtw_hal_init_recv_priv(struct adapter *padapter)
 
 		for (i = 0; i < NR_PREALLOC_RECV_SKB; i++) {
 			pskb = __netdev_alloc_skb(padapter->pnetdev,
-					MAX_RECVBUF_SZ, GFP_KERNEL);
+						  MAX_RECVBUF_SZ, GFP_KERNEL);
 			if (pskb) {
 				kmemleak_not_leak(pskb);
 				skb_queue_tail(&precvpriv->free_recv_skb_queue,
-						pskb);
+					       pskb);
 			}
 			pskb = NULL;
 		}
@@ -88,7 +88,7 @@ void rtw_hal_free_recv_priv(struct adapter *padapter)
 
 	if (skb_queue_len(&precvpriv->free_recv_skb_queue))
 		DBG_88E(KERN_WARNING "free_recv_skb_queue not empty, %d\n",
-				skb_queue_len(&precvpriv->free_recv_skb_queue));
+			skb_queue_len(&precvpriv->free_recv_skb_queue));
 
 	skb_queue_purge(&precvpriv->free_recv_skb_queue);
 }
-- 
2.27.0

