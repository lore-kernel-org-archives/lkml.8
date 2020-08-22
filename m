Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA8CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721CC2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 19:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgHVTd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgHVTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 15:33:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8CAC061573;
        Sat, 22 Aug 2020 12:33:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C2E6015CE720B;
        Sat, 22 Aug 2020 12:16:31 -0700 (PDT)
Date:   Sat, 22 Aug 2020 12:33:15 -0700 (PDT)
Message-Id: <20200822.123315.787815838209253525.davem@davemloft.net>
To:     Jianlin.Lv@arm.com
Cc:     netdev@vger.kernel.org, kuba@kernel.org, Song.Zhu@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove unnecessary intermediate variables
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200822020431.125732-1-Jianlin.Lv@arm.com>
References: <20200822020431.125732-1-Jianlin.Lv@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 22 Aug 2020 12:16:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlin Lv <Jianlin.Lv@arm.com>
Date: Sat, 22 Aug 2020 10:04:31 +0800

> It is not necessary to use src/dst as an intermediate variable for
> assignment operation; Delete src/dst intermediate variables to avoid
> unnecessary variable declarations.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>

It keeps the line lengths within reasonable length, so these local
variables are fine.

Also, the appropriate subsystem prefix for this patch should be "vxlan: "
not "net: " in your Subject line.  If someone is skimming the shortlog
in 'git' how will they tell where exactly in the networking your change
is being made?

Anyways, I'm not applying this, thanks.
