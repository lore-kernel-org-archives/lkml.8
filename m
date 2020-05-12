Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FBC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FB620753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgELUGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELUGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:06:34 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B6C061A0C;
        Tue, 12 May 2020 13:06:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AD94212837894;
        Tue, 12 May 2020 13:06:33 -0700 (PDT)
Date:   Tue, 12 May 2020 13:06:33 -0700 (PDT)
Message-Id: <20200512.130633.293867428547074800.davem@davemloft.net>
To:     christian.brauner@ubuntu.com
Cc:     arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct
 kernel_clone_args
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 May 2020 13:06:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 19:15:24 +0200

> I've tested this series with qemu-system-sparc64 and a Debian Sid image
> and it comes up no problem (Here's a little recording
> https://asciinema.org/a/329510 ).

Can you show how you put this environment together and also what
compilation tools you used?  Looks great.

> This is the sparc specific bit and _if_ you agree with the changes here
> it'd be nice if I could get your review, and if technically correct,
> your ack so I can fold this into a larger series and move on to the next
> arch.

With the delay slot instruction indentation fixed:

Acked-by: David S. Miller <davem@davemloft.net>

Thank you.
