Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05836C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85C1207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ExSMmNiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLRol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:44:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCCBC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:44:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so10363568ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=El2ZhOBNpOphhFc1XzfVOf5zdV0ZOf8ZqDSCzO0pdXQ=;
        b=ExSMmNiIU7w2dNRKqM6HiRU9brV5dI+iTGVf+mxt7q63rlToikgj3nMb1iq3YADJBF
         ev3ed8upaGQ+qe9wjcso2C9F45/3Ud5jGOhB8d1Zvs+Wj38uxrM0oQtF8lKK95/K5WGi
         81VPI2Bpm1n5W2VpKPUy+7srzOYLycHM1Rup4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=El2ZhOBNpOphhFc1XzfVOf5zdV0ZOf8ZqDSCzO0pdXQ=;
        b=kATwbaUCIk2p63ZXM5mtG5/9a88i2h3k4tjD8VNUkmn41N8ejeNIwretKuyFBgqfg4
         dPfHD0BcTwrIHcHjiWPv4ZPW71AvfReX3PFMt+RKWsp+MKjb8nDNHJbpnQQL8h1Ia4fd
         Zy2wqACDiEGdBr1PEvDv/8s0KYiNYmO5NAGO6ihzJN2NF18y60g05YMcVfzNTFKGyaGI
         LU4VcIQA2g9nFFJeD/ImDHw8rBLRi4l1HWiWOXrApFX/vmbXnJSWbO/gSCS2MZcBaRxb
         kfUvwcGsKbPlNOHslSgNxpyhcgSb4SsRy2Ai+vwMi7leYv7p6QpHtOSMgjbBECqXSbTr
         EGBA==
X-Gm-Message-State: AOAM530IonXKv8xSDOZdEft0P22i2GXz36cLjP3e5Umhtdic3F3Cut7v
        6xsbm8MdkfiEDqcZry8BBW6HoywCxqWQPg==
X-Google-Smtp-Source: ABdhPJxjGBObU+iuR5VFNURPaq/Kot+BO1JubX/YelHlAX2HwCoqdG4luT5UYW9Jpmd9kPxVsKQr+w==
X-Received: by 2002:a17:906:c952:: with SMTP id fw18mr13976047ejb.505.1591983878004;
        Fri, 12 Jun 2020 10:44:38 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:18e1])
        by smtp.gmail.com with ESMTPSA id d35sm3443742edc.40.2020.06.12.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:44:37 -0700 (PDT)
Date:   Fri, 12 Jun 2020 18:44:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [PATCH] mm, memcg: prevent missed memory.low load tears
Message-ID: <20200612174437.GA391453@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like one of these got missed when massaging in f86b810c2610 ("mm,
memcg: prevent memory.low load/store tearing") with other linux-mm
changes.

Reported-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b38b6ad547d..f7cc66a80348 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6416,7 +6416,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
-		memcg->memory.elow = memcg->memory.low;
+		memcg->memory.elow = READ_ONCE(memcg->memory.low);
 		goto out;
 	}
 
@@ -6428,7 +6428,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_min_usage)));
 
 	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
-			memcg->memory.low, READ_ONCE(parent->memory.elow),
+			READ_ONCE(memcg->memory.low),
+			READ_ONCE(parent->memory.elow),
 			atomic_long_read(&parent->memory.children_low_usage)));
 
 out:
-- 
2.27.0

