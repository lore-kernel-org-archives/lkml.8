Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF40AC2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8472A2070E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586056089;
	bh=J0VEFs+7R2vxCSMV2q1Cw+ItQk4n9UVuF2vDsSAAL/0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mVj9+H/NvZG91QqZZgfux0qhiuACXLZGDjv3y31J4AM0herMFkbUhJU0gYrbxGC1g
	 XkGTbTH36sD/T28iqjRonkOqmF3lcvWQBbIz7GeJ9r3pVP0XJ3eCHLERFG12+EHzu7
	 a30aLqaOxPpl8M1YbuYZIWlpuk4FMkBtXQ0+kLfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDEDII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgDEDII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:08:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B67C206A3;
        Sun,  5 Apr 2020 03:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586056087;
        bh=J0VEFs+7R2vxCSMV2q1Cw+ItQk4n9UVuF2vDsSAAL/0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QIl/rRjqQ87S2c1uQhTrQXlQndCNYiPRa51nZKaM39iK4MWtmYObXRDrMvF17SpwO
         5IfbHW9nh1tojQ+AeMrY3ceQDM0NRJrAYUnx+5fa9MNAVPIij1gDTZM8UIJBMfg+J9
         M1sHrrmR1y1wMP0gd/M/+DDo7G4uc1eAesgDPI/o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Sat, 04 Apr 2020 20:08:06 -0700
Message-ID: <158605608663.158626.7732167785990086489@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-03-31 03:45:32)
> Don't gate uart1_eb which provides console clock, gating that clock would
> make serial stop working if serial driver didn't enable that explicitly.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Do you have a Fixes: tag?
