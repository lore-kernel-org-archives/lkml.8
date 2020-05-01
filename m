Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A68C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BC620643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgEAW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgEAW2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:28:40 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211B4C061A0C;
        Fri,  1 May 2020 15:28:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5545014F4BE24;
        Fri,  1 May 2020 15:28:38 -0700 (PDT)
Date:   Fri, 01 May 2020 15:28:37 -0700 (PDT)
Message-Id: <20200501.152837.1463395932472619581.davem@davemloft.net>
To:     clay@daemons.net
Cc:     arnd@arndb.de, richardcochran@gmail.com, nico@fluxnic.net,
        grygorii.strashko@ti.com, geert@linux-m68k.org, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        nicolas.ferre@microchip.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org, kishon@ti.com, maowenan@huawei.com,
        ivan.khoronzhuk@linaro.org, ecree@solarflare.com,
        josh@joshtriplett.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: Make PTP-specific drivers depend on
 PTP_1588_CLOCK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200429075903.19788-1-clay@daemons.net>
References: <20200429072959.GA10194@arctic-shiba-lx>
        <20200429075903.19788-1-clay@daemons.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 May 2020 15:28:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clay McClure <clay@daemons.net>
Date: Wed, 29 Apr 2020 00:59:00 -0700

> Commit d1cbfd771ce8 ("ptp_clock: Allow for it to be optional") changed
> all PTP-capable Ethernet drivers from `select PTP_1588_CLOCK` to `imply
> PTP_1588_CLOCK`, "in order to break the hard dependency between the PTP
> clock subsystem and ethernet drivers capable of being clock providers."
> As a result it is possible to build PTP-capable Ethernet drivers without
> the PTP subsystem by deselecting PTP_1588_CLOCK. Drivers are required to
> handle the missing dependency gracefully.
 ...
> Note how these symbols all reference PTP or timestamping in their name;
> this is a clue that they depend on PTP_1588_CLOCK.
> 
> Change them from `imply PTP_1588_CLOCK` [2] to `depends on PTP_1588_CLOCK`.
> I'm not using `select PTP_1588_CLOCK` here because PTP_1588_CLOCK has
> its own dependencies, which `select` would not transitively apply.
> 
> Additionally, remove the `select NET_PTP_CLASSIFY` from CPTS_TI_MOD;
> PTP_1588_CLOCK already selects that.
 ...

Applied, thanks.
