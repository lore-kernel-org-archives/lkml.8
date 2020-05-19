Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E45AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751212075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589871767;
	bh=e6I5AOn+MQNsuOpreKE6NJenPK7FVfv6kOvYka10ELY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=X/+T2rka9/GNDckaiBIiBWVT1p08If6paXpl8MasmKVYomeJD0nrkLL6d42oLxWXh
	 tNSbrtqB1n+Jh/NTVGcYofdlcxd3MqGTWdCe5bl9Yathv/odG/yjRer6EHlaF3Pamk
	 u6ixpu5PL/kvFdjf1GDlrEhYFRixUmutNlZtCHKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgESHCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgESHCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:02:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9D820758;
        Tue, 19 May 2020 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589871766;
        bh=e6I5AOn+MQNsuOpreKE6NJenPK7FVfv6kOvYka10ELY=;
        h=From:To:Cc:Subject:Date:From;
        b=awQZp2nd6CFA2Y0PZyd0ULpBlUuqnu7eK33JFfn9BtF78mF9rD+k32PIIcnwjmdsW
         t5QPJW4DEdCz2nIHkLQGAkmM0Ek6zPYdBZBWk3RY+KlTwOQqYewjMD8Rlkdvn+7O2H
         i3Ehoe90lgSpEMQLKm6mYgrTKpL06AX3n75V10Cg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [GIT PULL] pinctrl: samsung: Stuff for v5.8
Date:   Tue, 19 May 2020 09:02:40 +0200
Message-Id: <20200519070240.6510-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Minor updates for Samsung pinctrl drivers.

Best regards,
Krzysztof


The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-5.8

for you to fetch changes up to f354157a7d184db430c1a564c506434e33b1bec5:

  pinctrl: samsung: Save/restore eint_mask over suspend for EINT_TYPE GPIOs (2020-04-28 11:38:11 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v5.8

Two fixes for S5Pv210 pinctrl driver: setting proper external interrupt
wakeup mask and restoring external interrupt mask value after system
suspend.

----------------------------------------------------------------
Jonathan Bakker (2):
      pinctrl: samsung: Correct setting of eint wakeup mask on s5pv210
      pinctrl: samsung: Save/restore eint_mask over suspend for EINT_TYPE GPIOs

 drivers/pinctrl/samsung/pinctrl-exynos.c | 82 ++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 24 deletions(-)
