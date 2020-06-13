Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B301C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782E02074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7hQMTvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgFMP7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgFMP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3299EC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:23 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n70so9765449ota.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2waM161DAKaaC/jJszWFJ4b/dfYZwxUtS6N+459tvyI=;
        b=H7hQMTvJ9EcP8KXtg8ZFZi8Q88kyHdEZ7ZeGZmGZoi7VnMJE8YXRG3chVPwzF+Ivks
         t2mTOHb9sg1bqMFQCjhHFTjpt+IDpuwYFDhak2jPU6xvzbiWXM6jlF99Omlzu399MdjO
         ase4dp3pvBgcTmtIEF0qOdTmJr9Yjf2NHdqLoa+xhupxVxYLaR2nEG6QLw92eZNWfr19
         6R+owfvTWO3wBd3jip+qhT38a32FAXyPiiHntA+1sN93CHjwVKdWgkJk0EDkWcsztMXK
         ycvQFMniGigyxeoCXy+uMPtpKANZ2M9KvO1F79PrNMTRxGySV1HuAraHZ8kMrQ9vkJp3
         ywsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2waM161DAKaaC/jJszWFJ4b/dfYZwxUtS6N+459tvyI=;
        b=Dph/kidGRVeR6fWBpdBuJmRHkuugEeJH1WSAfUgWYtZ9kfPOB9Afd1p3hwMusdozkF
         4iEQRrPKu5FAN5CcEuPLDR2UJFJyJuibJ06+43ZhK68eqAAWadlELlfqxdMM0f1q+swg
         r7It16Xgoo8HbN439ulYT5SmKJ5FAJ7bZCmJoeXbK4l+aI+78r/H9utkEHyW7sEvPljP
         nqeKY3oSZhmPxsa5gptB+3lhGMmbC4R4rdwKZ+UvchoAhLZ5gY3RQLK7FSh+UFk3oA4M
         aRmvdpoib+lGBH2spBQHLZt8g5ECYcDDNrzaNZLKOEzDAWn2rPiNMgXIeCuSUAVNLdUQ
         ZfTw==
X-Gm-Message-State: AOAM532YKb2SCkxC4VIUouDTR26876sdFASm0mCVSrFw9T6+Sy+85KfP
        P4uVwxMMCCF3KrvulKMgMa67xsb6Xwo=
X-Google-Smtp-Source: ABdhPJwHt4So/uJ7GShZE7h9/MYPSLGVtdUPE2jbQncDRTkyGVvofnyDI2JaH3bCWKf4I7OFPjbk4A==
X-Received: by 2002:a9d:6ad9:: with SMTP id m25mr15786524otq.206.1592063902597;
        Sat, 13 Jun 2020 08:58:22 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 16/24] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Sat, 13 Jun 2020 09:57:30 -0600
Message-Id: <20200613155738.2249399-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop memset in ddebug_parse_query, instead initialize the stack
variable in the caller; let the compiler decide how to do it.
---
 lib/dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 40436270d38a..b3c262c009d2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -373,7 +373,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		pr_err("expecting pairs of match-spec <value>\n");
 		return -EINVAL;
 	}
-	memset(query, 0, sizeof(*query));
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
@@ -494,7 +493,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
 	struct flagsettings filter = {};
-	struct ddebug_query query;
+	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
-- 
2.26.2

