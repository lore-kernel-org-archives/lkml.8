Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E1DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0714206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgDBNUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:20:10 -0400
Received: from foss.arm.com ([217.140.110.172]:42702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgDBNUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3B2630E;
        Thu,  2 Apr 2020 06:20:09 -0700 (PDT)
Received: from [10.57.59.199] (unknown [10.57.59.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33B83F52E;
        Thu,  2 Apr 2020 06:20:08 -0700 (PDT)
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0dea497-b272-e74a-ac9c-3a3cd653a9f9@arm.com>
Date:   Thu, 2 Apr 2020 14:20:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-02 11:16 am, Yoshihiro Shimoda wrote:
> Hi John,
> 
> I found an issue after applied the following patches:
> ---
> 64c775f driver core: Rename deferred_probe_timeout and make it global
> 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
> c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
> ---
> 
> Before these patches, on my environment [1], some device drivers
> which has iommus property output the following message when probing:
> 
> [    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
> [    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> 
> So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.
> 
> However, after these patches are applied, since the patches are always waiting for 30 seconds
> for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
> Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
> JFYI, I copied the kernel log to the end of this email.
> 
> I guess the patches will be merged into v5.7-rc1 because the patches are contained from
> next-20200316, I'd like to fix the issue in v5.7-rcN cycle somehow.

This already came up in a different context, and there's a proposal from 
John here:

https://lore.kernel.org/lkml/20200330202715.86609-1-john.stultz@linaro.org/

Robin.
