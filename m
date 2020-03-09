Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12014C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC968206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIFJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:09:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIFJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:09:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4013B158B8EA5;
        Sun,  8 Mar 2020 22:09:01 -0700 (PDT)
Date:   Sun, 08 Mar 2020 22:09:00 -0700 (PDT)
Message-Id: <20200308.220900.2003952585762736013.davem@davemloft.net>
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
Subject: Re: [PATCH v2 00/17] net: introduce Qualcomm IPA driver (UPDATED)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200306042831.17827-1-elder@linaro.org>
References: <20200306042831.17827-1-elder@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 08 Mar 2020 22:09:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>
Date: Thu,  5 Mar 2020 22:28:14 -0600

> This series presents the driver for the Qualcomm IP Accelerator (IPA).

Series applied, thank you.
