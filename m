Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9715BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7481D2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgG2A3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbgG2A3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:29:12 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A739C061794;
        Tue, 28 Jul 2020 17:29:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C6655128D3C95;
        Tue, 28 Jul 2020 17:12:25 -0700 (PDT)
Date:   Tue, 28 Jul 2020 17:29:10 -0700 (PDT)
Message-Id: <20200728.172910.1838346370661943435.davem@davemloft.net>
To:     bkkarthik@pesu.pes.edu
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net: ipv6: fix slab-out-of-bounda Read in
 xfrm6_tunnel_alloc_spi
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200725124553.zunta65rf3j23cth@pesu.pes.edu>
References: <20200725124553.zunta65rf3j23cth@pesu.pes.edu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 Jul 2020 17:12:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: B K Karthik <bkkarthik@pesu.pes.edu>
Date: Sat, 25 Jul 2020 18:15:53 +0530

> fix slab-out-of-bounds Read in xfrm6_tunnel_alloc_spi
> by checking for existance of head for the list spi_byspi

spi_byspi is an array, therefore as long as xfrm6_tn is not NULL
then spi_byspi will also not be NULL.


