Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6616F22DD6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbgFTC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbgFTC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:58:45 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0DC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:58:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3691712784D0B;
        Fri, 19 Jun 2020 19:58:45 -0700 (PDT)
Date:   Fri, 19 Jun 2020 19:58:44 -0700 (PDT)
Message-Id: <20200619.195844.1266525268293030127.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     nikolay@cumulusnetworks.com, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bridge: uapi: mrp: Fix MRP_PORT_ROLE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200617113249.2001901-1-horatiu.vultur@microchip.com>
References: <20200617113249.2001901-1-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Jun 2020 19:58:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please send networking patches for review to netdev@vger.kernel.org

Thank you.
