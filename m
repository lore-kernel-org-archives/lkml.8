Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84974C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6025920882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgATMOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:14:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56170 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:14:32 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5924014E2028B;
        Mon, 20 Jan 2020 04:14:29 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:14:24 +0100 (CET)
Message-Id: <20200120.131424.39658950858121597.davem@davemloft.net>
To:     ms@dev.tdt.de
Cc:     kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] wan/hdlc_x25: make lapb params configurable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200120061416.27714-1-ms@dev.tdt.de>
References: <20200120061416.27714-1-ms@dev.tdt.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 04:14:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Mon, 20 Jan 2020 07:14:15 +0100

> +static struct x25_state *state(hdlc_device *hdlc)
> +{
> +	return (struct x25_state *)hdlc->state;
> +}

Because hdlc->state is "void *", this cast is unnecessary.
