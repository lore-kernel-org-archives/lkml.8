Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4AD204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMWip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:38:44 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861EC061757;
        Thu, 13 Aug 2020 15:38:44 -0700 (PDT)
Received: from localhost (50-47-103-195.evrt.wa.frontiernet.net [50.47.103.195])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CE55712825D8D;
        Thu, 13 Aug 2020 15:21:57 -0700 (PDT)
Date:   Thu, 13 Aug 2020 15:38:42 -0700 (PDT)
Message-Id: <20200813.153842.596513779122352190.davem@davemloft.net>
To:     john.ogness@linutronix.de
Cc:     kuba@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] af_packet: TPACKET_V3: fix fill status rwlock imbalance
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200813193925.32477-1-john.ogness@linutronix.de>
References: <20200813193925.32477-1-john.ogness@linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Aug 2020 15:21:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>
Date: Thu, 13 Aug 2020 21:45:25 +0206

> After @blk_fill_in_prog_lock is acquired there is an early out vnet
> situation that can occur. In that case, the rwlock needs to be
> released.
> 
> Also, since @blk_fill_in_prog_lock is only acquired when @tp_version
> is exactly TPACKET_V3, only release it on that exact condition as
> well.
> 
> And finally, add sparse annotation so that it is clearer that
> prb_fill_curr_block() and prb_clear_blk_fill_status() are acquiring
> and releasing @blk_fill_in_prog_lock, respectively. sparse is still
> unable to understand the balance, but the warnings are now on a
> higher level that make more sense.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, applied.
