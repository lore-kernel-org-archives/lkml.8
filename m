Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F36C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5210620767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1Y/+Q/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGISvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGISvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:51:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72928C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:51:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so1184664pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DUAnAB1O1U5HTun6r8ahSdEu6tOLSHOah+bK2fkko5s=;
        b=K1Y/+Q/83Xk5X187BG8LiM6FTXuxO4382G+rWSxzkl9XZP0mrloSul4PYGI9oNtxKi
         JM9v3ajjTLlTubL8C/m3hInPk3uid85beWL8fY0ycrWxJnMBoNwePuYTdyFrRVwayUQY
         QERAbNM2UlYwonrlEOWW5w2J6AlJbKMpA/fhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DUAnAB1O1U5HTun6r8ahSdEu6tOLSHOah+bK2fkko5s=;
        b=sSDiPMeUu089wQqnhg61vXS5XOmLLKUicmzjxBC4oEVm2CsdGHiq3ky0o0eA1kbKRz
         l06vM1CVFx6gkbW4GMg96O4NpIiD6JJ6sLYzPdFnEIrnjlLnogvYfaGLzvEU2sXU8NaR
         /+faxeyM76+glmDBA/1w4ewvbXyl1W8gXGr9S1DSVSZ5a6zluUA/H9UlDINJ5Umr1SRU
         DK2jPg9oGwm1a7x1B+QBZSGF2c379EirVDT2Duzp0ojh/NZoIDEeDrULoBHYBDFd460D
         qBFS6/K7P2C+8/OnyHQAa0oBONNpS76d9FHoiHr/VZXDn8jlQjjMcE+4Eesnu2oVzNFW
         1Z5g==
X-Gm-Message-State: AOAM533BXg62BaxlxsXyF/kMy3MPZ/KG4sq6cYHGLcvtUQrgiUP+cVjH
        ue5C/9MwSgN/TWiDGLPPIxoMgg==
X-Google-Smtp-Source: ABdhPJzvtnZrznMl2tRk1z011k29OqQdwV+YAqxrjR9BJNucrcWWqyOT0gXYauRNk/mxEdKLsLyPHQ==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr21824068plr.161.1594320696912;
        Thu, 09 Jul 2020 11:51:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 190sm3320718pfz.41.2020.07.09.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:51:36 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:51:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc: yama: Swap HTTP for HTTPS and replace dead link
Message-ID: <202007091141.C008B89EC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one dead link for the same person's original presentation on the
topic and swap an HTTP URL with HTTPS. While here, linkify the text to
make it more readable when rendered.

Link: https://lore.kernel.org/lkml/20200708073346.13177-1-grandmaster@al2klimov.de/
Co-developed-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
- replace storm.net.nz url (kees)
- refactor with descriptive text (kees)
v1: https://lore.kernel.org/lkml/20200708073346.13177-1-grandmaster@al2klimov.de/
---
 Documentation/admin-guide/LSM/Yama.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
index d0a060de3973..d9cd937ebd2d 100644
--- a/Documentation/admin-guide/LSM/Yama.rst
+++ b/Documentation/admin-guide/LSM/Yama.rst
@@ -19,9 +19,10 @@ attach to other running processes (e.g. Firefox, SSH sessions, GPG agent,
 etc) to extract additional credentials and continue to expand the scope
 of their attack without resorting to user-assisted phishing.
 
-This is not a theoretical problem. SSH session hijacking
-(http://www.storm.net.nz/projects/7) and arbitrary code injection
-(http://c-skills.blogspot.com/2007/05/injectso.html) attacks already
+This is not a theoretical problem. `SSH session hijacking
+<https://www.blackhat.com/presentations/bh-usa-05/bh-us-05-boileau.pdf>`_
+and `arbitrary code injection
+<https://c-skills.blogspot.com/2007/05/injectso.html>`_ attacks already
 exist and remain possible if ptrace is allowed to operate as before.
 Since ptrace is not commonly used by non-developers and non-admins, system
 builders should be allowed the option to disable this debugging system.
-- 
2.25.1


-- 
Kees Cook
