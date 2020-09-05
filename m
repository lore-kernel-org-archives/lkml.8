Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C41C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2420797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599345299;
	bh=gTUTS4d/ufrDKJRmFcEEm/1+QytAkLO7wzR/HRpfCBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NyMu4Lr2ehlujVpNKpiNyB7swXqUfToxykn6KsbHk9cI776QmCv3sTvFDRoqmTPBA
	 aQcM/Qwxosz8Nn1rOzCBW8dmi25itWpOIFbjuP0JgyfYeGJs1dRis96pZGvRZBiWPe
	 Lqbj4ZGFo7Ks6T6z3ytcu/5RgpvM4HF0sGZ0fVqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgIEWeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgIEWeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:34:05 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFEC20760;
        Sat,  5 Sep 2020 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599345244;
        bh=gTUTS4d/ufrDKJRmFcEEm/1+QytAkLO7wzR/HRpfCBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K5ZP70/zCGXqVYmpylHCDwAJY3uvzWxpa4hOo/k1obhJVnW5Kcm7B9S0qmhEeB71v
         /s5377eGNcdgfEI9XR5x8+2FYny9FoLHeJoVT4SQ48ZHwErm9QvTdDUxZXhlHxQkdZ
         bqAhtMFnkPoQbBOPtdg47nso8i8b57EPoXHXSlws=
Date:   Sat, 5 Sep 2020 15:34:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net v1 0/2] hinic: BugFixes
Message-ID: <20200905153403.342a3401@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200904083729.1923-1-luobin9@huawei.com>
References: <20200904083729.1923-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 16:37:27 +0800 Luo bin wrote:
> The bugs fixed in this patchset have been present since the following
> commits:
> patch #1: Fixes: 00e57a6d4ad3 ("net-next/hinic: Add Tx operation")
> patch #2: Fixes: 5e126e7c4e52 ("hinic: add firmware update support")

Applied.
