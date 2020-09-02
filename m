Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2A42072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBJ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:29:47 -0400
Received: from foss.arm.com ([217.140.110.172]:34228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBJ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:29:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1ED31B;
        Wed,  2 Sep 2020 02:29:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CBE23F68F;
        Wed,  2 Sep 2020 02:29:45 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:29:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
Message-ID: <20200902092939.GA26433@e121166-lin.cambridge.arm.com>
References: <20200818063625.980-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818063625.980-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:36:23PM +0800, Zenghui Yu wrote:
> * From v1 [1]:
>   - As pointed out by Hanjun, remove two now unused inline functions.
>     Compile tested with CONFIG_IOMMU_API is not selected.
> 
> [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
> 
> Zenghui Yu (2):
>   ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
>   ACPI/IORT: Remove the unused inline functions
> 
>  drivers/acpi/arm64/iort.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

On the series:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
