Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189BC20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584382375;
	bh=spkLbBBbHUQVTZXNlMZ2J+CHChOLkAfsVcF7t9bITWY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=BdXzcqmvW4vpS8yAxnTu8nXNZoI3KlQC/EhIE44Fjsd9e5tlbv06sgjX193piPZC7
	 wypb8LgMOJsKaLvFywguLtVICOL4DqdLOG42qq10CgTPZ4N8TkIgCKjgOfWuNjmrDP
	 vWDbCFsDRTClBPQnf8LZfEN0j3+ysw1smD13tBfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgCPSMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbgCPSMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:12:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E767B20674;
        Mon, 16 Mar 2020 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584382373;
        bh=spkLbBBbHUQVTZXNlMZ2J+CHChOLkAfsVcF7t9bITWY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XTfHY0fddJ4ZzE6oucJBXe1s54TU4z1WLj3RPFODGBiMRzl4uSo1MmqI4aklK6Scq
         fP0HjkN08FW5utmzWaSZoJZbGIl5/DHN8nr9vkbaFt8MHEJXQhFKbOuew6zbu585CK
         /+PdS7w4ZOTPZ7/5FHMIfdBF7rs0uWlM/sUG2I4c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+G9fYsTV66+PYY6LqHdjLx1L3i23ubDuWYg0ABoWuLQZTyL+g@mail.gmail.com>
References: <CA+G9fYsTV66+PYY6LqHdjLx1L3i23ubDuWYg0ABoWuLQZTyL+g@mail.gmail.com>
Subject: Re: WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:4156 __clk_put+0xfc/0x130
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        mturquette@baylibre.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 16 Mar 2020 11:12:52 -0700
Message-ID: <158438237211.88485.8872594504996170580@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Naresh Kamboju (2020-03-16 02:05:24)
> The following kernel warning noticed on linux-next on arm64 juno-r2 devic=
e.
>=20
> Linux version 5.6.0-rc5-next-20200316 (TuxBuild@ccdbe23f0d06) (gcc
> version 9.2.1 20191130 (Debian 9.2.1-21)) #1 SMP PREEMPT Mon Mar 16
> 07:40:45 UTC 2020
>=20
> [    0.002822] ------------[ cut here ]------------
> [    0.002840] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:4156
> __clk_put+0xfc/0x130
> [    0.002846] Modules linked in:
> [    0.002859] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.6.0-rc5-next-20200316 #1
> [    0.002865] Hardware name: ARM Juno development board (r2) (DT)
> [    0.002873] pstate: 20000005 (nzCv daif -PAN -UAO)
> [    0.002882] pc : __clk_put+0xfc/0x130
> [    0.002891] lr : clk_put+0xc/0x18

Looks like the code is wrong. It calls of_clk_get() and then
unconditionally calls clk_put() on whatever is returned, including an
error pointer which we warn about.

	WARN_ON_ONCE(IS_ERR(clk))

in __clk_put().

> [    0.002896] sp : ffff80001003bba0
> [    0.002902] x29: ffff80001003bba0 x28: 0000000000000000
> [    0.002911] x27: 0000000000000000 x26: ffff800011c56000
> [    0.002919] x25: ffff800011c56490 x24: 0000000000000001
> [    0.002928] x23: ffff00097effdae8 x22: 0000000000000001
> [    0.002936] x21: ffff000975cc8000 x20: fffffffffffffdfb
> [    0.002945] x19: fffffffffffffdfb x18: 0000000000000001
> [    0.002953] x17: 00000000e80423fd x16: 00000000e66966f2
> [    0.002961] x15: ffffffffffffffff x14: ffffffffff000000
> [    0.002970] x13: ffffffffffffffff x12: 0000000000000018
> [    0.002978] x11: 0000000000000028 x10: 0101010101010101
> [    0.002987] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
> [    0.002995] x7 : 6b61ff726b6b6462 x6 : 000000000080636c
> [    0.003003] x5 : ffff00097eff3d30 x4 : 0000000000000000
> [    0.003011] x3 : 0000000000000001 x2 : 0000000000000001
> [    0.003019] x1 : 1989cb6049749c00 x0 : fffffffffffffdfb
> [    0.003028] Call trace:
> [    0.003037]  __clk_put+0xfc/0x130
> [    0.003045]  clk_put+0xc/0x18
> [    0.003057]  topology_parse_cpu_capacity+0x100/0x180

Looks like Greg picked up this patch[1] as commit b8fe128dad8f
("arch_topology: Adjust initial CPU capacities with current freq") from
the list. Not sure it's correct though and I haven't looked in any more
detail. At least, not calling clk_put() unless it is a valid pointer
will work to quiet this warning.

[1] https://lore.kernel.org/r/20200113034815.25924-1-jeffy.chen@rock-chips.=
com
