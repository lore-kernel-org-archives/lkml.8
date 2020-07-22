Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83662C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62059206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 01:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgGVB3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 21:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbgGVB3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:29:32 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B712C061794;
        Tue, 21 Jul 2020 18:29:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B959D11DB315F;
        Tue, 21 Jul 2020 18:12:46 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:29:30 -0700 (PDT)
Message-Id: <20200721.182930.2286555697760796633.davem@davemloft.net>
To:     valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Subject: Re: [PATCH 1/2] sparc64: Deselect IRQ_PREFLOW_FASTEOI
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200703155645.29703-2-valentin.schneider@arm.com>
References: <20200703155645.29703-1-valentin.schneider@arm.com>
        <20200703155645.29703-2-valentin.schneider@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 18:12:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>
Date: Fri,  3 Jul 2020 16:56:44 +0100

> sparc64 hasn't needed to select this since commit:
> 
>   ee6a9333fa58 ("sparc64: sparse irq")
> 
> which got rid of the calls to __irq_set_preflow_handler() first installed
> by commit:
> 
>   fcd8d4f49869 ("sparc: Use the new genirq functionality")
> 
> Deselect this option.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
