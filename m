Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C38C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DD320658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597830750;
	bh=2nY+yo4EUV/kJ0OJMEPEm9/MdaFPOXDjVlvIvWHa4GI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ov6ErKJ3RzRfi2MZ571bCRfLJx4WaSWjyLCx3ptMgibY7CsG5Rx9jguAUpeneEYMA
	 mZHqqapO/vl5k8RBOpLq+sWGFuZ4jsvYQep2G/M9IWRpMeH9NCQb13aMWVxa7z1PXw
	 Q34fmHvpoHcy/0h1fb1Gql9PjDv5PXUjvIxPLw1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHSJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgHSJwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:52:18 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE00207BB;
        Wed, 19 Aug 2020 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597830738;
        bh=2nY+yo4EUV/kJ0OJMEPEm9/MdaFPOXDjVlvIvWHa4GI=;
        h=From:To:Cc:Subject:Date:From;
        b=HaYc+Mk5n+CyvjOu0QVij7dcMQK5wyDr0DEWWWBZHBHhouaGGa8n9An4RcDvNkdFX
         XDt0ZUwXQJzWXbqjDkYfbVyWndxfrQsYyJgMWxAT2mcpWebN6ec9n2gbII8gk8bBGg
         URKXk0ju5yFCfUGJisIWMvgbp5OAeDg6aW1wXJ9U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8KlT-00EqpX-5s; Wed, 19 Aug 2020 11:52:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Add some missing dt bindings for Hikey970
Date:   Wed, 19 Aug 2020 11:52:12 +0200
Message-Id: <cover.1597830623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DT bindings for Kirin 970 and Hikey 970 are incomplete:
they're missing the I2C buses and several pinctrl.

Add those, as they'll be needed by upcoming drivers for DRM and
USB.

Mauro Carvalho Chehab (2):
  dts: hisilicon: hi3670.dtsi: add I2C settings
  dts: hikey970-pinctrl.dtsi: add missing pinctrl settings

 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  71 +++
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 548 +++++++++++++++++-
 2 files changed, 608 insertions(+), 11 deletions(-)

-- 
2.26.2


