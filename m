Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E968FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C865020717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 01:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgGRBZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:25:46 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94FC0619D2;
        Fri, 17 Jul 2020 18:25:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 94C7911E45910;
        Fri, 17 Jul 2020 18:25:43 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:25:40 -0700 (PDT)
Message-Id: <20200717.182540.2222186339961093391.davem@davemloft.net>
To:     mstarovoitov@marvell.com
Cc:     kuba@kernel.org, irusskikh@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ndanilov@marvell.com
Subject: Re: [PATCH net] net: atlantic: disable PTP on AQC111, AQC112
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200717203949.9098-1-mstarovoitov@marvell.com>
References: <20200717203949.9098-1-mstarovoitov@marvell.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:25:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Starovoytov <mstarovoitov@marvell.com>
Date: Fri, 17 Jul 2020 23:39:49 +0300

> From: Nikita Danilov <ndanilov@marvell.com>
> 
> This patch disables PTP on AQC111 and AQC112 due to a known HW issue,
> which can cause datapath issues.
> 
> Ideally PTP block should have been disabled via PHY provisioning, but
> unfortunately many units have been shipped with enabled PTP block.
> Thus, we have to work around this in the driver.
> 
> Fixes: dbcd6806af420 ("net: aquantia: add support for Phy access")
> Signed-off-by: Nikita Danilov <ndanilov@marvell.com>
> Signed-off-by: Mark Starovoytov <mstarovoitov@marvell.com>
> Signed-off-by: Igor Russkikh <irusskikh@marvell.com>

Applied and queued up for -stable, thank you.
