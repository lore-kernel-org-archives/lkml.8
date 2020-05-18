Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B49C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201542070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV0Te0Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgERGYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgERGYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:24:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:24:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m185so3984798wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fta7gXT+EOyUADbR+Lk2u+VIEaHdT0q5u+GceH6lNDU=;
        b=iV0Te0Vs3Z8AEJNMqLBmTboW0SNDwCPusJANY2ESmGE9nZ0SUAcHvkodI9hvW9rI49
         VN8bGDeFzq/JLWdYN6qd6yydOP0Kx/0nOams4jm/HggyHHrenHI1PTgAnCbfeWCZRPr9
         3iKMmvO2uXxr9Jhi2JdggKk5VOODGknEcQ6k0oPAok1bJwr1cFBQaKvI9eVdQkCeD19T
         7/ghrRYtCwcuKGUm08cSVMQe4Mi3C6txRI7QDPyBcGAtVgGfoL09MKXxRM1IDgDLrTKQ
         Br+3o2Kd78GftVJB/tbOqN2TvgatL+GW53E6VdIA5fYb2cnYxMFnK6MSANtWR7HakvTy
         Loxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fta7gXT+EOyUADbR+Lk2u+VIEaHdT0q5u+GceH6lNDU=;
        b=mEBwIT56GX7DCJbd07q0/xKg6y9Xpwb0pbFZ+27d2dhgM8oaHX8gY5H0oHM4R6Yi41
         dBJUtNMDSgy9luzu32s5vigcHJwD4iFc/1kgJtS0AgVH23x3aJigD8A1fENSnZYFDBws
         ITqpCWoIPAfEY+8oIvISR1C8SaROL/VZ2nsgctRuCbxm+Ne9OMvSL92df/7I9gi5JW3M
         cX5of17RFMWhZKJWV9IPm90D0Q3kTjY4XVL4nqKZIjGDnhrHXcobitmc0sLcOW4I9rCs
         E2z480FESrg5V7J0WLar2yOrmBYd7B1B4c2qVnEeoHEvINkzQM+NoJjSIC8n5xCiga7m
         t5hA==
X-Gm-Message-State: AOAM533vZng8/SGQWr6jdh8mvyqYDrUBhB6dGPL5/jcLUQX9Gv2GKZBi
        6BGOI2L/12/RG9ULZ0u5TVWmbU1uUd7YSQ==
X-Google-Smtp-Source: ABdhPJz+xQiBxA2Vxj1n4VgBkPt4V4KM0f78JSg2tj7Ih73QAdsS9Y2PCiBSXnbQSKAc6isMP2MIrA==
X-Received: by 2002:a1c:305:: with SMTP id 5mr17228673wmd.60.1589783088585;
        Sun, 17 May 2020 23:24:48 -0700 (PDT)
Received: from dinux ([102.186.187.39])
        by smtp.gmail.com with ESMTPSA id c16sm14852429wrv.62.2020.05.17.23.24.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 17 May 2020 23:24:47 -0700 (PDT)
Date:   Mon, 18 May 2020 08:24:45 +0200
From:   Mohamed Dawod <mhm.dawod@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: wfx: Typo fix
Message-ID: <20200518062445.GA13044@dinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing some typo errors in traces.h file

Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
---

Chagnes in v2:
  - Modifying the mail subject and the commit message
Chagnes in v1:
  - Fixing some typo errors in wfx/traces.h file  

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

