Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241D3C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011722072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAQKUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:20:06 -0500
Received: from foss.arm.com ([217.140.110.172]:39044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgAQKUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:20:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F0C11D4;
        Fri, 17 Jan 2020 02:20:05 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70BDA3F68E;
        Fri, 17 Jan 2020 02:20:04 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:19:57 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zeng Tao <prime.zeng@hisilicon.com>, linuxarm@huawei.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] cpu-topology: Don't error on more than CONFIG_NR_CPUS
 CPUs in device tree
Message-ID: <20200117101957.GA4099@bogus>
References: <1579225973-32423-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579225973-32423-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 09:52:52AM +0800, Zeng Tao wrote:
> When the kernel is configured with CONFIG_NR_CPUS smaller than the
> number of CPU nodes in the device tree(DT), all the CPU nodes parsing
> done to fetch topology information will fail. This is not reasonable
> as it is legal to have all the physical CPUs in the system in the DT.
>
> Let us just skip such CPU DT nodes that are not used in the kernel
> rather than returning an error.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>

Hi Greg,

Can you pick this patch for v5.6 ?

--
Regards,
Sudeep
