Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9CC20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqH51J+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHKAX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgHKAX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:23:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CBCC06174A;
        Mon, 10 Aug 2020 17:23:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so5842674pgl.10;
        Mon, 10 Aug 2020 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+99HTk829z77UgrecGTfuYR3c4AUA/fCCf1uyPq3Gps=;
        b=JqH51J+5OOrX2djgbNaNaswnXP/HlQYtcQsCZ5oN0ZvyhpWFZell4QyQU4zgKJEVbc
         vkebOn22n3aGaSC8IT4+7RtXE/YpspGqTsD8JPB0hqP09ihP0ZBFcdRTfKFdy3QpgjL+
         r58+nuzJ14sxJlF0ONVMBgbShhkuvGEXl2e4gYTGB8NwVac6y4QH8FpbBaCJT352KUni
         e/WCMEb5szl294cAlvU/CfWSDjpkZkqBqglVQ/znM/mYAS8eH1HnER13PvGrrEqcgXei
         jjToFVGYEPyAcBxi4OXL/MfZAMf+yhLJJF0O/587iJ52eUSbysCXZW6NDOJL6bu8el4g
         dvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+99HTk829z77UgrecGTfuYR3c4AUA/fCCf1uyPq3Gps=;
        b=uGDA5sIcAiyD+oDTwdqMQDsCf+yAcY9TRia9W1sjtPfSUECDrLQ5EWVGjVDAHeIhRg
         02V2p/Wz5VHMW6kqPX6o6G1S1IsXz4lhxry458TujE/qb8yKhvVGOmvE61eP/pBYfNk1
         mCOmgYF/0oFZtzUXqBcnZkzWPmy8Quehu8Gjr46p5yHXYPHnCtSk3OTGjL1FkJXWx5cZ
         /SuN/pJi1XEbRkbUzIETczlQTwLbIB2atW+DbKvPJpS73m9dNQwC3rMfmSwDkC4lC2vs
         UtysP9FM86rPxpm0rNbIZfEAIqAHNcVVnij3h0qi6v04zeTaxsp1858/f7uG0I/skpRf
         o/Mw==
X-Gm-Message-State: AOAM531Wj3Z20neMyIfYHnH9uD/sbbS3MuDzz16gWs5cLLQTN4ZxRzW4
        h7uahG/HlCJb1KaLk7LL1QE=
X-Google-Smtp-Source: ABdhPJygP9COsdnZLeCPz6eyeYXL2sj3Yj037OMMH/cI1UNtw6rIKfKl8cj8poOchjTYWMKukr5JVg==
X-Received: by 2002:a62:e30a:: with SMTP id g10mr3419621pfh.66.1597105437549;
        Mon, 10 Aug 2020 17:23:57 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.221])
        by smtp.gmail.com with ESMTPSA id i1sm24132356pfo.212.2020.08.10.17.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 17:23:56 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net, corbet@lwn.net,
        cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH v4] documentation: coccinelle: Improve command example for make C={1,2}
Date:   Tue, 11 Aug 2020 05:53:50 +0530
Message-Id: <20200811002350.5553-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify coccinelle documentation to further clarify
the usage of the makefile C variable by coccicheck.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in v4:
        - Modify commit message to clarify C is a variable
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

