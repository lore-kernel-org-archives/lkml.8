Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B32BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5CA20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCQLVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:21:35 -0400
Received: from foss.arm.com ([217.140.110.172]:35932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgCQLVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:21:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DB121FB;
        Tue, 17 Mar 2020 04:21:30 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B033F534;
        Tue, 17 Mar 2020 04:21:29 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:21:27 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/15] arm64: Don't use disable_nonboot_cpus()
Message-ID: <20200317112127.GA632169@arrakis.emea.arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
 <20200223192942.18420-6-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223192942.18420-6-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 07:29:32PM +0000, Qais Yousef wrote:
> disable_nonboot_cpus() is not safe to use when doing machine_down(),
> because it relies on freeze_secondary_cpus() which in turn is
> a suspend/resume related freeze and could abort if the logic detects any
> pending activities that can prevent finishing the offlining process.
> 
> Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> is an othogonal config to rely on to ensure this function works
> correctly.
> 
> Use `reboot_cpu` variable instead of hardcoding 0 as the reboot cpu.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will@kernel.org>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org

I'm not sure whether these patches have been queued already (still
unread in my inbox), so here it is:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
