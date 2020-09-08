Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262ACC2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BAB2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592009;
	bh=bvJMSfVCBdBWy15G1E8xhzkMq027MrMy34f0DRh54K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Opx4/d87G56InPBM6CxdxD8Rq+AQQLEz8HXtfq1tHCsMV3nbw1MzqN0Gy38XnZDRX
	 rAcb66F+eO68nbS2DdJ48yr3Bjyg5Zt1sNBrcdVJa7EJIkKodtcWAIGeLF0MJlWnxI
	 bXpKjJJ/KtTbQtkq28g8D10ObWW86fV1utFjWvgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgIHTGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731214AbgIHTFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:05:51 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B10206DB;
        Tue,  8 Sep 2020 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599591940;
        bh=bvJMSfVCBdBWy15G1E8xhzkMq027MrMy34f0DRh54K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f8sth351qL3WxQ04WSlLz2hj01zjjnH5vA02L5mqF6LqQcJxK6XH0eAFhtpjTfbyv
         HYn9MQvbgcHLrKkAB8/RD0BJ9wktGJqu+fNHP9UmIQSyFSvH/qnJ1ghCfG1Tteo3H7
         fJDLN/r1Ddh+T5NuYUhOJ7Fe7TVquAtR8DcNH26w=
Date:   Tue, 8 Sep 2020 12:05:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/7] net: hns3: misc updates
Message-ID: <20200908120538.4ba70787@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1599533994-32744-1-git-send-email-tanhuazhong@huawei.com>
References: <1599533994-32744-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 10:59:47 +0800 Huazhong Tan wrote:
> There are some misc updates for the HNS3 ethernet driver.
> 
> #1 narrows two local variable range in hclgevf_reset_prepare_wait().
> #2 adds reset failure check in periodic service task.
> #3~#7 adds some cleanups.

Looks trivial:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
