Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1066AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB56A20842
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgFASte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgFASG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:06:56 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3125AC05BD43;
        Mon,  1 Jun 2020 11:06:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54BC8120477C4;
        Mon,  1 Jun 2020 11:06:55 -0700 (PDT)
Date:   Mon, 01 Jun 2020 11:06:54 -0700 (PDT)
Message-Id: <20200601.110654.1178868171436999333.davem@davemloft.net>
To:     patrickeigensatz@gmail.com
Cc:     dsahern@kernel.org, nikolay@cumulusnetworks.com,
        scan-admin@coverity.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: nexthop: Fix deadcode issue by performing a
 proper NULL check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
References: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jun 2020 11:06:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: patrickeigensatz@gmail.com
Date: Mon,  1 Jun 2020 13:12:01 +0200

> From: Patrick Eigensatz <patrickeigensatz@gmail.com>
> 
> After allocating the spare nexthop group it should be tested for kzalloc()
> returning NULL, instead the already used nexthop group (which cannot be
> NULL at this point) had been tested so far.
> 
> Additionally, if kzalloc() fails, return ERR_PTR(-ENOMEM) instead of NULL.
> 
> Coverity-id: 1463885
> Reported-by: Coverity <scan-admin@coverity.com>
> Signed-off-by: Patrick Eigensatz <patrickeigensatz@gmail.com>

Applied, thank you.
