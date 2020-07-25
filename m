Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC734C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860B02070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGYACV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:02:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE5C0619D3;
        Fri, 24 Jul 2020 17:02:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 961C612756FEE;
        Fri, 24 Jul 2020 16:45:35 -0700 (PDT)
Date:   Fri, 24 Jul 2020 17:02:20 -0700 (PDT)
Message-Id: <20200724.170220.1275270219725381485.davem@davemloft.net>
To:     andrea.righi@canonical.com
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, kuba@kernel.org,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen-netfront: fix potential deadlock in
 xennet_remove()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200724085910.GA1043801@xps-13>
References: <20200724085910.GA1043801@xps-13>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 24 Jul 2020 16:45:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Righi <andrea.righi@canonical.com>
Date: Fri, 24 Jul 2020 10:59:10 +0200

> There's a potential race in xennet_remove(); this is what the driver is
> doing upon unregistering a network device:
> 
>   1. state = read bus state
>   2. if state is not "Closed":
>   3.    request to set state to "Closing"
>   4.    wait for state to be set to "Closing"
>   5.    request to set state to "Closed"
>   6.    wait for state to be set to "Closed"
> 
> If the state changes to "Closed" immediately after step 1 we are stuck
> forever in step 4, because the state will never go back from "Closed" to
> "Closing".
> 
> Make sure to check also for state == "Closed" in step 4 to prevent the
> deadlock.
> 
> Also add a 5 sec timeout any time we wait for the bus state to change,
> to avoid getting stuck forever in wait_event().
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
> Changes in v2:
>  - remove all dev_dbg() calls (as suggested by David Miller)

Applied, thank you.
