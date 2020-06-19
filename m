Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3715E2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580666;
	bh=D4A67mbrWqK5bcyd2xtaSN2eqdhN9WQjyd9DakMMtOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JW4C8Js/LTY+mjdVRTITHIaRuhrwUf/YSe+RmeGB8XAb9Saa9NoFYPzL+e6cgo5bC
	 rI0Sdd/Mp8AYunFp3PdS+ltKw2kRlkyqzkFzI3LPhIF2rohBr+TRM3zEpleAAAixNY
	 24a3SZKRpAkWSvUkZbtrT40IpfxoOClX0F+BZN9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393772AbgFSPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393758AbgFSPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7674206B7;
        Fri, 19 Jun 2020 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580656;
        bh=D4A67mbrWqK5bcyd2xtaSN2eqdhN9WQjyd9DakMMtOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJjPvH3KhiPe6K0gDfT4SHgKtsbSqXcrAZX+c92fOV9ZYdcf0yngGYwO2wxoIJrEf
         +ZM3tkEQh137DjjyugNs6AnwxF251VeU8r2PQFGm4RlT3aVako3vlFFfp7SUG06UuS
         hSK14QyG7N2BF7uOoKpEU0ImWHDP8ZoyeoCUxB2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.7 332/376] soc/tegra: pmc: Select GENERIC_PINCONF
Date:   Fri, 19 Jun 2020 16:34:10 +0200
Message-Id: <20200619141726.047887372@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

commit 5098e2b95e8e6f56266c2d5c180c75917090082a upstream.

I have hit the following build error:
armv7a-hardfloat-linux-gnueabi-ld: drivers/soc/tegra/pmc.o: in function `pinconf_generic_dt_node_to_map_pin':
pmc.c:(.text+0x500): undefined reference to `pinconf_generic_dt_node_to_map'
armv7a-hardfloat-linux-gnueabi-ld: drivers/soc/tegra/pmc.o:(.rodata+0x1f88): undefined reference to `pinconf_generic_dt_free_map'

So SOC_TEGRA_PMC should select GENERIC_PINCONF.

Fixes: 4a37f11c8f57 ("soc/tegra: pmc: Implement pad configuration via pinctrl")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/tegra/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -133,6 +133,7 @@ config SOC_TEGRA_FLOWCTRL
 
 config SOC_TEGRA_PMC
 	bool
+	select GENERIC_PINCONF
 
 config SOC_TEGRA_POWERGATE_BPMP
 	def_bool y


