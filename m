Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1AC206F4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPAWIBBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIIK3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgIIK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:29:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BBBC061756;
        Wed,  9 Sep 2020 03:29:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s65so694321pgb.0;
        Wed, 09 Sep 2020 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
        b=nPAWIBBQZscZP2VxtA/QFjIrqE8jNAcLYFah9SHCxCi7X3nALrlQD/qHcfeWXdIAF8
         VLyx5wb/euOZKWKdBdhB3ex2mbZu1zj3JwX7beimGt/6/7MFDdWhzoxVH5YTbKvt/YgG
         VJy1eHXwLmie1VnCDszqDBz5PkiK9JOKm2o1FfQ2p+p07+66CSr40z5QWR6QFNx2ckWB
         xc9mIICMHTudmxfJ43ZTOsqp3dHNYYX5ablzywvP4s5vZdD3i5K+NQrX+mZCEBtjv/Lt
         0qZxmCPL3iqqTdhE0e8QQ0Gq2yI07dDiyDLOqnXEb2oZi78oIPYJ25cgY3xa6CJ99wR3
         QLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
        b=W/VC57Zspd6q97j8MUCEAmYSarG3obFts4sNh+OavdC2Nm4H86ejWQTDKw4sZrro9d
         8hRjwKR61FZrWShBqp46Eu8580SfPtUC7BJg5zPlaCA1fhaWxf1lQoF5WFaMIJ5+qP4t
         uXVfT63irKgCFLsIgHRCoqyVzekBzo9lp6b/MSxh0kuZus0aBpopNE/eZkfK/TsfuVkd
         nLURlIvDctGm6g7oZK5C7/WprGxfjNT7bUTqWAlOiwVzh5IiYpdFvlZSXbt3Wf+1o/m2
         AqBEXT6al28+4vv/OBe+eIyrtISOkPepUdUzG7+RAVEtU1uUS4y4NJItD6qHXXfKm6RJ
         2KMA==
X-Gm-Message-State: AOAM5337KmagEP6Jlmilz98Z2grPmXTsOrCfo8oGTnkTn/fTKDVUsBFG
        v6bXhVHkfJ8u24AVOe6l+qE=
X-Google-Smtp-Source: ABdhPJxnx5qwJK5MRFb2jXoiqF3ihVYJ6uzVDwxzoDcHxl2egfJ3y8gFQbLix0JXQHmBz/02XWKWeA==
X-Received: by 2002:a63:3742:: with SMTP id g2mr122109pgn.71.1599647361851;
        Wed, 09 Sep 2020 03:29:21 -0700 (PDT)
Received: from adolin ([49.207.200.122])
        by smtp.gmail.com with ESMTPSA id l19sm2235775pff.8.2020.09.09.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:29:21 -0700 (PDT)
Date:   Wed, 9 Sep 2020 15:59:15 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, masahiroy@kernel.org,
        nicolas.palix@imag.fr, michal.lkml@markovi.net
Subject: [PATCH V3] scripts: coccicheck: Do not use shift command when rule
 is specified
Message-ID: <20200909102915.jzwe754pd7i65r6u@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command "make coccicheck C=1 CHECK=scripts/coccicheck" results in the
error:
	./scripts/coccicheck: line 65: -1: shift count out of range

This happens because every time the C variable is specified,
the shell arguments need to be "shifted" in order to take only
the last argument, which is the C file to test. These shell arguments
mostly comprise flags that have been set in the Makefile. However,
when coccicheck is specified in the make command as a rule, the
number of shell arguments is zero, thus passing the invalid value -1
to the shift command, resulting in an error.

Modify coccicheck to use the shift command only when
number of shell arguments is not zero.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

---
Changes in V2:
	- Fix spelling errors as suggested by Markus Elfring
---
 scripts/coccicheck | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..5c8df337e1e3 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -61,9 +61,19 @@ COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
 
-    # Take only the last argument, which is the C file to test
-    shift $(( $# - 1 ))
-    OPTIONS="$COCCIINCLUDE $1"
+    # If the rule coccicheck is specified when calling make, number of
+    # arguments is zero
+    if [ $# -ne 0 ]; then
+	    # Take only the last argument, which is the C file to test
+	    shift $(( $# -1 ))
+	    OPTIONS="$COCCIINCLUDE $1"
+    else
+	if [ "$KBUILD_EXTMOD" = "" ] ; then
+		OPTIONS="--dir $srctree $COCCIINCLUDE"
+	else
+		OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
+	fi
+    fi
 
     # No need to parallelize Coccinelle since this mode takes one input file.
     NPROC=1
-- 
2.25.1

