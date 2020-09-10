Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E25E206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599755764;
	bh=dzZnmnmW/OcULkwgSlJBXQmNt6Lts9wz/zHvPwNp9Eo=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:
	 Cc:Cc:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cs2XjM1fGG0xk8kc6tvoGuYFvt+ZkBbI8N0UJL8OWl3PxAgmgVk4p+6y6Qyq47Xmw
	 7g3XqH0xPd1b9c+/+lZe6Sf5E+Bk3wpLXXKxlpnGnkkkPLAzk5Sgo7m4gateolFFoz
	 ujY7+Z9LrnwPgx5PgNK5WFx6WlSRiam49CWXw73U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIJQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgIJQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:34:17 -0400
Received: from localhost (unknown [70.37.104.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DB121582;
        Thu, 10 Sep 2020 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599755657;
        bh=dzZnmnmW/OcULkwgSlJBXQmNt6Lts9wz/zHvPwNp9Eo=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:
         Cc:Cc:Cc:Subject:In-Reply-To:References:From;
        b=YpwMjIwo8m5ztCnRf7uNWp5ABWFf5uIsg56Ck/Eaw1TrHozTf4PNKD0au+S2BG6Zi
         iy9hvggmavdj7R+XijSp1G4Jq13Fdz/pfIZ50NBq1VBmhRTe7QaDFEIrbvXqnCCzo4
         lPALA2tpLa5g2okAe36l/zqwGrcoi/YYz5GM99C0=
Date:   Thu, 10 Sep 2020 16:34:16 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>
Cc:     Stephane Eranian <eranian@google.com>
Cc:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jiri Olsa <jolsa@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Petlan <mpetlan@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86 <x86@kernel.org>
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] perf/amd/uncore: Set all slices and threads to restore perf stat -a behaviour
In-Reply-To: <20200908214740.18097-2-kim.phillips@amd.com>
References: <20200908214740.18097-2-kim.phillips@amd.com>
Message-Id: <20200910163417.16DB121582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 2f217d58a8a0 ("perf/x86/amd/uncore: Set the thread mask for F17h L3 PMCs").

The bot has tested the following trees: v5.8.7, v5.4.63, v4.19.143, v4.14.196.

v5.8.7: Build OK!
v5.4.63: Failed to apply! Possible dependencies:
    4dcc3df82573 ("perf/amd/uncore: Prepare L3 thread mask code for Family 19h")
    9689dbbeaea8 ("perf/amd/uncore: Make L3 thread mask code more readable")
    e48667b86548 ("perf/amd/uncore: Add support for Family 19h L3 PMU")

v4.19.143: Failed to apply! Possible dependencies:
    4dcc3df82573 ("perf/amd/uncore: Prepare L3 thread mask code for Family 19h")
    6d0ef316b9f8 ("x86/events: Add Hygon Dhyana support to PMU infrastructure")
    9689dbbeaea8 ("perf/amd/uncore: Make L3 thread mask code more readable")
    e48667b86548 ("perf/amd/uncore: Add support for Family 19h L3 PMU")

v4.14.196: Failed to apply! Possible dependencies:
    4dcc3df82573 ("perf/amd/uncore: Prepare L3 thread mask code for Family 19h")
    6d0ef316b9f8 ("x86/events: Add Hygon Dhyana support to PMU infrastructure")
    9689dbbeaea8 ("perf/amd/uncore: Make L3 thread mask code more readable")
    e48667b86548 ("perf/amd/uncore: Add support for Family 19h L3 PMU")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
