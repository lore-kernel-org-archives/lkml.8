Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F007CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB624214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBhsvg+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDSOVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:21:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:21:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a23so2944667plm.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iNdtGmX8Mu2ED7qo7igSHuIaVBqlC/RXPGPET/rFH7E=;
        b=fBhsvg+goi25pzMlI+TkmrqJUQAcio7u4bRcJHuyL48e/1CpRxRIzGRBZYjV9n8AUq
         aWlloDEsVTSf0orRQUSDGFXgPFy0ju44OziL5os8utnq+d/Jjte0AXOJlbTWaM1oy5Kc
         yoO6If4Dorh9WHpbWWirUW5jjjc3Eg/53vwlENdo39J322Q0c522eRP0jtGDQm6LnPvY
         kgf+Tity1Xs3+mm6x8MDHWgR+qn/fETfiqoMCxpIkH7Ck0DHOLRN8Dd431FXrs+Uim4i
         uBLWTM1pS9S4BqpoH+tmNZjH0gecs2o7Y+GPlT+M1gJjViL1s4DDbgFT7b5Gyt9za+Cn
         BCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iNdtGmX8Mu2ED7qo7igSHuIaVBqlC/RXPGPET/rFH7E=;
        b=lk0ZrjCUaJKgOgFjhtoS4zME7VRQLqyQuHDATOoidMVl5gWawWLRt5515GtkOzEeVn
         eXZ/POgMLRvS2fhaYX0catHjYi5mqNpk58x2wu9gJX74+CnY3KDPgU0MQpbqvrgGOrE+
         uKEhledEpl8IKqf3KYvgZUU6cYs3UIHEIFuuk5pDfgw8sBhATXvBK9hhD51dx+z1aRs/
         7uTgPvEcRdv7ciT5D7sqRHHyewAWHztAb2NoJYcFIOdV5IfQK1BcteE5Fkkg5P6oXPMo
         c5pAjWlD11MTALvUqruWpKvOWlsiE2pyzq/q1XkGdFI76kZGPJVcAZZ/vYIa7fn42Im5
         h9VA==
X-Gm-Message-State: AGi0PuZWkeUp9RqBwTOb9im+EPamgEF2Og/Jb3KW1hZcFrPh4TUhm37J
        x6KP9fiW9zptdtAR9ey/X3o=
X-Google-Smtp-Source: APiQypKp/jN68WTcZUdJP/Wub1688Qcn2axAexOpLU1AMRrP0nrP/ij+wGC54EYhIv5cgm7vs0J+2g==
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr11100014pjp.72.1587306065858;
        Sun, 19 Apr 2020 07:21:05 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id q200sm23603494pgq.68.2020.04.19.07.21.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 07:21:05 -0700 (PDT)
Date:   Sun, 19 Apr 2020 19:50:59 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: afs: Use the correct style for SPDX License Identifier
Message-ID: <20200419142055.GA8233@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Andrew File System support (AFS).
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/afs/protocol_uae.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/protocol_uae.h b/fs/afs/protocol_uae.h
index 1b3d1060bd34..528a6f1aa611 100644
--- a/fs/afs/protocol_uae.h
+++ b/fs/afs/protocol_uae.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Universal AFS Error codes (UAE).
  *
  * Copyright (C) 2003, Daria Phoebe Brashear
-- 
2.17.1

