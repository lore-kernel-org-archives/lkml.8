Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA77C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912A20719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbgDASYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:24:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbgDASYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:24:32 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C57AF120F5284;
        Wed,  1 Apr 2020 11:24:30 -0700 (PDT)
Date:   Wed, 01 Apr 2020 11:24:30 -0700 (PDT)
Message-Id: <20200401.112430.163553561499492961.davem@davemloft.net>
To:     xianfengting221@163.com
Cc:     andrew@lunn.ch, mchehab+samsung@kernel.org, andrew@aj.id.au,
        corbet@lwn.net, stfrench@microsoft.com, chris@chris-wilson.co.uk,
        xiubli@redhat.com, airlied@redhat.com, tglx@linutronix.de,
        benh@kernel.crashing.org, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/faraday: fix grammar in function
 ftgmac100_setup_clk() in ftgmac100.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200401105624.17423-1-xianfengting221@163.com>
References: <20200401105624.17423-1-xianfengting221@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Apr 2020 11:24:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hu Haowen <xianfengting221@163.com>
Date: Wed,  1 Apr 2020 18:56:24 +0800

> "its not" is wrong. The words should be "it's not".
> 
> Signed-off-by: Hu Haowen <xianfengting221@163.com>

Applied.
