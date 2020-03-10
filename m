Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1CDC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116A920873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846150;
	bh=llynbQKbK6n+wI4aDXwNHYl+NblAb+NHlVsftpKe+UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yLPAkc7HG1x0jCpr4m3eUgBfcV0W9rv+bpnVkvH8P56ew3FZgwL2ROp9ridz7TsMs
	 v7J+cYHhLPoM2KazcE6wRV2F9AiBDFIhl+PzTZV1lC6MAvnYN3KbQAtIxyNgzqCPk6
	 s5NcTOycByoXKMuSbXqWP16vD41FeKcHYa1Ugwlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgCJNOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbgCJNOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:14:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E45208E4;
        Tue, 10 Mar 2020 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846077;
        bh=llynbQKbK6n+wI4aDXwNHYl+NblAb+NHlVsftpKe+UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3lwFSP06ZQZtzisUHqTH66ft5oBsmn4HCLdcXGFN1UUqaQfPn34o/SFMu85Hyoat
         O+ZdCl1KxgKfYygymwNKBsK2puy4eaUUtx7rfLPEIKZIrcBn8OC6rEuJQ14Y4IQxd/
         Sj2hVLH7VMpdQsAlUQoSh6c+dUMZENqEHhOFWZ20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.19 79/86] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
Date:   Tue, 10 Mar 2020 13:45:43 +0100
Message-Id: <20200310124535.023776273@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

commit 2773fe1d31c42ffae2a9cb9a6055d99dd86e2fee upstream.

SD/MMC on Colibri iMX7S/D modules successfully support
200Mhz frequency in HS200 mode.

Removing the unnecessary max-frequency limit significantly
increases the performance:

== before fix ====
root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
/dev/mmcblk0:
 Timing buffered disk reads: 252 MB in  3.02 seconds =  83.54 MB/sec
==================

=== after fix ====
root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
/dev/mmcblk0:
 Timing buffered disk reads: 408 MB in  3.00 seconds = 135.94 MB/sec
==================

Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx7-colibri.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -319,7 +319,6 @@
 	assigned-clock-rates = <400000000>;
 	bus-width = <8>;
 	fsl,tuning-step = <2>;
-	max-frequency = <100000000>;
 	vmmc-supply = <&reg_module_3v3>;
 	vqmmc-supply = <&reg_DCDC3>;
 	non-removable;


