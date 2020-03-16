Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD69C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6D620658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584395312;
	bh=CnMIboNQ97/1ItjUrq7+ZP+N7ilQvKJ+yQhVKn2gXxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e7WjzGkmNvNCW8zXSRRB5nyxJrPrDJzrxO4h1mxuvX4TOXrJwQxBbNWZm1GnP6Y0k
	 +dtaHs3HaLi9ugzgaRM1RFCuOookBXrFWyaJGvgbmcQ2Npjt/zdICh7YtF/kwCU21D
	 XK06H4Eu8M3a+dAt7oNatLIWuutElXEjW4Rpq1W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgCPVsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbgCPVsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:48:31 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522A9205ED;
        Mon, 16 Mar 2020 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584395310;
        bh=CnMIboNQ97/1ItjUrq7+ZP+N7ilQvKJ+yQhVKn2gXxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qM2kP/BYZ7DUmBQYHTM9wb4HhiuS6OasxRNyHAX1fLbzsw/I6Wq9WJGCdiTFN1lXQ
         882qGFnrvf2t3TSCW6F9EunbPbTPnNOOEVSfTkEwbZRN/ZSZgk5lf9caO2yZVTiNiM
         iX6B6GxHXrza5cgeKuhPgsZCtwKeZPADW/yrORd8=
Date:   Mon, 16 Mar 2020 14:48:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <aviad.krawczyk@huawei.com>,
        <luoxianjun@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <yin.yinshi@huawei.com>
Subject: Re: [PATCH net 3/6] hinic: fix the bug of clearing event queue
Message-ID: <20200316144617.16a84f15@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200316005630.9817-4-luobin9@huawei.com>
References: <20200316005630.9817-1-luobin9@huawei.com>
        <20200316005630.9817-4-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 00:56:27 +0000 Luo bin wrote:
> +	synchronize_irq(eq->msix_entry.vector);
> +	free_irq(eq->msix_entry.vector, eq);

Doesn't free_irq() imply synchronize_irq()?
