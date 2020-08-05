Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE897C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7756022B45
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPNRDUgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgHEILJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgHEIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:07:22 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291ADC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:07:22 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id i129so4835331vsi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0nOFFF7hzc6dw8TmhAOGzyrKIPGf5iLMCTuLYuw0u4=;
        b=SPNRDUgdSDQlK5tqqIU4NcO4Laf7h6KZOhYv7nAV/kYD7hmyqmT/G00JE4LmRs3N54
         uQpwTCU1s+SbL0Kbqlns5LWQ+tbXmteqBTgtQYSBsmekDKE5eCLjvth/Tr7fuIFPBs3R
         NRf/Ne1J9uPNH825RyxPoTL9RQkaRMYB+Mk3awoR+70zFSOva7Tu8e1KglvZ0cuDsNd1
         nOKvqqn1RDqm5ZutMWgwgZeUri7lqzd0biqY1+X+nDRytnsKlLTieF5hIHN1HNDij/1s
         HOp/DYpDv9CNrpYCEJt6MKUvVhTP/9UgcCVMn6oQtDGJqdNW6xA58AkW3hDIq1wMghtN
         BwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0nOFFF7hzc6dw8TmhAOGzyrKIPGf5iLMCTuLYuw0u4=;
        b=WZ9rVEaIHwlXQvNBZVt/DR8NpizKp7A6YAFhp2emnQIQK4kLuclyfIw1noQKcW47mq
         +Szi9eKsnQu/4c4DT2Q9L5rECCAZhFbf3btNEMAUdq1l4+BAaejrLTI7Q0S6fxPpfBaT
         DpcgDBETgIRc6nCcTP72dl2zfYVaIpQ4VaQ14tiHG/sWXoc+YBYZ6wOHBDLZcYsFk8Yv
         IYxde/3GJ9ObKHAa90lDw0vub7ZVkhiNsIIK86P4tbB2skPXqEs/vzlw4p/a3KPRdgor
         NP+mFyQmdL/y5INN2iIFjYXA88a1zI6ZtdfXvRWIMEoPWv+SDgQ2up/WMmRoXfzGOT00
         fxUg==
X-Gm-Message-State: AOAM530CkiWCeWZGeOCHaMZDEidxBMtp5eLV1PhnWKCPO9vxpOGtfMFm
        hmZj5GcEcAo3kAe1g9HYkh7jowQW
X-Google-Smtp-Source: ABdhPJyywUkwd2MNVNywvYnb9KFia/D+EVX1rgJYxN0t4//18F/rJmFs8xmvm7R/jr5EC+HhylQP9w==
X-Received: by 2002:a67:f6d7:: with SMTP id v23mr1165269vso.38.1596614841056;
        Wed, 05 Aug 2020 01:07:21 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id u3sm264272vkb.0.2020.08.05.01.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 01:07:19 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id q13so15293901vsn.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:07:18 -0700 (PDT)
X-Received: by 2002:a67:f5ce:: with SMTP id t14mr1105046vso.240.1596614838401;
 Wed, 05 Aug 2020 01:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200804123012.378750-1-colin.king@canonical.com> <b99004ea-cd9d-bec3-5f9f-82dcb00a6284@gmail.com>
In-Reply-To: <b99004ea-cd9d-bec3-5f9f-82dcb00a6284@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 5 Aug 2020 10:06:41 +0200
X-Gmail-Original-Message-ID: <CA+FuTSd9K+s1rXUFpb_RWEC-uAgwU1Vz44zaUPaZK0cfsX4kwA@mail.gmail.com>
Message-ID: <CA+FuTSd9K+s1rXUFpb_RWEC-uAgwU1Vz44zaUPaZK0cfsX4kwA@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: skip msg_zerocopy test if we have less
 than 4 CPUs
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 2:54 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 8/4/20 5:30 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The current test will exit with a failure if it cannot set affinity on
> > specific CPUs which is problematic when running this on single CPU
> > systems. Add a check for the number of CPUs and skip the test if
> > the CPU requirement is not met.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  tools/testing/selftests/net/msg_zerocopy.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
> > index 825ffec85cea..97bc527e1297 100755
> > --- a/tools/testing/selftests/net/msg_zerocopy.sh
> > +++ b/tools/testing/selftests/net/msg_zerocopy.sh
> > @@ -21,6 +21,11 @@ readonly DADDR6='fd::2'
> >
> >  readonly path_sysctl_mem="net.core.optmem_max"
> >
> > +if [[ $(nproc) -lt 4 ]]; then
> > +     echo "SKIP: test requires at least 4 CPUs"
> > +     exit 4
> > +fi
> > +
> >  # No arguments: automated test
> >  if [[ "$#" -eq "0" ]]; then
> >       $0 4 tcp -t 1
> >
>
> Test explicitly uses CPU 2 and 3, right ?
>
> nproc could be 500, yet cpu 2 or 3 could be offline
>
> # cat /sys/devices/system/cpu/cpu3/online
> 0
> # echo $(nproc)
> 71

The cpu affinity is only set to bring some stability across runs.

The test does not actually verify that a run with zerocopy is some
factor faster than without, as that factor is hard to choose across
all platforms. As a result the automated run mainly gives code coverage.

It's preferable to always run. And on sched_setaffinity failure log a
message about possible jitter and continue. I can send that patch, if
the approach sounds good.
