Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA9C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0A52071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846885;
	bh=r066dt6Ij9pfjakkwrpGOU10oacfiQWN2fwGMx1QBds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zQxHTpxls1G0KyLZ9SLukVZKqiUBhzbnUu2AwloFJajnJblZ3JZNXehNp6d0ndR8i
	 flq7s/m2IzVF8hlvSqu8HQJQDh9rpUL8KcnwKTk6n95KGSDCKFax1GfcFrSDYrvlnw
	 Gju7Wdy96LsybsaYaPtVJHtxhw+osdqkQG7rtqg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgCJN2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgCJMxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B7820674;
        Tue, 10 Mar 2020 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844811;
        bh=r066dt6Ij9pfjakkwrpGOU10oacfiQWN2fwGMx1QBds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuQKD+h30ByQ6uUwpEj34Fay/XtZ12OTBgOVqWbLntr9prB0fvxctyCBT0JDteHjV
         bi1l/HR7rMo85f94dlkDcyAfwkClll1gYbDukv+wfIo6VIzLtUbER8RWACtbShxCY7
         RJF1BlCz4xgURXZc/eH/kWmyk+skvclr5kXrQndc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 127/168] ASoC: Intel: Skylake: Fix available clock counter incrementation
Date:   Tue, 10 Mar 2020 13:39:33 +0100
Message-Id: <20200310123648.318361685@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

commit 8308a09e87d2cb51adb186dc7d5a5c1913fb0758 upstream.

Incrementation of avail_clk_cnt was incorrectly moved to error path. Put
it back to success path.

Fixes: 6ee927f2f01466 ('ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev')
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200224125202.13784-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-ssp-clk.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -384,9 +384,11 @@ static int skl_clk_dev_probe(struct plat
 				&clks[i], clk_pdata, i);
 
 		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
-			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
+			ret = PTR_ERR(data->clk[data->avail_clk_cnt]);
 			goto err_unreg_skl_clk;
 		}
+
+		data->avail_clk_cnt++;
 	}
 
 	platform_set_drvdata(pdev, data);


