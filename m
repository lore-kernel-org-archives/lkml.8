Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAFDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57825206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393842AbgFWVi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393791AbgFWViX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:38:23 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1CC061573;
        Tue, 23 Jun 2020 14:38:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98557129428C9;
        Tue, 23 Jun 2020 14:38:22 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:38:21 -0700 (PDT)
Message-Id: <20200623.143821.491798381160245817.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 0/2] bridge: mrp: Update MRP_PORT_ROLE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
References: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 14:38:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Jun 2020 11:05:39 +0200

> This patch series does the following:
> - fixes the enum br_mrp_port_role_type. It removes the port role none(0x2)
>   because this is in conflict with the standard. The standard defines the
>   interconnect port role as value 0x2.
> - adds checks regarding current defined port roles: primary(0x0) and
>   secondary(0x1).
> 
> v2:
>  - add the validation code when setting the port role.

Series applied, thank you.
