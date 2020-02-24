Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD3C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746F20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBXWsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:48:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39680 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:48:36 -0500
Received: from localhost (unknown [50.226.181.18])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EFFCA1235831F;
        Mon, 24 Feb 2020 14:47:29 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:47:14 -0800 (PST)
Message-Id: <20200224.144714.329725174070305071.davem@davemloft.net>
To:     vicamo.yang@canonical.com
Cc:     hayeswang@realtek.com, kuba@kernel.org, pmalani@chromium.org,
        kai.heng.feng@canonical.com, grundler@chromium.org,
        vicamo@gmail.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: r8151: check disconnect status after long sleep
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200224071541.117363-1-vicamo.yang@canonical.com>
References: <20200224071541.117363-1-vicamo.yang@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Feb 2020 14:48:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: You-Sheng Yang <vicamo.yang@canonical.com>
Date: Mon, 24 Feb 2020 15:15:41 +0800

> When hotplugging such dock with additional usb devices already attached on
> it, the probing process may reset usb 2.1 port, therefore r8152 ethernet
> device is also reset. However, during r8152 device init there are several
> for-loops that, when it's unable to retrieve hardware registers due to
> being discconected from USB, may take up to 14 seconds each in practice,
> and that has to be completed before USB may re-enumerate devices on the
> bus. As a result, devices attached to the dock will only be available
> after nearly 1 minute after the dock was plugged in:

Your description of the problem and exactly what is happening is great,
but you are not explaining how exactly you are solving the problem and
why you are solving it in that way.

Please enhance your commit message the explain those things.

Thank you.
