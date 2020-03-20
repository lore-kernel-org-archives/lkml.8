Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D9120754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCTOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:07:45 -0400
Received: from foss.arm.com ([217.140.110.172]:49394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCTOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:07:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CE51FB;
        Fri, 20 Mar 2020 07:07:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3BC3F792;
        Fri, 20 Mar 2020 07:07:43 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:07:41 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/15] arm64: Don't use disable_nonboot_cpus()
Message-ID: <20200320140741.f37mtomvr5wb6cct@e107158-lin.cambridge.arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
 <20200223192942.18420-6-qais.yousef@arm.com>
 <20200317112127.GA632169@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317112127.GA632169@arrakis.emea.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/20 11:21, Catalin Marinas wrote:
> On Sun, Feb 23, 2020 at 07:29:32PM +0000, Qais Yousef wrote:
> > disable_nonboot_cpus() is not safe to use when doing machine_down(),
> > because it relies on freeze_secondary_cpus() which in turn is
> > a suspend/resume related freeze and could abort if the logic detects any
> > pending activities that can prevent finishing the offlining process.
> > 
> > Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> > is an othogonal config to rely on to ensure this function works
> > correctly.
> > 
> > Use `reboot_cpu` variable instead of hardcoding 0 as the reboot cpu.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > CC: Will Deacon <will@kernel.org>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-kernel@vger.kernel.org
> 
> I'm not sure whether these patches have been queued already (still
> unread in my inbox), so here it is:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin!

Russel has requested to split the arm patch into 2 so that the change to
use reboot_cpu is in a separate patch. I'll do the same for arm64 to stay
consistent. I'll add your Acked-by to both patches if that's okay.

Please shout if you have any objection.

Thanks

--
Qais Yousef
