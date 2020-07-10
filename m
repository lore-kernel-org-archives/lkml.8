Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F862C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7860520578
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GX8zxuVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGJNg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:36:54 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2252C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:36:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so4213376otc.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nmcel6hnCJlIj22fihRFD6BrYZLNIkP5+FTjhcnw9o8=;
        b=GX8zxuVhdC9uja2zMn8o2d29S/xFaumMWA9hqdJJaq4Yt+cFx8noGVO2kG/WtV0f8A
         /bUlgvYm4jLyOy4+NzLFTMxf91WwW97uDdzz7ske13qLjXYQj8Xx6ZTY6ac7NROEr5SA
         SxzzZLU1A2SNWhD4CAjRWAvnFFXkdDQNuVDAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nmcel6hnCJlIj22fihRFD6BrYZLNIkP5+FTjhcnw9o8=;
        b=ddzbN92+I2COOwhZvGFWwB1vw316d9eyz59HO9B94dpOXh1UK7v5WygKShn/Hsn2Wl
         9pYPzx5oMhu15F7bxIWmBy+OOwX7HuIyrTStrSALGZEuTiVXpgu7O4+ur+U/X6WwrDnT
         MuU3sX6o5INPUtbaEYmLAhxN7T0euvKrRiZO+kVF7mF2Y8JflYjyLTF6jT+XBLJhMyk0
         r/LfcV7s0lE3rtvn7eLkjAJ4qnoUxlF+K62/SrF72UImHZU75btT9s7czi9VTg0LDHxr
         bsXZ3wUCAAQctrb5CwzSdddTWRJih+44mfZPSeu12Osm02ECyt7svJKfzxc8wJDoaCOx
         PUuw==
X-Gm-Message-State: AOAM5326CQRQFNwu/heU50O30qeFDu8fx0GaV2SpXu6yHzFZa3uZ34Ox
        ptcnjziTTI5+5S4t6ElVqOzbqwLcL3pqu+5P99XNKg==
X-Google-Smtp-Source: ABdhPJwVBbcsNjNQvs02Ak+32h+kJHFtnmZ1zNowEhHhzLcOKvCq1Vt5X4LsucLlQ1RJzMaKN62kgE/jK9bd0JxcWcM=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr59311273otn.75.1594388213194;
 Fri, 10 Jul 2020 06:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
In-Reply-To: <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 10 Jul 2020 09:36:42 -0400
Message-ID: <CANaguZArdu1Jz3SvogFSXhnqmbdKX5aAORmGMf_uc+J=UQZpJw@mail.gmail.com>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

On Fri, Jul 10, 2020 at 8:19 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> Hi Joel/Vineeth,
> [...]
> The problem is gone when we reverted this patch. We are running multiple
> uperf threads(equal to cpu number) in a cgroup with coresched enabled.
> This is 100% reproducible on our side.
>
> Just wonder if anything already known before we dig into it.
>
Thanks for reporting this. We haven't seen any lockups like this
in our testing yet.

Could you please add more information on how to reproduce this?
Was it a simple uperf run without any options or was it running any
specific kind of network test?

We shall also try to reproduce this and investigate.

Thanks,
Vineeth
