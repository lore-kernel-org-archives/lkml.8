Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0948C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEEB206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgFGXkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 19:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgFGXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 19:40:30 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A629C061A0E;
        Sun,  7 Jun 2020 16:40:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3BD7E127385FC;
        Sun,  7 Jun 2020 16:40:30 -0700 (PDT)
Date:   Sun, 07 Jun 2020 16:40:29 -0700 (PDT)
Message-Id: <20200607.164029.2024393765839829686.davem@davemloft.net>
To:     viro@zeniv.linux.org.uk
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] a couple of sparc ptrace fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200607144152.GM23230@ZenIV.linux.org.uk>
References: <20200531010414.GW23230@ZenIV.linux.org.uk>
        <20200607144152.GM23230@ZenIV.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Jun 2020 16:40:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 7 Jun 2020 15:41:52 +0100

> On Sun, May 31, 2020 at 02:04:14AM +0100, Al Viro wrote:
>> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
>> 
>>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-davem
>> 
>> for you to fetch changes up to cf51e129b96847f969bfb8af1ee1516a01a70b39:
>> 
>>   sparc32: fix register window handling in genregs32_[gs]et() (2020-05-20 13:29:37 -0400)
>> 
>> ----------------------------------------------------------------
>> Al Viro (2):
>>       sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
>>       sparc32: fix register window handling in genregs32_[gs]et()
>> 
>>  arch/sparc/kernel/ptrace_32.c | 228 ++++++++++++++++++------------------------
>>  arch/sparc/kernel/ptrace_64.c |  17 +---
>>  2 files changed, 101 insertions(+), 144 deletions(-)
> 
> Grrr...  
> 
> sparc32 fix had breakage of its own; I've pushed a fix into #for-davem.  Fixup
> follows.  Could you pull it?

Done.
