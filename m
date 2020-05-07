Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1956DC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF6E20747
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEGAci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgEGAch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:32:37 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99700C061A0F;
        Wed,  6 May 2020 17:32:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DDCA01277CC95;
        Wed,  6 May 2020 17:32:35 -0700 (PDT)
Date:   Wed, 06 May 2020 17:32:34 -0700 (PDT)
Message-Id: <20200506.173234.92268086246049661.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, allen.pais@oracle.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: Do not leave DSA master with NULL
 netdev_ops
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200504201806.27192-1-f.fainelli@gmail.com>
References: <20200504201806.27192-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 May 2020 17:32:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 May 2020 13:18:06 -0700

> When ndo_get_phys_port_name() for the CPU port was added we introduced
> an early check for when the DSA master network device in
> dsa_master_ndo_setup() already implements ndo_get_phys_port_name(). When
> we perform the teardown operation in dsa_master_ndo_teardown() we would
> not be checking that cpu_dp->orig_ndo_ops was successfully allocated and
> non-NULL initialized.
> 
> With network device drivers such as virtio_net, this leads to a NPD as
> soon as the DSA switch hanging off of it gets torn down because we are
> now assigning the virtio_net device's netdev_ops a NULL pointer.
> 
> Fixes: da7b9e9b00d4 ("net: dsa: Add ndo_get_phys_port_name() for CPU port")
> Reported-by: Allen Pais <allen.pais@oracle.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable, thanks Florian.
