Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FA0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F883206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599838429;
	bh=ppKz9/xMA3knCPoLo9BVKXtZb35GS+zrwtH21mrYvGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XeptAQeaSvSrMUEAolOvEswLr4okttHM4Vx6epYCPZaCySw00UAs6LhR7oQbZzNzN
	 M1jLiZFj+rpWVZauzNO/9eOH/W3mEJNeSoN3J1VHRj3QjuI1K53llK4X9OLRLo2IIN
	 XW77zkofIQRHjrzE8SwoJQx/UwXQLbS0LfgHzcOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgIKPd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgIKP2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:10 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7135B20770;
        Fri, 11 Sep 2020 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599838070;
        bh=ppKz9/xMA3knCPoLo9BVKXtZb35GS+zrwtH21mrYvGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JdgqVYkebQFsn49OmtvAcPswaNTVMYCRs7Kdc+4NJFytfbtEBY5GkV3PrnW5d+2bD
         KXS0K/gr0wwbKnfBDhRpvSztofOMT4b8XLdVUzkJVa5Sfy5BDF/xoAd2QptpjLr/Cr
         boHJ7qXmWoMs+9ITvshtTo1Eoyde8sucrARH/uSk=
Date:   Fri, 11 Sep 2020 08:27:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net v1] hinic: fix rewaking txq after netif_tx_disable
Message-ID: <20200911082748.377cd9f2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200910140440.20361-1-luobin9@huawei.com>
References: <20200910140440.20361-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 22:04:40 +0800 Luo bin wrote:
> When calling hinic_close in hinic_set_channels, all queues are
> stopped after netif_tx_disable, but some queue may be rewaken in
> free_tx_poll by mistake while drv is handling tx irq. If one queue
> is rewaken core may call hinic_xmit_frame to send pkt after
> netif_tx_disable within a short time which may results in accessing
> memory that has been already freed in hinic_close. So we call
> napi_disable before netif_tx_disable in hinic_close to fix this bug.
> 
> Fixes: 2eed5a8b614b ("hinic: add set_channels ethtool_ops support")
> Signed-off-by: Luo bin <luobin9@huawei.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
