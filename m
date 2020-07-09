Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE4DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0C20775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGIUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgGIUHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:07:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE2C08C5CE;
        Thu,  9 Jul 2020 13:07:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C00F120F19C4;
        Thu,  9 Jul 2020 13:07:18 -0700 (PDT)
Date:   Thu, 09 Jul 2020 13:07:17 -0700 (PDT)
Message-Id: <20200709.130717.943617001507092696.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     f.fainelli@gmail.com, kuba@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: systemport: fix double shift of a vlan_tci
 by VLAN_PRIO_SHIFT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200708183723.1212652-1-colin.king@canonical.com>
References: <20200708183723.1212652-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 Jul 2020 13:07:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed,  8 Jul 2020 19:37:23 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the u16 skb->vlan_tci is being right  shifted twice by
> VLAN_PRIO_SHIFT, once in the macro skb_vlan_tag_get_pri and explicitly
> by VLAN_PRIO_SHIFT afterwards. The combined shift amount is larger than
> the u16 so the end result is always zero.  Remove the second explicit
> shift as this is extraneous.
> 
> Fixes: 6e9fdb60d362 ("net: systemport: Add support for VLAN transmit acceleration")
> Addresses-Coverity: ("Operands don't affect result")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thanks.
