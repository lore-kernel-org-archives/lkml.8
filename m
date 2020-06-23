Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB01C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23E42208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592949507;
	bh=hg2iKk2FyAJhy6WhAIEKOg9w+aKTzzCm6T1h1TJYCAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lIQ3/L+szjrFEkv0FygFc5wonWGrdFGpep5vtf9nKusOxIGcFxPllMmsNKDfsPVYx
	 ZI3HscFFtNxPce5jcHwJrLg0U2FAMAMI/qob+MyT8NhZMnc0Efq4hSmEUDtQbqROIF
	 adseSFh31Z10sHzxEakLK7LPmZ1fqDUvITFZ3GVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbgFWV60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387455AbgFWV6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:58:25 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BCF2078E;
        Tue, 23 Jun 2020 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592949505;
        bh=hg2iKk2FyAJhy6WhAIEKOg9w+aKTzzCm6T1h1TJYCAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MOV0OZdzYNwQBuc3jexI8ZluHuohzKcNHeCNyCHbR3yfkUFQB3OmXux2uGY9VY4YB
         UV1nnTBbpQcbdstxnUAhfAxrtTTi/lNkpPLRETE5TkbKAAUwu2aegOp34Ft1P0wRFt
         di9Sf8HS5W2YhLB3YtJWKxIGSqfMWkIvXWE1KAkg=
Date:   Tue, 23 Jun 2020 14:58:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>
Subject: Re: [PATCH net-next v2 4/5] hinic: add support to identify physical
 device
Message-ID: <20200623145823.5ab8f857@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200623142409.19081-5-luobin9@huawei.com>
References: <20200623142409.19081-1-luobin9@huawei.com>
        <20200623142409.19081-5-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 22:24:08 +0800 Luo bin wrote:
> add support to identify physical device by flashing an LED
> attached to it with ethtool -p cmd.
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
