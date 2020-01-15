Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E71DC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5610B2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579119351;
	bh=l1Qq0CVhPL/GxMn+TDWXRowAL2bleP+DqLBLYN8WhwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ptxbg9FWAiOmQPUpQi0AudS0eeL3/CGOdkLia2IibEnVOw9sxfddMI53YUFdueIhn
	 jmVS2IqJNX8c6VulGycyC9jbv4Us6vKpmNuNPjmqynMxdEo1mcYxqLtPz6NzPfZ0ag
	 z4J6+wfF2jMdZZijxEoTICGINgHnPtl4ygHWDvZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAOUPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgAOUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:15:50 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07192064C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579119349;
        bh=l1Qq0CVhPL/GxMn+TDWXRowAL2bleP+DqLBLYN8WhwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mRDOOQg0KKNaAZRiaZr1kbWc1mYG0F+s7Jrh3zJKE13cju0fE+wDybCKb1G9hYDj+
         T7xe7X4etH6OxC690OmjmuS/2ON+R9pT5FVrt5szk/dwgSzEY1OX9bUepyJopF2UPD
         xezUvWg0dniokSmLanbeD01oybITFsWMA/gfObpI=
Received: by mail-wr1-f44.google.com with SMTP id b6so17031606wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:15:48 -0800 (PST)
X-Gm-Message-State: APjAAAXGuHO9JGHpKTc2+9nOZIz5n3rSHmSHlPA7EcYD+t9eLUJXqRbN
        9k8+s5aKmKBRveUGX0y2QUePwG4uVFzFEYvDn0Y1nA==
X-Google-Smtp-Source: APXvYqyQPRL73ievK11kD+Sry/1a7y8gn2Kab8NQUZCYDXIBn1pTHF0gFxaGSeBbLcDmTkXhq0N0WwyzlZpC4eTrq6A=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr32200761wro.195.1579119347459;
 Wed, 15 Jan 2020 12:15:47 -0800 (PST)
MIME-Version: 1.0
References: <03j72W25Dne_HDSwI8Y7xiXPzvEBX5Ezw_xw8ed8DC83bpdMxoPcjhbinNcDD0yeoX9GGN691f3kqqtGLztTnW8Pay3FrbO5sTlj3vjnh-Y=@protonmail.com>
In-Reply-To: <03j72W25Dne_HDSwI8Y7xiXPzvEBX5Ezw_xw8ed8DC83bpdMxoPcjhbinNcDD0yeoX9GGN691f3kqqtGLztTnW8Pay3FrbO5sTlj3vjnh-Y=@protonmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 15 Jan 2020 12:15:36 -0800
X-Gmail-Original-Message-ID: <CALCETrVBbj+tKxu0sPwQTPMS+UV6_6cRVPXF8tqfGFOaxtH17A@mail.gmail.com>
Message-ID: <CALCETrVBbj+tKxu0sPwQTPMS+UV6_6cRVPXF8tqfGFOaxtH17A@mail.gmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_guess flag disabling CPUID.16h use for
 tsc calibration
To:     Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "malat@debian.org" <malat@debian.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich@akamai.com" <mzhivich@akamai.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 6:39 AM Krzysztof Piecuch
<piecuch@protonmail.com> wrote:
>
> Changing base clock frequency directly impacts tsc hz but not CPUID.16h
> values. An overclocked CPU supporting CPUID.16h and partial CPUID.15h
> support will set tsc hz according to "best guess" given by CPUID.16h
> relying on tsc_refine_calibration_work to give better numbers later.
> tsc_refine_calibration_work will refuse to do its work when the outcome is
> off the early tsc hz value by more than 1% which is certain to happen on an
> overclocked system.
>
> Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>  arch/x86/kernel/tsc.c                           | 12 ++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..54ae9e153a19 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4905,6 +4905,12 @@
>                         interruptions from clocksource watchdog are not
>                         acceptable).
>
> +       tsc_guess=      [X86,INTEL] Don't use data provided by CPUID.16h during
> +                       early tsc calibration. Disabling this may be useful for
> +                       CPUs with altered base clocks.
> +                       Format: <bool> (1/Y/y=enable, 0/N/n=disable)
> +                       default: enabled

This has more negatives than makes sense.  I also think it's wrong.  How about:

tsc_guess= ... Use data provided by CPUID.16h ...
