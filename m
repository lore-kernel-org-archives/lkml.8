Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC316C33CA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 22:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4222084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 22:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgAKWlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 17:41:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49250 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbgAKWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 17:41:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87F7415A0B0E5;
        Sat, 11 Jan 2020 14:41:44 -0800 (PST)
Date:   Sat, 11 Jan 2020 14:41:43 -0800 (PST)
Message-Id: <20200111.144143.1259862830806502680.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next 0/7] net: hns3: add some misc update about
 reset issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1578731633-10709-1-git-send-email-tanhuazhong@huawei.com>
References: <1578731633-10709-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 11 Jan 2020 14:41:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Sat, 11 Jan 2020 16:33:46 +0800

> This series includes some misc update relating to reset issue.
> [patch 1/7] & [patch 2/7] splits hclge_reset()/hclgevf_reset()
> into two parts: preparing and rebuilding. Since the procedure
> of FLR should be separated out from the reset task([patch 3/7 &
> patch 3/7]), then the FLR's processing can reuse these codes.
> 
> pci_error_handlers.reset_prepare() is void type function, so
> [patch 6/7] & [patch 7/7] factor some codes related to PF
> function reset to make the preparing done before .reset_prepare()
> return.
> 
> BTW, [patch 5/7] enlarges the waiting time of reset for matching
> the hardware's.

Series applied, thanks.
