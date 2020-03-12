Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018F0C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB1420663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbgCLGPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:15:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56096 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbgCLGPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:15:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8991514D3C78D;
        Wed, 11 Mar 2020 23:15:52 -0700 (PDT)
Date:   Wed, 11 Mar 2020 23:15:51 -0700 (PDT)
Message-Id: <20200311.231551.178115854707336170.davem@davemloft.net>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, yangerkun@huawei.com,
        mkl@pengutronix.de, wg@grandegger.com
Subject: Re: [PATCH] net: slcan, slip -- no need for goto when if () will do
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200309223323.GA1634@duo.ucw.cz>
References: <20200309223323.GA1634@duo.ucw.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Mar 2020 23:15:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 9 Mar 2020 23:33:23 +0100

> No need to play with gotos to jump over single statement.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.
