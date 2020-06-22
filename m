Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A293DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BAB20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgFVSSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:18:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53906 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgFVSSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:18:49 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jnR1j-001hb4-4X; Mon, 22 Jun 2020 20:18:39 +0200
Date:   Mon, 22 Jun 2020 20:18:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     yunaixin03610@163.com
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, wuguanping@huawei.com,
        wangqindong@huawei.com
Subject: Re: [PATCH 0/5] Adding Huawei BMA drivers
Message-ID: <20200622181839.GA405672@lunn.ch>
References: <20200622160311.1533-1-yunaixin03610@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622160311.1533-1-yunaixin03610@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:03:06AM +0800, yunaixin03610@163.com wrote:
> From: yunaixin <yunaixin03610@163.com>
> 
> This patch set contains 5 communication drivers for Huawei BMA software.
> The BMA software is a system management software. It supports the status
> monitoring, performance monitoring, and event monitoring of various
> components, including server CPUs, memory, hard disks, NICs, IB cards,
> PCIe cards, RAID controller cards, and optical modules.
> 
> These 5 drivers are used to send/receive message through PCIe channel in
> different ways by BMA software.

This is v2 right? Please put v2 into the subject.

Also, you need to list what changes you have made since v1.

Thanks
      Andrew
