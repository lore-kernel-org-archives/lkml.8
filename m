Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4799C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A432120716
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCODxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:53:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35216 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgCODxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:53:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 130F915B75272;
        Sat, 14 Mar 2020 20:53:36 -0700 (PDT)
Date:   Sat, 14 Mar 2020 20:53:35 -0700 (PDT)
Message-Id: <20200314.205335.907987569817755804.davem@davemloft.net>
To:     michael@walle.cc
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org
Subject: Re: [PATCH 1/2] net: dsa: felix: allow the device to be disabled
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200312164320.22349-1-michael@walle.cc>
References: <20200312164320.22349-1-michael@walle.cc>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 14 Mar 2020 20:53:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series depends upon some devicetree tree changes, so why don't you
submit these changes there and add my:

Acked-by: David S. Miller <davem@davemloft.net>

Thank you.
