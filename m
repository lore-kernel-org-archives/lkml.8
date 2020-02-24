Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A494C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86612067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBXB1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:27:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58294 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXB1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:27:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::f0c])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E400C13411C32;
        Sun, 23 Feb 2020 17:27:11 -0800 (PST)
Date:   Sun, 23 Feb 2020 17:27:11 -0800 (PST)
Message-Id: <20200223.172711.2214140372026747021.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        tanhuazhong@huawei.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns3: remove redundant initialization of pointer
 'client'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200222195231.200089-1-colin.king@canonical.com>
References: <20200222195231.200089-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 23 Feb 2020 17:27:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sat, 22 Feb 2020 19:52:31 +0000

> @@ -9076,7 +9076,7 @@ static int hclge_init_nic_client_instance(struct hnae3_ae_dev *ae_dev,
>  static int hclge_init_roce_client_instance(struct hnae3_ae_dev *ae_dev,
>  					   struct hclge_vport *vport)
>  {
> -	struct hnae3_client *client = vport->roce.client;
> +	struct hnae3_client *client;
>  	struct hclge_dev *hdev = ae_dev->priv;
>  	int rst_cnt;
>  	int ret;

Please preserve the reverse christmas tree ordering of local variables when
you make changes like this.
