Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B390C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FFA2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc85tChe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbgEZKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388501AbgEZKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:53:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB27C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:53:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so19982914wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/X/VgnyC3HIoMTaZFKxWYG40oheShX3/ZPr18h9D1M=;
        b=Vc85tChelfWUsKYMlUXXJcIclXD0SP+4qTCuB01m0OhuQfmU2v6Bd/7wuJ4+QxQrDN
         LL/niYIf1u7fr6T/lrMq34JSdwSs6VTM5xv8iEYFVPXekiTGHgPhMSo6EJZA2RhbPCFl
         BTrtO355Exs9Hoit8jHxYHV2uC3Vht4nV4IQunmwreoSVRxObXqDx4VulGWdEuRDt1n7
         neDcSdcv4kF/mqfPa4MfFVBZl5QZMltFRTaBEsdiIsk7v1GMCAV+6yr6yl08eRLcduH+
         rSN4NMxt4yfbgMFFevBFKVCIfD/CIpBp9xZZl2mLsPaTkPrbSXGf7Al0d9g2hU8PY57P
         zUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/X/VgnyC3HIoMTaZFKxWYG40oheShX3/ZPr18h9D1M=;
        b=irUrUvmV22AZCOsMphOMoNOmzMiW5E9L0nA7QizqWpIxTbDYnRI8wUIuOXYMhnAMUo
         uwuWBdhjK+zpTXcrkEKS29lnF0OJaR8mxHIizlwcerOqZ14utDAhfdo6EjVlNObqoCZO
         sc1Mn7XHGoBtUz6PtuVSJh7PAy0T7coD+GRzvSuDkJxSE/8bSDtbvF/MC+pRehm0qL9s
         m/SI+V8Kw52m/ALg2icv7sxrXw6e3FFNS7tiYFhY2sAaeHl2l1LavtaJipAbTyxzlX1G
         ouuSzfbNOnLP7PvPBG/qlLfQ8ANvy8HMQ4Eme3Mq8z5NNlRinUoSH4ebwU5g42BHsqf7
         loLg==
X-Gm-Message-State: AOAM531UCgFhnAO57TdWydyPLNhox1Z/1DpgodtE9OiOgXBGUAqw2fEX
        /IVhp2PVS8iVLN2u/urAulJv1g==
X-Google-Smtp-Source: ABdhPJyE4hdLBk98AqoF2vCujR8GjEG4YMHN12wrAaGuVW8KY7u4Cd1xS3+zTBdkQXJvLUOxIgksoA==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr6638631wrq.151.1590490395069;
        Tue, 26 May 2020 03:53:15 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:8bee:312:6092:58f2])
        by smtp.gmail.com with ESMTPSA id s7sm7244395wrr.60.2020.05.26.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 03:53:14 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, acme@kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 1/1] perf: cs-etm: Allow no CoreSight sink to be specified on command line
Date:   Tue, 26 May 2020 11:53:10 +0100
Message-Id: <20200526105310.9706-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526105310.9706-1-mike.leach@linaro.org>
References: <20200526105310.9706-1-mike.leach@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the handling of the session sink selection to allow no sink to
be selected on the command line. This then forwards the sink selection to
the CoreSight infrastructure which will attempt to select a sink based
on the default sink select priorities.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 941f814820b8..ed9ea2c60f27 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -242,10 +242,10 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 	}
 
 	/*
-	 * No sink was provided on the command line - for _now_ treat
-	 * this as an error.
+	 * No sink was provided on the command line - allow the CoreSight
+	 * system to look for a default
 	 */
-	return ret;
+	return 0;
 }
 
 static int cs_etm_recording_options(struct auxtrace_record *itr,
-- 
2.17.1

