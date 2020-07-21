Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F87C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1172077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgGUXHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:07:50 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EEC061794;
        Tue, 21 Jul 2020 16:07:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7C6C911E45904;
        Tue, 21 Jul 2020 15:51:04 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:07:48 -0700 (PDT)
Message-Id: <20200721.160748.512782775104680938.davem@davemloft.net>
To:     alobakin@marvell.com
Cc:     kuba@kernel.org, irusskikh@marvell.com,
        michal.kalderon@marvell.com, aelior@marvell.com,
        denis.bolotin@marvell.com, tomer.tayar@marvell.com,
        GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] qed: suppress irrelevant error messages on HW
 init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200721144143.379-1-alobakin@marvell.com>
References: <20200721144143.379-1-alobakin@marvell.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 15:51:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@marvell.com>
Date: Tue, 21 Jul 2020 17:41:41 +0300

> This raises the verbosity level of several error/warning messages on
> driver/module initialization, most of which are false-positives, and
> the one actively spamming the log for no reason.

Series applied.
