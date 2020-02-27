Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126DFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF5D2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS8y0DSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgB0MNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:13:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728856AbgB0MNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582805615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2D82d9yGQCcZdAAoWsJQEf0HtVPlovUAMIiLK8MIQk=;
        b=QS8y0DSU24DKXydopCF7KrL1NJDuolwX1HiSWuXmO40oi4XQ0SsLaVg2ptCAHwzbPRxm8Q
        NEwo4T48vBTxrQHc+zmCe0MnXuS9dsbIz661361XjjYN5N0wHOF5gsA8W6f+aTMHUNDvrj
        pPm6gZb4TRf4sZHyz7m5n7tnO3oXPok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-eJcD63VbNX26U5U5Hu2dWg-1; Thu, 27 Feb 2020 07:13:34 -0500
X-MC-Unique: eJcD63VbNX26U5U5Hu2dWg-1
Received: by mail-wr1-f72.google.com with SMTP id z1so1227677wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j2D82d9yGQCcZdAAoWsJQEf0HtVPlovUAMIiLK8MIQk=;
        b=UxUSKlbeNx6cSsA0ZZAOXlSblTcovn5wIShOIUVPorZGg7ltZMw4R1KQs2ZEtTeBk1
         h/dVvOX1XOllXH0z43XGusPbGUrAuFGr3LXMy5y3lmuy+3499Vzc1j9+fubALnhedCJO
         IGyYAABZaagBNf1DlB7NsI2LGcIrldP/RXq9cIrWxkv47lWRf7qxf+E1Jnb5xFCE7NEZ
         I43A7vfo7jmhVisxtL1QGPWJIu3nv5f2ViBSfnMoKgkcUBTOF9VAilA8lMuzXfFo501v
         tomanTy+HOhkD+qC5ewLBvTB7EoEGiIY/iav8F13pvFVRIJzfd+9MOTWOAGI/4SLsy/j
         crHA==
X-Gm-Message-State: APjAAAUDEUlbk8uTYUS7R/wQ7avfyx6sOc/9uBU0nc4vqy8pesOo+xFs
        1oGagIGgLeec9JjwhTB1uhnP7dwsri1KpywA1i/TuS6Hzjio15ef8NlENFOUbLORkiu1s/gWhYp
        aucpDF/Xy6QW4l9JqWeQEAlwr
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4580042wrq.321.1582805612554;
        Thu, 27 Feb 2020 04:13:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzW2wTDzLFLGCYWNGje+9tyFKsX9iq0sYnR2/EEHuuj+thlGvUnZdCsW4a9Ciq4HszpYAcADw==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4580014wrq.321.1582805612314;
        Thu, 27 Feb 2020 04:13:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d7sm7843915wmc.6.2020.02.27.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:13:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C43D5180362; Thu, 27 Feb 2020 13:13:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luigi Rizzo <lrizzo@google.com>
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
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
In-Reply-To: <CAMOZA0+C4SyGLVhFAa10WPFMarBVVnT+Cysfat-bcJS9mBySmg@mail.gmail.com>
References: <20200226135027.34538-1-lrizzo@google.com> <87ftexz93y.fsf@toke.dk> <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com> <878skpx7th.fsf@toke.dk> <CAMOZA0+C4SyGLVhFAa10WPFMarBVVnT+Cysfat-bcJS9mBySmg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Feb 2020 13:13:29 +0100
Message-ID: <87zhd4ut1y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Rizzo <lrizzo@google.com> writes:

> On Wed, Feb 26, 2020 at 3:11 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Luigi Rizzo <lrizzo@google.com> writes:
>>
>> > - the runtime cost and complexity of hooking bpf code is still a bit
>> > unclear to me. kretprobe or tracepoints are expensive, I suppose that
>> > some lean hook replace register_kretprobe() may exist and the
>> > difference from inline annotations would be marginal (we'd still need
>> > to put in the hooks around the code we want to time, though, so it
>> > wouldn't be a pure bpf solution). Any pointers to this are welcome;
>> > Alexei mentioned fentry/fexit and bpf trampolines, but I haven't found
>> > an example that lets me do something equivalent to kretprobe (take a
>> > timestamp before and one after a function without explicit
>> > instrumentation)
>>
>> As Alexei said, with fentry/fexit the overhead should be on par with
>> your example. This functionality is pretty new, though, so I can
>> understand why it's not obvious how to do things with it yet :)
>>
>> I think the best place to look is currently in selftests/bpf in the
>> kernel sources. Grep for 'fexit' and 'fentry' in the progs/ subdir.
>> test_overhead.c and kfree_skb.c seem to have some examples you may be
>> able to work from.
>
> Thank you for the precise reference, Toke.
> I tweaked test_overhead.c to measure (using kstats) the cost of the vario=
us
> hooks and I can confirm that fentry and fexit are pretty fast. The
> following table
> shows the p90 runtime of __set_task_comm() at low (100/s) and high (1M/s)=
 rates:
>
>                       90 percentile of __set_task_comm() runtime
> (accuracy: 30ns)
> call rate          base     kprobe   kretprobe  tracepoint   fentry   fex=
it
> 100/sec          270       870        1220         500             400   =
    450
>  >1M/s            60        120         210          90
> 70          80
>
> For high rate operation, the overhead of fentry and fexit is quite good,
> even better than tracepoints, and well below the clock's accuracy
> (more detailed measurements indicate ~5ns for fentry, ~10ns for fexit).
> At very low call rates there is an extra 150-200ns
> but that is expected due to the out of line code.

Great, thank you for the performance numbers! This is indeed quite good :)

-Toke

