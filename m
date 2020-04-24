Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B9C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3569E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4iC1BYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgDXRF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:05:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47AC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:05:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so3945261plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3U+a3uev8d2352EB+p1AL9exeCeOG/zkKwiEaOROeNo=;
        b=Y4iC1BYdMjXV2Tiut0aUt4eedeczo5MFseq5FrqlExx10LxxrKAssVqFZyX5yDxlZ/
         zrvvtO3R9PX4XPcomeNHXOeOkt3Hq2Pd3wQQSiW6bUM9qxKycq+op4YZnecizAn250+e
         pFvpHiq5VRyuf/k50JZHOPFQrwkx0bOdf3Zef1WSoa7bqkkhpERrfnaVHEKolbCn4vMN
         f+8lJyLh1lXEBbv3+aLUleHLu3cCH4Ud31JIDX1W2fajD8oemGpDd9uF670YKqimdjnT
         ngPr4Xtxb4hD4ktk1aFQhopF3zcf1XUccjwHdkeO7JtAjbSEazow170+lsaENyfghqOx
         3M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3U+a3uev8d2352EB+p1AL9exeCeOG/zkKwiEaOROeNo=;
        b=CHTumLfu+vRFioeDl26NNvcJuTVrgjn8d122CFaCzwx5qoecz5drCs4+b42nNkKHL7
         99yr48cpEHg6z25cySkJPRd4yPTF/4VN3BenesJO22c5VdWLf75ul7dHAXmXsPXOjUo6
         RMFcRxNUIM17d5jHUnvamuKZpNIgf7sDLY9NuP6E0O9T+5/4guYeT0VRGT+o0tmHbwuU
         4PwXs6jViyl9DMriz7UjxkpikNGRqGDyIX54WaJjR2OurAhyZL0WatKIaznIMVpmK5RU
         9jjtu7Uhg/hIslGlGA2K3ikIsJRy++XydljnG/b5aKUzBhU+3wD1cqWwzgzX4E3geOi7
         gqrA==
X-Gm-Message-State: AGi0PuY+L63bedteTzHkhyV8uGxL+mkFjJaMOrPFIVxD22RvtHfLyO30
        m7gNbsadJsdUDmz0v8yyPHqGl0r5onK5Wg==
X-Google-Smtp-Source: APiQypLJGHki/O4NyxEo4REtwndVeMiBhj/1YwNXViHoZyTPTQRjtcXGvs2tTAJHs7VX+1gCGzmglg==
X-Received: by 2002:a17:90a:f418:: with SMTP id ch24mr7230962pjb.68.1587747924260;
        Fri, 24 Apr 2020 10:05:24 -0700 (PDT)
Received: from koo-Z370-HD3 ([143.248.230.14])
        by smtp.gmail.com with ESMTPSA id q64sm6176821pfc.112.2020.04.24.10.05.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 10:05:16 -0700 (PDT)
Date:   Sat, 25 Apr 2020 02:05:12 +0900
From:   kyoungho koo <rnrudgh@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8723bs: Fix comment typo "the the".
Message-ID: <20200424170508.GA10761@koo-Z370-HD3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have found double typed comments "the the". So i modified it to
one "the"

Signed-off-by: kyoungho koo <rnrudgh@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index efb5135ad743..bd18d1803e27 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -822,7 +822,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	psecnetwork->IELength = 0;
 	/*  Added by Albert 2009/02/18 */
-	/*  If the the driver wants to use the bssid to create the connection. */
+	/*  If the driver wants to use the bssid to create the connection. */
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
-- 
2.17.1

