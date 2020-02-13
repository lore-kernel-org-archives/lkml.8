Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA3C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D255520675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbgBMPsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:48:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387891AbgBMPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:47:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0813D15B2C896;
        Thu, 13 Feb 2020 07:47:58 -0800 (PST)
Date:   Thu, 13 Feb 2020 07:47:55 -0800 (PST)
Message-Id: <20200213.074755.849728173103010425.davem@davemloft.net>
To:     manivannan.sadhasivam@linaro.org
Cc:     dcbw@redhat.com, kuba@kernel.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Migrate QRTR Nameservice to Kernel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200213153007.GA26254@mani>
References: <20200213091427.13435-1-manivannan.sadhasivam@linaro.org>
        <34daecbeb05d31e30ef11574f873553290c29d16.camel@redhat.com>
        <20200213153007.GA26254@mani>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Feb 2020 07:47:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 13 Feb 2020 21:00:08 +0530

> The primary motivation is to eliminate the need for installing and starting
> a userspace tool for the basic WiFi usage. This will be critical for the
> Qualcomm WLAN devices deployed in x86 laptops.

I can't even remember it ever being the case that wifi would come up without
the help of a userspace component of some sort to initiate the scan and choose
and AP to associate with.

And from that perspective your argument doesn't seem valid at all.
