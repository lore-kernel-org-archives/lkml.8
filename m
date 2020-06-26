Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1913CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF81E2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgFZX1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 19:27:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301BC03E979;
        Fri, 26 Jun 2020 16:27:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 284C912758908;
        Fri, 26 Jun 2020 16:27:09 -0700 (PDT)
Date:   Fri, 26 Jun 2020 16:27:08 -0700 (PDT)
Message-Id: <20200626.162708.1730579125273999226.davem@davemloft.net>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com
Subject: Re: [PATCH 0/2] sparc32: srmmu: improve type safety of
 __nocache_fix()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200626181713.GA3547368@kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org>
        <20200626181713.GA3547368@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Jun 2020 16:27:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>
Date: Fri, 26 Jun 2020 21:17:13 +0300

> Any comments on this?

Sorry I didn't see this in my patchwork queue, could you please just resubmit
it to sparclinux@vger.kernel.org

Thank you.
