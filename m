Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6793C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FC20678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgFCMEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:04:37 -0400
Received: from foss.arm.com ([217.140.110.172]:60686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgFCMEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:04:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08FC331B;
        Wed,  3 Jun 2020 05:04:36 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3D193F305;
        Wed,  3 Jun 2020 05:04:34 -0700 (PDT)
References: <1590597554-370150-1-git-send-email-vincent.donnefort@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     vincent.donnefort@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        dietmar.eggemann@arm.com, qais.yousef@arm.com
Subject: Re: [PATCH] sched/debug: Add new tracepoints to track util_est
In-reply-to: <1590597554-370150-1-git-send-email-vincent.donnefort@arm.com>
Date:   Wed, 03 Jun 2020 13:04:26 +0100
Message-ID: <jhjlfl4icdx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/05/20 17:39, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
>
> The util_est signals are key elements for EAS task placement and
> frequency selection. Having tracepoints to track these signals enables
> load-tracking and schedutil testing and/or debugging by a toolkit.
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>

To put it more bluntly, we can't really do task placement / load tracking
testing if util_est is enabled (which reminds me we may want to get rid of
the SCHED_FEAT at some point, it's been default on since ~v4.17), since
there can be noticeable gaps between util_avg and util_est.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
