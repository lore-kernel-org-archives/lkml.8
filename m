Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F001C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F528206CC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1Lbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:31:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1Lbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:31:51 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jI9gr-0003tF-C4
        for linux-kernel@vger.kernel.org; Sat, 28 Mar 2020 11:31:49 +0000
Received: by mail-wr1-f70.google.com with SMTP id f8so6115042wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 04:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qqy0+XOT8WqhQrltX5gCRS9oS4phxUfRkeGmoD35Mjs=;
        b=jzs68STnmZ5Twzhm8RVBNRNkwAlP+1b7Szd8TLYDjERWRb+HL82dMHyLE/HNvAZjYh
         ytQ2pac8btyATdZdu+gTVaUVm4roEQJS8y1gtNzyW3ohpQTdp7WWMdtGppgTI291Fa8A
         w5IrJeyh+Cxk0L82lZP/A5PUwcJj3Kmv0hvjDCNrNAeeLadZKnPYcUtZNbgQmtxySuWt
         vEnaopzxQ4yOwIMi2Pfkx58aXaVcwem8ugxBMphmryiWb0/A+CiElLqOiADUU3pnVpXG
         rbDHj629Ih9AGDo0KPByilJupE+u0RyegLPKp+1gg3y0Ix4CVV+hhfn1p5dbaSzpKHDm
         2mxg==
X-Gm-Message-State: ANhLgQ3r1W+kGRyGB9utIPho86QWdBVGJhm21HI4n2tsTAZUDbP3wYXP
        IP1R29/6xmEThcVa0gQPlZ6VmwagPxd6oFx0fa2AMjEgd6qEReLr5xkFsqh49gZJNDYh4fVJC6Q
        9Ux9W1gxl0JTcYBbwuEVrZJBxNSRVxH3wPnfmVqov8Q==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr3551437wmj.156.1585395108831;
        Sat, 28 Mar 2020 04:31:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsG1dGyA/RHZAnl+8bj6tF2K1BBKGwMYgS9zLyphO5tObGfhkWizV9l3ZWrySWsH7pMn9qEzw==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr3551418wmj.156.1585395108528;
        Sat, 28 Mar 2020 04:31:48 -0700 (PDT)
Received: from localhost ([95.239.127.44])
        by smtp.gmail.com with ESMTPSA id o14sm11692573wmh.22.2020.03.28.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 04:31:47 -0700 (PDT)
Date:   Sat, 28 Mar 2020 12:31:45 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <20200328113145.GB1371917@xps-13>
References: <20200327093620.GB1223497@xps-13>
 <202003271208.0D9A3A48CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003271208.0D9A3A48CC@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:28:05PM -0700, Kees Cook wrote:
> On Fri, Mar 27, 2020 at 10:36:20AM +0100, Andrea Righi wrote:
> > Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
> > (disabled) in the "settings" file for a specific test.
> 
> That seems to be a reasonable optimization, sure.
> 
> > NOTE: without this change (and adding timeout=0 in the corresponding
> > settings file - tools/testing/selftests/seccomp/settings) the
> > seccomp_bpf selftest is always failing with a timeout event during the
> > syscall_restart step.
> 
> This, however, is worrisome. I think there is something else wrong here.
> I will investigate why the output of seccomp_bpf is weird when running
> under the runner scripts. Hmmm. The output looks corrupted...

Running seccomp_bpf directly (without using runner.sh) shows this error:

 $ sudo ./tools/testing/selftests/seccomp/seccomp_bpf
 ...
 seccomp_bpf.c:2839:global.syscall_restart:Expected true (1) == WIFSTOPPED(status) (0)
 global.syscall_restart: Test terminated by assertion

Instead, running it via /usr/bin/timeout (with timeout disabled):

  $ sudo /usr/bin/timeout 0 ./tools/testing/selftests/seccomp/seccomp_bpf
  ...
  [ RUN      ] TSYNC.siblings_fail_prctl

It gets stuck here forever, basically it's during the execution of
syscall_restart().

I'll investigate more later.

Thanks,
-Andrea
