Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D04C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008CD20842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgHDTzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHDTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:55:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5621C06174A;
        Tue,  4 Aug 2020 12:55:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C696A12880A1F;
        Tue,  4 Aug 2020 12:38:22 -0700 (PDT)
Date:   Tue, 04 Aug 2020 12:55:07 -0700 (PDT)
Message-Id: <20200804.125507.1365180086597649192.davem@davemloft.net>
To:     joe@perches.com
Cc:     romieu@fr.zoreil.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] via-velocity: Use more typical logging styles
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9f98b7a2c4ce56b9702597eab1349eaa5f1753bb.camel@perches.com>
References: <e45d15ad36a0c9a994b5a1136c72518215c99f7a.camel@perches.com>
        <20200803.154248.2020214547846261577.davem@davemloft.net>
        <9f98b7a2c4ce56b9702597eab1349eaa5f1753bb.camel@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Aug 2020 12:38:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Mon, 03 Aug 2020 20:23:13 -0700

> Use netdev_<level> in place of VELOCITY_PRT.
> Use pr_<level> in place of printk(KERN_<LEVEL>.
> 
> Miscellanea:
> 
> o Add pr_fmt to prefix pr_<level> output with "via-velocity: "
> o Remove now unused functions and macros
> o Realign some logging lines
> o Remove devname where pr_<level> is also used
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Yeah I definitely like this better, applied, thanks.
