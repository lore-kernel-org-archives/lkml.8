Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECA42137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450378;
	bh=R69Ua2vJXpb/mpI5qQA79XmEOZGBKV2Wa9fGVHmCRcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+d1o/fbYZrYWx7Zs0tCSONokvPn3aJ3SS9q7zRfU+AdMDqeZ4DmcucyWotecIIkI
	 uTMx6jEbzQ99O2ESWyE59qr+kXtKG9/JJOyLtsDo+NwkngD0riRBmTuO8PS+uVQaAE
	 NcCSmziYUn2wdACEvjQuKumt5S8ChbMDmYhWs4dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIGDp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F5C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so7925941pfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmsHkuXTfVjdOXmnrSnyMRHJc8MdPEuRY9I0xRhzFJ0=;
        b=tsIgFhozZuFCIGkh6WxSJFU06AUQm1onnB+5GCl5JaOgQaaekYEWF2aiVT3hNnJRPz
         SrrSOpEHqFWo6fByj7FwLSsjW9JmTtBk2cn//Cwb5C53iQw5sfSj0FLyAOjBTc+dsdN4
         FxmRVWhZnbBfPf3mTxoI2I/QZV6P4fKYTsti0ZxytSBEh8lqIc5GA8oQvthi7JIzc42Z
         kS/gU74ioR1m40mDaLs1ygNmbAlANzm/9aMG11Vzmdm3AnPEFJpfd3dAGkMfLiqx4U7P
         dV02mC92zRX85zUouK9tDzi0tRyBUJvPSHEu+9v3u0B2VsFgujU4DIYEgEFJ6iux6/bV
         8cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WmsHkuXTfVjdOXmnrSnyMRHJc8MdPEuRY9I0xRhzFJ0=;
        b=ZZFLOpUaFpjbnQIcOiH+6G8vHRC9hoq2KEX1RxkCACNSgkP2GLqwU7dheI5Hq8hpaN
         hs0e1Ld4N38ptNyOoHmGe1r3O7DR+iSyXttU8kmY7xnc879SmAyV9Q4qMOGq5G37UOtP
         t683AUXLrOGYQGJdFK5jrbP1wbNRKiWBK66pab8H4F23vimeFe0lTVXOWSN2CC9jIH1n
         oBV9WgNPUjjY3hLDtxz3jyqJSRk9pbXsKI1RzWqjYg9mnskD4ZCyaqOKsAmdOJ0zhFGS
         rN8GO5eHc6urqlTT+jTbbd4uEAC2vM2EmwOfvBIQWb0Az/SbOny+SwKe4ikgpcDElAq9
         LYgw==
X-Gm-Message-State: AOAM5336Y0NOvuL2PcaxentrSJjyVDO9bnBvoSfPSi460/utDnNKGyVf
        thKUTFVA9qc6A4XUWOuKxqM=
X-Google-Smtp-Source: ABdhPJxzseEAXXnAGmyipobpU8zTPg3icPAbgJI/zKJ4RBp3t8g9rK2pPasAOr5gdQOKg5P4XD7flQ==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr15052981pgp.341.1599450317357;
        Sun, 06 Sep 2020 20:45:17 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:16 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/9] perf evlist: Fix cpu/thread map leak
Date:   Mon,  7 Sep 2020 12:44:54 +0900
Message-Id: <20200907034502.753230-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asan reported leak of cpu and thread maps as they have one more
refcount than released.  I found that after setting evlist maps it
should release it's refcount.

It seems to be broken from the beginning so I chose the original
commit as the culprit.  But not sure how it's applied to stable trees
since there are many changes in the code after that.

Fixes: 7e2ed097538c5 ("perf evlist: Store pointer to the cpu and thread maps")
Fixes: 4112eb1899c0e ("perf evlist: Default to syswide target when no thread/cpu maps set")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e3fa3bf7498a..c0768c61eb43 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -946,6 +946,10 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
+	/* as evlist now has references, put count here */
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
+
 	return 0;
 
 out_delete_threads:
@@ -1273,11 +1277,12 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
 		goto out_put;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-out:
-	return err;
+
+	perf_thread_map__put(threads);
 out_put:
 	perf_cpu_map__put(cpus);
-	goto out;
+out:
+	return err;
 }
 
 int evlist__open(struct evlist *evlist)
-- 
2.28.0.526.ge36021eeef-goog

