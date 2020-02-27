Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3FDC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE40F20656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgB0BN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:13:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgB0BN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:13:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D066915AE21D4;
        Wed, 26 Feb 2020 17:13:27 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:13:27 -0800 (PST)
Message-Id: <20200226.171327.726312650027889484.davem@davemloft.net>
To:     nsaenzjulienne@suse.de
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, wahrenst@gmx.net,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bcmgenet: Clear ID_MODE_DIS in
 EXT_RGMII_OOB_CTRL when not needed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200225131159.26602-1-nsaenzjulienne@suse.de>
References: <20200225131159.26602-1-nsaenzjulienne@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Feb 2020 17:13:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Tue, 25 Feb 2020 14:11:59 +0100

> Outdated Raspberry Pi 4 firmware might configure the external PHY as
> rgmii although the kernel currently sets it as rgmii-rxid. This makes
> connections unreliable as ID_MODE_DIS is left enabled. To avoid this,
> explicitly clear that bit whenever we don't need it.
> 
> Fixes: da38802211cc ("net: bcmgenet: Add RGMII_RXID support")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> Changes since v1:
>  - Fix tags ordering
>  - Add targeted tree

Applied and queued up for v5.5 -stable.
