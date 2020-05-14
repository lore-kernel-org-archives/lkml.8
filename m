Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A889CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD61206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589477382;
	bh=6mRRqpiwLxOhCNpCBrqkVr2gH5DQgRKpZIqUUf5ecQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=004iCxhkBYgRxaYaDPSBtobGN7tMcn2WOI0toO710BVy1dIBb/9+ktzpq0AiZcXyR
	 u/Ta24zSDeR8SjEns4ZNPjXcDj1VQTw7a4FkwB1ubsB37AbAuLBLpH0YOgxudgsFRF
	 byYexoSQhFmDds3Sw3cqEIrI6f7Eh97SD9ocnVdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENR3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgENR3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:29:41 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A9AE206D8;
        Thu, 14 May 2020 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589477380;
        bh=6mRRqpiwLxOhCNpCBrqkVr2gH5DQgRKpZIqUUf5ecQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r27XGOpea4qx1qaAU5SwHmRDl+pGxNXaxCnj/9ajye0iMAM9w8BX15G4GS/tuCd78
         0duckZzkLbLr/gR4tGDBP25hGxrqwbzAdMXSZkwyPdEWpMDO1TQ6Atx7DrkCMUllSp
         a2cDDJhbdXNDXxPL8UQqrFk6sCR0UJLSL8iT5wNk=
Date:   Thu, 14 May 2020 10:29:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/5] net: hns3: add some cleanups for -next
Message-ID: <20200514102938.3392ecb7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1589460086-61130-1-git-send-email-tanhuazhong@huawei.com>
References: <1589460086-61130-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 20:41:21 +0800 Huazhong Tan wrote:
> This patchset adds some cleanups for the HNS3 ethernet driver.

You may want to spell out 'state' instead of 'stat' in patch 3, stat is
often used as abbreviation of statistic. But that's a nit pick, up to
you:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
