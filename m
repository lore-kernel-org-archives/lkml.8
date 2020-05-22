Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D5206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgEVXRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbgEVXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:17:34 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8536CC061A0E;
        Fri, 22 May 2020 16:17:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 52778127517BD;
        Fri, 22 May 2020 16:17:33 -0700 (PDT)
Date:   Fri, 22 May 2020 16:17:32 -0700 (PDT)
Message-Id: <20200522.161732.2033826090264059505.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/3] bridge: mrp: Add br_mrp_unique_ifindex function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
References: <20200521231907.3564679-1-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 May 2020 16:17:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 21 May 2020 23:19:04 +0000

> This patch series adds small fixes to MRP implementation.
> The following are fixed in this patch series:
> - now is not allow to add the same port to multiple MRP rings
> - remove unused variable
> - restore the port state according to the bridge state when the MRP instance
>   is deleted
> 
> v2:
>  - use rtnl_dereference instead of rcu_dereference in the first patch

Series applied to net-next, thanks.
