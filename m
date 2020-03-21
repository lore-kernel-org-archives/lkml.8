Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A60C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E24D20757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skHcS7F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCUOEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:04:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40794 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgCUOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:04:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so3736462plk.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J9eGr1XRuuMVhT4BB0OXqzh8ZUNEQwk5lWfXIehE4RU=;
        b=skHcS7F3YJWvMX4rRiycVWZ7L8rACzYJkh6R1+nulg0+KzXQS2OcNPrqfQjZgnJGVX
         +O1jF/a7lmk/2Uqx76M+eoKLfgwz2chvOz0q68gUN3liu3cBVVSKVgSSCX8scFOxnzhB
         im1AMBM/pu+fA1VJbHiqLkgAnLuurIahr8G/2YOAUeZg32wzUuFpofhTcffvbDRBhMMH
         Lyb/7HhK1tsbzfAraKZ+jmap7FQCec8AI7vfPZF84S1hr1fKn9JmguxcTK+YOfCM+Rou
         HFBedKFyAGEapSfaHZsKonbU4NdBwAw1T5GQfkgyXvwWqT2dh3J4Yfpfj9IYRYb6EZIx
         0qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J9eGr1XRuuMVhT4BB0OXqzh8ZUNEQwk5lWfXIehE4RU=;
        b=SI3VrcvpOsnRd3dYQwxbAdxGgXozzNiICj/ScMem3lfXQT5RvXxnJR4ld2GaBbvZSa
         cHCfXZcunyQqRHE3S+DXGIDPaaMIxz43xzh3tdL8IWa/HEN7yKSZZSIHyE25UJVHzS/W
         GFo0VjApdQV4S50IU8K8sq5koM4yQeRNdtBe3PtkEdHfR0NpSjdXRGj3JOzgzp9mSRcn
         bEfjXPOrmmt3XalZEIUMrbtL5v2nvcJ4Ls4tdBBAh1jJMV/fyO9I8w23GMNJbe6a/vf4
         N5tzdjjxwKd7Wvdq4f1xtxJ5Acr+zeZt3jHQfgLfick42aKXTDxhIuxlKTgg5oy7Y1PA
         XZBw==
X-Gm-Message-State: ANhLgQ39ul3d1HYAVhAchD0Y9olKt0QD+o4aJc/Ycm38PdHSdANSW7/F
        GWu58kThBevo4sqJ/f7vuC6f+krbzLQ=
X-Google-Smtp-Source: ADFU+vtB7XAaobJC3/csU7xutUniWUS8W0WcjIp6L3ZMJMv3TV0R1Sw+EZWDGWdeo36fv9M/W0cQCg==
X-Received: by 2002:a17:902:7b87:: with SMTP id w7mr14025772pll.214.1584799476391;
        Sat, 21 Mar 2020 07:04:36 -0700 (PDT)
Received: from simran-Inspiron-5558 ([14.139.82.6])
        by smtp.gmail.com with ESMTPSA id g2sm1257540pfh.193.2020.03.21.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 07:04:35 -0700 (PDT)
Date:   Sat, 21 Mar 2020 19:34:31 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     gregkh@linuxfoundation.org, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: kpc2000: Removing multiple blank lines
Message-ID: <20200321140430.GA18933@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch warning by removing multiple blank
lines.
CHECK: Please don't use multiple blank lines

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/kpc2000/kpc2000/pcie.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/pcie.h b/drivers/staging/kpc2000/kpc2000/pcie.h
index cb815c30faa4..f1fc91b4c704 100644
--- a/drivers/staging/kpc2000/kpc2000/pcie.h
+++ b/drivers/staging/kpc2000/kpc2000/pcie.h
@@ -6,7 +6,6 @@
 #include "../kpc.h"
 #include "dma_common_defs.h"
 
-
 /*      System Register Map (BAR 1, Start Addr 0)
  *
  *  BAR Size:
-- 
2.17.1

