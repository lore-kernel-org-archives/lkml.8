Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4181D2065F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGRByz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGRByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:54:54 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961BDC0619D2;
        Fri, 17 Jul 2020 18:54:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3432411E45915;
        Fri, 17 Jul 2020 18:54:54 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:54:53 -0700 (PDT)
Message-Id: <20200717.185453.1344185473580521561.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        grygorii.strashko@ti.com, vinicius.gomes@intel.com
Subject: Re: [PATCH 2/2 v2] net: hsr: validate address B before copying to
 skb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200717145510.30433-2-m-karicheri2@ti.com>
References: <20200717145510.30433-1-m-karicheri2@ti.com>
        <20200717145510.30433-2-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:54:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Fri, 17 Jul 2020 10:55:10 -0400

> Validate MAC address before copying the same to outgoing frame
> skb destination address. Since a node can have zero mac
> address for Link B until a valid frame is received over
> that link, this fix address the issue of a zero MAC address
> being in the packet.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Applied.
