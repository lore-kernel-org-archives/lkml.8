Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C4AC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1104D222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsABhMqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBZXLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:11:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727749AbgBZXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582758702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVTeW6eIVfotq4j/j+bd1NFJwtLmqk/g4H0c70NTw9U=;
        b=TsABhMqQWD1j4H8QAgOe1z9p3gvTrYra08UTx/1Yg8fycsayS8LZR5vkT+dSIm8gsyuUd/
        WA+P9t2cPKNK+cFPxkqdSXtOYctVGkkK7fqjTLAgdlNwEQrBbl+ophz1b8dRf/V3x/KgD3
        ksYrjfRtIDplL5gOKmR5H2Y0rMow9G8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-xK8ZwdngNkOk7z_3_BrkfQ-1; Wed, 26 Feb 2020 18:11:40 -0500
X-MC-Unique: xK8ZwdngNkOk7z_3_BrkfQ-1
Received: by mail-wr1-f72.google.com with SMTP id h4so431621wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EVTeW6eIVfotq4j/j+bd1NFJwtLmqk/g4H0c70NTw9U=;
        b=WBLcw3QzQJ2jneV3ZnJR2lkHxZQ50sVXjnvojsyLpIWolYPF4wpKp0TU1C67aVhw/6
         9W6/1/UjBN6RK270jVpQylrdon5Oi4NE/B7u7nXra/WZfsyV8N7D15INf0kC1ZmV7poe
         z6UwhquPsRBkvSMeD5cyUEE6KffUqP5BHcQfTTJ7WAkHCuSlJqvqFd9wLClVpykNrdk1
         XPqbQeUnHLtmq5BqQDe6h1lQ3E/uT9kfpOPtmIXscvtdLUGEb/Lf2Wv6uTDWEBvJJ+Zf
         RlMYZLWO1n1YMh9Oq2ZitZXOi20CsSWlWHryeAVoVDMKQLDiLAIvrE3K5tW4rcUC/dTF
         dYnQ==
X-Gm-Message-State: APjAAAVJE/lTWJWg3IHar0VvqyveJHUaPcxL0YGrOLpnhkGUthCh+Pem
        mY2CAof3K4aGV+APVgm0QftHg8c8tSIU4NELoC+SninaHspiTc1aZZ0AX69YEeIkNvZLNXeOxtZ
        zoK6wMiU6ty9ql3d8Cef7nR8t
X-Received: by 2002:adf:ee85:: with SMTP id b5mr981490wro.34.1582758699617;
        Wed, 26 Feb 2020 15:11:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqx36cp9dH6ZSSd5q5V5TYBUq/mw/dNP2BaVZDX6i8Rloh5bcUrdvgSdMpFQDyVKlSt1xrN3oA==
X-Received: by 2002:adf:ee85:: with SMTP id b5mr981476wro.34.1582758699362;
        Wed, 26 Feb 2020 15:11:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z6sm5071575wrw.36.2020.02.26.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:11:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1F774180362; Thu, 27 Feb 2020 00:11:38 +0100 (CET)
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
        peterz@infradead.org
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
In-Reply-To: <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
References: <20200226135027.34538-1-lrizzo@google.com> <87ftexz93y.fsf@toke.dk> <CAMOZA0Lzf2r7rFvgBEWpf-B=wXvyED2CxfzuO7qUA_qVsNtL7g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 Feb 2020 00:11:38 +0100
Message-ID: <878skpx7th.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Rizzo <lrizzo@google.com> writes:

> - the runtime cost and complexity of hooking bpf code is still a bit
> unclear to me. kretprobe or tracepoints are expensive, I suppose that
> some lean hook replace register_kretprobe() may exist and the
> difference from inline annotations would be marginal (we'd still need
> to put in the hooks around the code we want to time, though, so it
> wouldn't be a pure bpf solution). Any pointers to this are welcome;
> Alexei mentioned fentry/fexit and bpf trampolines, but I haven't found
> an example that lets me do something equivalent to kretprobe (take a
> timestamp before and one after a function without explicit
> instrumentation)

As Alexei said, with fentry/fexit the overhead should be on par with
your example. This functionality is pretty new, though, so I can
understand why it's not obvious how to do things with it yet :)

I think the best place to look is currently in selftests/bpf in the
kernel sources. Grep for 'fexit' and 'fentry' in the progs/ subdir.
test_overhead.c and kfree_skb.c seem to have some examples you may be
able to work from.

> - I still see some huge differences in usability, and this is in my
> opinion one very big difference between the two approaches. The
> systems where data collection may be of interest are not necessarily
> accessible to developers with the skills to write custom bpf code, or
> load bpf modules (security policies may prevent that). One thing is to
> tell a sysadmin to run "echo trace foo >
> /sys/kernel/debug/kstats/_config" or "watch grep CPUS
> /sys/kernel/debug/kstats/bar", another one is to tell them to load a
> bpf program (or write their own one).

With BPF the solution for this is to distribute a tool that does all the
setup for the user. Basically the userspace equivalent of what you're
proposing to include into the kernel here. You can make this arbitrarily
user-friendly, up to and including having a GUI list all the functions
available in the running kernel and letting the user just click on the
one to measure :)

-Toke

