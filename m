Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A15C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3EF206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgDUPCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgDUPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:02:50 -0400
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Apr 2020 08:02:50 PDT
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95065C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:02:50 -0700 (PDT)
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 03LEub4j031107
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:56:37 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 03LEuVXg028859
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:56:36 -0400
Received: by mail-wr1-f72.google.com with SMTP id r11so7602338wrx.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFr+l/9NrRUnuu1XyMEc4CbumNQfH4WoE3fGU6r6v68=;
        b=ncQauPMzv+E5NBHmDrKsCSATFfGU2Dp6f8LZsFrw29NtIvV25LYqGOhKF0zXOYA3TX
         avHpi4imv7S0/cM9ck7wbLr77MjPzbXnzGadA4irzDlpifFWkvo/BS0Dd7tmhGP68Kmj
         C69eXbwIjIszW+UTUQTO5MwRL/N0K4rq1oAwvgkrY1vRgqacuu/I4z6Cz+4Gx3+pn6Q7
         j8T5guzTx6QKeoQSNaejLSJ/PuL97Tm3NuDlm8RR1jaW5bEsZut9y0VwUPDdbjUB+JfI
         Z11b5i/ThMNAsxStVoUUPH9JD6+7MIO36chHtVFKEQOoJkaHALGKxYIYfPS0zwt1aL+m
         Mc6w==
X-Gm-Message-State: AGi0PubmeLkkisRA2oAx1ZIH+XP0cM8D6xDJ2VMfLbwfZZjGXWPXTXvH
        OXNAMMojZxhmO69EOHbJtAHFbp61B01xc07n9EDR3ySzkRNprdj/ON60Ier1/Gzyk3iFzBoAyok
        owvgebhAciALv6kDCikOnZF1NAoJWYlBNCMQ=
X-Received: by 2002:adf:aa8e:: with SMTP id h14mr23431850wrc.371.1587480991390;
        Tue, 21 Apr 2020 07:56:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKNlYRKMvZZnWWabDg53tb4Xc5YOD+62vwyQnIJmhPMcPgdojeM5loR8SqItscHjX1ocxI4DA==
X-Received: by 2002:adf:aa8e:: with SMTP id h14mr23431836wrc.371.1587480991130;
        Tue, 21 Apr 2020 07:56:31 -0700 (PDT)
Received: from localhost.localdomain (36.red-79-155-141.dynamicip.rima-tde.net. [79.155.141.36])
        by smtp.gmail.com with ESMTPSA id w18sm3912915wrn.55.2020.04.21.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:56:30 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bilbao@vt.edu, Zildj1an <cbilbao@ucm.es>
Subject: [PATCH] Documentation: Fixed typo in Documentation/x86/x86_64/5level-paging.rst
Date:   Tue, 21 Apr 2020 16:56:25 +0200
Message-Id: <20200421145625.8575-1-bilbao@vt.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zildj1an <cbilbao@ucm.es>

Mispelled word "paging" corrected.

Signed-off-by: Carlos Bilbao Muñoz <bilbao@vt.edu>
---
 Documentation/x86/x86_64/5level-paging.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/5level-paging.rst b/Documentation/x86/x86_64/5level-paging.rst
index 44856417e6a5..8d7a45a582a7 100644
--- a/Documentation/x86/x86_64/5level-paging.rst
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -6,7 +6,7 @@
 
 Overview
 ========
-Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
+Original x86-64 was limited by 4-level paging to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
 this limit: some vendors offers servers with 64 TiB of memory today.
 
-- 
2.17.1

