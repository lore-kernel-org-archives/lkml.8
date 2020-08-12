Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE03EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FC920781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQa7Biuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHLS16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:27:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF3C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:27:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so1554949pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z12EV34czuh/q8HI4kW7uvaEJ50bFNuDIiyEV0Yi0MA=;
        b=ZQa7BiuqEvG9sR814NBToxsuC6xwgsO5zCoPRnOjyDQOcRwn6dwO++9qNVlIe2GgHW
         vAkVRjnVqajBGDnfo6wXpal0I77AFLqgB8Z11oDNVku7tfduXavYOwDIF2Z/xQtnEHX8
         4e4fU3fuV+xjRSK6NxEx/7krWi6T33GHlodUA8pW4LrxlJHJXBZNXzRJmBHB/AozD2Z6
         +3rdEY0whqSlw2AuFd5qz/pUA9m5NW96lZhW8bsneemqakEmLjRJdfrlqT/gXvrBsXMi
         AOVN2n8Fpmj2LHX+1/HR6XfaC+yVUlCFJxYY/TggwoACz7G8FzowUGAomSPycBwQesnN
         AjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z12EV34czuh/q8HI4kW7uvaEJ50bFNuDIiyEV0Yi0MA=;
        b=r0yajtKiaGA4OsbvaFttuysRsZQXh4xJM/Tv8aoH2TQk+kgvkyu/6VtdvrxMLA4j+O
         59mPnjYZ1gOA7FHTWC+tMkmhlz8BUoU0V+Ekq67cuGcZRBNYzM82wvtF9FUs4bBUDpnr
         WHzKD6MGnwOijahxHkYw8LF5UiBUVXmb3SHfeFHqY27UGeH7KgjXaAY78Yw0VxPHeqRi
         m20xai9mdxV2TbNknF8Qx5PuAzATMyzc/Jcq5A1jGaJFCF3JA42vtl6qYR3RUekAJyts
         WJboF/i7ziQlafWj2+9rf3h2Q6ksTrEis/Ox/mMh/L8ZH/nZcZnzfQhV8OBj3k9cm8RR
         lvGA==
X-Gm-Message-State: AOAM533D2zAr2sW6Eq0Iw7pRMjvRkhEqQai5Gy98qpkLVs/A4DnJajOL
        CjbnAzrn3RaX2XmUWp0WgljVt3GvIaQ=
X-Google-Smtp-Source: ABdhPJzPlb2wxupcRjoPW1RawrslTau6wu4VgTr4MXByZTXuj1r3POdksPr7H/AU0e+CXJ21iUq/9A==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr659792plo.218.1597256877219;
        Wed, 12 Aug 2020 11:27:57 -0700 (PDT)
Received: from localhost.localdomain ([106.51.107.61])
        by smtp.gmail.com with ESMTPSA id 80sm3128627pfy.147.2020.08.12.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 11:27:56 -0700 (PDT)
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: [PATCH] scripts: coccicheck: Change default value for parallelism
Date:   Wed, 12 Aug 2020 23:57:22 +0530
Message-Id: <20200812182722.4553-1-sylphrenadin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, coccicheck utilizes all available threads to implement
parallelisation. However, when hyperthreading is enabled, this leads
to all threads per core being occupied resulting in longer wall-clock
times and higher power consumption. Hence, to improve performance,
modify coccicheck to use only one thread per core atmost.

In the cases where the total number of threads is more than 8 and
hyperthreading is enabled, it was observed that optimum performance
is achieved around one-fourth of the total number of cores.
Modify the script further to accommodate this use case.

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

