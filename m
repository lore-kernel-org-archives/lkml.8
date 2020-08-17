Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B429C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6711A20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689428;
	bh=tUg0ufDbgldg0Nz5MOqtxis8bznVshMzTik0MI4PymY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KlnDYlmEsqp2/G+wceJ9WDNVTjD6RJnIzJOrnhUsIPKDTwC/JG5nzlJTnFKyY8leW
	 QvkNwQ8mkAisityvJBKMeTyUaZyQy+enV+gzcdDheWwCVNfG9RvSqUZvQSl190DpbW
	 QKHazESQfdahaRL27PvhmXnd5UqhyYt3R/T2Xh28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391356AbgHQSgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730959AbgHQP7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D822072E;
        Mon, 17 Aug 2020 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679955;
        bh=tUg0ufDbgldg0Nz5MOqtxis8bznVshMzTik0MI4PymY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfYfYK7RVMS5Wx3VxIHPjs2saJ9bLeto3KaORrHcwd+1/Otgb6hpmUEJXOdoir4fe
         Ji9FvC72I3EMId/ZdcEKgiuMvZB2APxCTSPUixGXWvcHPrnOuoUtSYwvolb6nFk657
         sYRitSVFw77GlOwoncxlme4HYn6XXm1Xl9FKXq7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Andrew Lunn <andrew@lunn.ch>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.7 361/393] cpufreq: dt: fix oops on armada37xx
Date:   Mon, 17 Aug 2020 17:16:51 +0200
Message-Id: <20200817143837.113419999@linuxfoundation.org>
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

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

commit 10470dec3decaf5ed3c596f85debd7c42777ae12 upstream.

Commit 0c868627e617e43a295d8 (cpufreq: dt: Allow platform specific
intermediate callbacks) added two function pointers to the
struct cpufreq_dt_platform_data. However, armada37xx_cpufreq_driver_init()
has this struct (pdata) located on the stack and uses only "suspend"
and "resume" fields. So these newly added "get_intermediate" and
"target_intermediate" pointers are uninitialized and contain arbitrary
non-null values, causing all kinds of trouble.

For instance, here is an oops on espressobin after an attempt to change
the cpefreq governor:

[   29.174554] Unable to handle kernel execute from non-executable memory at virtual address ffff00003f87bdc0
...
[   29.269373] pc : 0xffff00003f87bdc0
[   29.272957] lr : __cpufreq_driver_target+0x138/0x580
...

Fixed by zeroing out pdata before use.

Cc: <stable@vger.kernel.org> # v5.7+
Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/armada-37xx-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -456,6 +456,7 @@ static int __init armada37xx_cpufreq_dri
 	/* Now that everything is setup, enable the DVFS at hardware level */
 	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
 
+	memset(&pdata, 0, sizeof(pdata));
 	pdata.suspend = armada37xx_cpufreq_suspend;
 	pdata.resume = armada37xx_cpufreq_resume;
 


