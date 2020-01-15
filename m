Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B24C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AD224679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgAOSqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:46:14 -0500
Received: from foss.arm.com ([217.140.110.172]:41216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgAOSqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:46:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A51328;
        Wed, 15 Jan 2020 10:46:12 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1AF53F6C4;
        Wed, 15 Jan 2020 10:46:09 -0800 (PST)
Subject: Re: [PATCH 0/2] Add EDAC support for Kryo CPU core caches
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, tsoni@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, psodagud@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, baicar@os.amperecomputing.com
References: <0101016ed57a10a8-bd8fbdb9-a5cd-4460-bae6-c5c35f0eed88-000000@us-west-2.amazonses.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <0769b7cb-4e01-eb83-8ad4-b29b4fafafd4@arm.com>
Date:   Wed, 15 Jan 2020 18:46:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0101016ed57a10a8-bd8fbdb9-a5cd-4460-bae6-c5c35f0eed88-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

(CC: +Tyler)

On 05/12/2019 09:52, Sai Prakash Ranjan wrote:
> This series implements EDAC support for error reporting on
> Kryo{3,4}XX CPU caches L1,L2, L3-SCU. All the cores(big.LITTLE)
> in Kryo{3,4}XX CPUs implement RAS extensions and use interrupt
> based ECC mechanism to report errors.
> 
> This series has been tested on SC7180, SDM845, SM8150 SoCs with
> Kryo{3,4}XX CPU cores based on ARM Cortex-A55, Cortex-A75 and
> Cortex-A76.
> 
> This implementation is platform specific in contrast to the
> patch posted last time for generic error reporting on arm cortex
> implementations with RAS extensions by Kyle Yan.
>  - https://patchwork.kernel.org/patch/10161955/

I think that series was dropped because it was too soc-specific and overlaps with the v8.2
kernel first support. That series was superseded by:
lore.kernel.org/r/1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com

Can you work with Tyler on a combined series? The combined support may need to look quite
different. (DT and big/little being the obvious differences).

I'm afraid this is the tip of the kernel-first-RAS iceberg.


Thanks,

James
