Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E531C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D18206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgEOAiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgEOAix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:38:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03217C061A0C;
        Thu, 14 May 2020 17:38:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9626A14CF8695;
        Thu, 14 May 2020 17:38:52 -0700 (PDT)
Date:   Thu, 14 May 2020 17:38:52 -0700 (PDT)
Message-Id: <20200514.173852.694218644901877608.davem@davemloft.net>
To:     luobin9@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        luoxianjun@huawei.com, yin.yinshi@huawei.com,
        cloud.wangxiaoyun@huawei.com
Subject: Re: [PATCH net-next] hinic: update huawei ethernet driver
 maintainer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200513225049.7080-1-luobin9@huawei.com>
References: <20200513225049.7080-1-luobin9@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 May 2020 17:38:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo bin <luobin9@huawei.com>
Date: Wed, 13 May 2020 22:50:49 +0000

> update huawei ethernet driver maintainer from aviad to Bin luo
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

Applied.
