Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D08DC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CC42253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 02:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCJCg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:36:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35024 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgCJCg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:36:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2352120F5285;
        Mon,  9 Mar 2020 19:36:28 -0700 (PDT)
Date:   Mon, 09 Mar 2020 19:36:28 -0700 (PDT)
Message-Id: <20200309.193628.1915009045229686481.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, kuba@kernel.org
Subject: Re: [PATCH V2 net-next 0/9] net: hns3: misc updates for -net-next
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1583552570-51203-1-git-send-email-tanhuazhong@huawei.com>
References: <1583552570-51203-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Mar 2020 19:36:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Sat, 7 Mar 2020 11:42:41 +0800

> This series includes some misc updates for the HNS3 ethernet driver.
> 
> [patch 1] fixes some mixed type operation warning.
> [patch 2] renames a macro to make it more readable.
> [patch 3 & 4]  removes some unnecessary code.
> [patch 5] adds check before assert VF reset to prevent some unsuitable
> error log.
> [patch 6 - 9] some modifications related to printing.
> 
> Change log:
> V1->V2: fixes a wrong print format in [patch 1] suggested by Jian Shen.

Series applied, thank you.
