Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B611C55194
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431162098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgDWRqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:46:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgDWRqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:46:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC8C230E;
        Thu, 23 Apr 2020 10:46:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1C843F68F;
        Thu, 23 Apr 2020 10:46:50 -0700 (PDT)
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com> <jhj8simxgqo.mognet@arm.com> <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
In-reply-to: <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
Date:   Thu, 23 Apr 2020 18:46:48 +0100
Message-ID: <jhj7dy6xfg7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/04/20 18:29, John Stultz wrote:
> Oof. Way to twist the knife :) I'm probably to blame for that
> deferred_probe_work_func issue. I'll take a look at it.
>

Sorry :(

> thanks
> -john
