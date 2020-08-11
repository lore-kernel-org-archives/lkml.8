Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64BF20781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgHKRYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgHKRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:24:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934ACC06174A;
        Tue, 11 Aug 2020 10:24:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E957312880A1B;
        Tue, 11 Aug 2020 10:07:32 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:24:18 -0700 (PDT)
Message-Id: <20200811.102418.1200203139092745562.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     jhansen@vmware.com, netdev@vger.kernel.org, kuba@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        stefanha@redhat.com
Subject: Re: [PATCH net 0/2] vsock: fix null pointer dereference and
 cleanup in vsock_poll()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200811095504.25051-1-sgarzare@redhat.com>
References: <20200811095504.25051-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Aug 2020 10:07:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 11 Aug 2020 11:55:02 +0200

> The first patch fixes a potential null pointer dereference in vsock_poll()
> reported by syzbot.
> The second patch is a simple cleanup in the same block code. I put this later,
> to make it easier to backport the first patch in the stable branches.

Please do not mix cleanups and bug fixes into the same patch series.

net-next is closed, so you should not be submitting non-bugfixes at
this time.
