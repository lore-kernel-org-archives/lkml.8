Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67512C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4312A2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="SUqHQSv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgESIiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgESIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:38:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18237C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:38:11 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e18so13634824iog.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jabd/ejZir+aDGBzqGMPlMd6x0TFls4+w9CeMWu63EY=;
        b=SUqHQSv6GAjdG2b6FWtocyMNWRVlTcdf7POaW1bc+Lk6ciKmy0MFk88a+d8roSURhR
         Czj46TJprxBtrMAgCT+gn6NftmSeGDu6oaGL0aQMwCrEUJXHRzc8YkFBgcL11MyDMBXW
         CMXTWojXrQodz+8wn5k5OktAssHTpD1i12niYv0LC6X4JYduCoAnRf2l83YugXzWf73f
         6An19MZU6exGDMtyIsmUCNVHJMzHqm2p0RrVr84os8yZ7Iwng4H3PPggKgaG/fYBldak
         /ShPvBWNOqzxgQqT/TJK0PiP8yJRwWNcK8X0f4V+A/6bWo+oPQcQWKol6pSHdKkCn1jb
         QlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jabd/ejZir+aDGBzqGMPlMd6x0TFls4+w9CeMWu63EY=;
        b=MWO3jMXLZ6HSD16JdOYWN8FGexmSZg4mFjUV4+9wexSO2t0sLssd4sHq/ZIDzhJXw0
         au0E05z2yWiKizo5Rgsd76bzY4/lPG229ItmRujKZ3EPqC821ZKx6IF4tMWMPkZZFlAJ
         3VV3x7SgkivieMqv8oL79UDhbprgfzdOdUivX2B2mr2OKY857ToUvZvNzF2LJp2P6IPS
         WE49tEPuVM1OghsPUfZqhcTwNQldrEUZnrWU8P1e4/TMY9Pub3tgW7t9q/Gqxdokby0k
         jMOIpzF1Z6gUXMq/uWGGyr2Ar/qV9M/by1nGGDt4eX57lmAWKa37SGI021U63GbBPiOl
         QRiw==
X-Gm-Message-State: AOAM532o8S8kP5u6XCIz0omkC59yjCiIwBFSa5K/A3wfOnOPk2seccTF
        uwZqBtdsODVdsZD1PxJkRJQ4dBnfT8bGmB5MLNDAFQ==
X-Google-Smtp-Source: ABdhPJyzLSHUR5QX36fqmt2VGwYHOHJCvRjK3pmqZLG5dxy9zLw3DI9Ni+SU8petoBgfV0Dxk3kUN3l/Y+slF3Uy6kA=
X-Received: by 2002:a6b:902:: with SMTP id t2mr18230256ioi.153.1589877490392;
 Tue, 19 May 2020 01:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck>
In-Reply-To: <20200519081551.GA9980@willie-the-truck>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 19 May 2020 04:37:34 -0400
Message-ID: <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> Yes, we inherited this from ARM and I think strace relies on it. In
> hindsight, it is a little odd, although x7 is a parameter register in the
> PCS and so it won't be live on entry to a system call.

I'm not familiar with the PCS acronym, but I assume you mean the
calling convention? You have more faith in userspace than I do ;). For
example, cursory googling brought up this arm64 syscall definition in musl:

https://github.com/bminor/musl/blob/593caa456309714402ca4cb77c3770f4c24da9da/arch/aarch64/syscall_arch.h

The constraints on those asm blocks allow the compiler to assume that
x7 is preserved across the syscall. If a ptracer accidentally modified it
(which is easy to do in the situations that I mentioned), it could
absolutely cause incorrect execution of the userspace program.

> Although the examples you've
> listed above are interesting, I don't see why x7 is important in any of
> them (and we only support up to 6 system call arguments).

It's not so much that x7 is important, it's that lying to the ptracer is
problematic, because it might remember that lie and act on it later.
I did run into exactly this problem, where my ptracer accidentally
changed the value of x7 and caused incorrect execution in the tracee
(now that incorrect execution happened to be an assertion, because
my application is paranoid about these kinds of issues, but it was
incorrect nevertheless)

If it would be helpful, I can code up the syscall entry -> signal trap example
ptracer to have a concrete example.

Keno
