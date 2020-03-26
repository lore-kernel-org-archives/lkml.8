Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA3C2D0EE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20102073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmakIFQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCZN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:28:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36567 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgCZN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:28:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so2129819plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9VMBXAMCwL7qm/FeM98BMJBlfVZIr+3WQNOcgxok4qo=;
        b=OmakIFQfxCrQNfd8PVzCQSci2n6MNA7igCtPFOFRNTpd5G1xLmXqSri+roMLEcbbpm
         wcGG2/KlQKEL4Y4uNNLJ9eWMmVGrt2TL7ymP7PvOnI60QX9GEFMRaPOVOFWhQDi13/Ek
         fdk9qkgfiZMG5u8RdMKGWbP0emmHEwEWFlZbIVOFdt1Cmc8jQGZXdzgaC03xkNRcDRcU
         JzKun+rZD4iThoE1OhE406GpUQbLhZopSRbtmeZyZoXXT8YVa9207fBrayLquQHQ8KnD
         9X6na/wlphZyexHgf4kx9Lebgy9a6Z7jhWhXcbF6zFFh6y71Wllrq1tJcNbwSrYrFWSs
         l54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9VMBXAMCwL7qm/FeM98BMJBlfVZIr+3WQNOcgxok4qo=;
        b=jIr+Tb1yNsdyyHHMvRmWsqL9AVWlEgCq+E3BQoiwejJlSjalil+unebhZYXALoyVR0
         DtCfno2o0lZY5S/ieawoiUDw1dEnoeKDFcQStjrdGeoa97Hj/20Wu0XDC3MWemm/eXXp
         HmRNMz09Z0xdM0PuPsiZZyilO8MKdriEIQKZExEPkocfq5mXJnxmXycriLT61GcgLVuT
         cHBMmZ29r8ocY19TiPSIHyQcHmjPgavF4x/17f9L724zZO+zFh5nKKhSLMgpjC3wO05T
         KBvcqOLZIWiYlTUvFEGouYO9cB3AdkolvEvSKb3zRxwnU1pNfZCQCnOAIc/Y0fHSV5lW
         Y6tw==
X-Gm-Message-State: ANhLgQ3R178wzfdI+n0Ek25+QDfimZFzEhQeGrgqcSBFPHQ0LuQw1zo4
        7Lvnyh/pBOU3FiUShEPNf3Q=
X-Google-Smtp-Source: ADFU+vtdj9jQbRa6FPxuUgqBp9Kg1xU6xet7VwDUriXEGjEXcCqo1jZ5IHInQG8rzICrdN7XUcTqUg==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr8508293plr.168.1585229309170;
        Thu, 26 Mar 2020 06:28:29 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2405:205:1208:56c8:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id q19sm1672840pgn.93.2020.03.26.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:28:28 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:58:23 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: rtl8723bs: hal: Remove NULL check before kfree
Message-ID: <20200326132823.GA18625@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before kfree is unnecessary so remove it.

The following Coccinelle script was used to detect this:
@@ expression E; @@
- if (E != NULL) { kfree(E); }
+ kfree(E);
@@ expression E; @@
- if (E != NULL) { kfree(E); E = NULL; }
+ kfree(E);
+ E = NULL;

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 1e8b61443408..cf68193a167f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -480,10 +480,8 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 		precvpriv->precv_buf = NULL;
 	}
 
-	if (precvpriv->pallocated_recv_buf) {
-		kfree(precvpriv->pallocated_recv_buf);
-		precvpriv->pallocated_recv_buf = NULL;
-	}
+	kfree(precvpriv->pallocated_recv_buf);
+	precvpriv->pallocated_recv_buf = NULL;
 
 exit:
 	return res;
@@ -518,8 +516,6 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 		precvpriv->precv_buf = NULL;
 	}
 
-	if (precvpriv->pallocated_recv_buf) {
-		kfree(precvpriv->pallocated_recv_buf);
-		precvpriv->pallocated_recv_buf = NULL;
-	}
+	kfree(precvpriv->pallocated_recv_buf);
+	precvpriv->pallocated_recv_buf = NULL;
 }
-- 
2.17.1

