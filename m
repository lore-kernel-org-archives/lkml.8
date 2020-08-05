Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6EB21744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHEFX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:23:58 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:7309
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbgHEFX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:23:57 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 424792005F;
        Wed,  5 Aug 2020 05:23:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Aug 2020 07:23:55 +0200
From:   Martin Schiller <ms@dev.tdt.de>
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        netdev-owner@vger.kernel.org
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Organization: TDT AG
In-Reply-To: <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
References: <20200802195046.402539-1-xie.he.0141@gmail.com>
 <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de>
 <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
Message-ID: <9975370f14b8ddeafc8dec7bc6c0878a@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-04 21:20, Xie He wrote:
> On Tue, Aug 4, 2020 at 5:43 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> I'm not an expert in the field, but after reading the commit message 
>> and
>> the previous comments, I'd say that makes sense.
> 
> Thanks!
> 
>> Shouldn't this kernel panic be intercepted by a skb_cow() before the
>> skb_push() in lapbeth_data_transmit()?
> 
> When a skb is passing down a protocol stack for transmission, there
> might be several different skb_push calls to prepend different
> headers. It would be the best (in terms of performance) if we can
> allocate the needed header space in advance, so that we don't need to
> reallocate the skb every time a new header needs to be prepended.

Yes, I agree.

> Adding skb_cow before these skb_push calls would indeed help
> preventing kernel panics, but that might not be the essential issue
> here, and it might also prevent us from discovering the real issue. (I
> guess this is also the reason skb_cow is not included in skb_push
> itself.)

Well, you are right that the panic is "useful" to discover the real
problem. But on the other hand, if it is possible to prevent a panic, I
think we should do so. Maybe with adding a warning, when skb_cow() needs
to reallocate memory.

But this is getting a little bit off topic. For this patch I can say:

LGTM.

Reviewed-by: Martin Schiller <ms@dev.tdt.de>

