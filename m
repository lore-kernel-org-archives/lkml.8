Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BFAC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C296020767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ8SUsfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgDWTPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDWTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:15:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46098C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:15:10 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 11so2868629qkh.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A9o/1fjOsC5s5Fr0nJQ29JU4WvQHR0Kqyz/lYqRJhYg=;
        b=DQ8SUsfdlVCwuS+b+6ouTLAaMoaw4xA62xo8HPnqgfpy+nbrfkhTgo5KUnklAXPgQB
         IoFHGPH98QpX2Tf1YgNw+vkI/9Uidp49uHE+jg9YrGvWAQ0ppu2OnQcyQ3Bh0C5+pHVv
         6T4FBRUCp/zczXh2A25yVkUxv0vEy2GmH5gretX8baHJWhGcJqA0i25tbViL0T0JmSai
         Z1YcbgwnXvOWT0mifDMBmu6/wiYcf5LMrCrrMDpMNIc7pVgw+ismNlTKQ6GcgTRgdGVz
         IOCFuvXkrblJ0LJNr9sN2aJaCwlcRISmsyPtoMrJ4Md2fllFEV6TrC97lLyzp3u46wFv
         8Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A9o/1fjOsC5s5Fr0nJQ29JU4WvQHR0Kqyz/lYqRJhYg=;
        b=FRTSJvo2vLveTWTVGkKEH4PmEEtqTfx3G0hGlyUW6QfADfVJ728lxE4Piu5wbHKhhF
         f9wl8JH+AOm1wZY+axfy9FaoLvfNcPkABgRTX/7QkXkG2zGe3NA9tkDINwJZjx8lAY1e
         GtgGfJTJ6Iud0hhCsS2GvVD34SjGedjJRWDDc704NsqMENYulvU+EWwbMKTMkA+ikK3a
         1dJnvY24IYcBji1k26Ifz2cxkUu+Lq6qh0ui67Jybta7iXfwFAOHRXcd59wZXvWm2YQe
         Iw4wRj0PrIUIFtaxVB2LJ3qbgOYc5Joh7h18hecw7nshwRYkKSzfu+fJgCDpFT2Mnt45
         IHcQ==
X-Gm-Message-State: AGi0PuZeOQRyVfmAcedRqoFxM92sR3O4Ivit6zwTtmDBIHfcnbiNT2KN
        Ujo+h3cRNqZuoNJ8wbdl7GiRHQg=
X-Google-Smtp-Source: APiQypJnWQe7zwAml78nW7ouwWCkolMFc9qngYIkWHS42sNrNqaB5n4YBDp70hm+3jtzcxsX3RiNlXU=
X-Received: by 2002:a0c:a2c5:: with SMTP id g63mr5575921qva.114.1587669309294;
 Thu, 23 Apr 2020 12:15:09 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:15:04 -0400
Message-Id: <20200423191504.149922-1-rcy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] Add rcy@google.com as maintainer for drivers/staging/gasket
From:   Richard Yeh <rcy@google.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org, Richard C Yeh <rcy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard C Yeh <rcy@google.com>

After consultation with Todd Poynor and Jesse Barnes, I am
adding myself as a maintainer for drivers/staging/gasket

Signed-off-by: Richard C Yeh <rcy@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1175fc0aadb..3a61de752219 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7036,6 +7036,7 @@ GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
 M:	Todd Poynor <toddpoynor@google.com>
 M:	Ben Chan <benchan@chromium.org>
+M:	Richard Yeh <rcy@google.com>
 S:	Maintained
 F:	drivers/staging/gasket/
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

