Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A920842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgETC5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgETC5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:57:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32449C061A0E;
        Tue, 19 May 2020 19:57:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4069512942617;
        Tue, 19 May 2020 19:57:23 -0700 (PDT)
Date:   Tue, 19 May 2020 19:57:22 -0700 (PDT)
Message-Id: <20200519.195722.1091264300612213554.davem@davemloft.net>
To:     tglx@linutronix.de
Cc:     stephen@networkplumber.org, a.darwish@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        paulmck@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 01/25] net: core: device_rename: Use rwsem instead
 of a seqcount
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87lfln5w61.fsf@nanos.tec.linutronix.de>
References: <87v9kr5zt7.fsf@nanos.tec.linutronix.de>
        <20200519161141.5fbab730@hermes.lan>
        <87lfln5w61.fsf@nanos.tec.linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 May 2020 19:57:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 20 May 2020 01:42:30 +0200

> Stephen Hemminger <stephen@networkplumber.org> writes:
>> On Wed, 20 May 2020 00:23:48 +0200
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>> No. We did not. -ENOTESTCASE
>>
>> Please try, it isn't that hard..
>>
>> # time for ((i=0;i<1000;i++)); do ip li add dev dummy$i type dummy; done
>>
>> real	0m17.002s
>> user	0m1.064s
>> sys	0m0.375s
> 
> And that solves the incorrectness of the current code in which way?

You mentioned that there wasn't a test case, he gave you one to try.

