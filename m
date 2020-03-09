Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E1C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F94F24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQlBKd7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCIUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:01:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39106 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgCIUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:01:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id e13so8008451qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=e4ESlaeaOWB4SITOU7C7LFR2ZXRJ265Gjmf/Gjxj0o4=;
        b=IQlBKd7g1kVI7EjuSkuGaWbHWCiMGEnOf/N7n2WaURHFD+km7jeiUbWLN8kxXpExtb
         q01nNwGEbqernaZ5ItGYp+op0TQxFG1GI1rA+2F3rOso1WOEKgR6w1K7PJzDJ8Mf/qY0
         BSy0QGfqHzoEGmM6mo4U5hJPcVADq0Gvb+7wn/VWRFgUc5eb2TEHZoIXvfluoBQfBYGF
         le9NiDskqzG7ujQusPAppK99FxshHLI9m3JVw2w72SwM46i9pzZkpe37akrBETDIxH7M
         ONF4GH8J+dsP7A5n5IMkZhk44L6MW/9XRWZSxLEIUq7a+DDEYl9MVh1QwBJLMC+mGgCK
         UBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=e4ESlaeaOWB4SITOU7C7LFR2ZXRJ265Gjmf/Gjxj0o4=;
        b=enkBpKnbrGmlPh58fsPe4cQgUyo9EIixauCMFiKOZDUlSnbU6o+eH7RaFEcTEhfUaK
         O/oQmfJKmxBOwJ1ONSP94Ju7Q7SmjCX8CdTOvIV7FCaYAqJDlQQXVFjWWY6cU5qLfpJK
         FJ35YypIRHV7GAkcvBtkA1fGxzP0O5xP+w2Y7KxZ9aAQf5T95QOi7ZUMKLZxXGoFtWtr
         NC/1t9h8EWUUdolaKDmfhfKM5i+XBYscRFhJ6H2mlKIIbi6BrkhbGBiWdVianht/oH0j
         gLCRV99w6doKPBVMojYzXG+tzzFB1iphJvp/i93CNs01BPAJ7b62EfcvJFa9HtlGGjeH
         DV6g==
X-Gm-Message-State: ANhLgQ1IPGxkreNFZPyhDtnKaXa73PmFfQYNgrqDq60ykJPYpbOJ/Ws9
        y9Rq9rtNtQTAjxvTkUkoHUprXBO0XDg=
X-Google-Smtp-Source: ADFU+vu1rpz+O4aAMA1ecoul6YuTJ4HEOGhiM7E9b4jHGPqUiOYlkMDfHqLTrn1et8ZKGmekPNEN2Q==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr16188218qtq.262.1583784082479;
        Mon, 09 Mar 2020 13:01:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 17sm6041283qkm.105.2020.03.09.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:01:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2694740009; Mon,  9 Mar 2020 17:01:19 -0300 (-03)
Date:   Mon, 9 Mar 2020 17:01:18 -0300
To:     Dominik Czarnota <dominik.b.czarnota@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Keeping <john@metanate.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf map: Use strstarts() to look for Android libraries
Message-ID: <20200309200118.GH477@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I took your ok to use strstarts() as an Acked-by, ok?

If nobody have any other consideration I'll keep this in my private
perf/core branch for later submission,

- Arnaldo

commit 565cb8e4fb09ddee6e4d1e8112218a212c2ef54d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Mar 9 16:53:41 2020 -0300

    perf map: Use strstarts() to look for Android libraries
    
    And add the '/' to avoid looking at things like "/system/libsomething",
    when all we want to know if it is like "/system/lib/something", i.e. if
    it is in that system library dir.
    
    Using strstarts() avoids off-by-one errors like recently fixed in this
    file.
    
    Since this adds the '/' I separated this patch, another patch will make
    this consistent by removing other strncmp(str, prefix, manually
    calculated prefix length) usage.
    
    Reported-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
    Acked-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: Link: http://lore.kernel.org/lkml/CABEVAa0_q-uC0vrrqpkqRHy_9RLOSXOJxizMLm1n5faHRy2AeA@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b342f744b1fc..53d96611e6a6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -44,8 +44,8 @@ static inline int is_no_dso_memory(const char *filename)
 
 static inline int is_android_lib(const char *filename)
 {
-	return !strncmp(filename, "/data/app-lib", 13) ||
-	       !strncmp(filename, "/system/lib", 11);
+	return strstarts(filename, "/data/app-lib/") ||
+	       strstarts(filename, "/system/lib/");
 }
 
 static inline bool replace_android_lib(const char *filename, char *newfilename)
@@ -65,7 +65,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 	app_abi_length = strlen(app_abi);
 
-	if (!strncmp(filename, "/data/app-lib", 13)) {
+	if (strstarts(filename, "/data/app-lib/")) {
 		char *apk_path;
 
 		if (!app_abi_length)
@@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		return true;
 	}
 
-	if (!strncmp(filename, "/system/lib/", 12)) {
+	if (strstarts(filename, "/system/lib/")) {
 		char *ndk, *app;
 		const char *arch;
 		size_t ndk_length;
