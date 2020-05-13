Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB959C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB407206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5pVIY/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgEMHYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgEMHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:24:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D11C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:24:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d207so8174022wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6nqb/odvCbAMcAZjupDiJo4HqnEb1Zq0i9Jx0IEifqc=;
        b=u5pVIY/CdD3Jp/CTwB6NZoNN4X4jlHT5wtxLxfp0+oPMSuYkffgSimjy+A3EZqyfYU
         cgtaM5NV8DBaSaJApPV6/UTw0pm6+wXTFgnQTZaNo7c9bmdRz3gTNIGk6oZqbBMLhFS7
         F6K+7j2Z/FBqtQCAdhpeGrURg3Nt5wm6APiX94oBVjNI5YQHSeMi0v/Y/AWzPuDUMlZV
         as9jrDI928Wm8Ztd6rnKU6vCnpBkpB2NzmlV/npfeesyk2xgYJ64pnwKMUQqh0oaTA8d
         x/jUc1T6oGT8KBm6F5HJ5mL/L4Qd7qIQKPERq/AunN9oiebtXz8LBkx7XnKhcMq1D2xQ
         Xv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6nqb/odvCbAMcAZjupDiJo4HqnEb1Zq0i9Jx0IEifqc=;
        b=oae8/N0xG+PA90FGt8Lrz6OqEqNgS2+4hH+T4jGBbD1qhoz321b2P+IN+a24tGCzjv
         3g+uAccTDPNQhOM6+N1uxGFEPOzmThfkz0i5V60uCa5cohs18QJFF47ICrAk1arHBPaZ
         TUFkEBJgyXBkj2d8egS+2sz2gMuAMUrlrleBk4W5CBq+I/K+cvw5fb0gjbsO9RfeawSQ
         PALJZvq4tC+/wf5m2b5lJj6nn923jsKj5PnW53LrwIru4Uw6IveE1C/CdVJaXLuJ2mpN
         W+ThCpY6nrXPYE5Zou3CKXMLhBDxDafJ8UU5YVl04HtViNkoNPo/umKmujYXNCwoSlzk
         RYOQ==
X-Gm-Message-State: AOAM531RHhvHkAO4quyXoHyOM9/oR74rwCEx8nOBhO+TnaQCV206QG3c
        gAnLCgvmZ8tf6qL+TGc45/Ugd420f2MP+w==
X-Google-Smtp-Source: ABdhPJzXr4pHGzBpFE/OXC0JgcJnU+47Ys7s36mKb8av16o/Kd3SAteYBkU8Zr1cty3ebI681I8wbA==
X-Received: by 2002:a7b:cf14:: with SMTP id l20mr7614598wmg.100.1589354676439;
        Wed, 13 May 2020 00:24:36 -0700 (PDT)
Received: from dinux ([102.186.189.183])
        by smtp.gmail.com with ESMTPSA id a15sm26491972wrw.56.2020.05.13.00.24.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 13 May 2020 00:24:35 -0700 (PDT)
Date:   Wed, 13 May 2020 09:24:33 +0200
From:   Mohamed Dawod <mhm.dawod@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wfx: typo fix
Message-ID: <20200513072433.GA11560@dinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing some typo errors in traces.h file

Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
---
 drivers/staging/wfx/traces.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wfx/traces.h b/drivers/staging/wfx/traces.h
index bb9f7e9..80e131c 100644
--- a/drivers/staging/wfx/traces.h
+++ b/drivers/staging/wfx/traces.h
@@ -32,16 +32,16 @@
  *             xxx_name(XXX)       \
  *             ...
  *
- *   3. Instanciate that list_names:
+ *   3. Instantiate that list_names:
  *
  *          list_names
  *
- *   4. Redefine xxx_name() as a entry of array for __print_symbolic()
+ *   4. Redefine xxx_name() as an entry of array for __print_symbolic()
  *
  *          #undef xxx_name
  *          #define xxx_name(msg) { msg, #msg },
  *
- *   5. list_name can now nearlu be used with __print_symbolic() but,
+ *   5. list_name can now nearly be used with __print_symbolic() but,
  *      __print_symbolic() dislike last comma of list. So we define a new list
  *      with a dummy element:
  *
-- 
2.7.4

