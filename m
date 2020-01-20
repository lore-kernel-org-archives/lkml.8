Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF632C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911C424655
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579543355;
	bh=5g+nhNLBu3QaKcp7T3GYytUhOVrS04sl1IWrP+4wSqk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Hk6sezqOPBCFf+9LDsrMWQmJ0WJ1QNYWzseFojtUGzA1kEcwHuTU6WR2hDPm3kBY9
	 qvq7qMsR+WFV9LPNs6iia3IF0agpWILZ6c640HJZbzrH3HDZE3OugEB61bLvX23TYF
	 JOX183CupOv7xs9hyy718qm8/xOIY4bNg+bK9lFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgATSCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATSCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:02:34 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFE522314;
        Mon, 20 Jan 2020 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579543354;
        bh=5g+nhNLBu3QaKcp7T3GYytUhOVrS04sl1IWrP+4wSqk=;
        h=From:To:Cc:Subject:Date:From;
        b=r2hEtFLB/hocwTKWiMWXITcsdVBrZg7eEOoxP3U3OvU4tVMZVxa/qtumf7KuOsFAh
         JB70raMw7aosIAQP3fV7enDBefarYoslwimkcYRBEPAUBbZU2qLHbOnCFWJT+sJzpQ
         LuAD+Xk5GJeM2eWK5I5ZnnWx2Ld91bsUBbeHaNa4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: defconfig: Samsung defconfig for v5.6
Date:   Mon, 20 Jan 2020 19:02:27 +0100
Message-Id: <20200120180227.9061-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope it is not too late for these defconfig changes.


Best regards,
Krzysztof


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.6

for you to fetch changes up to cdfc88f1cdbf12b666dcf2da3f1de38fb1512262:

  ARM: multi_v7_defconfig: Enable devfreq thermal integration (2020-01-17 20:28:54 +0100)

----------------------------------------------------------------
Samsung defconfig changes for v5.6

1. Bring back explicitly wanted options which were removed through
   `make savedefconfig`.  savedefconfig removes options selected by
   other symbol, however developers of this other symbol can remove
   anytime 'select' statement.
2. Enable NFS v4.1 and v4.2, useful in testing/CI systems.
3. Enable thermal throttling through devfreq framework.

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      ARM: exynos_defconfig: Bring back explicitly wanted options
      ARM: exynos_defconfig: Enable NFS v4.1 and v4.2
      ARM: multi_v7_defconfig: Enable NFS v4.1 and v4.2

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable devfreq thermal integration
      ARM: multi_v7_defconfig: Enable devfreq thermal integration

 arch/arm/configs/exynos_defconfig   | 9 +++++++++
 arch/arm/configs/multi_v7_defconfig | 3 +++
 2 files changed, 12 insertions(+)
