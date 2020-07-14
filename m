Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0057C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D68206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGNUYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgGNUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:24:00 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F71C061794;
        Tue, 14 Jul 2020 13:24:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1E96115E18275;
        Tue, 14 Jul 2020 13:23:58 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:23:55 -0700 (PDT)
Message-Id: <20200714.132355.1352071851569568246.davem@davemloft.net>
To:     dalon.westergreen@intel.com
Cc:     kuba@kernel.org, mkubecek@suse.cz, ley.foon.tan@intel.com,
        chin.liang.see@intel.com, dinh.nguyen@intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        joyce.ooi@intel.com, thor.thayer@linux.intel.com
Subject: Re: [PATCH v4 09/10] net: eth: altera: add msgdma prefetcher
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9a8ba2616f72fb44cdc3b45fabfb4d7bdf961fd0.camel@intel.com>
References: <3bcb9020f0a3836f41036ddc3c8034b96e183197.camel@intel.com>
        <20200714092903.38581b74@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <9a8ba2616f72fb44cdc3b45fabfb4d7bdf961fd0.camel@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Jul 2020 13:23:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Westergreen, Dalon" <dalon.westergreen@intel.com>
Date: Tue, 14 Jul 2020 18:51:15 +0000

> I don't think this is necessary, i think just having a module parameter
> meets our needs.  I don't see a need for the value to change on a per
> interface basis.  This was primarily used during testing / bringup.

Please no module parameters...
