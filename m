Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EBDC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473BF249F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgDFRXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:23:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57376 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgDFRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:23:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4D7D315DA6716;
        Mon,  6 Apr 2020 10:23:52 -0700 (PDT)
Date:   Mon, 06 Apr 2020 10:23:51 -0700 (PDT)
Message-Id: <20200406.102351.305606112132834192.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: bcm_sf2: Ensure correct sub-node is parsed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200405200031.27263-1-f.fainelli@gmail.com>
References: <20200405200031.27263-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Apr 2020 10:23:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun,  5 Apr 2020 13:00:30 -0700

> When the bcm_sf2 was converted into a proper platform device driver and
> used the new dsa_register_switch() interface, we would still be parsing
> the legacy DSA node that contained all the port information since the
> platform firmware has intentionally maintained backward and forward
> compatibility to client programs. Ensure that we do parse the correct
> node, which is "ports" per the revised DSA binding.
> 
> Fixes: d9338023fb8e ("net: dsa: bcm_sf2: Make it a real platform device driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable, thanks Florian.
