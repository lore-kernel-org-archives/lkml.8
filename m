Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F54C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4910E20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgG3XrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgG3XrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:47:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC221C061574;
        Thu, 30 Jul 2020 16:47:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1D0B7126C06A6;
        Thu, 30 Jul 2020 16:30:33 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:47:17 -0700 (PDT)
Message-Id: <20200730.164717.749974909338549420.davem@davemloft.net>
To:     min.li.xe@renesas.com
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ptp: ptp_clockmatrix: update to support 4.8.7
 firmware
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1595966430-8603-1-git-send-email-min.li.xe@renesas.com>
References: <1595966430-8603-1-git-send-email-min.li.xe@renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jul 2020 16:30:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <min.li.xe@renesas.com>
Date: Tue, 28 Jul 2020 16:00:30 -0400

> From: Min Li <min.li.xe@renesas.com>
> 
> With 4.8.7 firmware, adjtime can change delta instead of absolute time,
> which greately increases snap accuracy. PPS alignment doesn't have to
> be set for every single TOD change. Other minor changes includes:
> adding more debug logs, increasing snap accuracy for pre 4.8.7 firmware
> and supporting new tcs2bin format.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Applied to net-next, thanks.
