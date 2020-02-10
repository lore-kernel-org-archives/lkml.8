Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D377C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EDE2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338924;
	bh=dADVztZeb6G9viFvzKw+h3k0rY7ip4xnuV6dfLYV7rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cNKueKvfacP9hfYQzHdhRraZzNfmpWu2eWwtI3P2bTfJimsKO4U5oyc7BTQ9fo5p3
	 zy6t/oJc7K5Vr3ED//YaSTHVFAwLyIgCdzLyjm/r8UnikkyN1R2F1SBzh4Hew/cOue
	 KsKi0UnmphMMarscxGmHuL768PJEwh5ZXoNVq8Sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgBJMql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBJMlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:46 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E15921569;
        Mon, 10 Feb 2020 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338506;
        bh=dADVztZeb6G9viFvzKw+h3k0rY7ip4xnuV6dfLYV7rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKO1JyDHT7P0za7AX9yRn3shCCzucJN2CbHDXI9gd1L8ioRCmENLPKE8ooN68zuNu
         7uyA65Hbw8+0Qpmf0S/MOtVkKtKPVgEt2p0wSbFxouZuXaC0b4/jtNRNXYYKoWRONC
         718XN1rK8ocEo2UDsyLZPpdLXw1EiAMVwvrM932c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH 5.5 307/367] ASoC: sgtl5000: Fix VDDA and VDDIO comparison
Date:   Mon, 10 Feb 2020 04:33:40 -0800
Message-Id: <20200210122451.742375489@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

commit e19ecbf105b236a6334fab64d8fd5437b12ee019 upstream.

Comparing the voltage of VDDA and VDDIO to determine whether or not to
enable VDDC manual override is insufficient. This is a problem in case
the VDDA is supplied from different regulator than VDDIO, while both
report the same voltage to the regulator framework. In that case where
VDDA and VDDIO is supplied by different regulators, the VDDC manual
override must not be applied.

Fixes: b6319b061ba2 ("ASoC: sgtl5000: Fix charge pump source assignment")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Link: https://lore.kernel.org/r/20191220164450.1395038-2-marex@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/sgtl5000.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1344,7 +1344,8 @@ static int sgtl5000_set_power_regs(struc
 		 * if vddio == vdda the source of charge pump should be
 		 * assigned manually to VDDIO
 		 */
-		if (vddio == vdda) {
+		if (regulator_is_equal(sgtl5000->supplies[VDDA].consumer,
+				       sgtl5000->supplies[VDDIO].consumer)) {
 			lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
 			lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
 				    SGTL5000_VDDC_MAN_ASSN_SHIFT;


