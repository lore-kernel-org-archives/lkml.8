Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C27C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F17206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDZFrT3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgIGRnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgIGNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:17:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB79C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:17:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so8040692pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tXlaUzLwVVKkp2nug9LSgDtLZzxwlV3OQrTwOaM4mCk=;
        b=KDZFrT3FUBB8HCrkkMnC0JoRhryFVJVEbvDoEnKDDDrbvyB1TEY+8XUaj7rYgbZ/mE
         pVjrk4ACiNUHNmMPKLOjaKbZQlbMonq3ZFL3mERUDc3PX5h68nkuoyhrTvv9JxePD0kW
         TdllSXmLkyy25eJXKuv53OIv5xdVOsCLwYpUJppm6Q9T0SKTUBmAdxGiEvTdHUPhKqO1
         ScGUoNxdA+/n1icMgAKHFSzzZdT6U2Kh8eL7I7KHV67SvAL7C3z8UeEBGPoxDGsb6/RX
         Rn8WBCMmfRBR9I2CuMyrkhRhZ965+5KzcxjIjRUMnNhO94DUwtpvZnQahfveNNOKntNw
         bXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tXlaUzLwVVKkp2nug9LSgDtLZzxwlV3OQrTwOaM4mCk=;
        b=VP+waZrS/JmuC58ZXH0uf/lX5Gv32CAFz+dgFjRnNZFnwZnlrAH8l6Fxc/oOorMr5x
         0sMJGHL7Qjsp24jpzBBvcmD6bZjYz5t7zWMAlX8caNOz8nvdlLgz5mwA0ES1nUH6UTjc
         hc8QM4ucB3t4GC15OEo4TY5NfxqI6B2zxShV/ARndlY0zOjJr5jQA93NXYS8WMwTGMP8
         DD/nZnrvYQPdbGdSus4l5awvwwwyE0lODuGnr7gCnWIcSu/1nJzYBFjgokCw+l+yiaAd
         kzCzL1SykC3Zu94uecYofr6QeU2Ot2CDyj4FkEGBiAmBMQ4debzEsFZ3wdnf8YGuK7rJ
         jz2A==
X-Gm-Message-State: AOAM532qJMnVTeSrYcH6jrDn5XngI3AQxBO/udxEoNoJ/USfxxRC+wMq
        I8such+ZtPUnTzNgfAIWKa7njBZFdc5DlkAP
X-Google-Smtp-Source: ABdhPJwaTYgLkTQwOysWc7yonPdFc+sJbfNmtrJWF6MBXnMw8UrqnBEKagL7vJYmfsdcXugRtIwQAw==
X-Received: by 2002:a62:fccf:: with SMTP id e198mr20409326pfh.183.1599484668372;
        Mon, 07 Sep 2020 06:17:48 -0700 (PDT)
Received: from adolin ([49.207.196.129])
        by smtp.gmail.com with ESMTPSA id m13sm5229752pjl.45.2020.09.07.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 06:17:47 -0700 (PDT)
Date:   Mon, 7 Sep 2020 18:47:44 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccicheck: Do not use shift command when rule is
 specfified
Message-ID: <20200907131744.xovlxbmrzrfm2w3x@adolin>
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
mostly comprise flags that have been set in the Makfeile. However,
when coccicheck is specified in the make command as a rule,
number of shell arguments is zero, thus paasing the invalid value -1
to the shift command, resuting in an error.

This patch modifies coccicheck to use the shift command only when
number of shell arguments is not zero.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
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

