Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAAFC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D768F20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8WLYOiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCIMxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:53:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCIMxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:53:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so9445318wme.2;
        Mon, 09 Mar 2020 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KH1VNE2zt1RlYZ8rl8KTG3SK8e66WbruwQJVkNVIE98=;
        b=c8WLYOiCVOo3TcVaTgnTw3VXuNGVreLagIf8x9lrWlUI/FaUFPULrCKTH3PRrBMCE0
         NYbkl6g/ahGSwyC083KTSyICT2cjG7uhyV7GpOs7coflZdu7ALapA431f3RimNbGUJJD
         3sp3/TTIMpcr0IjS4IHRJ7eafDL5O34K+6HyfHmuVJpgUIAvHbiE/mwRGuFploheBc4s
         +D8sGjuke/hh0bXwvbAto2Vq1iMJhcZ3GVNADe87INxRAfzMwEAgq/3vp/kkmxJfMs6Y
         bvn93fJ/F7uDE+1oe/1LceBv/cJ+VBP+04+7CHy+emD3+7fYSH5sgMPsanG1/oEObc+v
         q6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KH1VNE2zt1RlYZ8rl8KTG3SK8e66WbruwQJVkNVIE98=;
        b=Qn7C0tfgxFPfq9azqsbiGKijLCKGqs4kSsMMYU2Vc/ripgJ8nFjkFH2AuIrSgzTehC
         Hn80sL/wwwrxgviG3WTQR7H1VAO3ruBDdZ5uU03/v5Iv0k6BXEsGKQWa8aM/90WllR3y
         TOzPTypveEDBejjOWKRExoziY34QxYByA8b4/yXHZcCMxmaJFIgRb2A3/KObpOCuR0cy
         way3eDRLdCW9TuvfQUxpFpxwTHR/gad/jq1m8Fwhpq591m2sON4hM6ugQtnJXRBfyXC4
         hnsWE9JvTGAWrufo0JrpuYjvFeiNNaIXfKLw6aNwlqdsT8WjpM9+gnObfMA7ZuowEtFl
         vbsw==
X-Gm-Message-State: ANhLgQ1kF7BGXF8Oa8kQk86TutQMm74c0tg48C+6XLZRPgaojhLM2Yuv
        2Vbg/KzS/nFHH0mwBQ+YcOQ=
X-Google-Smtp-Source: ADFU+vtxz72bTI5i3Dyf4QaCSEg7XW/rjT5sFXoowpjaK8taEIwzAXYNCeUCdqFCnzrrMFztHVPfRw==
X-Received: by 2002:a1c:9e85:: with SMTP id h127mr19292611wme.145.1583758419327;
        Mon, 09 Mar 2020 05:53:39 -0700 (PDT)
Received: from localhost.localdomain (178.43.54.24.ipv4.supernova.orange.pl. [178.43.54.24])
        by smtp.gmail.com with ESMTPSA id q1sm19653144wrx.19.2020.03.09.05.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 05:53:38 -0700 (PDT)
From:   Dominik 'disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc:     dominik.b.czarnota@gmail.com, Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix off by one in nvidia driver strncpy size arg
Date:   Mon,  9 Mar 2020 13:49:46 +0100
Message-Id: <20200309124947.4502-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: disconnect3d <dominik.b.czarnota@gmail.com>

This patch fixes an off-by-one error in strncpy size argument in
drivers/video/fbdev/nvidia/nvidia.c. The issue is that in:

        strncmp(this_opt, "noaccel", 6)

the passed string literal: "noaccel" has 7 bytes (without the NULL byte)
and the passed size argument is 6. As a result, the logic will also
match/accept string "noacce" or "noacceX".

This bug doesn't seem to have any security impact since its present in
the driver's setup and just accepts slighty changed string to enable the
`noaccel` flag.

Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
---

Notes:
    The bug could also be fixed by changing the size argument to
    `sizeof("string literal")-1` but I am not proposing this change as that
    would have to be changed in other places.
    
    There are also more cases like this in kernel sources which I
    reported/will report soon.
    
    This bug has been found by running a massive grep-like search using
    Google's BigQuery on GitHub repositories data. I am also going to work
    on a CodeQL/Semmle query to be able to find more sophisticated cases
    like this that can't be found via grepping.

 drivers/video/fbdev/nvidia/nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index c583c018304d..b77efeb33477 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1470,7 +1470,7 @@ static int nvidiafb_setup(char *options)
 			flatpanel = 1;
 		} else if (!strncmp(this_opt, "hwcur", 5)) {
 			hwcur = 1;
-		} else if (!strncmp(this_opt, "noaccel", 6)) {
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
 		} else if (!strncmp(this_opt, "noscale", 7)) {
 			noscale = 1;
-- 
2.25.1

