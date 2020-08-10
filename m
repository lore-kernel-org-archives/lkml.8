Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9247320829
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URRQu2Nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHJSAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHJSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:00:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC90C061756;
        Mon, 10 Aug 2020 11:00:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so353776pje.1;
        Mon, 10 Aug 2020 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0LG55qG51rpCI41PmpiglFHzTiH9YaKX8Oz0iDSp87M=;
        b=URRQu2NhmUP+sYGDjX7MTZsDaNn04ufx+5HSlggp5zPp8N5Vay45mQ5I+ZIW2EthCG
         5ixlBaL9OLQVvRBDSPdKwJLIG+SOQfG9SEWpFWyu4M0wwbsCKd5eNkYXVJmdQOuzxnAi
         VI5goqxRFBr5V7EBy3hXA7ylcxYEQ7aXO0om/F4nbxda8XHX/+EP7Zi6WxtZgAnWAjzl
         gZDdFx7WXQvprftcPeOK0tAAO7di6xdIZTMJfz66t7HhsbEuOo6IILtG22l+oX2pGkft
         tP15405Rfis21jNmX0k9NR5+vK4wmuM4GnYFegGxX/xzIcqc/O3RFFePFJc+ZGdBzw7+
         xmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0LG55qG51rpCI41PmpiglFHzTiH9YaKX8Oz0iDSp87M=;
        b=iJqummR1GucFoanc1oEZbSIDIGgjmTCL3CzMorgp5jq5WRSK72oRoE8+pFRQd0Bkd8
         5G0TV+DQsH+Qw9Fe7KTXOapbIaBDYwOgy1w7FUnucUpDvGwoVu2QAYB8s6TObRaPT2Mf
         QVHeIpLtgFswnOZVPfNfvBlyLjimRBGMwkf3JHwgCayX632D7feXkKMz+PipO4eWqWpW
         ehEbA7gMdAAKo4sVhe7Nf8W8hyE9uZSmPTtoPSKqJwUeuTGG9d1/wKT5pLvZRV82y1po
         KiVHCVOLh/qSJRIP6T5b3oIeBiYwFqkmDrwwFAG8Re4mx8uEMjLrprgbNoqQcaf5gBYG
         tcrg==
X-Gm-Message-State: AOAM531RUIgRTEyb4Kstsnrrgb/8m6NSdU6K0gUBUpU/gHy8C/gk0uba
        9V+YYgGl7pgVLz/WNRTm1eQ=
X-Google-Smtp-Source: ABdhPJz3jnM2YrQz8Nk9zaTHHn8Y527vevBQb2fK04cFNM5Oo8Cr9oVQISUOASOqI2oQuxzpiMs1XQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5mr4536166plt.87.1597082407541;
        Mon, 10 Aug 2020 11:00:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:548a:bff1:8079:d08c:8652:dd80])
        by smtp.gmail.com with ESMTPSA id n3sm22275250pfq.131.2020.08.10.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:00:06 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net, corbet@lwn.net,
        cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH v3] documentation: coccinelle: Improve command example for make C={1,2}
Date:   Mon, 10 Aug 2020 23:29:48 +0530
Message-Id: <20200810175948.14090-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify coccinelle documentation to further clarify
the usage of the makefile C variable flag by coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in v3:
        - Remove quotes as suggested by Markus Elfring
	- Change in wording, and punctuation, as suggested by Julia Lawall
---
 Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6c791af1c859..74c5e6aeeff5 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -175,13 +175,20 @@ For example, to check drivers/net/wireless/ one may write::
     make coccicheck M=drivers/net/wireless/
 
 To apply Coccinelle on a file basis, instead of a directory basis, the
-following command may be used::
+C variable is used by the makefile to select which files to work with.
+This variable can be used to run scripts for the entire kernel, a
+specific directory, or for a single file.
 
-    make C=1 CHECK="scripts/coccicheck"
+For example, to check drivers/bluetooth/bfusb.c, the value 1 is
+passed to the C variable to check files that make considers
+need to be compiled.::
 
-To check only newly edited code, use the value 2 for the C flag, i.e.::
+    make C=1 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
 
-    make C=2 CHECK="scripts/coccicheck"
+The value 2 is passed to the C variable to check files regardless of
+whether they need to be compiled or not.::
+
+    make C=2 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
 
 In these modes, which work on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
-- 
2.17.1

