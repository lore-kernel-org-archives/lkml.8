Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF234C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45A6204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689637;
	bh=9Bt/jyalB6XYEU9dIuPeyUuO68Bq5uKPaF58m0/gacI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5reF9/DBiL3U6I+56rB1zFM/OU+QcMcgECBC+ZFMPm4U/9yHWz+XXz5IWY5YAkoU
	 D37c/wnTcIb6Jx8+XJP+6VIpLaItKT0dEMokd87iRK/62MUcq4DkWBZ7H+wim6wtxK
	 0gJODREjri0f/xr1zu9utO+y8Jgt/e3PvbLAcvdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbgHQSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbgHQP5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:57:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7F12072E;
        Mon, 17 Aug 2020 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679873;
        bh=9Bt/jyalB6XYEU9dIuPeyUuO68Bq5uKPaF58m0/gacI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsdbF4slcPF0e0MDEwGa1Lbfk7HXjz3yVPFIwkX6tcYiYzHWb93kEYK/5KXeQ27/2
         t9Oow1rdNLYJArxsEp/Yg9V8Nq7da86YShu2q0E4JDtau42kZkHeNpuVT+o9kMGIoH
         F0NLGX1vAa/WebuuFUgBUiClz1w49heqFSTe4UjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5.7 364/393] PM / devfreq: Fix indentaion of devfreq_summary debugfs node
Date:   Mon, 17 Aug 2020 17:16:54 +0200
Message-Id: <20200817143837.259199159@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsung.com>

commit 0aae11bcdefb4894b6100656ad24cbd85ff34b52 upstream.

The commit 66d0e797bf09 ("Revert "PM / devfreq: Modify the device name
as devfreq(X) for sysfs"") roll back the device name from 'devfreqX'
to device name explained in DT. After applied commit 66d0e797bf09,
the indentation of devfreq_summary debugfs node was broken.

So, fix indentaion of devfreq_summary debugfs node as following:

For example on Exynos5422-based Odroid-XU3 board,
$ cat /sys/kernel/debug/devfreq/devfreq_summary
dev                            parent_dev                     governor        polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
------------------------------ ------------------------------ --------------- ---------- ------------ ------------ ------------
10c20000.memory-controller     null                           simple_ondemand          0    413000000    165000000    825000000
soc:bus_wcore                  null                           simple_ondemand         50     88700000     88700000    532000000
soc:bus_noc                    soc:bus_wcore                  passive                  0     66600000     66600000    111000000
soc:bus_fsys_apb               soc:bus_wcore                  passive                  0    111000000    111000000    222000000
soc:bus_fsys                   soc:bus_wcore                  passive                  0     75000000     75000000    200000000
soc:bus_fsys2                  soc:bus_wcore                  passive                  0     75000000     75000000    200000000
soc:bus_mfc                    soc:bus_wcore                  passive                  0     83250000     83250000    333000000
soc:bus_gen                    soc:bus_wcore                  passive                  0     88700000     88700000    266000000
soc:bus_peri                   soc:bus_wcore                  passive                  0     66600000     66600000     66600000
soc:bus_g2d                    soc:bus_wcore                  passive                  0     83250000     83250000    333000000
soc:bus_g2d_acp                soc:bus_wcore                  passive                  0            0     66500000    266000000
soc:bus_jpeg                   soc:bus_wcore                  passive                  0            0     75000000    300000000
soc:bus_jpeg_apb               soc:bus_wcore                  passive                  0            0     83250000    166500000
soc:bus_disp1_fimd             soc:bus_wcore                  passive                  0            0    120000000    200000000
soc:bus_disp1                  soc:bus_wcore                  passive                  0            0    120000000    300000000
soc:bus_gscl_scaler            soc:bus_wcore                  passive                  0            0    150000000    300000000
soc:bus_mscl                   soc:bus_wcore                  passive                  0            0     84000000    666000000

Cc: stable@vger.kernel.org
Fixes: 66d0e797bf09 ("Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1660,8 +1660,7 @@ static int devfreq_summary_show(struct s
 	unsigned long cur_freq, min_freq, max_freq;
 	unsigned int polling_ms;
 
-	seq_printf(s, "%-30s %-10s %-10s %-15s %10s %12s %12s %12s\n",
-			"dev_name",
+	seq_printf(s, "%-30s %-30s %-15s %10s %12s %12s %12s\n",
 			"dev",
 			"parent_dev",
 			"governor",
@@ -1669,10 +1668,9 @@ static int devfreq_summary_show(struct s
 			"cur_freq_Hz",
 			"min_freq_Hz",
 			"max_freq_Hz");
-	seq_printf(s, "%30s %10s %10s %15s %10s %12s %12s %12s\n",
+	seq_printf(s, "%30s %30s %15s %10s %12s %12s %12s\n",
+			"------------------------------",
 			"------------------------------",
-			"----------",
-			"----------",
 			"---------------",
 			"----------",
 			"------------",
@@ -1701,8 +1699,7 @@ static int devfreq_summary_show(struct s
 		mutex_unlock(&devfreq->lock);
 
 		seq_printf(s,
-			"%-30s %-10s %-10s %-15s %10d %12ld %12ld %12ld\n",
-			dev_name(devfreq->dev.parent),
+			"%-30s %-30s %-15s %10d %12ld %12ld %12ld\n",
 			dev_name(&devfreq->dev),
 			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
 			devfreq->governor_name,


