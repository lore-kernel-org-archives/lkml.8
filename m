Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8493C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F762076F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIGFOiRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCYUy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:54:27 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38283 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYUy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:54:27 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so1511673pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=almAkzaBjE6PHygh3j1m0Jqz/97wbN8tJnv57jeXwQc=;
        b=KIGFOiRtaenwOUhFx39py2v7EmX7BUwo3SCdsyEJxUPfzD8eoy/NdfyQA8+uwb7bWa
         iAoirmcu5wcto705bhC9zap213StzfO4QMCGHTxXUw70sjm7TJHG+WEP6aPK5l3BLmau
         PoOYOzvUjdNalFo+t6+0gSmvEiIM96S30EE8K9x4G4XqgH+ABVZokGVXXdeSc1+5YhQx
         UUG3lbbnvwH7LhkSVP604+H3uemrI4dXOCay26wLKkq+2wyS8zW0pawyvh+XqUz8IIZ2
         7g7qbG0i1ct3FOxkI4Xu7FyADDd63TxIW+6Ze8U475qNjkBEF1z/xvQUSX4hazxkeQT1
         pMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=almAkzaBjE6PHygh3j1m0Jqz/97wbN8tJnv57jeXwQc=;
        b=qhSNluKFGErW4m9WliNegc1W7GO9XVI8ext9b7tux8kLon1XGcWvDJb4uUZrJhVGAk
         SgBA0CdE9uFPS4HYls2KThSL+X0ZGQZI2j996Qwq+QADOfpqL9B0yfMGPdcseXsEota+
         pyl5yg7Pm5AUVGLUbTEFuYZzAwJGCIb2G7qtZEJlS0h58o3RIbneO1waydZsToY/H4DR
         mbsPbc0e53fkGTxz+lCH8f/SZeV+D8D9LBE0Zhr7ZXDogNEHRnYln9WdfEhOwYDZAkPS
         y4Rdr/oWV1NvNIBvdaeJ7Xksl1ZU1QAOwOjk80XAc3BNVrwFPqSrSPu4Bvsjinrm6b2m
         COwA==
X-Gm-Message-State: ANhLgQ3x9KUUziPQ1zfv1yx5DRyW/U4lNjUo/mXD7eOpGcoKmxORjPDx
        CWlak1EWNtSRfHDJteVTyAE=
X-Google-Smtp-Source: ADFU+vtaGycFMwnQbZvkxx3l0lWZyeIR6/zzWaRVb/hGmjpAu+Gt3uW6+uVcvqiFaA290wWxPgoi7Q==
X-Received: by 2002:a17:902:ff14:: with SMTP id f20mr4694982plj.51.1585169663924;
        Wed, 25 Mar 2020 13:54:23 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id 132sm26209pfc.183.2020.03.25.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 13:54:23 -0700 (PDT)
Date:   Thu, 26 Mar 2020 02:24:18 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: rtw_efuse: Compress lines for immediate
 return
Message-ID: <20200325205418.GA29149@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compress two lines into a single line if immediate return statement is found.

It is done using script Coccinelle. And coccinelle uses following semantic
patch for this compression function:

@@
expression ret;
identifier f;
@@

-ret =
+return
     f(...);
-return ret;

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index de7d15fdc936..8794638468e6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -266,8 +266,7 @@ bool		bPseudoTest)
 	/* DBG_871X("===> EFUSE_OneByteRead() start, 0x34 = 0x%X\n", rtw_read32(padapter, EFUSE_TEST)); */
 
 	if (bPseudoTest) {
-		bResult = Efuse_Read1ByteFromFakeContent(padapter, addr, data);
-		return bResult;
+		return Efuse_Read1ByteFromFakeContent(padapter, addr, data);
 	}
 
 	/*  <20130121, Kordan> For SMIC EFUSE specificatoin. */
@@ -319,8 +318,7 @@ bool		bPseudoTest)
 	/* DBG_871X("===> EFUSE_OneByteWrite() start, 0x34 = 0x%X\n", rtw_read32(padapter, EFUSE_TEST)); */
 
 	if (bPseudoTest) {
-		bResult = Efuse_Write1ByteToFakeContent(padapter, addr, data);
-		return bResult;
+		return Efuse_Write1ByteToFakeContent(padapter, addr, data);
 	}
 
 
-- 
2.17.1

