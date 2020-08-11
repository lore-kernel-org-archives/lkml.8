Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4AAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB32D20774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597161685;
	bh=HfTydH9geFaRSnkoG8mA3Y504eGsoqdIyQhcH0Tq7jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HzY/advfevGgXb3013iU8XyiE8azhE61wxT0NNirO/MN/pQjDdekOe2oE0W+6yCL+
	 3s62IrJ3STT8X5FRSWjjNtSK1fJRlKH7P11w0rTURIEUF8Bf8S+koyGDe/iM8HEA2F
	 U3rzKFhBWQprKQTQYxt0dTTrAO1+8nLUcXcuT+/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgHKQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgHKQBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:01:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037CE206B5;
        Tue, 11 Aug 2020 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597161682;
        bh=HfTydH9geFaRSnkoG8mA3Y504eGsoqdIyQhcH0Tq7jY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cVXsv9wYmfGFx0gaK16wiXeufTPPBrqzllVISaGOK4UYxwjkRDbnXL2KbHwQJdZ8p
         uZFfRVeD2wqb0FgEuFoYYQnzcYdDRyDq6nwXBLyxHSp4/GdL2bMrRLuMPCNoHjfAij
         lx9t+9c4NUDF9KytNHa6Uagv18UPgKe1Q1i/h7ag=
Date:   Tue, 11 Aug 2020 09:01:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     ira.weiny@intel.com
Cc:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tls: Fix kmap usage
Message-ID: <20200811090120.4c122255@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200811000258.2797151-1-ira.weiny@intel.com>
References: <20200811000258.2797151-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 17:02:58 -0700 ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> When MSG_OOB is specified to tls_device_sendpage() the mapped page is
> never unmapped.

Nice catch!

> Hold off mapping the page until after the flags are checked and the page
> is actually needed.

We could take the kmap/kunmap from under the socket lock, but that'd
perhaps be more code reshuffling than we need in a fix.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
