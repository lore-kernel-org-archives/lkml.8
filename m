Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F42C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CA7206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgEAWyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgEAWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:54:46 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED5C061A0C;
        Fri,  1 May 2020 15:54:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5757215009FA5;
        Fri,  1 May 2020 15:54:46 -0700 (PDT)
Date:   Fri, 01 May 2020 15:54:45 -0700 (PDT)
Message-Id: <20200501.155445.1145592921900948285.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: Move wake-up event out of side
 band ISR
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1588289211-26190-1-git-send-email-opendmb@gmail.com>
References: <1588289211-26190-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 May 2020 15:54:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Thu, 30 Apr 2020 16:26:51 -0700

> The side band interrupt service routine is not available on chips
> like 7211, or rather, it does not permit the signaling of wake-up
> events due to the complex interrupt hierarchy.
> 
> Move the wake-up event accounting into a .resume_noirq function,
> account for possible wake-up events and clear the MPD/HFB interrupts
> from there, while leaving the hardware untouched until the resume
> function proceeds with doing its usual business.
> 
> Because bcmgenet_wol_power_down_cfg() now enables the MPD and HFB
> interrupts, it is invoked by a .suspend_noirq function to prevent
> the servicing of interrupts after the clocks have been disabled.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Applied, thank you.
