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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFDC2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6CccuvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYVnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:43:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40400 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:43:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id l184so1710493pfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=h0hI1ctK7evRWi0Tx3F+lFEp/ylOEoUVzXunsODTLdY=;
        b=K6CccuvDhDFg4uDguK3OiesQSTy4fN0R7L2ZKiBbN6KUB5W5JGjUjBeE8sAHEWaPX2
         w/HSgNcZUtbTEQ28K1Q8MlNo5DaOd8AscgJK5B3m5OeehiuaHg1US+Hapq413+gXZgxD
         pC/tsiWBNJEFkVFyevTpcfH7QZijl90PLmgGflSa8Fy7sXpNJtnKbfG++5ArAO6Rdaj+
         gDFnjrinuJIrGqgR5G4NygPWvjK7+oq7x6gE9H1UhL0UfjtPwT5biCQ+bEhxPvjmMzzS
         ZgkB+HD5/RSOurcjFBSUuP1KD5/ocn9MzxOEE4CNq1jVf5ZbdVHr3IrFWx1V8RBeCj3p
         fpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h0hI1ctK7evRWi0Tx3F+lFEp/ylOEoUVzXunsODTLdY=;
        b=d0j811x1uAEi6MdMjDvAIZpNpqajsNfgn09+jGXPX6HyLC5/5blc1GnGzttjvhk3xB
         gbiBCOrZTWJcZWF/jOsLNPDnWLU6uD6tSx/ebUhuS1eGsu1WOVP+W6sNfptdVsg7yfQM
         C6yP7pXTfYXtaOE37ZOL3QCMORYPTpfFd0oHyx93vsfa/0XXK5JkOhFw1aWlGpvLbx4Y
         ft0fzPERxbRlZxgkJVIKrCQ4J69JdqV+/nln8TDUqHfQ91E7pu46yW2oYo31Dilzc5PM
         JsoeqC9EiGNG1aZTLpw88qQr7PTHJKPQL5Q4+Y/CF3rXbQbuEKX/rIK5aeVb6j8+3xDh
         VjzA==
X-Gm-Message-State: ANhLgQ1ws/ERxUqDd4odxYXGNQzNx0PiNySAlHxA5daOlzlL2OcnQSPV
        m+7EQRlo/xGBk5hDciilMUw=
X-Google-Smtp-Source: ADFU+vswKqbNWwboFJ5F9a2l/B9QXa6IvqAjyDmNjtLiyGK2ZPZ2k32SjAAvPZlNAiOyyLKTauRU9g==
X-Received: by 2002:aa7:828e:: with SMTP id s14mr5336751pfm.15.1585172598186;
        Wed, 25 Mar 2020 14:43:18 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id a19sm87724pfk.110.2020.03.25.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:43:17 -0700 (PDT)
Date:   Thu, 26 Mar 2020 03:13:12 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: hal: Compress return logic
Message-ID: <20200325214312.GA1936@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify function returns by merging assignment and return into
one command line.
Found with Coccinelle

@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index eb7de3617d83..767e2a784f78 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1498,9 +1498,7 @@ s8 PHY_GetTxPowerByRate(
 		return value;
 	}
 
-	value = pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex];
-
-	return value;
+	return pHalData->TxPwrByRateOffset[Band][RFPath][TxNum][rateIndex];
 
 }
 
-- 
2.17.1

