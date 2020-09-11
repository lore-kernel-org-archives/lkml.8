Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4CFC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582A921582
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRG9h3KA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgIKB5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:56:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE34C061573;
        Thu, 10 Sep 2020 18:56:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so3437054pgd.3;
        Thu, 10 Sep 2020 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HG1zAgdPFrrU59ksZmiILqlFIp+EBIES682ABwEbay4=;
        b=CRG9h3KAbPCIyKTVL5Ow6v7ZTVc44jcchGqT6g/gbB97QkzRI/pxAC5bAFcQNYgLOL
         j7exE93qy0vMBx2QQagyNvKQ8jknKuNU1z9Gsyy9uns0WiNT7mHKge4rHTz3E5Aurw0o
         +bBFnX3qBR+nksXEcSG5LzqlEJges90x2CzwhcSEhLZkKxM7V6tjiF8d431WXBwvFKqt
         uXEffIpnGnStn3Z/HhiWir6ARemBbVZfus51skvx+qWlJMibQv4alYU0IYnWMh/s458V
         0yGS9KVBcKQ0W1wTvmOKKS12HBXfy85GpuhCy7xaLz6agMBVVsL1hwxc6AG5ggrnohdc
         q0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HG1zAgdPFrrU59ksZmiILqlFIp+EBIES682ABwEbay4=;
        b=dXkLekX9svbBigrYEaWnEEj/NRP4uMF06YB+QUK2krOut1J3w+nsY0ZlJK7rpl2ZqW
         acWgLPhSZ7yeHtv9IaZ9xtgfQksg7KQui5xHT1FgmA1Cf+I69QysL1B4f7UQUsgcianC
         n742lXJRbtbxK4JLZSdyWam02dzC+5sA7zo+1DGZMgZuIvQJbiuwk2xupRuGaXHCSkkM
         WfPtbkCVs55suEt/XA1xF9lZ3698DaSWIK7Gu+KXDlSZhCscHjVkXJrpjhZ7yUh1sQDz
         NbV8gYNGBjPktIgzinqjEeUgekKCm32AIZs/lhSgLguzbgnYMFqOT+fby6S8WFH7GVvj
         uUfA==
X-Gm-Message-State: AOAM532OipLd5tmS2chHAbuXltu79OcfR2pRAnlywwL8Be54DMTR1ulE
        CKPrB6T3P5tI5g/FJFyaLf0=
X-Google-Smtp-Source: ABdhPJwxENCUocwPmcx6aR/MU6SdUyHz5qi78cyuQMc3HZd1NLlxaHNTH0tLuis9MK6+/ANU21oVSA==
X-Received: by 2002:aa7:9dd2:0:b029:13e:d13d:a109 with SMTP id g18-20020aa79dd20000b029013ed13da109mr8044459pfq.37.1599789416445;
        Thu, 10 Sep 2020 18:56:56 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id 82sm269257pgd.6.2020.09.10.18.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 18:56:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org
Cc:     jeremie.francois@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] scripts : config : Added example use when run without argument,extend help
Date:   Fri, 11 Sep 2020 07:24:21 +0530
Message-Id: <20200911015421.22193-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the help section by adding an explicit example of use.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/config | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/config b/scripts/config
index eee5b7f3a092..d905dccabb94 100755
--- a/scripts/config
+++ b/scripts/config
@@ -45,6 +45,23 @@ make time.
 By default, $myname will upper-case the given symbol. Use --keep-case to keep
 the case of all following symbols unchanged.
 
+The concrete example, say, you want to change any particular config,like
+GCOV for profiling, you can simply use this command
+
+To enable:
+
+#scripts/config --enable GCOV_KERNEL  && grep GCOV .config
+
+ and the output will be like this:
+
+  CONFIG_GCOV_KERNEL=y
+
+To disable:
+
+#scripts/config --disable GCOV_KERNEL  && grep GCOV .config
+
+# CONFIG_GCOV_KERNEL is not set
+
 $myname uses 'CONFIG_' as the default symbol prefix. Set the environment
 variable CONFIG_ to the prefix to use. Eg.: CONFIG_="FOO_" $myname ...
 EOL
-- 
2.26.2

