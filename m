Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE13C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2A920720
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgGATOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgGATOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:14:32 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3919C08C5C1;
        Wed,  1 Jul 2020 12:14:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5E4AA13404AF4;
        Wed,  1 Jul 2020 12:14:31 -0700 (PDT)
Date:   Wed, 01 Jul 2020 12:14:28 -0700 (PDT)
Message-Id: <20200701.121428.1951593933355913699.davem@davemloft.net>
To:     luobin9@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoxianjun@huawei.com, yin.yinshi@huawei.com,
        cloud.wangxiaoyun@huawei.com, chiqijun@huawei.com
Subject: Re: [PATCH net v1] hinic: fix passing non negative value to ERR_PTR
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200701031633.24249-1-luobin9@huawei.com>
References: <20200701031633.24249-1-luobin9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Jul 2020 12:14:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>
Date: Wed, 1 Jul 2020 11:16:33 +0800

> get_dev_cap and set_resources_state functions may return a positive
> value because of hardware failure, and the positive return value
> can not be passed to ERR_PTR directly.
> 
> Fixes: 7dd29ee12865 ("hinic: add sriov feature support")
> Signed-off-by: Luo bin <luobin9@huawei.com>

Applied, thank you.
