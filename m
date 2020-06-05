Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AC7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C3D2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FNkDcqb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgFEKVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgFEKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:21:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8EC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:21:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e12so7046023eds.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/J7ZrVA1rgXoXL6DjJISUYcAv4+vLlwoMgGndxtdpyA=;
        b=FNkDcqb5+ZLDK83iFgO/f9mZbVnprS9Ze/r+65JeexTtEZFx87s3v2AgZVSny3bJm7
         tsWH0akqcu/gVP36AOZGwv5pdB1TsihKKhfmGbH52JQvT76vofKo25ahCh3dOAkn6oLb
         J8lqE4jZnFB+uQLPvkZr+fp4gou+mZ/tGIOqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/J7ZrVA1rgXoXL6DjJISUYcAv4+vLlwoMgGndxtdpyA=;
        b=TdKy3XYFzHmcs2H+j2dh3uEIfV87+rri5IafSMJ0PVze8IS7tE2gVmpfxKU1476knC
         viNnWhTrOVLM52Xc5vbPMWqpcOodd6JpOGbZBkzdZ8pB0sW2v84qwhK+3REPTz5gH6hw
         mqkL19Xb4jqict69fRULY98ku534IErMZHYoSg8lgzLWW3Lm0Ds0R9GWMyj6txlQz1VC
         AdFATpMONQjn1z2zh3gXL/t1siR47mJPnc5yEv5GSR9q4iojHj+jMeU+MhIconV/J3e3
         7MrMeXh32WOIunosszOkXUW6zSDX5KU4EohcZaGSZnV2gOWnwCBarY0nBEOBTRzdT5Ck
         kGfQ==
X-Gm-Message-State: AOAM531jq3MpUSE6mHs1+IJfLPsAgTUim85gueZUC/5nXx5Mng4k4sbP
        Ccwr6IEscIX0EU1yP1PP8qCvWOXXF1PG2cL95VWiSQ==
X-Google-Smtp-Source: ABdhPJyyJuIZY/2M+UehWJLcidOIIgfYP8bl6CgNvIysvUrsDsu7CwoN2KVMLErueBLDfWIIygGqWG5viH2bmJ1olmw=
X-Received: by 2002:a50:bb29:: with SMTP id y38mr8465470ede.358.1591352500590;
 Fri, 05 Jun 2020 03:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <1a1c32fe-d124-0e47-c9e4-695be7ea7567@redhat.com> <87k10l7rf4.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k10l7rf4.fsf@nanos.tec.linutronix.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Jun 2020 12:21:29 +0200
Message-ID: <CAJfpegs6PKe0HCO9hdMDRLckRrfOjFcSPpyMpvGceOCiqc4KqA@mail.gmail.com>
Subject: Re: system time goes weird in kvm guest after host suspend/resume
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 12:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
> > On 04/06/20 21:28, Miklos Szeredi wrote:
> >> time(2) returns good time, while clock_gettime(2) returns bad time.
> >> Here's an example:
> >>
> >> time=1591298725 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> >> time=1591298726 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> >> time=1591298727 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> >> time=1591298728 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> >> time=1591298729 RT=1591300383 MONO=39582 MONO_RAW=39582 BOOT=39582
> >>
> >> As you can see, only time(2) is updated, the others remain the same.
> >> date(1) uses clock_gettime(CLOCK_REALTIME) so that shows the bad date.
> >>
> >> When the correct time reaches the value returned by CLOCK_REALTIME,
> >> the value jumps exactly 2199 seconds.
>
> Which value jumps?

The time value returned by clock_gettime() and gettimeofday() jumps by
2199s after the resume of host, and then again and again jumps with a
period of 2^41 ns.

Only time() returns the correct value and that appears to use the VDSO
since there's no time() syscall in strace.

> I can actually now reproduce, but I won't be able to investigate that
> before monday.

No problem.  Good news that you can reproduce it now.

Thanks,
Miklos
