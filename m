Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28073C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00164206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFICN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFICNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:13:55 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD12C03E969;
        Mon,  8 Jun 2020 19:13:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2E6AF128A6AEC;
        Mon,  8 Jun 2020 19:13:54 -0700 (PDT)
Date:   Mon, 08 Jun 2020 19:13:53 -0700 (PDT)
Message-Id: <20200608.191353.1433508565956506007.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, gerry@auristor.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] rxrpc: Fix hang due to missing notification
From:   David Miller <davem@davemloft.net>
In-Reply-To: <159164218727.2758133.1046957228494479308.stgit@warthog.procyon.org.uk>
References: <159164218727.2758133.1046957228494479308.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jun 2020 19:13:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 08 Jun 2020 19:49:47 +0100

> Here's a fix for AF_RXRPC.  Occasionally calls hang because there are
> circumstances in which rxrpc generate a notification when a call is
> completed - primarily because initial packet transmission failed and the
> call was killed off and an error returned.  But the AFS filesystem driver
> doesn't check this under all circumstances, expecting failure to be
> delivered by asynchronous notification.
> 
> There are two patches: the first moves the problematic bits out-of-line and
> the second contains the fix.
> 
> The patches are tagged here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	rxrpc-fixes-20200605

Pulled, thanks David.
