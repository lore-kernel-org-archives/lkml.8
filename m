Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61621207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgFOUmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:42:17 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C15C061A0E;
        Mon, 15 Jun 2020 13:42:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E6509120ED49A;
        Mon, 15 Jun 2020 13:42:16 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:42:16 -0700 (PDT)
Message-Id: <20200615.134216.1492983787088475104.davem@davemloft.net>
To:     navid.emamdoost@gmail.com
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, emamd001@umn.edu, wu000273@umn.edu,
        kjlu@umn.edu, mccamant@cs.umn.edu
Subject: Re: [PATCH] net: fec: fix ref count leaking when
 pm_runtime_get_sync fails
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200614053801.94112-1-navid.emamdoost@gmail.com>
References: <20200614053801.94112-1-navid.emamdoost@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Jun 2020 13:42:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Sun, 14 Jun 2020 00:38:01 -0500

> in fec_enet_mdio_read, fec_enet_mdio_write, fec_enet_get_regs,
> fec_enet_open and fec_drv_remove, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

This does not apply to the net tree.
