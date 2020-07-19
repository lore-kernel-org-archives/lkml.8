Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3055C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E77620809
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a4lS0k+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGSSJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGSSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:09:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6FBC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=G2g4Ceb7iWRskTszXh5u/2+ZaJlCDCsfgNYhSicznHw=; b=a4lS0k+GTcKGcQ0AilLiU1+vgJ
        q8FcMUxsztwUZTY6eoNtCDa18NjmGUf/a4dzysFju4jYG2WcOlyX/qCyRG7yN2mdkLRb7hjh3sWSe
        hHW8fToSdOkM3hq/0eLPc7hzbGC2KTzTFaNcuzqVoq0CH7JkkQ8mxv8Q1WtLH+Qmqfp3ZdOoNLaZ8
        RqGiokGkt8Ct5lhlPKXZIdWcl8oStBvMkb+c975sDsSeDFlJuRCiw2xgEzq9ZdxcVFxKY/wmU3qby
        uR5TRaB9ZOtF5Bpk8GVNy/G3k99yftRmtaLQFwdpQB9ioTe3WOhEJds4hTLOrgsuxC/iaVIFejJyv
        eiPmWF6Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxDkS-0006EF-P7; Sun, 19 Jul 2020 18:09:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Warren <swarren@nvidia.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: tegra20_das.h: delete duplicated words
Date:   Sun, 19 Jul 2020 11:09:12 -0700
Message-Id: <20200719180912.30770-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the doubled word "to" in two comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/tegra/tegra20_das.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/sound/soc/tegra/tegra20_das.h
+++ linux-next-20200717/sound/soc/tegra/tegra20_das.h
@@ -91,14 +91,14 @@ struct tegra20_das {
  */
 
 /*
- * Connect a DAP to to a DAC
+ * Connect a DAP to a DAC
  * dap_id: DAP to connect: TEGRA20_DAS_DAP_ID_*
  * dac_sel: DAC to connect to: TEGRA20_DAS_DAP_SEL_DAC*
  */
 extern int tegra20_das_connect_dap_to_dac(int dap_id, int dac_sel);
 
 /*
- * Connect a DAP to to another DAP
+ * Connect a DAP to another DAP
  * dap_id: DAP to connect: TEGRA20_DAS_DAP_ID_*
  * other_dap_sel: DAP to connect to: TEGRA20_DAS_DAP_SEL_DAP*
  * master: Is this DAP the master (1) or slave (0)
