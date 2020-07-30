Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E68D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgG3Vce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgG3Vcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:32:33 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483DC061574;
        Thu, 30 Jul 2020 14:32:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E307126A83E3;
        Thu, 30 Jul 2020 14:15:44 -0700 (PDT)
Date:   Thu, 30 Jul 2020 14:32:26 -0700 (PDT)
Message-Id: <20200730.143226.1527353835656521105.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     edumazet@google.com, netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tcp: Export tcp_write_queue_purge()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2347a342-f0b0-903c-ebb6-6e95eb664864@gmail.com>
References: <20200730210728.2051-1-f.fainelli@gmail.com>
        <CANn89iJETzud8PK7eTj=rXMSCjBtnmcSq1y0qF7EVK8b5M_vXA@mail.gmail.com>
        <2347a342-f0b0-903c-ebb6-6e95eb664864@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jul 2020 14:15:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 30 Jul 2020 14:23:50 -0700

> On 7/30/20 2:16 PM, Eric Dumazet wrote:
>> On Thu, Jul 30, 2020 at 2:07 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Hmmm.... which module would need this exactly ?
> 
> None in tree unfortunately, and I doubt it would be published one day.
> For consistency one could argue that given it used to be accessible, and
> other symbols within net/ipv4/tcp.c are also exported, so this should
> one be. Not going to hold that line of argumentation more than in this
> email, if you object to it, that would be completely fine with me.
> 
>> 
>> How come it took 3 years to discover this issue ?
> 
> We just upgraded our downstream kernel from 4.9 to 5.4 and this is why
> it took so long.

We really can't do this, sorry.
