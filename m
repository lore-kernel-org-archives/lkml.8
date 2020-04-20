Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F19C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54DF206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387014;
	bh=fhMCzs+5oAeNDilCXNjN57Y84x/pplV7/I0kKxgTNjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pNLdVe/NS1iCPmqCoce2y9gfFSfxcCmkD+qigFfPH/7EnHg2j5UhXjhnoFtcgNYnD
	 QWvyx6wXnAX4LQ8IfrnHIIIQWoao4ErGPLqCIL3UGZxdXQeJC0I32PTyVSqg3CMwiP
	 4WM3BvEGs5szIOgxq5fNi8NGihLwqQmQJqW2UuSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgDTMuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgDTMth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:49:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A614720735;
        Mon, 20 Apr 2020 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386977;
        bh=fhMCzs+5oAeNDilCXNjN57Y84x/pplV7/I0kKxgTNjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOZSa0T3YmSy5xosrJL/HiCYa4N6Bm7pwm8fgu9rwcb1yLt6ehfuqLA3NBVT0bsVf
         7xo0ypnjarUwlmZDLyUJi/G2EyXPejPDDBUPf+CkiAOUjk6ON7x++qVR7ZTiNT8tj9
         TTsY14fkXVihcm7R/MjgzJ37TPtZ5OWioupD+eV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 16/40] ASoC: Intel: mrfld: return error codes when an error occurs
Date:   Mon, 20 Apr 2020 14:39:26 +0200
Message-Id: <20200420121458.268430959@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 3025571edd9df653e1ad649f0638368a39d1bbb5 upstream.

Currently function sst_platform_get_resources always returns zero and
error return codes set by the function are never returned. Fix this
by returning the error return code in variable ret rather than the
hard coded zero.

Addresses-Coverity: ("Unused value")
Fixes: f533a035e4da ("ASoC: Intel: mrfld - create separate module for pci part")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200208220720.36657-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/atom/sst/sst_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -107,7 +107,7 @@ static int sst_platform_get_resources(st
 	dev_dbg(ctx->dev, "DRAM Ptr %p\n", ctx->dram);
 do_release_regions:
 	pci_release_regions(pci);
-	return 0;
+	return ret;
 }
 
 /*


