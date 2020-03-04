Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E76C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D8F20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbgCDWPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:15:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46732 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDWPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:15:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C1A7E15AD71B2;
        Wed,  4 Mar 2020 14:15:47 -0800 (PST)
Date:   Wed, 04 Mar 2020 14:15:47 -0800 (PST)
Message-Id: <20200304.141547.1905642444413562833.davem@davemloft.net>
To:     elder@linaro.org
Cc:     arnd@arndb.de, bjorn.andersson@linaro.org, agross@kernel.org,
        johannes@sipsolutions.net, dcbw@redhat.com, evgreen@google.com,
        ejcaruso@google.com, syadagir@codeaurora.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        robh+dt@kernel.org, mark.rutland@arm.com, ohad@wizery.com,
        sidgup@codeaurora.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] net: introduce Qualcomm IPA driver (UPDATED)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200228224204.17746-1-elder@linaro.org>
References: <20200228224204.17746-1-elder@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Mar 2020 14:15:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>
Date: Fri, 28 Feb 2020 16:41:47 -0600

> This series presents the driver for the Qualcomm IP Accelerator (IPA).

This doesn't apply cleanly to the net-next tree if that's where you want
this applied, can you respin?

Thanks.
