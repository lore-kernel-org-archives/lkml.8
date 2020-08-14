Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B6A20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYwO7AyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgHNMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHNMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:45:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341FBC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 05:45:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so4129101plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SmHbAJCevR0amMN/Zfcj3PyJxNcwE0n/cl6TTUsXdNc=;
        b=AYwO7AyHkiDBNjn47cDqSTJQl4femmkIULUnFnOa5ljUbDmk+Tm7P8+9xmnzF0Lwer
         TA0ivp6FbtknhP/WR6JVeNYVi3NlSzTySdzCIY7CwtddtOqZB15W9rOL+qAw/JCxIEyT
         pmYGQzRjPKpAPdgRKSeRqaLnDd+nDXZzbc6ToGyJHiEV1b1QoXuiP0/takARs+DzfcEt
         033BhFsxQKqnbpCoBMtCZnxu0nPnPrTu/hs5jCi6bjcNyJiOa4p/S35irh43zJXVr1Bu
         BtaMjUs1m79AWPWtVYB5kWXqACOH14tXsROrzUSjjxGGkW8WzpVf/FYqoaJ6bOkT21lx
         iKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SmHbAJCevR0amMN/Zfcj3PyJxNcwE0n/cl6TTUsXdNc=;
        b=T8UITtLXS/vziGYMGjwyZqipJA/7P9RJTWxXBwBj/V95YNJeYNi7uJ6IuCne2OTklt
         yFasLdzJIRm1qdP3DXpFMgUk98ZIMFFgbCQeEfapSuPKxRCeHQN4qVDPWMd0CXbT6/XV
         7tP9+7WL/KFUp0aHJL8adBmFU/uR0g9JwY8h5hUUG1RTT3tI0fDrpruRojstKrwUO0B1
         hD8HUgNBeIiu01ojm4WX4iTx+YNzVrN3HAB0+fc/aFxAILmad4p/P4DELwrGMiTspuQd
         ziBL01yrDptMkHeHAK1BCNKqFpNx0ySEqf8MdnKbjxrtRHDYPw9kNuUBkyx8H54EDAn8
         Kw3Q==
X-Gm-Message-State: AOAM530t9jeBBbeyvw419VyWIBnpDrV4Esk5eGX9fk5AE7I6KofU1ADN
        gYO8aPLCilVoP7LsZ9vGlmIb/yp+APvriA==
X-Google-Smtp-Source: ABdhPJzQRmyvNdWQHzsF9IF129kcaTj8mszVA6io9lQ2/cejD/Rnnk/oKhGnREbYAB4E/NgpTNokQA==
X-Received: by 2002:a17:90a:bf86:: with SMTP id d6mr2075391pjs.83.1597409138981;
        Fri, 14 Aug 2020 05:45:38 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.61])
        by smtp.gmail.com with ESMTPSA id 196sm9592765pfc.178.2020.08.14.05.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:45:38 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH V2] scripts: coccicheck: Change default value for parallelism
Date:   Fri, 14 Aug 2020 18:15:30 +0530
Message-Id: <20200814124530.24793-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when all available threads are used,
a decrease in performance is noted. The elapsed time is  minimum
when at most one thread per core is used.

For example, on benchmarking the semantic patch kfree.cocci for
usb/serial using hyperfine, the outputs obtained for J=5 and J=2
are 1.32 and 1.90 times faster than those for J=10 and J=9
respectively for two separate runs. For the larger drivers/staging
directory, minimium elapsed time is obtained for J=3 which is 1.86
times faster than that for J=12. The optimal J value does not
exceed 6 in any of the test runs. The benchmarks are run on a machine
with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.

To improve performance, modify coccicheck to use at most only
one thread per core by default.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..dd228dcc915e 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -75,8 +75,17 @@ else
         OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 
+    # Use only one thread per core by default if hyperthreading is enabled
+    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+		if [ $NPROC -gt 8 ] ; then
+			NPROC=$((NPROC/4))
+		else
+			NPROC=$((NPROC/2))
+		fi
+	fi
     else
         NPROC="$J"
     fi
-- 
2.17.1

