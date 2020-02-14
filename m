Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B9AC3B1B1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5408B206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbgBNRvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:51:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55798 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388825AbgBNRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:51:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 015F115CE62E9;
        Fri, 14 Feb 2020 09:51:45 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:51:43 -0800 (PST)
Message-Id: <20200214.095143.1994809335003032453.davem@davemloft.net>
To:     hns@goldelico.com
Cc:     andrew@lunn.ch, paul@crapouillou.net, ynezz@true.cz,
        rfontana@redhat.com, tglx@linutronix.de, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2] net: davicom: dm9000: allow to pass MAC address
 through mac_addr module parameter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0d6b4d383bb29ed5d4710e9706e5ad6c7f92d9da.1581696454.git.hns@goldelico.com>
References: <0d6b4d383bb29ed5d4710e9706e5ad6c7f92d9da.1581696454.git.hns@goldelico.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Feb 2020 09:51:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Fri, 14 Feb 2020 17:07:35 +0100

> The MIPS Ingenic CI20 board is shipped with a quite old u-boot
> (ci20-v2013.10 see https://elinux.org/CI20_Dev_Zone). This passes
> the MAC address through dm9000.mac_addr=xx:xx:xx:xx:xx:xx
> kernel module parameter to give the board a fixed MAC address.
> 
> This is not processed by the dm9000 driver which assigns a random
> MAC address on each boot, making DHCP assign a new IP address
> each time.
> 
> So we add a check for the mac_addr module parameter as a last
> resort before assigning a random one. This mechanism can also
> be used outside of u-boot to provide a value through modprobe
> config.
> 
> To parse the MAC address in a new function get_mac_addr() we
> use an copy adapted from the ksz884x.c driver which provides
> the same functionality.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Sorry, this is not appropriate.  Module parameters in networking
drivers never are.
