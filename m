Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A04C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1901C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgHZLCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:02:10 -0400
Received: from foss.arm.com ([217.140.110.172]:44176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgHZK5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:57:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35C71FB;
        Wed, 26 Aug 2020 03:57:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F20823F71F;
        Wed, 26 Aug 2020 03:57:31 -0700 (PDT)
References: <20200826104720.530040-1-mchehab+huawei@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: scheduler: fix the directory name on two files
In-reply-to: <20200826104720.530040-1-mchehab+huawei@kernel.org>
Date:   Wed, 26 Aug 2020 11:57:24 +0100
Message-ID: <jhj8se1ektn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/08/20 11:47, Mauro Carvalho Chehab wrote:
> The name of the directory where the schedule docs are
> stored are wrong on those files.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

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
