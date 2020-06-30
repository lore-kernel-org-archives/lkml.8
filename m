Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8621DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F77A2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593534046;
	bh=Eb8jNXc8EnYUCEIKTcujPzsprFPnpocxVhhT59LmSoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yn7jEl9Ydnkb92mz7/AfLF6ndHB+thpTwSzLt0IF3HRC11Ws9kNgZ71F4Dk3kTVM3
	 8Mad9YdWYTwjcMlYmlObY/62uSM+ALMnQt+t83cUgARqPNILaotDgK4KBkyHOlvfod
	 PGkB+dnTZwP2Gk2o5LhmwRBB3rZUxndzHvzIuuc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgF3QUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgF3QUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:20:43 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C185206BE;
        Tue, 30 Jun 2020 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593534043;
        bh=Eb8jNXc8EnYUCEIKTcujPzsprFPnpocxVhhT59LmSoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGIqg615Br5QWIaxdnk5k/r3a1XrtPuDMmw8NjiKMUZRS1Dk5Qh13KSUSs1AdYXb4
         Rzlz8Jt/4j4VV58smstGREyuJHMbVhdkLgjj9TF9Da62CnEyYtFH9Vzb6uSn8ZjlhA
         R1B5G15Do++uQCb3jBQ47UEzNxVnKpR/5I4xSd8Q=
Date:   Tue, 30 Jun 2020 09:20:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net] hinic: fix passing non negative value to ERR_PTR
Message-ID: <20200630092041.55d8a245@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200630063554.14639-1-luobin9@huawei.com>
References: <20200630063554.14639-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 14:35:54 +0800 Luo bin wrote:
> get_dev_cap and set_resources_state functions may return a positive
> value because of hardware failure, and the positive return value
> can not be passed to ERR_PTR directly.
> 
> Fixes: 7dd29ee12865 ("net-next/hinic: add sriov feature support")
> Signed-off-by: Luo bin <luobin9@huawei.com>

Fixes tag: Fixes: 7dd29ee12865 ("net-next/hinic: add sriov feature support")
Has these problem(s):
	- Subject does not match target commit subject
	  Just use
		git log -1 --format='Fixes: %h ("%s")'
