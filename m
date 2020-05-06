Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB30D2078C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgEFWAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726927AbgEFWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:00:39 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47DC061A0F;
        Wed,  6 May 2020 15:00:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0975123229E3;
        Wed,  6 May 2020 15:00:38 -0700 (PDT)
Date:   Wed, 06 May 2020 15:00:38 -0700 (PDT)
Message-Id: <20200506.150038.89398054484090920.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: hsr: fix incorrect type usage for
 protocol variable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200506154107.575-1-m-karicheri2@ti.com>
References: <20200506154107.575-1-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 May 2020 15:00:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Wed, 6 May 2020 11:41:07 -0400

> Fix following sparse checker warning:-
> 
> net/hsr/hsr_slave.c:38:18: warning: incorrect type in assignment (different base types)
> net/hsr/hsr_slave.c:38:18:    expected unsigned short [unsigned] [usertype] protocol
> net/hsr/hsr_slave.c:38:18:    got restricted __be16 [usertype] h_proto
> net/hsr/hsr_slave.c:39:25: warning: restricted __be16 degrades to integer
> net/hsr/hsr_slave.c:39:57: warning: restricted __be16 degrades to integer
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Applied.
