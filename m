Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AAAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C69320767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="au1Yo8Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbgFYUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390575AbgFYUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:12:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:12:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 64so6500767oti.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjqWFPXEnWS3hoGvyuAvg6oRK8aZbk3ZdmtLDlSQuNw=;
        b=au1Yo8FvpDT6JOJ1tXi7hHdaT6OsuGU81rIqsZupygmz8kNlehMXfBQd/SgFCSSlmi
         /xIuS1VXZQOM12Prs/mj57U1kYzLhf7s28QCGEXeNmf/B9hoPiPgknBcL+lA88raxiiM
         TFRA4Pacwk86XJZl92upnXEd/IjkwC4xz6CtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjqWFPXEnWS3hoGvyuAvg6oRK8aZbk3ZdmtLDlSQuNw=;
        b=AQP3rm93ULlkkE76jvvP4+xeARE8s+nOCI9b/93bd4Hdu0Y6FDh/K1TypoxvX4nwXf
         fmPvTPXocVjwQqa7P9oAGUty4VOo0JSF0H0XgzNe2tqE5g7N2KhdtbiG3SjKXFsUsInT
         K2sYHyaurkNgfsNUZdfBpSrgK6gudixzyY7CoeCnw0bRelT7jOCGo4yg7bYd2990s+Qv
         9l64GSbonXXwo6F04FV4ztAeSR4Cl6H4kzJZ+1lWr8fhMzYhxl0YXlwBrzJff0fe+9XI
         ZHjneicTmLcbEoyw6iGoEXTgs4FmikSd/N70PyZieuVi3UhxoCpN2/3iTuT8/oBl9ifE
         CqsA==
X-Gm-Message-State: AOAM532kBwMC666dZme9enZBmbbHyBJwv1DrOUrINOpHFUk7uXJR6sJN
        GlugIe0mYi/QOcOlfF2mZNoo0esEsEtKA9r4hCk1HA==
X-Google-Smtp-Source: ABdhPJxuRlaeGNvZMAC1U6gP3Vlq6cvqhFevjlnPZk8+xleNmi+cnKqk1FmM57a8YrvK3OfT/lfVBEErO7nuSS1BQks=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr27261522oto.246.1593115972631;
 Thu, 25 Jun 2020 13:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Thu, 25 Jun 2020 16:12:41 -0400
Message-ID: <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 12:00 PM vpillai <vpillai@digitalocean.com> wrote:
>
>
> Fifth iteration of the Core-Scheduling feature.
>
Its probably time for an iteration and We are planning to post v6 based
on this branch:
 https://github.com/digitalocean/linux-coresched/tree/coresched/pre-v6-v5.7.y

Just wanted to share the details about v6 here before posting the patch
series. If there is no objection to the following, we shall be posting
the v6 early next week.

The main changes from v6 are the following:
1. Address Peter's comments in v5
   - Code cleanup
   - Remove fixes related to hotplugging.
   - Split the patch out for force idling starvation
3. Fix for RCU deadlock
4. core wide priority comparison minor re-work.
5. IRQ Pause patch
6. Documentation
   - https://github.com/digitalocean/linux-coresched/blob/coresched/pre-v6-v5.7.y/Documentation/admin-guide/hw-vuln/core-scheduling.rst

This version is much leaner compared to v5 due to the removal of hotplug
support. As a result, dynamic coresched enable/disable on cpus due to
smt on/off on the core do not function anymore. I tried to reproduce the
crashes during hotplug, but could not reproduce reliably. The plan is to
try to reproduce the crashes with v6, and document each corner case for crashes
as we fix those. Previously, we randomly fixed the issues without a clear
documentation and the fixes became complex over time.

TODO lists:

 - Interface discussions could not come to a conclusion in v5 and hence would
   like to restart the discussion and reach a consensus on it.
   - https://lwn.net/ml/linux-kernel/20200520222642.70679-1-joel@joelfernandes.org

 - Core wide vruntime calculation needs rework:
   - https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net

 - Load balancing/migration changes ignores group weights:
   - https://lwn.net/ml/linux-kernel/20200225034438.GA617271@ziqianlu-desktop.localdomain


Please have a look and let me know comments/suggestions or anything missed.

Thanks,
Vineeth
