Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E67C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D075220838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596060187;
	bh=LD9BhmIzX4YumPHb5UlSPSVhGGoH73D44GF0F7CO2KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZQ2oJ9QI2cqlRJw1UM1cZtFg7fnQJ64CvYRnYI1zF+8CU+AzWnbUCWawL9x6v90nF
	 eUfg7wu6hjBpyurT76/asdAwyUNE7+achKQ7vZeSxgrsm8xYtMuGLBSSRA52UxKOz0
	 PkpcOWV7R3jA8VaHY/WT2GPPuNoCFHXTh1FsuIaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgG2WDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2WDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:03:06 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EC52070B;
        Wed, 29 Jul 2020 22:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596060185;
        bh=LD9BhmIzX4YumPHb5UlSPSVhGGoH73D44GF0F7CO2KM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t1Z2YYv/zGzV0WjL6nMyk9d4+0lxJ5BK5pzCLoBg+KXA6KgnpM9uz/9UJR8T6NUfp
         /Gry3A4MRb8H2cT0E9TIDZDoY8MRdV1kYf2eeW6ShLXH19PmXGIUH26VRrbRi6m1PU
         xI9JKvzi+AKoI6ur+8IpK5u15en1pAEC0VlG6tvA=
Date:   Wed, 29 Jul 2020 15:03:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo bin <luobin9@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoxianjun@huawei.com>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <chiqijun@huawei.com>
Subject: Re: [PATCH net-next] hinic: add generating mailbox random index
 support
Message-ID: <20200729150303.0cbe7948@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200729005919.11293-1-luobin9@huawei.com>
References: <20200729005919.11293-1-luobin9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 08:59:19 +0800 Luo bin wrote:
> add support to generate mailbox random id for VF to ensure that
> the mailbox message from VF is valid and PF should check whether
> the cmd from VF is supported before passing it to hw.

This is hard to review. I don't see how the addition of
hinic_mbox_check_cmd_valid() correlates to the random id 
thing. Please split this into two or more patches making
one logical change each.

