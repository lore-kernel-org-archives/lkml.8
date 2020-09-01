Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1D4C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1682078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgIAULT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgIAULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:11:13 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C770C061244;
        Tue,  1 Sep 2020 13:11:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BD9431364B6FD;
        Tue,  1 Sep 2020 12:54:25 -0700 (PDT)
Date:   Tue, 01 Sep 2020 13:11:11 -0700 (PDT)
Message-Id: <20200901.131111.186993526997490086.davem@davemloft.net>
To:     trix@redhat.com
Cc:     pshelar@ovn.org, kuba@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: openvswitch: pass NULL for unused parameters
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200830212630.32241-1-trix@redhat.com>
References: <20200830212630.32241-1-trix@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Tue, 01 Sep 2020 12:54:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: trix@redhat.com
Date: Sun, 30 Aug 2020 14:26:30 -0700

> Passing unused parameters is a waste.

Poorly predicted branches are an even bigger waste.

I'm not a big fan of this change and others have asked for performance
analysis to be performed.

So I'm not applying this as-is, sorry.

It's also not great to see that CLANG can't make use of the caller's
__always_unused directive to guide these warnings.
