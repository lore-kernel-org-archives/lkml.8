Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA370C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89FE20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590169151;
	bh=RRhumbpcXuP6sfYkFPLXxlQCEq9VlFfm+mydeGn9aho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T8+kwD4r028KQFscOWuDDyLDjcoVvrDDMQlwdvrAQJjuqd9yBRZyiauPZi/9SQTwK
	 Ok3K7XZlvq7oexxEy2jPRQvC89rbgBSe3z/I+Oh6kW3+G6VfTUMxcKwdNo/3LEELcS
	 Q6ow+gK8bG4gnH048cgavGwR+GkI/qnDfzVhVCeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgEVRjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbgEVRjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:39:10 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D75A20756;
        Fri, 22 May 2020 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590169149;
        bh=RRhumbpcXuP6sfYkFPLXxlQCEq9VlFfm+mydeGn9aho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JVI1Pqcr+F/6/5sNrTQWxtzkb/EpjwA50vIt4rKfOQ4uCHLBS10fzJ2WFfOP3q0Cv
         0m/CdlgjC2u5bRzq+Sg5bj43w88O/ckKB/qIYUKY6AEQmJL3KCIJE5WjIdE7BJcPpJ
         hYq/dzw7+TZB002FyO7jIFKg/Tl+QYoWKbWmw9MY=
Date:   Fri, 22 May 2020 10:39:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>
Subject: Re: [PATCH net-next 1/5] net: hns3: add support for VF to query
 ring and vector mapping
Message-ID: <20200522103907.2eec2b6e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1590115786-9940-2-git-send-email-tanhuazhong@huawei.com>
References: <1590115786-9940-1-git-send-email-tanhuazhong@huawei.com>
        <1590115786-9940-2-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 10:49:42 +0800 Huazhong Tan wrote:
> From: Guangbin Huang <huangguangbin2@huawei.com>
> 
> This patch adds support for VF to query the mapping of ring and
> vector.
> 
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

Could you explain a little more what this is doing?

Also what's using this? In the series nothing is making this request.
