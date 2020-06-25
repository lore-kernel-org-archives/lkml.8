Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D8EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3319020767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407681AbgFYXFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405930AbgFYXFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:05:47 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A06C08C5C1;
        Thu, 25 Jun 2020 16:05:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E5B9153C7171;
        Thu, 25 Jun 2020 16:05:46 -0700 (PDT)
Date:   Thu, 25 Jun 2020 16:05:45 -0700 (PDT)
Message-Id: <20200625.160545.16023142112288844.davem@davemloft.net>
To:     dmurphy@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v11 0/5] RGMII Internal delay common property
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200624121605.18259-1-dmurphy@ti.com>
References: <20200624121605.18259-1-dmurphy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Jun 2020 16:05:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 24 Jun 2020 07:16:00 -0500

> The RGMII internal delay is a common setting found in most RGMII capable PHY
> devices.  It was found that many vendor specific device tree properties exist
> to do the same function. This creates a common property to be used for PHY's
> that have internal delays for the Rx and Tx paths.
> 
> If the internal delay is tunable then the caller needs to pass the internal
> delay array and the return will be the index in the array that was found in
> the firmware node.
> 
> If the internal delay is fixed then the caller only needs to indicate which
> delay to return.  There is no need for a fixed delay to add device properties
> since the value is not configurable. Per the ethernet-controller.yaml the
> interface type indicates that the PHY should provide the delay.
> 
> This series contains examples of both a configurable delay and a fixed delay.

Series applied, thank you.
