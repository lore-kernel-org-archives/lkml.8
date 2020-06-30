Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44B0206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgF3Uob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgF3Uoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:44:30 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299FC061755;
        Tue, 30 Jun 2020 13:44:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 30C731277FAD7;
        Tue, 30 Jun 2020 13:44:30 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:44:29 -0700 (PDT)
Message-Id: <20200630.134429.1590957032456466647.davem@davemloft.net>
To:     edumazet@google.com
Cc:     mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ycheng@google.com, joraj@efficios.com
Subject: Re: [regression] TCP_MD5SIG on established sockets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CANn89iJ+rkMrLrHrKXO-57frXNb32epB93LYLRuHX00uWc-0Uw@mail.gmail.com>
References: <CAHk-=wjEghg5_pX_GhNP+BfcUK6CRZ+4mh3bciitm9JwXvR7aQ@mail.gmail.com>
        <312079189.17903.1593549293094.JavaMail.zimbra@efficios.com>
        <CANn89iJ+rkMrLrHrKXO-57frXNb32epB93LYLRuHX00uWc-0Uw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jun 2020 13:44:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jun 2020 13:39:27 -0700

> The (C) & (B) case are certainly doable.
> 
> A) case is more complex, I have no idea of breakages of various TCP
> stacks if a flow got SACK
> at some point (in 3WHS) but suddenly becomes Reno.

I agree that C and B are the easiest to implement without having to
add complicated code to handle various negotiated TCP option
scenerios.

It does seem to be that some entities do A, or did I misread your
behavioral analysis of various implementations Mathieu?

Thanks.
