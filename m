Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A648C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC332071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDYQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:01:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:51436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDYQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:01:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D58D0AD9F;
        Sat, 25 Apr 2020 16:01:39 +0000 (UTC)
Message-ID: <1587830499.28179.66.camel@suse.cz>
Subject: Re: [BISECTED] bug/regression, x86-64: completely unbootable machine
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 25 Apr 2020 18:01:39 +0200
In-Reply-To: <CALjTZvb_nzOXd09VXJDECu4b7xuS3tduQ1SXJ0BrpCMBp4qcRQ@mail.gmail.com>
References: <CALjTZvaiCzPQT6Jrx4pFW6KuZj2WLSQQpCbU-sg1jEgscQAKFQ@mail.gmail.com>
         <1587715859.28179.17.camel@suse.cz>
         <CALjTZvb_nzOXd09VXJDECu4b7xuS3tduQ1SXJ0BrpCMBp4qcRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-24 at 18:39 +0100, Rui Salvaterra wrote:
> Hi, again,
> 
> On Fri, 24 Apr 2020 at 09:11, Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
> > 
> > The problem you encountered is due to a bug where the code doesn't work on
> > machines with less than 4 physical CPU cores.
> 
> Thinking about it more thoroughly, are you sure that's the bug I'm
> hitting? I'm asking because I have an i5-6200U (Skylake, also dual
> core, dual thread, like the i3-380M) laptop which runs 5.7-rc1/rc2
> just fine.
> 
> Thanks,
> Rui

There is an easy way to tell (besides compiling with those patches on top and
check if it works): run the command "turbostat --interval 1 sleep 0", the
output should tell you the content of the register MSR_TURBO_RATIO_LIMIT.

If bits 31:24 are zero, you see the bug (the code divides by that value),
otherwise you don't. Some 2 cores / 4 threads CPU have a non-zero value there
(even if it doesn't mean much), some others have zero instead.

The Intel Software Developer Manual (SDM) says the register content is like
this:

    Bit Fields      Bit Description
    7:0             Maximum turbo ratio limit of 1 core active.
    15:8            Maximum turbo ratio limit of 2 core active.
    23:16           Maximum turbo ratio limit of 3 core active.
    31:24           Maximum turbo ratio limit of 4 core active.
    39:32           Maximum turbo ratio limit of 5 core active.
    47:40           Maximum turbo ratio limit of 6 core active.
    55:48           Maximum turbo ratio limit of 7 core active.
    63:56           Maximum turbo ratio limit of 8 core active.

As I wrote above, some 2c/4t CPUs will say (correctly) their 4 cores turbo
frequency is zero, such as this Intel Core i5-430M (Arrandale) where I've seen
turbostat saying:

    cpu1: MSR_TURBO_RATIO_LIMIT: 0x00001313
    19 * 133.3 = 2533.3 MHz max turbo 2 active cores
    19 * 133.3 = 2533.3 MHz max turbo 1 active cores

On the contrary, my laptop has an Intel Core i5-5300U (Broadwell, also
2 cores / 4 threads) and it has:

    cpu3: MSR_TURBO_RATIO_LIMIT: 0x1b1b1b1b1b1d
    27 * 100.0 = 2700.0 MHz max turbo 6 active cores
    27 * 100.0 = 2700.0 MHz max turbo 5 active cores
    27 * 100.0 = 2700.0 MHz max turbo 4 active cores
    27 * 100.0 = 2700.0 MHz max turbo 3 active cores
    27 * 100.0 = 2700.0 MHz max turbo 2 active cores
    29 * 100.0 = 2900.0 MHz max turbo 1 active cores

You can see above that the 4 cores turbo freq is declared as 2.7GHz even if
it's nonsense because there aren't 4 cores. In any case, this cpu wouldn't
trigger the bug, just as your skylake.


Thanks,
Giovanni
