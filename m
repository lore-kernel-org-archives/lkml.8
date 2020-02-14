Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0941C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53C522314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLB5TsDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgBNGLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:11:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37720 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgBNGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:11:06 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so5983917lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njfNnQiCeUEBG52xictUVq0m+v7kSIQZeATjIIXbfxk=;
        b=gLB5TsDA1ZRG7nli4iT9ccXWpaGhARLPSH7amAmnB2qRecdOqIntGGWFA3PqwEcZ3d
         J454+6XlzJ0qoL/RrDpQD3slTfmvqv3TudrqflhZx1GMuY5jff7Xgw2JplifroTRZHrP
         AAVgwSrps3WKUImMnJIGqN8VAT6Q2oGCF3ItigcHg4alBdVEPMuv50lbicWExMJ8AvCB
         bQL3J03h4PNohB7NAgwBnrjligWy2ETFdlnvRFzrMJ0Qu8pFq78OzIlRQU5iYbnvLd8i
         Vro3/yDRtgeLaBeqC8nKbx5H25C8qdCrga2Tj5vatdrbZ6Z4414HZ28FGvt00u0Qt+2i
         jDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njfNnQiCeUEBG52xictUVq0m+v7kSIQZeATjIIXbfxk=;
        b=osPYaLFT5MJZ/fWpnlvl4j8TiPaVXelOUZGxNyGsAh4fLkOoJw+sTKdkKkJiKahi3L
         USOu7IiCV8xTrzYPdefP6AuFb9HSzhHq5DqjfKwJ24chIrrg543ejgNZxsKe0wjzTQr+
         LaF3HgNMseGs6aIZz0wf8WOP9hKh3XsQs/LgZtMEs4Jb3XHokV8HiCJ+VMzf1jbVRxk8
         7FqIBDML1QwGCd1r0GN9pg2STaCRGfTYowD5pzV/X9X23JbSgbulNWVlLvL1qEpftOnE
         z8WMcF+XBM9sEWkxjv/kzDWpc8Nh3Nzbry2FZoqaQWnmVgmxAPw0VHPB25zBbdXxkRx/
         ssag==
X-Gm-Message-State: APjAAAWPYp832K4CQdLXxgvsCZj+ZE+/9FNtYSYrDx78FbXHLnK46Z05
        1fuYQ43MblitOnYiJVrVGWfbHbPc8x1VOkxBd9c=
X-Google-Smtp-Source: APXvYqygVd1rQm5kB2iLBme1kZwTu+AN+R2hE9YNReZTO8QkK14cUhr0R55RkJW6ow5UIl5tvwITS3I0CoJ8ObgRuSA=
X-Received: by 2002:a19:850a:: with SMTP id h10mr820790lfd.89.1581660664579;
 Thu, 13 Feb 2020 22:11:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
In-Reply-To: <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 14 Feb 2020 14:10:53 +0800
Message-ID: <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 2:37 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On 2/12/20 3:07 PM, Julien Desfossez wrote:
>
> >>
> >> Have you guys been able to make progress on the issues with I/O intensive workload?
> >
> > I finally have some results with the following branch:
> > https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.5.y
> >
> >
> > So the main conclusion is that for all the test cases we have studied,
> > core scheduling performs better than nosmt ! This is different than what
> > we tested a while back, so it's looking really good !
>
> Thanks for the data.  They look really encouraging.
>
> Aubrey is working on updating his patches so it will load balance
> to the idle cores a bit better.  We are testing those and will post
> the update soon.

I added a helper to check task and cpu cookie match, including the
entire core idle case. The refined patchset updated at here:
https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2

This branch also includes Tim's patchset. According to our testing
result, the performance data looks on par with the previous version.
A good news is, v5.4.y stability issue on our 8 numa node machine
is gone on this v5.5.2 branch.

Thanks,
-Aubrey
