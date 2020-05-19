Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C98C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0008205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgESWpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESWpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:45:39 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FAFC061A0E;
        Tue, 19 May 2020 15:45:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A43B8128F0068;
        Tue, 19 May 2020 15:45:38 -0700 (PDT)
Date:   Tue, 19 May 2020 15:45:37 -0700 (PDT)
Message-Id: <20200519.154537.2177911931662623148.davem@davemloft.net>
To:     hch@lst.de
Cc:     kuba@kernel.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: add a new ->ndo_tunnel_ctl method to avoid a few set_fs calls
 v2
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200519130319.1464195-1-hch@lst.de>
References: <20200519130319.1464195-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 May 2020 15:45:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 19 May 2020 15:03:10 +0200

> both the ipv4 and ipv6 code have an ioctl each that can be used to create
> a tunnel using code that doesn't live in the core kernel or ipv6 module.
> Currently they call ioctls on the tunnel devices to create these, for
> which the code needs to override the address limit, which is a "feature"
> I plan to get rid of.
> 
> Instead this patchset adds a new ->ndo_tunnel_ctl that can be used for
> the tunnel configuration using struct ip_tunnel_parm.  The method is
> either invoked from a helper that does the uaccess and can be wired up
> as ndo_do_ioctl method, or directly from the magic IPV4/6 ioctls that
> create tunnels with kernel space arguments.
> 
> Changes since v2:
>  - properly propagate errors in ipip6_tunnel_prl_ctl

Looks good, series applied, thanks.
