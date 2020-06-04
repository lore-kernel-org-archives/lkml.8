Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6646C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D89D207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591239709;
	bh=l4cGGOeQtX576EdkeXJ3SBIP9oSotpU6JYE4NkWSboo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KvulVP2NrqH/n9s9VO5GL7hgsXSstzFvSK8O5UzUtS8gPAyJ/Vv3T22B1GlltReAx
	 19izQO/GMBreu68m5mneTbxzMF7+wJNquLQOckQcYJmtSB8Z6snGyN7zUH2xclMxvi
	 B78oz73L7pdo0nku3Ktt+rq5Rzvk31iwO8pjJ1jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgFDDBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 23:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgFDDBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:01:47 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9B8206C3;
        Thu,  4 Jun 2020 03:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591239707;
        bh=l4cGGOeQtX576EdkeXJ3SBIP9oSotpU6JYE4NkWSboo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqZW2+BxmxhBH0SiAs7rfIX4Vs/xdbBeWAKHX1/JBtoZEDXq3NWr7VMLcLTmmLxeU
         2uVrT+D9hbOUpcIkWoMW+z5jOhcMxO2IVZ2Jh14LBp+48JtfufiyxdXRiPGYwBUU8y
         qAbs3TXuegSpgTVE7+mQ0YZ1MxWbZSEblVH7tB8s=
Date:   Wed, 3 Jun 2020 20:01:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <chiqijun@huawei.com>, <yin.yinshi@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next 5/5] hinic: add support to get eeprom
 information
Message-ID: <20200603200145.41cf76fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200603062015.12640-6-luobin9@huawei.com>
References: <20200603062015.12640-1-luobin9@huawei.com>
        <20200603062015.12640-6-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 14:20:15 +0800 Luo bin wrote:
> add support to get eeprom information from the plug-in module
> with ethtool -m cmd.
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

drivers/net/ethernet/huawei/hinic/hinic_port.c:1386:5: warning: variable port_id set but not used [-Wunused-but-set-variable]
 1386 |  u8 port_id;
      |     ^~~~~~~
