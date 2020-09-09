Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177AAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4302087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgIIQdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbgIIQci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:32:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB535C0617A9;
        Wed,  9 Sep 2020 06:37:35 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjkP4f7pz9sV5; Wed,  9 Sep 2020 23:37:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        a.zummo@towertech.it, mpe@ellerman.id.au, leoyang.li@nxp.com,
        benh@kernel.crashing.org, Biwen Li <biwen.li@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
In-Reply-To: <20200527034228.23793-1-biwen.li@oss.nxp.com>
References: <20200527034228.23793-1-biwen.li@oss.nxp.com>
Subject: Re: [v3 1/2] dts: ppc: t4240rdb: remove interrupts property
Message-Id: <159965824243.811679.11439322992907877530.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:37:33 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 11:42:27 +0800, Biwen Li wrote:
> Since the interrupt pin for RTC DS1374 is not connected
> to the CPU on T4240RDB, remove the interrupt property
> from the device tree.
> 
> This also fix the following warning for hwclock.util-linux:
> $ hwclock.util-linux
> hwclock.util-linux: select() to /dev/rtc0
> to wait for clock tick timed out

Applied to powerpc/next.

[1/2] powerpc/dts/t4240rdb: remove interrupts property
      https://git.kernel.org/powerpc/c/8c7614d648037b0776e0b76cb62911be3b059ea4
[2/2] powerc/dtc/t1024rdb: remove interrupts property
      https://git.kernel.org/powerpc/c/843dc8ee23d1b353fa9cc24da3e52be0111d5931

cheers
