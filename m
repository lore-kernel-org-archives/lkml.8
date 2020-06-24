Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4357C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CF52081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbgFXDYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:24:04 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD71AC061573;
        Tue, 23 Jun 2020 20:24:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1C128129847C5;
        Tue, 23 Jun 2020 20:24:04 -0700 (PDT)
Date:   Tue, 23 Jun 2020 20:24:03 -0700 (PDT)
Message-Id: <20200623.202403.1704397333023796145.davem@davemloft.net>
To:     likaige@loongson.cn
Cc:     kuba@kernel.org, benve@cisco.com, _govind@gmx.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lixuefeng@loongson.cn, yangtiezhu@loongson.cn
Subject: Re: [PATCH RESEND] net/cisco: Fix a sleep-in-atomic-context bug in
 enic_init_affinity_hint()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f12f40fe-7c9a-6ba8-f2ff-daf315030258@loongson.cn>
References: <1592899989-22049-1-git-send-email-likaige@loongson.cn>
        <20200623135007.3105d067@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <f12f40fe-7c9a-6ba8-f2ff-daf315030258@loongson.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Jun 2020 20:24:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaige Li <likaige@loongson.cn>
Date: Wed, 24 Jun 2020 10:07:16 +0800

> You are right. Should I do spin_unlock before the enic_open, or remove
> spin_lock in enic_reset?

You need to learn how this driver's locking works and design a correct
adjustment.
