Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527E6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D6020888
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgFSDkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFSDkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:40:46 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C303C06174E;
        Thu, 18 Jun 2020 20:40:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0FA1120ED4AD;
        Thu, 18 Jun 2020 20:40:45 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:40:45 -0700 (PDT)
Message-Id: <20200618.204045.980620033626622900.davem@davemloft.net>
To:     tharvey@gateworks.com
Cc:     bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan743x: allow mac address to come from dt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1592434750-8940-1-git-send-email-tharvey@gateworks.com>
References: <1592434750-8940-1-git-send-email-tharvey@gateworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jun 2020 20:40:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 17 Jun 2020 15:59:10 -0700

> If a valid mac address is present in dt, use that before using
> CSR's or a random mac address.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to net-next, thanks.
