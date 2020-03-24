Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE96CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD73D2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCXXMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:12:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37682 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCXXMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:12:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 88A51159F39A2;
        Tue, 24 Mar 2020 16:12:11 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:10:11 -0700 (PDT)
Message-Id: <20200324.161011.1071844122704777408.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     vishal@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rahul.lakkireddy@chelsio.com
Subject: Re: [PATCH net-next] cxgb4: remove set but not used variable 'tab'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200324062614.29644-1-yuehaibing@huawei.com>
References: <20200324062614.29644-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Mar 2020 16:12:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 24 Mar 2020 14:26:14 +0800

> @@ -544,7 +544,7 @@ int cxgb4_get_free_ftid(struct net_device *dev, u8 family, bool hash_en,
>  {
>  	struct adapter *adap = netdev2adap(dev);
>  	struct tid_info *t = &adap->tids;
> -	struct filter_entry *tab, *f;
> +	struct filter_entry *f;
>  	u32 bmap_ftid, max_ftid;
>  	unsigned long *bmap;
>  	bool found = false;

Please preserve the reverse christmas tree ordering here.
