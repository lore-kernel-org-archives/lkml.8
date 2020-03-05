Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE2C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB720848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgCEVcG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:32:06 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53744 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgCEVcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:32:06 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j9y64-00064u-IE; Thu, 05 Mar 2020 22:32:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: rockchip: add missing @0 to memory nodenames
Date:   Thu, 05 Mar 2020 22:31:59 +0100
Message-ID: <1784340.9KJLpVao5L@phil>
In-Reply-To: <20200304074051.8742-2-jbx6244@gmail.com>
References: <20200304074051.8742-1-jbx6244@gmail.com> <20200304074051.8742-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Mittwoch, 4. März 2020, 08:40:50 CET schrieb Johan Jonker:
> A test with the command below gives for example this error:
> 
> arch/arm/boot/dts/rk3288-tinker.dt.yaml: /: memory:
> False schema does not allow
> {'device_type': ['memory'], 'reg': [[0, 0, 0, 2147483648]]}
> 
> The memory nodes all have a reg property that requires '@' in
> the nodename. Fix this error by adding the missing '@0' to
> the involved memory nodenames.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
> schemas/root-node.yaml

changes to memory nodes you sadly cannot do in such an automated fashion.
If you read the comment in rk3288-veyron.dtsi you'll see that a previous
similar iteration broke all of those machines as their coreboot doesn't
copy with memory@0 and would insert another memory node without @0

In the past iteration the consensus then was that memory without @0
is also ok (as it isn't changeable anyway).

As I don't really want to repeat that, I'd like actual hardware tests
before touching memory nodes.

Heiko


