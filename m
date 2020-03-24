Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3EC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E5B2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+2sSDci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCXXC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:02:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgCXXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:02:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id 142so180665pgf.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1s6A7ajW1F7QM+axDcHOvDFt2fqhddwQz0wjaRjcuo=;
        b=o+2sSDcinDH9mPaO2+diR0Dh4kZk+bsUkXxLBYdxDpZkik7UZ2ErTGY3ftGMEmxjB7
         LCvhz20LqTUQit52A7f5+r5D3qHgtuZ1y5i67WfVR1PxWJXzOeTIY8aOK4elCZxjILcV
         5JdvxBmhU+RIhkJ2mVBpPlariTc95cOCOadPBF73JekjKcg4PK7HuZ4tePBQvNoLA7Fv
         30MJqpsb9HOg5uje6AkdXXDtH/yolMiLRifsHB5U39OgZz0tV8qZROfYqnrpFMK2e7Z3
         R+Yv66tKv/5uGwwl5smc9NCGpU41kPvGu7gAzJp9ko0AHLhcJ5zpEOFUlR00z/n7oQux
         kJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1s6A7ajW1F7QM+axDcHOvDFt2fqhddwQz0wjaRjcuo=;
        b=kvfkd9urkHXrYg1hLBFvU1ZebZTrLwfVkUJFankACrpi3uIjbHDrpdptfDkobVdfdI
         jCFk4eJIrpOiw1J/YiP7ma0xlDrh2cSk7Ty1b821K3DTVBNPw2qzOL4fTGqZiMOXznXg
         NTOr4qBqRcTlJTor6V5n0ceBJsQHl2kFP+FwQP2uF5vInkd2gqLFePwkgfeREnlzr8eX
         tJff2qFP4tcB+ikSpCCA97qmbSx5+bOgeZwIPMddNtQNp6Fu/NQCS7GeLer09BOfcklj
         Yv1jeyuiw59vpsNnWod756dH+ipU28OKUiZAfrdn2yZP0OQBf6dMM21W6lu+dEeGy+sN
         Zbkw==
X-Gm-Message-State: ANhLgQ0ySA3BTDNBTzUKCBINA+hC0yUkpNUKXCvWJRpPF5pMJmRXgE3l
        DXGLtUvI+YUX/zaKYndaNwAk/bUt6q8=
X-Google-Smtp-Source: ADFU+vtDYn2fngQVL6gs8RjH9WVemUNCDxt6lJ6I1hBWdAvKnpho6M6QfDJeWgFsMz/QEFoe7U2JwA==
X-Received: by 2002:a63:be0f:: with SMTP id l15mr66280pgf.451.1585090947917;
        Tue, 24 Mar 2020 16:02:27 -0700 (PDT)
Received: from localhost.localdomain ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id k5sm3044384pju.29.2020.03.24.16.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 16:02:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux@leemhuis.info, rdunlap@infradead.org, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] : kernel-chktaint : Fixed space ,cosmetic change
Date:   Wed, 25 Mar 2020 04:29:17 +0530
Message-Id: <20200324225917.26104-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Space bwtween the words is fixed at the bottom of the file,sentence
starting with "Documentation....."

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/debugging/kernel-chktaint | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 74fd3282aa1b..1af06bc0e667 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -198,6 +198,6 @@ fi
 echo "Raw taint value as int/string: $taint/'$out'"
 echo
 echo "For a more detailed explanation of the various taint flags see below pointers:"
-echo "1) Documentation/admin-guide/tainted-kernels.rst in  the Linux kernel sources"
+echo "1) Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo "2)  https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
 #EOF#
-- 
2.24.1

