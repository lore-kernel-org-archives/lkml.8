Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7209C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA220732
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgCaDA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:00:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgCaDA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BFB1B15D1720D;
        Mon, 30 Mar 2020 20:00:57 -0700 (PDT)
Date:   Mon, 30 Mar 2020 20:00:56 -0700 (PDT)
Message-Id: <20200330.200056.456632783811662995.davem@davemloft.net>
To:     matthias.schiffer@ew.tq-group.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: mv88e6xxx: account for PHY base
 address offset in dual chip mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200330135345.4361-2-matthias.schiffer@ew.tq-group.com>
References: <20200330135345.4361-1-matthias.schiffer@ew.tq-group.com>
        <20200330135345.4361-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Mar 2020 20:00:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Date: Mon, 30 Mar 2020 15:53:43 +0200

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index e5430cf2ad71..88c148a62366 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -257,6 +257,7 @@ struct mv88e6xxx_chip {
>  	const struct mv88e6xxx_bus_ops *smi_ops;
>  	struct mii_bus *bus;
>  	int sw_addr;
> +	unsigned int phy_base_addr;

Please preserve the reverse christmas tree ordering here.

And this submission was quite late and net-next is closing now so
please resubmit this after the merge window and net-next opens again.

Thanks.
