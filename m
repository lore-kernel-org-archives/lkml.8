Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5211C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895E82100A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgH3UQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:16:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48252 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgH3UQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:16:43 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTkn-0002d8-L6; Sun, 30 Aug 2020 22:16:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: update cpu supplies on rk3288
Date:   Sun, 30 Aug 2020 22:16:34 +0200
Message-Id: <159881858451.25534.11030928777586956509.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813180241.14660-1-jbx6244@gmail.com>
References: <20200813180241.14660-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 20:02:41 +0200, Johan Jonker wrote:
> The use of cpu0-supply for cpu0 alone is deprecated,
> so add cpu-supply to each cpu separately and
> update all existing rk3288 boards that use this property.

Applied, thanks!

[1/1] ARM: dts: rockchip: update cpu supplies on rk3288
      commit: b282ae0511cdb6f17cb5052de20288245a8ecd00

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
