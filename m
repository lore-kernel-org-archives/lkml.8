Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F05207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnVRPOke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgFIPJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:09:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49244C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:09:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n23so10400883pgb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RmHUFo+IZkEW1sUj7r2fp4n5hZbj7/qoM8mQ5oWjeho=;
        b=dnVRPOkeeIPU+OwHsVRLNvXWTSyrgQJxnAlVIn3nwK+bO08QVI2WWuevIzacF8/+Bp
         9ljmJu/cZC1gmkio8bpDMxwjzaKyyTskQQfjvqBhBnuR+KA8KZHMfeXLxLZsNnxKx/yj
         g95/HA2YHPjg2wzD2QQBkhoKtx6TWO8KQSg+Lv8vrmu2ViCY2SraCLu66scPJ22ip9Ha
         x4gpJ2cG83+s40fWkPdAj289N75W7cnu59I0zSZBeuIPQgcYuJtvnGMI7+jiRReqba0D
         xdXrhPUD6X+CYsGi6QBOE59swhoUOC/fc3PyQFfPQTbR0E7ahUYyhjmOa6IJbWcQyrOm
         t27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RmHUFo+IZkEW1sUj7r2fp4n5hZbj7/qoM8mQ5oWjeho=;
        b=XFpy7q4IjYMgwp0qCOsqEz+62dJ9VVKlKP4W2er5Lf99O0sDbVICLJIIoi+IFIPYba
         wSvP79tr1d6T3tnFSPDn2IZp3L6Pc6VWyFZXyV+2hDAaKzwQXzUdbN7wyPbImO41ovrI
         DuIowluKYY6+AjXl/v8ClxvNIcM+kj9qmGBGF2xMiPhnJArGWBMll72qBVpJEa5ZOSEI
         wbJmyiP63McddLHDsZCyN+79nMipabpKx2wc+jtYkuMCnP0LwThr6jKX75liTylc06Vs
         gI/tXXD5s+1io/4tMpTJMzd9m/P5NEDspQWWFW2Je6TSWP4DTUhKKHfnniJ6ANRgaIQ4
         1K4A==
X-Gm-Message-State: AOAM533RL0PE/evTE8HWwxBXicK/xgBipcj9sVknijmi8dgZF6mfLox6
        UffmDdu+Q2SjTzLeXfrmNsQ=
X-Google-Smtp-Source: ABdhPJzzerH9KqpML1As76cOZ8J8OBLMC+QEQwc+E37yjOOpWVRag5R0VqGwTtrWsJz1cGxsyYagEw==
X-Received: by 2002:a65:614b:: with SMTP id o11mr24480145pgv.443.1591715380851;
        Tue, 09 Jun 2020 08:09:40 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id n1sm2931438pjn.24.2020.06.09.08.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jun 2020 08:09:40 -0700 (PDT)
Date:   Tue, 9 Jun 2020 23:09:36 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Cc:     iwtbavbm@gmail.com
Subject: [PATCH] sched: correct SD_flags returned by tl->sd_flags()
Message-ID: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During sched domain init, we check whether non-topological SD_flags are
returned by tl->sd_flags(), if found, fire a waning and correct the
violation, but the code failed to correct the violation. Correct this.

Fixes: 143e1e28cb40 ("sched: Rework sched_domain topology definition")
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ba81187bb7af..9079d865a935 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1328,7 +1328,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd_flags = (*tl->sd_flags)();
 	if (WARN_ONCE(sd_flags & ~TOPOLOGY_SD_FLAGS,
 			"wrong sd_flags in topology description\n"))
-		sd_flags &= ~TOPOLOGY_SD_FLAGS;
+		sd_flags &= TOPOLOGY_SD_FLAGS;
 
 	/* Apply detected topology flags */
 	sd_flags |= dflags;
-- 
2.20.1

