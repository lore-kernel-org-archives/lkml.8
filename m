Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B42C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D774C20769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgELUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:10:54 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CDC061A0C;
        Tue, 12 May 2020 13:10:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B9B311283890C;
        Tue, 12 May 2020 13:10:53 -0700 (PDT)
Date:   Tue, 12 May 2020 13:10:52 -0700 (PDT)
Message-Id: <20200512.131052.2208472827152242233.davem@davemloft.net>
To:     olteanv@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com,
        kuba@kernel.org, jiri@mellanox.com, idosch@idosch.org,
        rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 00/15] Traffic support for dsa_8021q in
 vlan_filtering=1 mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200512172039.14136-1-olteanv@gmail.com>
References: <20200512172039.14136-1-olteanv@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 May 2020 13:10:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 12 May 2020 20:20:24 +0300

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This series is an attempt to support as much as possible in terms of
> traffic I/O from the network stack with the only dsa_8021q user thus
> far, sja1105.
> 
> The hardware doesn't support pushing a second VLAN tag to packets that
> are already tagged, so our only option is to combine the dsa_8021q with
> the user tag into a single tag and decode that on the CPU.
> 
> The assumption is that there is a type of use cases for which 7 VLANs
> per port are more than sufficient, and that there's another type of use
> cases where the full 4096 entries are barely enough. Those use cases are
> very different from one another, so I prefer trying to give both the
> best experience by creating this best_effort_vlan_filtering knob to
> select the mode in which they want to operate in.
 ...

Series applied, thanks Vladimir.
