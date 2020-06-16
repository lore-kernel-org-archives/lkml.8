Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B05208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVuZirMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgFPMvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPMvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:51:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A5C0F26CA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:51:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so1535631pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+HKpiBULj5/x+8JoN3AVc7dWKv37MLi37e+vc/Tkuk=;
        b=jVuZirMAy0emttsGnuAecLYK0EdQ9xJpE0ZSDfnOab61zHzmy+gb9XMzaTrodYgSHs
         Xv6jn0RlFFgOgUvscS60gx3uCDf7oc7M2/QAd8eCfyckVK2tJrhIHOHr2P2/qis5Jm8Z
         Ve5n9WvjfNTnBOdyCzxGMgxCNcWgD5vQ7InBmXGhP+6IOEtiFiXJ9VVxrtCQu7L4BDE1
         4gcJ4ZMfX8DaMLEYG9u7jDOlgqNbBSC20WylJDSLND3Fqd55jjcApJjXtBsml3uOErZU
         UPiYGVuREKP49Y7jzWPq0/V5Rb9D3cm0fBrTBl7EgQvuTTWaiMa0o9HEsibGKhkjbMQI
         IN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+HKpiBULj5/x+8JoN3AVc7dWKv37MLi37e+vc/Tkuk=;
        b=R2XuM98tWYEw1OasmLc+H9q3mHk892lCCdj5sq0OaZOiusrn6lDz+jzPHADCnMqbK7
         Jgw/1eKdKP8p0eNgHp7pictmyHTsWqUGsLyEiWCUjP/z2xZhZ0zAJGbUSmluV5B3mRSr
         Xj0h/o9Tkzi1/SARpPAmE6mDWJw5r4cr9gtuHvhojumvjl+lp+A1rzgBkWbJ8ooqcgyN
         Cxjm/J5D0wUydDt4Lzk+q80IyHrFMA+LvMA0256vMIGvaTkMVqoWXe6d+6CYPAYaBAAd
         sQlUl/4Qc9giVsnDM9emj0XUsKZ1Lq1FgMtc0l+dy8OLGdwyZWg5iGnAOtL5b61zohAc
         LLJQ==
X-Gm-Message-State: AOAM530XkVXhVsu2GJjeR1d5+Bzd+BTERmLkV7lAgsGkt/ABIhL4eZ0G
        tWVwg4tPBHMU5MJUHM/47NM=
X-Google-Smtp-Source: ABdhPJyD9rYqsvjIRvFkeJrxMmm/10C4XSG7Dn9KS9TzDdg/7mQDJCq66SYQFOJSFAL1kmfWHKuFFg==
X-Received: by 2002:a17:90b:2308:: with SMTP id mt8mr2598237pjb.211.1592311897707;
        Tue, 16 Jun 2020 05:51:37 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id 25sm1811392pfi.7.2020.06.16.05.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:51:37 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 1D4CA2360394; Tue, 16 Jun 2020 21:51:35 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        arnd@arndb.de, geert+renesas@glider.be
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] scripts: Fix typo in headers_install.sh
Date:   Tue, 16 Jun 2020 21:51:32 +0900
Message-Id: <20200616125132.1586086-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36c6ebe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in scripts/headers_install.sh

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 scripts/headers_install.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 955cf3aedf21..224f51012b6e 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -11,7 +11,7 @@ then
 	echo "asm/inline/volatile keywords."
 	echo
 	echo "INFILE: header file to operate on"
-	echo "OUTFILE: output file which the processed header is writen to"
+	echo "OUTFILE: output file which the processed header is written to"
 
 	exit 1
 fi
-- 
2.27.0.83.g0313f36c6ebe

