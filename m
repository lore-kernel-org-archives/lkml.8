Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E20C2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHYBVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHYBVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:21:36 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6457C061574;
        Mon, 24 Aug 2020 18:21:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A72391295BBB2;
        Mon, 24 Aug 2020 18:04:49 -0700 (PDT)
Date:   Mon, 24 Aug 2020 18:21:35 -0700 (PDT)
Message-Id: <20200824.182135.131366460578950674.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next 0/6] MAINTAINERS: Remove self from PHY LIBRARY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <bd8da53d-ebf8-2e2e-124d-f12e614d820a@gmail.com>
References: <20200822201126.8253-1-f.fainelli@gmail.com>
        <20200824.161937.197785505315942083.davem@davemloft.net>
        <bd8da53d-ebf8-2e2e-124d-f12e614d820a@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 18:04:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 24 Aug 2020 17:43:37 -0700

> 
> 
> On 8/24/2020 4:19 PM, David Miller wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>> Date: Sat, 22 Aug 2020 13:11:20 -0700
>> 
>>> Hi David, Heiner, Andrew, Russell,
>>>
>>> This patch series aims at allowing myself to keep track of the
>>> Ethernet
>>> PHY and MDIO bus drivers that I authored or contributed to without
>>> being listed as a maintainer in the PHY library anymore.
>>>
>>> Thank you for the fish, I will still be around.
>> I applied this to 'net' because I think it's important to MAINTAINERS
>> information to be as uptodate as possible.
> 
> Humm sure, however some of the paths defined in patches 4 and 5 assume
> that Andrew's series that moves PHY/MDIO/PCS to separate
> directories. I suppose this may be okay for a little while until you
> merge his patch series?

Aha, I see.  I think it's ok for now.
