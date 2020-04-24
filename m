Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05513C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCD320774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDXILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:11:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:52786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgDXILA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:11:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 11D68AED2;
        Fri, 24 Apr 2020 08:10:59 +0000 (UTC)
Message-ID: <1587715859.28179.17.camel@suse.cz>
Subject: Re: [BISECTED] bug/regression, x86-64: completely unbootable machine
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Rui Salvaterra <rsalvaterra@gmail.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 24 Apr 2020 10:10:59 +0200
In-Reply-To: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
References: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-24 at 09:00 +0100, Rui Salvaterra wrote:
> Hi, everyone,
> 
> Starting with Linux 5.7-rc1, my Arrandale (Core i3-380M) laptop is
> completely unbootable (the last messages on screen are GRUB's loading
> kernel/initramfs). I was hoping someone would have noticed it before
> 5.7-rc2 had been tagged, but alas. Anyway, I bisected it down to
> commit 1567c3e3467cddeb019a7b53ec632f834b6a9239 (x86, sched: Add
> support for frequency invariance). After reverting it, the machine
> boots again, obviously.
> 
> Let me know if you need any further info in order to fix this issue.
> 
> Complete bisection log follows.
> [...]

Hello Rui,

thanks for the report.

The problem you encountered is due to a bug where the code doesn't work on
machines with less than 4 physical CPU cores. It is fixed by this patch
series:

https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/

The series has been merged in the branch sched/urgent of the "tip" tree
(https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git), the commit
fixing the bug you observed is 23ccee22e834 (x86, sched: Account for CPUs
with less than 4 cores in freq. invariance), and will be merged in Linus'
tree at some point.


Thanks,
Giovanni Gherdovich
