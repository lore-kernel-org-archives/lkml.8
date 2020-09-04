Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3536C2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231784;
	bh=wycQ6jI9pjOiTB5GIp2mZuyFyDlyeuQ9huVpOEiGNBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zvnBk5Fpvxk9cBH5f7bX84kUN13wjoMhLBVGd1I/i0EBac1LFq0mkaxfHkpldilso
	 PAeHSttlgUj4CQxZWPTK50RvVXWb7VrUF5JZWWhOlCkhjIuGVFnWp8bo2mTuZ8N7Lg
	 28Ey8WjPX5kk8Js9U4WUKKpe6E6oj4yIavI5Fv3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgIDPDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730202AbgIDPC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:02:59 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FE42073B;
        Fri,  4 Sep 2020 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231779;
        bh=wycQ6jI9pjOiTB5GIp2mZuyFyDlyeuQ9huVpOEiGNBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=htsQ614gJzrBICf3ZITx+iZk2nx7WN/yqvMGOxY3MATmyUrnWJsSI9Pg0c3Jq56tm
         63i5K7T62hgsFtEj1HoH3hQQu95Nn0y+RDaLW8QQ+6nXu2QzYeu2fLGevjksP5N8mq
         KZ9E3hS88vzoqWlLX6qsM7yhXbGaZrZ6HsHaovXg=
Date:   Fri, 4 Sep 2020 08:02:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc:     <davem@davemloft.net>, <roopa@nvidia.com>, <nikolay@nvidia.com>,
        <jiri@mellanox.com>, <idosch@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH RFC 4/7] bridge: cfm: Kernel space implementation of
 CFM.
Message-ID: <20200904080257.6b2a643f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200904091527.669109-5-henrik.bjoernlund@microchip.com>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
        <20200904091527.669109-5-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 09:15:24 +0000 Henrik Bjoernlund wrote:
> +	rcu_read_lock();
> +	b_port = rcu_dereference(mep->b_port);
> +	if (!b_port)
> +		return NULL;
> +	skb = dev_alloc_skb(CFM_CCM_MAX_FRAME_LENGTH);
> +	if (!skb)
> +		return NULL;

net/bridge/br_cfm.c:171:23: warning: context imbalance in 'ccm_frame_build' - different lock contexts for basic block
