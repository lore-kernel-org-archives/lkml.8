Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DE5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C25F20708
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594054682;
	bh=GEufiPLHL4Nbly1lFuGDh/rrlW5QF5QlEhBoJCGKZFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JiRN/NcFDrngAzWRLv0THYz5Yo14JFyrEgCts86JOiYXEgwmSeb5R2l8vQfi+Wdjw
	 YxG+lvEoxpemkSLhF1f+QKt5rFGehvYGteLv8dzxvxi902hB730bPUastmoK8ITAxq
	 UfnuLV2a5KDl4Vw6nh+uObLbfaqLtLG+937xyObM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgGFQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgGFQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:58:00 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD0220702;
        Mon,  6 Jul 2020 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594054680;
        bh=GEufiPLHL4Nbly1lFuGDh/rrlW5QF5QlEhBoJCGKZFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BeiZPfbQ50ORdx2w+4fNMZwRFQlWzivGquRkh1WpaxX14+4JQikNxziZ0wPFoyhoe
         UBoN3Mu8WqrowhpyX7jSiI2hFM52I+iza44p5eeAlEPc8WGQMwqjx7EIjBYNEC3KvX
         2j5rhZwDy7rdkylpjlqiWIPr2uRNWq3WsUX7+VUo=
Date:   Mon, 6 Jul 2020 09:57:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next] hinic: add firmware update support
Message-ID: <20200706095758.713a069a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200706145406.7742-1-luobin9@huawei.com>
References: <20200706145406.7742-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 22:54:06 +0800 Luo bin wrote:
> add support to update firmware with with "ethtool -f" cmd
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:1996:44: warning: missing braces around initializer
drivers/net/ethernet/huawei/hinic/hinic_ethtool.c:1996:44: warning: missing braces around initializer

But really - please try to implement the devlink flashing API, using
ethtool for this is deprecated.
