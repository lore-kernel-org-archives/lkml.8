Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B1DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD77208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc1be8SB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIIJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgIIIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:09:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB6C061573;
        Wed,  9 Sep 2020 01:09:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m8so1522278pgi.3;
        Wed, 09 Sep 2020 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
        b=Yc1be8SBjWq+KAkLjeHBXNGg8D8viucHr66IFvqr6CPDdnxzpg7V64QlqeP+DThD5B
         91WRDzyRNWp48mkFkh/Mj+4ZC+xzdtjx4rCB6RvL8bWiZa4nmaJz1C/8T5a3mw0nEpHd
         NuI1+sKPX3ExoP/YaVhuXeOCKSVudYL8dGLpykiiIRSaGEp1P47q5yVRtEA2R2qiOomN
         +4E4KscqSXJibUJ8xPCbTXp8UjcEvJMDqvGh2xcaYbOjuOC3owp/S6hDg/+4/NfnuQVk
         Rvlu9ZGgV0uNmWU0bhkYAwD9kNGkMd4LWAU6Ub1P6S8uiN4t4b1vS1CBYIvA/dPojSns
         ofdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=x1ennYUlzh5ZiE58CNNa6Rmzq+yOs03mH5GcYAaRQyI=;
        b=DGdZbyIxQQmeEOLmrbfWYdzvDwFhX/fZ3+l3MHfPMWqfUE58SpyQbjEBU7Yu6H4wZj
         tWVKlsFEpcygU6XUQV8abHM3Jn4xfIbD8coakCyvT75Uc9vbfDgwaKTFbG1fVjsDDrBv
         rRZCVMnUsemkp3cPz1ODQZ4mLeaczyUCq33h7RAKigr9va0pdOB3lxDGXQgU6HL+sxO6
         v9wftzvv+RrvGOUwkUUf2ix5isrA55Q+HNEJQX1rucwIcHcGuKALWH780AXbv9XyZxjI
         8/r9cztpajnixIAEZW0nexQxeZYvMe3bs32AEXfRabbHfBgCD+q4dLSYEg+SHmrKOfxF
         Gizg==
X-Gm-Message-State: AOAM5304J8j5nIFYU8MjvGki7gp3yHJDbnvCb5JMMhQEf3wjA04FwdkD
        pc7+8ZrXjfmga71Lq+zsTfU=
X-Google-Smtp-Source: ABdhPJwLmGAG2A5a2r29KKqQm2O+XLzOCLEkeRfBbqYIWr+0Gl9hJUGEkYlO4HbYh4Z8nRMVyY5bPA==
X-Received: by 2002:a17:902:ff02:b029:d0:89f3:28d2 with SMTP id f2-20020a170902ff02b02900d089f328d2mr2840803plj.14.1599638985715;
        Wed, 09 Sep 2020 01:09:45 -0700 (PDT)
Received: from adolin ([49.207.200.122])
        by smtp.gmail.com with ESMTPSA id f10sm1790655pfk.195.2020.09.09.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:09:44 -0700 (PDT)
Date:   Wed, 9 Sep 2020 13:39:39 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, masahiroy@kernel.org,
        michal.lkml@markovi.net, nicolas.palix@imag.fr
Subject: [PATCH V2] scripts: coccicheck: Do not use shift command when rule
 is specfified
Message-ID: <20200909080939.bhkgluvo5zw2kder@adolin>
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

