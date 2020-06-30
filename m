Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4857D206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ze4B74SN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbgF3Nwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbgF3Nvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A860C08C5DD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so19684649wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZzcRr+il6B7Wb5szs9514Q011nYXDt2b1eWYEXToMg=;
        b=ze4B74SNFERaaTVJaC+Vyy9gFPkffpaYoHDqnKPXapQkMmFkERaQqn16iIHhsHRn+G
         yJu7CcRD2h2URZMaPCPR4lxNq6wl9EhGCCPQoqSHF+jo60WsQChbaXzZvumAd4yR4FXN
         CZ9cix2D3iP96P1e3KDEkwHSBE+39b9H6hxax52ooGJh0ZYOc+OzfcGV7nuplasxTM5S
         IYiud7p8VTP9R9nV8ujiG6tWdWaRWs911QiZycDK6vvTcZb2/w7GAxUU7ZXRHILGxfTQ
         HrgIagryeAIhS/lDTaOIwM89w4a1G+c8uWzTWOv2Fpvayb4MasWtClkqd4jQ9qgWy//G
         sNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZzcRr+il6B7Wb5szs9514Q011nYXDt2b1eWYEXToMg=;
        b=rtXPMyD7phsJGiO3+kerumF68zGpkefrUukR99SL8hTof3q/H066j/qW5HwskJFkqW
         gVdbdhPlk8LE53kjMTJNzBNKn/TdfkbbohjzlpQtk2bQhX3ZnZQEsTZHivM2Zt5vmiq0
         NpSjFK5N06j05LfzQ2RuJK8e0vlevKGDlKAhz+31/f9WVDFkhTpqsX2gCpz05wuVP284
         PXtdEnHlMo4hq3QLXvHqRZTOsn/FbFZuBg/ehBIWE4CrA20VfUTWFYbI1C9R/LH8XpxS
         gBN8kf3tDiHPAMmBsQxXCHayUMMyyC7Zeiazowre9MxuGzDiaFmRSZJ96ZPPKkYsd00W
         sy+Q==
X-Gm-Message-State: AOAM5331ifr1/+OdUCBr9daNhGP+qgr9y8rmhNwFSPZ7XgEKRkag/lHO
        E4Bugge7CA4XhvfljGcRsyUcgSVmMoo=
X-Google-Smtp-Source: ABdhPJxyqQHdVZGRJovPYRIq+ziAdoNs4/aOWvvPnANoKN6II3dppM9ZNMFHnOC3zBh8CS1Nwt2Upw==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr21892593wmg.153.1593525094264;
        Tue, 30 Jun 2020 06:51:34 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 19/30] misc: mic: scif: scif_api: Demote scif_accept() function header
Date:   Tue, 30 Jun 2020 14:50:59 +0100
Message-Id: <20200630135110.2236389-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'epd' not described in 'scif_accept'
 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'peer' not described in 'scif_accept'
 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'newepd' not described in 'scif_accept'
 drivers/misc/mic/scif/scif_api.c:739: warning: Function parameter or member 'flags' not described in 'scif_accept'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_api.c
index d7faffdd87e92..9cc6b2a6cf229 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -713,7 +713,7 @@ int scif_connect(scif_epd_t epd, struct scif_port_id *dst)
 }
 EXPORT_SYMBOL_GPL(scif_connect);
 
-/**
+/*
  * scif_accept() - Accept a connection request from the remote node
  *
  * The function accepts a connection request from the remote node.  Successful
-- 
2.25.1

