Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA732166E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmiyDdp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgDXUCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbgDXUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:01:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840CC09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x26so5115365pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eewTcbuSLQRCFeSiAoYYX0+XB7BDJvlp2EU0H6eGjY4=;
        b=HmiyDdp1jKoJRJ08HAwnGFrLp2BqyTXeVlxNgf+lTmmyTS8yOuVzEJl6XmSBvWkAS/
         v/JwQlGdlmMeH1Xd2BZ21I5FEC/BV6wHAGRCVgAcB1lwzZxKnZIpNlLZKOWVsyGJbyoC
         KtPcO3HbrrJWEEOr6guTSb+qPCw8jozVoSA/MrrMeuM6iNlHvF1jx3hXzlHEcdZn6hpj
         5NatL9qSFglUvtASP78GysB2bsqBosJIQfd3d0g1fkisR7rgNut1AfGdF+fffrUNEz71
         r6AvQvD/tP1ZkkRjfAX8kAyamS0lQCLChUKc9kr/vLDxhkPNWR10WS1BDEXYXm6d3zVP
         kBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eewTcbuSLQRCFeSiAoYYX0+XB7BDJvlp2EU0H6eGjY4=;
        b=QocOdB45auanzw3Nltv4SMpCv+kgDIwAp78WnShARtqKW62L2dvkkJSgOOo4QWSOPQ
         Ckv8Bxihz7aUCsQI9WYlbW0Yz+bG8avX6MINWwfs/3W/7BXHd2NWjEoRjHu1nQHNYwFC
         2tgGwgu07kx94nZtyBFSOoDUEXZwHtkmIA6xYyP/TqZ2rkqMOj5kwsrsVcMZncy31Eqq
         4t4LmhNKWRlhNhEwiL9wLR2cikHrcrQLg8RpjmC+K6mljCqsb8OU1klaTog944LXxh8K
         5IfP9y4KloGQci21uAnE5x4w71OkZJnrS3GsQNjiWKKw0s1MKBcrx72udDcgWitOVN0u
         Ebog==
X-Gm-Message-State: AGi0PuZGt8IpHRPpbB5ZPFG82tNdSqjN6h57KXVhy+d5zIN3Edx78B0X
        hcjW9M4gbzWVcYijpAZOr8j5Vg==
X-Google-Smtp-Source: APiQypKrHJCG5PxycsdeNY28g4yilDbLzXrizVM7n33WA5yRahh5tr3biAmtw3GGMoaVwRFNakd1jA==
X-Received: by 2002:a62:2b06:: with SMTP id r6mr11126923pfr.249.1587758515825;
        Fri, 24 Apr 2020 13:01:55 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o11sm5532224pgd.58.2020.04.24.13.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:01:55 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] remoteproc: Expose synchronisation flags via debugfs
Date:   Fri, 24 Apr 2020 14:01:35 -0600
Message-Id: <20200424200135.28825-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424200135.28825-1-mathieu.poirier@linaro.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs entry that reflects the value of the current
synchronisation flags used by the remoteproc core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 732770e92b99..3dde24e62cd8 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -291,6 +291,25 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(rproc_carveouts);
 
+ /* Expose synchronisation states via debugfs */
+static int rproc_sync_flags_show(struct seq_file *seq, void *p)
+{
+	struct rproc *rproc = seq->private;
+
+	seq_printf(seq, "Sync with rproc: %s\n",
+		   rproc->sync_with_rproc ? "true" : "false");
+	seq_printf(seq, "On init: %s\n",
+		   rproc->sync_flags.on_init ? "true" : "false");
+	seq_printf(seq, "After stop: %s\n",
+		   rproc->sync_flags.after_stop ? "true" : "false");
+	seq_printf(seq, "After crash: %s\n",
+		   rproc->sync_flags.after_crash ? "true" : "false");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(rproc_sync_flags);
+
 void rproc_remove_trace_file(struct dentry *tfile)
 {
 	debugfs_remove(tfile);
@@ -337,6 +356,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
 			    rproc, &rproc_rsc_table_fops);
 	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
 			    rproc, &rproc_carveouts_fops);
+	debugfs_create_file("sync_flags", 0400, rproc->dbg_dir,
+			    rproc, &rproc_sync_flags_fops);
 }
 
 void __init rproc_init_debugfs(void)
-- 
2.20.1

