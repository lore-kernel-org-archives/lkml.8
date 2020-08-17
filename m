Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072412072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHQL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:26:14 -0400
Received: from muru.com ([72.249.23.125]:40522 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgHQL0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:26:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2AA4580A3;
        Mon, 17 Aug 2020 11:26:12 +0000 (UTC)
Date:   Mon, 17 Aug 2020 14:26:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     linux@armlinux.org.uk, t-kristo@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix an IS_ERR() vs NULL check in
 _get_pwrdm()
Message-ID: <20200817112640.GG2994@atomide.com>
References: <20200724035430.96287-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724035430.96287-1-jingxiangfeng@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jing Xiangfeng <jingxiangfeng@huawei.com> [200724 06:51]:
> The of_clk_get() function returns error pointers, it never returns NULL.

Thanks applying into fixes.

Tony
