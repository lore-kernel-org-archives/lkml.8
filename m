Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA369C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:22:36 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647F20737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taWpI8IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7647F20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgDMHWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbgDMHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:22:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E821C008679;
        Mon, 13 Apr 2020 00:22:34 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a43so10920110edf.6;
        Mon, 13 Apr 2020 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=12YaGZ0Q7/4MTqyWRVrwSum2gRGtuip2cL2gQR6LOpQ=;
        b=taWpI8IPNfim4/HRodFQtrondjFAQ2VuoNQg7pOnuAXZDi3xD7K+EQ3uMD/Kn6f6Rq
         SdKPjxEt1/b/BvIfNTbbCmiPyXh/TWAXfOzVyjPfNGJbmxomObCZ/o7On9dSLREuAJI9
         /Ynkd+r58eHZjv86GNoSMsJXr8D1zPLskgGDFnbFc4zoOBnXD0Jb5eD37dd5831KKYTA
         0v8gCcElj7p7HYBeWkarS+z2o+dVej6NXQtHdnKFRO34+H3gnayY/sDt4AHrLQjiwyrE
         RdGPwxzlNcGCT+NzoQWuk6TwZnEn29F06QkX/q3DyEXGXG69qA1BI8Lpf1PYe1S+HshR
         JsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12YaGZ0Q7/4MTqyWRVrwSum2gRGtuip2cL2gQR6LOpQ=;
        b=jBxzcwucRXWx7LxxzBtyHWpp4SovEgpe/81zNCK/EPwvp1RTTvqcXfiD9eV/svSXay
         +NyCAym9nQbY+bZz06Zg1XAFx6gXQCPfnn8Y/Fd5ly6VW9bxTcX/g1F9Mx6BbQi2DIAY
         /6EbXxWv5Wkqt4VcOxYC0x3vcmk5FYy0IfuCj77E8hCZU1kSiKMPzFX5EYJIRJQNOR22
         8opKaYCXSmnCOZ5x+/Wj0rSLHO3su6ChHgHuKvN1Kjh+q/bAhXGSy5amjuxbQB7HDPDj
         LFFgqyMZhi7HY9T5mwgnRp+uWYIFeRvT7iBJ1uJ7ZAZ5lqjCI3EozQop7imTHiUq2l6x
         0+Cw==
X-Gm-Message-State: AGi0PuZ6DIJOujPjvpMAvb67fC5aJ8r79rDZcI3V3R6To8JbgN+Bq32C
        knB9d1YDIvP+4VKQNe72fjUYC7ql
X-Google-Smtp-Source: APiQypLJzjmcJ07zIDZytFRftCleLq1hSx24Fc0wPZXV4mCSsFEwVqkdPm4G1r5miQPgefltc3Nv7Q==
X-Received: by 2002:a17:906:2ccc:: with SMTP id r12mr14761123ejr.47.1586762553339;
        Mon, 13 Apr 2020 00:22:33 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:c0be:812e:7fb0:ebe0])
        by smtp.gmail.com with ESMTPSA id 30sm1080047edw.70.2020.04.13.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:22:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: rectify MMP SUPPORT after moving cputype.h
Date:   Mon, 13 Apr 2020 09:22:21 +0200
Message-Id: <20200413072221.8061-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
added a file entry that does not point to the intended file location.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: linux/soc/mmp/

Rectify the MAINTAINERS entry now.

Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lubomir, please pick this patch.

v1 & v1-RESEND: was ignored.

v1 -> v2:
  - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
  ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
  ("MAINTAINERS: sort field names for all entries").
  - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..a0fef0c33ba5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11327,7 +11327,7 @@ S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
-F:	linux/soc/mmp/
+F:	include/linux/soc/mmp/
 
 MMP USB PHY DRIVERS
 R:	Lubomir Rintel <lkundrak@v3.sk>
-- 
2.17.1

