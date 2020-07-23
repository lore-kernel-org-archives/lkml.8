Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C00320714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBWC4BFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGWSHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGWSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:07:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C41C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:07:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so6039337wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wBJkfvCOZyc81ojTqQT3ESIFT3XyYfjTfodi1aPt+nE=;
        b=vBWC4BFWxoQ3LrcjrDvJrZH7UWrLeHoqpZB96XyLvMPGCtVpHsoNpuIbJnXnjq4yWm
         vo6uZ3g+z9vMmWdau9QLisc2cyK3UxBb7jbodkxuUjHPZgOFUtq5gH4IvoEHZjQFfz97
         AnbnPvxHOryRiQ50xW55yVT+WWzMxinoJurb8aceqADrGP5sFZsaeR0Sd3TnjeuGhpsn
         XJsxnoBI/9gV+dc9zVWA7hFBlnhJrjVlQTklVAw1d2htgctWIAN0P4vczHJEYMX/HChY
         AAz4OpnATOr/UFu5HySHp4gxxFuwRLqDDmj3++ducAOukaUb3rSSJY7R48l6hq5NFrye
         fftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wBJkfvCOZyc81ojTqQT3ESIFT3XyYfjTfodi1aPt+nE=;
        b=ltvjXs+QpT6sTyBd3C+/E9kzjxV0/ND9qdfW9NRNwHPC1Qy9W6eyVaWczWIZP0uuiM
         UvfiKR02RPgtq7MY00bhZHOfoVQYiswzXE34hULQLBb6aTYvjFm2shK83W7p3J/quei9
         qevBejgZBO91021xOklS0mxgW1JFz4S9nvY+mO7+GZss0eG2lQULASssGb3MI3XQpeQH
         ydwTbKgSYXVwrdccavKU5XTNsIlBv2Ztf9lAFrodP6qgaFZMtiRJFZhFzuKm8uKGBjpF
         FFxIrVnFQZ6Ggbjp+Z0t7IQy3ivQAIH9V+Ay9rKGOOrvBaD/1Lim8gPMpDTlJQ5bBI3l
         qEZA==
X-Gm-Message-State: AOAM530Ze5Ly6zbXvZVyRtTNdQP2z+CyRcjqDfJmuhE9kQhHrQqjp3Ht
        6LsTW9PsnjD6SPhEP02UniwvtX3r01U=
X-Google-Smtp-Source: ABdhPJykbDyBx5oqb8XWMu/eo8SzcwM1HastQpYeTmCY46cuigp/qUVDVoBkJTbZCRoy49cV9QYARQ==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr5103654wmi.22.1595527649969;
        Thu, 23 Jul 2020 11:07:29 -0700 (PDT)
Received: from musamaanjum ([111.119.187.25])
        by smtp.gmail.com with ESMTPSA id p15sm1568184wrj.61.2020.07.23.11.07.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 11:07:29 -0700 (PDT)
Date:   Thu, 23 Jul 2020 23:07:23 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH v3] staging: octeon: Add the license identifier
Message-ID: <20200723180723.GA30699@musamaanjum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:
WARNING: Missing or malformed SPDX-License-Identifier tag

Add a the SPDX-License-Identifier tag on line 1

Other files in this folder have GPL-2.0 license. So this file should
have the same license which was missing before and checkpatch.pl was
giving the warning.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
Changes in v3:
  - Removed an empty line which I had added in v1
  - Updated the commit message to include why this patch is needed

 drivers/staging/octeon/octeon-stubs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index d06743504f2b..3f8e5713b8a8 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #define CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE	512
 
 #ifndef XKPHYS_TO_PHYS
-- 
2.17.1

