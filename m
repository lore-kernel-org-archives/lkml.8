Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63665C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114620936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598900365;
	bh=5UgcUqxc/SGYEeJgPb8komp3CVw3WewY9q80HuOrfc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kUSFQa5jQtrhGg8N4isrz7Ff5aj5avAp0WEjxcQ30wlsHkQc+F822xEON1PJ8gaQ9
	 slar6eceZZ5dibJct0VKu5Hl39Q2pmHIPHTVAZ2CpRKvuJLuwDcAzUwAaesVHKQPma
	 +HPIuvXkMqKaF5/HOWtt2vYWbS4IMgaKSWkLMUd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHaS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgHaS7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:59:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785BD206FA;
        Mon, 31 Aug 2020 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598900361;
        bh=5UgcUqxc/SGYEeJgPb8komp3CVw3WewY9q80HuOrfc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eeCcECK49tqdgHitTotsiExHWwk0a6II0jf0NI0iSO/h/8sFZ1Eu7rBiw1oTnvumV
         PaWjlo1TKCtguo7k3SpxRyhGQ9/PW8i8wPaPkkejyK4qcGGyOnQ2IjWqJG+CH7VMdx
         N6+1IU91pXVizwWGc1RtevE2TEzO0D4VN04olN3U=
Date:   Mon, 31 Aug 2020 11:59:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next v3 1/3] hinic: add support to query sq info
Message-ID: <20200831115920.71969dbc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200829005520.27364-2-luobin9@huawei.com>
References: <20200829005520.27364-1-luobin9@huawei.com>
        <20200829005520.27364-2-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 08:55:18 +0800 Luo bin wrote:
> add debugfs node for querying sq info, for example:
> cat /sys/kernel/debug/hinic/0000:15:00.0/SQs/0x0/sq_pi
> 
> Signed-off-by: Luo bin <luobin9@huawei.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
