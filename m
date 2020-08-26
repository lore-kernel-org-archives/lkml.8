Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF40C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B06C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHZP31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgHZP30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:29:26 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65154C061574;
        Wed, 26 Aug 2020 08:29:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 18072135985CB;
        Wed, 26 Aug 2020 08:12:39 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:28:57 -0700 (PDT)
Message-Id: <20200826.082857.584544823490249841.davem@davemloft.net>
To:     aranea@aixah.de
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] veth: Initialize dev->perm_addr
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200826152000.ckxrcfyetdvuvqum@vega>
References: <20200824143828.5964-1-aranea@aixah.de>
        <20200824.102545.1450838041398463071.davem@davemloft.net>
        <20200826152000.ckxrcfyetdvuvqum@vega>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Aug 2020 08:12:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mira Ressel <aranea@aixah.de>
Date: Wed, 26 Aug 2020 15:20:00 +0000

> I'm setting the peer->perm_addr, which would otherwise be zero, to its
> dev_addr, which has been either generated randomly by the kernel or
> provided by userland in a netlink attribute.

Which by definition makes it not necessarily a "permanent address" and
therefore is subject to being different across boots, which is exactly
what you don't want to happen for automatic address generation.
