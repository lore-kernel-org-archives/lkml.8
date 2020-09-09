Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC067C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E2A2065E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIISMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:12:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIISMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:12:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 675C8101E;
        Wed,  9 Sep 2020 11:12:19 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814813F68F;
        Wed,  9 Sep 2020 11:12:18 -0700 (PDT)
References: <cover.1599660067.git.mchehab+huawei@kernel.org> <a32c2bba17aa69dc18670b7de1a3a35bfa1e1f88.1599660067.git.mchehab+huawei@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/30] docs: scheduler: fix the directory name on two files
In-reply-to: <a32c2bba17aa69dc18670b7de1a3a35bfa1e1f88.1599660067.git.mchehab+huawei@kernel.org>
Date:   Wed, 09 Sep 2020 19:12:13 +0100
Message-ID: <jhjy2li6cqq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



(+Cc Ingo, Peter)

On 09/09/20 15:10, Mauro Carvalho Chehab wrote:
> The name of the directory where the schedule docs are
> stored are wrong on those files.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This still stands from last posting:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

In the cover letter you mention resending a bunch of these (including this
one) as they weren't picked up. Ingo / Peter, would you guys mind picking
this one up in tip? AFAICT it's the only scheduler-related patch of the
series.

> ---
>  Documentation/scheduler/sched-capacity.rst | 2 +-
>  Documentation/scheduler/sched-energy.rst   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
> index 00bf0d011e2a..9b7cbe43b2d1 100644
> --- a/Documentation/scheduler/sched-capacity.rst
> +++ b/Documentation/scheduler/sched-capacity.rst
> @@ -365,7 +365,7 @@ giving it a high uclamp.min value.
>  .. note::
>
>    Wakeup CPU selection in CFS can be eclipsed by Energy Aware Scheduling
> -  (EAS), which is described in Documentation/scheduling/sched-energy.rst.
> +  (EAS), which is described in Documentation/scheduler/sched-energy.rst.
>
>  5.1.3 Load balancing
>  ~~~~~~~~~~~~~~~~~~~~
> diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
> index 78f850778982..001e09c95e1d 100644
> --- a/Documentation/scheduler/sched-energy.rst
> +++ b/Documentation/scheduler/sched-energy.rst
> @@ -331,7 +331,7 @@ asymmetric CPU topologies for now. This requirement is checked at run-time by
>  looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
>  domains are built.
>
> -See Documentation/sched/sched-capacity.rst for requirements to be met for this
> +See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
>  flag to be set in the sched_domain hierarchy.
>
>  Please note that EAS is not fundamentally incompatible with SMP, but no
