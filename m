Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFCC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896D520708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339450;
	bh=dADVztZeb6G9viFvzKw+h3k0rY7ip4xnuV6dfLYV7rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjWWPemUuP5zyO8H/sDKm1d2OhmgFjpP6nYFxpuCt32K1Qg6q4Mt5lCblcMbs14SE
	 Lj5Xgi6ZDOOtoQ1OXa1QuHEPqSH9kABbtVpo//sisgCkUIw0e+NAx0H1ymOREAzM3P
	 EphjhF7T0Gu7WoVSeHjSBo8wDcPDGloyQa5rksKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgBJMl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbgBJMir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:47 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9317C24676;
        Mon, 10 Feb 2020 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338326;
        bh=dADVztZeb6G9viFvzKw+h3k0rY7ip4xnuV6dfLYV7rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrVNbhWMO5/a/+fTd834LeCQog8COnLWQpfH3FwrpY0XHMZKeyCjvydWaobDgxQ79
         yBZFAWPv2NDzVSmSZRXPS2LJlkzK2VrR3RE4bkBMmaVSNOS5MDOCFJgqYOjYh22oha
         Pm0S2JNtqg15ZmWBFANdLtRpYJwwBJfJc/FjPGfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH 5.4 262/309] ASoC: sgtl5000: Fix VDDA and VDDIO comparison
Date:   Mon, 10 Feb 2020 04:33:38 -0800
Message-Id: <20200210122431.838244642@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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


