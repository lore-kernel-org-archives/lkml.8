Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F282C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF92074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588183025;
	bh=7bL7fy+zpvRaBRGS3vof7/tm6Y0uLMnCbzbmo6MPs20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CQKLpwrIDYZCkPAjLr/1SxA1jaEg4WTq7Jx4E5vLmMDIJ79iEdq8+d5A3FoYy2UC2
	 7udizFaMusZqYLqkLVLQxPqb7s0xRCZ351873phoKL/9/LoThirUyikW0KSFny8+Nu
	 zuYcPX6wuQqdlb+EdEwryg5dsfNDlkyT0wEIN/fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2R5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2R5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:57:03 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397102064A;
        Wed, 29 Apr 2020 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588183023;
        bh=7bL7fy+zpvRaBRGS3vof7/tm6Y0uLMnCbzbmo6MPs20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JrbndfwgSxUsQ92RildFa6fwr0+e5oUkrk/P8NQG8uXDGi02YzHFZpZ7vL+Y3EIbF
         IRjcmheu0byjABnl5/vmvxvG7VdJ4bGKVzXo6Ftn9VBJphzof8U99taQGId8NzP3K6
         lGaLyXE7+vkAsD+lYV802LFOOQFBEhOR4AYiYG/I=
Date:   Wed, 29 Apr 2020 10:57:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        Yonglong Liu <liuyonglong@huawei.com>
Subject: Re: [PATCH V2] net: hns3: adds support for reading module eeprom
 info
Message-ID: <20200429105701.5b4daa7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1588131984-27468-1-git-send-email-tanhuazhong@huawei.com>
References: <1588131984-27468-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 11:46:24 +0800 Huazhong Tan wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> This patch adds support for reading the optical module eeprom
> info via "ethtool -m".
> 
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
