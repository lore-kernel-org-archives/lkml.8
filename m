Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22220873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL01+kyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCCFD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:03:27 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35050 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCCFD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:03:26 -0500
Received: by mail-pl1-f178.google.com with SMTP id g6so771316plt.2;
        Mon, 02 Mar 2020 21:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KZLeL10yiQKICWQXqyAvMrywCfnXJptYMW6Zsbkw6Hc=;
        b=sL01+kySLKhWi3WTTqfnDZMkga2lYHMC8TJBX553wS9djxqe9SZh4xH1imjzVh9RS0
         iCx4fhWW+Yy3rgXr+FLGRTDUc1seqJ842iScTRyy3h6AqWgxCdcOR9LLSNUqcNlzeDHc
         R3M+nYFo4QstxDc5I7dBwW1kz9JcEhiBdPkS+/07KUOFBAr7H7TdoAaYKa6vZMjrN0Ai
         0MHunzlodKpY5ldfjaS63SGhpwJJ4mJdikPzMfSx3CEj0mQu5xJMrXO9cvITjuiqpUOe
         SlFL/KjFHk1YHzRKpPWBTp9mPJHsnr1dGNpc0EfBP46EUg3Ihb5XHqGRYIJ5Aa/WsJss
         e4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KZLeL10yiQKICWQXqyAvMrywCfnXJptYMW6Zsbkw6Hc=;
        b=IaeWHFkSALqaY1r5Bpn7Qu75pIY7Gl1mpE0kfRC81ZkdbkD30TcW3Vfr9fEKxfp3vP
         Z7SCjbXY2vFIPnhM72g9KSyQLWwZubkzOgsaEcKMcbdQRXuUFk/hMIvvgb/L62gSRavG
         mu/IWXN6ZLG6bjiurv9zqpYxvZcyOB4v6ZgpbUtATFuR+j+x4oVAAEecs4xmoklXEZk1
         HEYeoy8rAnr9/88yh2AsoN107i1rNu+UZXHA4tcJu1okyA3w4lrLhHZjr2Zl2LZi0u8r
         yWOAecM5a9RYzEV6HdkRCKPhlOBQbvS3Tz071j2a/KsrA21bK+xT0eVPVt47kmVG5hsC
         CmUA==
X-Gm-Message-State: ANhLgQ1U4kwNxMSGsmLBE57fhVaV/U1UqxUkbBn9Y5mcL3B7z3KW3yfN
        27RljzRPE2fyRsg01YjfZ40=
X-Google-Smtp-Source: ADFU+vsKO4Rt6MZ8vsfQIweKuQFxfgCjHHs1pU7cbaRVbYq1XpuUPZ3rSM/ytzjSn1pxfhnctgGCtg==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr2531084plt.334.1583211805614;
        Mon, 02 Mar 2020 21:03:25 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c8aa:e481:f8d3:6de2:77f9:5602])
        by smtp.gmail.com with ESMTPSA id b2sm780446pjc.40.2020.03.02.21.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 21:03:25 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v3 1/2] Documentation: Add io-mapping.rst to driver-api manual
Date:   Tue,  3 Mar 2020 10:33:00 +0530
Message-Id: <20200303050301.5412-2-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303050301.5412-1-pragat.pandya@gmail.com>
References: <20200302114300.34875f69@lwn.net>
 <20200303050301.5412-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add io-mapping.rst under Documentation/driver-api and reference it from
Sphinx TOC Tree present in Documentation/driver-api/index.rst

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 Documentation/driver-api/index.rst                          | 1 +
 Documentation/{io-mapping.txt => driver-api/io-mapping.rst} | 0
 2 files changed, 1 insertion(+)
 rename Documentation/{io-mapping.txt => driver-api/io-mapping.rst} (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 0ebe205efd0c..e9da95004632 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -79,6 +79,7 @@ available subsections can be seen below.
    ipmb
    isa
    isapnp
+   io-mapping
    generic-counter
    lightnvm-pblk
    memory-devices/index
diff --git a/Documentation/io-mapping.txt b/Documentation/driver-api/io-mapping.rst
similarity index 100%
rename from Documentation/io-mapping.txt
rename to Documentation/driver-api/io-mapping.rst
-- 
2.17.1

