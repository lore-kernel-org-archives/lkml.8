Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEE3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE39F24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgBNPFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:05:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53182 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbgBNPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:05:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 28F9015C3BCEB;
        Fri, 14 Feb 2020 07:05:33 -0800 (PST)
Date:   Fri, 14 Feb 2020 07:05:30 -0800 (PST)
Message-Id: <20200214.070530.386375186739050820.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        huangdaode@huawei.com, linuxarm@huawei.com, kuba@kernel.org
Subject: Re: [PATCH net 0/3] net: hns3: fixes for -net
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
References: <1581645223-23038-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Feb 2020 07:05:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Fri, 14 Feb 2020 09:53:40 +0800

> This series includes three bugfixes for the HNS3 ethernet driver.
> 
> [patch 1] fixes a management table lost issue after IMP reset.
> [patch 2] fixes a VF bandwidth configuration not work problem.
> [patch 3] fixes a problem related to IPv6 address copying.

Series applied.
