Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1574D206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598900377;
	bh=tZ+ratlhDoEvROEiPnk37lhwCGzc/2EESC2XmRrEDgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yqc/B/pABwIbkd7CvwIn+4op7mHXhoUNyNB6PxA5jK4js1V4mEtQE/3IA+RGs1LJo
	 utD9P6qsQUtaR68zE/34+cevdLIz9Usq4udBLt1PLCzK/cEmIfIGPr4DdCeAyLXdq1
	 bIkZyRc90oIsOIMZ/DdeA6zOB8fAgvI2fLS7xjbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgHaS7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgHaS7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:59:31 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8277C206FA;
        Mon, 31 Aug 2020 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598900370;
        bh=tZ+ratlhDoEvROEiPnk37lhwCGzc/2EESC2XmRrEDgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hEOs542aHZn07ho2JgMu0BpjwwVC5Gy1ZX6W7LGjT9uRQ4WmF0dhZ91F9Nh4Hd4l9
         9v5lQrK/vvPKaL7k9nh37N0i2PWnrX82zYYj5RmoCNYdvcn5qsQl07WbifEjzsj5TV
         fDw3wBURO6yHvRE3gXICTnpfEWqZXUur+crgZ4C4=
Date:   Mon, 31 Aug 2020 11:59:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next v3 2/3] hinic: add support to query rq info
Message-ID: <20200831115929.6646e680@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200829005520.27364-3-luobin9@huawei.com>
References: <20200829005520.27364-1-luobin9@huawei.com>
        <20200829005520.27364-3-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 08:55:19 +0800 Luo bin wrote:
> add debugfs node for querying rq info, for example:
> cat /sys/kernel/debug/hinic/0000:15:00.0/RQs/0x0/rq_hw_pi
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
