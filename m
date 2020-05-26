Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ECCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1C42071C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgEZBKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387888AbgEZBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:10:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80FC061A0E;
        Mon, 25 May 2020 18:10:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 384A0127AA135;
        Mon, 25 May 2020 18:10:09 -0700 (PDT)
Date:   Mon, 25 May 2020 18:10:08 -0700 (PDT)
Message-Id: <20200525.181008.578915373174688150.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        kuba@kernel.org, andrew@lunn.ch, UNGLinuxDriver@microchip.com,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com
Subject: Re: [PATCH] bridge: mrp: Fix out-of-bounds read in br_mrp_parse
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200525095541.46673-1-horatiu.vultur@microchip.com>
References: <20200525095541.46673-1-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 May 2020 18:10:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 25 May 2020 09:55:41 +0000

> The issue was reported by syzbot. When the function br_mrp_parse was
> called with a valid net_bridge_port, the net_bridge was an invalid
> pointer. Therefore the check br->stp_enabled could pass/fail
> depending where it was pointing in memory.
> The fix consists of setting the net_bridge pointer if the port is a
> valid pointer.
> 
> Reported-by: syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com
> Fixes: 6536993371fa ("bridge: mrp: Integrate MRP into the bridge")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Applied to net-next, thanks.
