Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7147C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D23206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBRVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:45:04 -0500
Received: from foss.arm.com ([217.140.110.172]:34962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBRVpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:45:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D583A1FB;
        Tue, 18 Feb 2020 13:45:03 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A043F68F;
        Tue, 18 Feb 2020 13:45:02 -0800 (PST)
Subject: Re: [PATCH v2 0/5] mfd: RK8xx tidyup
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-rockchip@lists.infradead.org, smoch@web.de,
        linux-kernel@vger.kernel.org, heiko@sntech.de
References: <cover.1578789410.git.robin.murphy@arm.com>
Message-ID: <caf2fcfe-696e-9398-7c85-57498107f0ac@arm.com>
Date:   Tue, 18 Feb 2020 21:44:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-12 1:54 am, Robin Murphy wrote:
> Hi all,
> 
> Here's a second crack at my RK805-inspired cleanup. There was a bit
> of debate around v1[1], but it seems like we're now all happy that this
> is a reasonable way to go. For clarity I decided to include Soeren's
> patch as #1/5, but since I've rewritten most of my patches I've not
> included the tested-by tags.

Any more comments, or are these patches good to merge now? My local 
branch seemed to rebase to 5.6-rc1 cleanly, but I can resend if necessary.

Thanks,
Robin.

> 
> [1] https://lore.kernel.org/lkml/cover.1575932654.git.robin.murphy@arm.com/
> 
> Robin Murphy (4):
>    mfd: rk808: Ensure suspend/resume hooks always work
>    mfd: rk808: Stop using syscore ops
>    mfd: rk808: Reduce shutdown duplication
>    mfd: rk808: Convert RK805 to shutdown/suspend hooks
> 
> Soeren Moch (1):
>    mfd: rk808: Always use poweroff when requested
> 
>   drivers/mfd/rk808.c       | 139 +++++++++++++-------------------------
>   include/linux/mfd/rk808.h |   2 -
>   2 files changed, 48 insertions(+), 93 deletions(-)
> 
