Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A9FC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C58424691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3lX5ksA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgB0KbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:31:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43205 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0KbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:31:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so2604584edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 02:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YKyRHw8ooAbVqhc4j2ngoAhb6YbVkAChdGM4erJXS14=;
        b=h3lX5ksAlAw16kZAC+cz6MW0bE33uYelHnblACOLdKT+oXqleejRwsOODH2LxyEWbk
         Rf4Mzw5XgSxyd7BT8z3kfPwNvrh1JHP9gvxCgx7JUVqIejefJhGdSZITuRS8uLOZaID6
         TlRKrE0uqYT0kK3VOiN/rMy+5vxvHL3ZtnNHmQWdXrHjgZhesLL2pixzru2B5LYsxsq6
         eexccovkU6pzAss8ioYApf/hc71ugF2uRy/fe1/fpCrl+5bvuRDzZywT8ZiGS29yDq4z
         U23Z5s6pJLnO3E703ku+Jm+fGEZBkwrLqRMo+gAzkBN1qKTa+G1Yq6ZCUak/b5kehT4A
         dGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YKyRHw8ooAbVqhc4j2ngoAhb6YbVkAChdGM4erJXS14=;
        b=e/9pueaf5Qu9lkHeev1HB20ydunouodEuZcj6rf6hKHB5Rz+WMLsrDuRYVlfkGNC1C
         U9lUlNC8RCNnbfLzwqjEhNHRvCpgFNguMgVVvPydyW/Ntmk9zLn0gGS1U71fG4Mjo758
         JIoOnwgqa5k5reor8yh4qMI7xdaih11pYQ4Z6ElMnzRcWKKuT0DWJjN2AK7o8aWlOG3X
         ISyF+k+Cp5xIyNoLB7kxkiUntgV5ARYTqRQysXdluKuJaVP91VinMcusyjzNJwoIx+fc
         Lx+vtOpIAPshD9gD0zRvzJR49U7HDZblj0KyfOLkMdhi1s51BEs5KXCok/MUO9ol3dMp
         whLw==
X-Gm-Message-State: APjAAAWbQEV4PzekeehOrOzWJF1cPHTaOTyWXt4hrCHhI5YqFGMLRKS9
        Y3m+ES6mtxv0DrDkER5xNr2HEIEgRAs3QtDCWdNGxw==
X-Google-Smtp-Source: APXvYqyGuAjmZQy3cdBjDEhl09d5WD8JWyNai1gipdzpHQMDtz9CYCNJmZAOG3cY5jpZ0TPrYwMMaZ0/S0I0KUPYTLw=
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr3471713eje.276.1582799475220;
 Thu, 27 Feb 2020 02:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20200226135027.34538-1-lrizzo@google.com> <87ftexz93y.fsf@toke.dk>
 <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com> <878skpx7th.fsf@toke.dk>
In-Reply-To: <878skpx7th.fsf@toke.dk>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Thu, 27 Feb 2020 02:31:03 -0800
Message-ID: <CAMOZA0+C4SyGLVhFAa10WPFMarBVVnT+Cysfat-bcJS9mBySmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org,
        Luigi Rizzo <rizzo@iet.unipi.it>,
        Paolo Abeni <pabeni@redhat.com>, giuseppe.lettieri@unipi.it,
        Jesper Dangaard Brouer <hawk@kernel.org>, mingo@redhat.com,
        acme@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 3:11 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Luigi Rizzo <lrizzo@google.com> writes:
>
> > - the runtime cost and complexity of hooking bpf code is still a bit
> > unclear to me. kretprobe or tracepoints are expensive, I suppose that
> > some lean hook replace register_kretprobe() may exist and the
> > difference from inline annotations would be marginal (we'd still need
> > to put in the hooks around the code we want to time, though, so it
> > wouldn't be a pure bpf solution). Any pointers to this are welcome;
> > Alexei mentioned fentry/fexit and bpf trampolines, but I haven't found
> > an example that lets me do something equivalent to kretprobe (take a
> > timestamp before and one after a function without explicit
> > instrumentation)
>
> As Alexei said, with fentry/fexit the overhead should be on par with
> your example. This functionality is pretty new, though, so I can
> understand why it's not obvious how to do things with it yet :)
>
> I think the best place to look is currently in selftests/bpf in the
> kernel sources. Grep for 'fexit' and 'fentry' in the progs/ subdir.
> test_overhead.c and kfree_skb.c seem to have some examples you may be
> able to work from.

Thank you for the precise reference, Toke.
I tweaked test_overhead.c to measure (using kstats) the cost of the various
hooks and I can confirm that fentry and fexit are pretty fast. The
following table
shows the p90 runtime of __set_task_comm() at low (100/s) and high (1M/s) r=
ates:

                      90 percentile of __set_task_comm() runtime
(accuracy: 30ns)
call rate          base     kprobe   kretprobe  tracepoint   fentry   fexit
100/sec          270       870        1220         500             400     =
  450
 >1M/s            60        120         210          90
70          80

For high rate operation, the overhead of fentry and fexit is quite good,
even better than tracepoints, and well below the clock's accuracy
(more detailed measurements indicate ~5ns for fentry, ~10ns for fexit).
At very low call rates there is an extra 150-200ns
but that is expected due to the out of line code.

cheers
luigi
