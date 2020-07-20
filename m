Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA7322BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595268811;
	bh=eu6YAK/AKmt0UAEGY2jBxg6/wBkBh/KhN1CitBZ9Tug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0ESjRGcR+ujb16n+pb9024UrQ8Re6UHGRoUy/lFsBFW+5RbKOIjJPmsuzvjrtZr+o
	 i/kdMPDbEJgPGI+vNeiO7RVUHKwKpKahDcWMmgOC398Amb1xdoDFoF5p5mHwu6+YJ1
	 WkfiqitTf190SJUN+4W6pTiuCrYpuTDFGDDaIWOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgGTSNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgGTSN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:13:28 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B4C22B4E;
        Mon, 20 Jul 2020 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595268808;
        bh=eu6YAK/AKmt0UAEGY2jBxg6/wBkBh/KhN1CitBZ9Tug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uSs4lfuqEdcsNCdWGAjIbHcrLkTWF8D5qkTtG3s6NHgca15UILI7yPc+BTMrpPpCu
         fdK0NpVRzDrU0ymSonsB1safxXd7hNmOgOZO585W7aPrhovKZyCv6EnjWEmuhaHeB/
         n7T66fLO05EfIKur3eWimO5n3EA+mDn4nzl6HURY=
Date:   Mon, 20 Jul 2020 11:13:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next v2 1/2] hinic: add support to handle hw
 abnormal event
Message-ID: <20200720111326.301b6d74@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200718085830.27821-2-luobin9@huawei.com>
References: <20200718085830.27821-1-luobin9@huawei.com>
        <20200718085830.27821-2-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 16:58:29 +0800 Luo bin wrote:
> add support to handle hw abnormal event such as hardware failure,
> cable unplugged,link error
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>
> ---
> V1~V2: add link extended state
> V0~V1: fix auto build test WARNING

I don't understand what you think devlink health is missing.

If it is really missing some functionality you require you have to work
on extending it.

Dumping error event state into kernel logs when we have specific
infrastructure built to address this sort of needs won't fly.
