Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD06BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2102065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8tGaHMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgGVPkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgGVPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:40:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DCC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:39:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so2342212wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RnJUfvdhHEXCtn6kTDVL1C13ap2rftP42dOu9oQ/bio=;
        b=U8tGaHMw3sVHJOhPvWUGfPQCTMd+v4FqzJoqbZOZvGebiwLOJzxV/y7SlbUZ7KqqsT
         ui+rmggO7FzpGhD0LBjMmU2FBe/pXNoInQcorXS8zGnN1DbZjOb/+kTv/zH2WMpv4Tkp
         VBTQVzpyp1Nr1RahFRIWqQnhHrdaRG+otqWfln3odJ6PKrs6lfLcyvLbiBkog0SBK+Y3
         HobOtzjuyPivVD0GYsBbn3KwlsiF9liuAVVQafQaJT+AQeFDfvUyG78S6WedSFGFM36F
         K88R2pNnHx/qkxwkRu9lPlCWaIx5WGZqE5mXvTMnYtEPqlrZUqbOBUzqzdjGl40PTp0E
         /3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RnJUfvdhHEXCtn6kTDVL1C13ap2rftP42dOu9oQ/bio=;
        b=kyK6R0T2GYW+D9Jz3dAh6dxMJxhUV2+/BcK5IO6bZIdNw5VDh1kQzVFr8aXZE36Nrn
         IdUZYFVwdQL/d8dlkbvzlzWhL+mIZvsPHOMG7G7bnF6ihZb3jDH1ZGCma2lfammQZtCh
         HmZw+1cxzN7OD2nqBnq/hMhilgHg3fLg+AU3SfppOKxIwZeaP10jjIdtPrGuax9gDAjN
         PESZL2l3fQ289dd46o55EHsTDqm5v2EJnYi4remr3fI5g1itZ/6hasPP3WGYVxB8S936
         k6S+u6lt6P+I+w12qQrPj2LrnmhfXj0Oylrd5UZtTPw3ir+vSRrNx1+McdFMyTjOtDvJ
         4oEg==
X-Gm-Message-State: AOAM532uWb8Xd8p29ISrWrdkIXmTIfn0dUPn8TFTvGbv//sCMluZp3qW
        zikpqZTL6vrQamCWpKezZyJKI4K2/2I=
X-Google-Smtp-Source: ABdhPJwkfzSUd2XNGj/U2C/eIFBS5lLSgW43ml7nh/uCSidVClcpc8NCaPXetMuDL4FVco272+wNRQ==
X-Received: by 2002:adf:bb14:: with SMTP id r20mr156893wrg.366.1595432398746;
        Wed, 22 Jul 2020 08:39:58 -0700 (PDT)
Received: from PKL-UANJUM-LT.pkl.mentorg.com ([103.150.154.211])
        by smtp.gmail.com with ESMTPSA id u20sm70453wmc.42.2020.07.22.08.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 08:39:58 -0700 (PDT)
Date:   Wed, 22 Jul 2020 20:39:53 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: Add the license identifier
Message-ID: <20200722153953.GA8148@PKL-UANJUM-LT.pkl.mentorg.com>
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

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index d06743504f2b..889b7c80666d 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #define CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE	512
 
 #ifndef XKPHYS_TO_PHYS
-- 
2.17.1

