Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FDC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB58206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqjUlrOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBZQbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:31:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35647 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgBZQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:31:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so3830224ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YsK7RC3jNyUUCAI8YO0dZwG1LLhNnYXoQcGVITBKQgY=;
        b=FqjUlrOV8kswPqn7o8fKaz4tyZlXfb7BTWpJani82vjG7UqF6G+efcPzvAeQe4zEsV
         bGwdnsP5NukTjOJUrgVOa8huSecOxD/WvjSVeN0HOfLfHkU+WAszYS44z0hZUvwvVCFu
         Ljg+COePTAEsA05Ictyg/e7HEPgmoU0uOADLJO+I7AEETdBdZ9yA/woOmk7nDbB0ECs+
         IoqIhHimkBQbEvN/1jZNgvri3qT5+y3ii26QaACMzVUidNPxUko1zu7mdbzdSlmGfmyu
         mvm23TnDjbFfB856j7Ik5jmEjsJWV6C+Nx17PEgNrJCWrxuNFZ+LDnm2NlpLW69zxVyJ
         WgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YsK7RC3jNyUUCAI8YO0dZwG1LLhNnYXoQcGVITBKQgY=;
        b=CXR/mQRwdNXaSDpmGWCH/mEF5P5SwOBQ+p6S0+0Eyn1nGIqZTh8qTTOcBQugeZ702x
         ek827Gi9UvPDM8gOELzH7u+JPaw0dzyQArMh8Kp5zM6u1D4AzO15FGvRd0tsxzPzDcFF
         x3TkGNKS+hAQupXpw2mzpIi0xeu+xzoo6gdqLI0f1qYh+U+lw2XCdJ+5kZdQrnuTtIrb
         40i9YtbHYmpIVPzqm6bKoY8tDmV1o9CmnmFqGBNvRM1HzyfdRe3UwAzpGK6M6rjmq27s
         pM4SYmDMxALSruQLs5374FyWnj9Q/gLSrvm7q6BH+/OUNMnrK3lbmtO1idmWYkcenhnW
         eOQw==
X-Gm-Message-State: APjAAAVyelXvQckRPuKfbqJLK+O7qVy9Cf85EeBOaUavmwMwkTzGMUpT
        OZ63oaYn6J4oGayrBt0DZx9IwMs/qtFGC6F9zNk=
X-Google-Smtp-Source: APXvYqzfUaNr53ByN0SUMx5zeay0A7sIAhFDSzMfOEZgwDjEfFmGfSA3A6lwsFJopUoYfrQri+E3zGBj+imVdqYOX34=
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr3601778ljj.212.1582734694451;
 Wed, 26 Feb 2020 08:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20200226135027.34538-1-lrizzo@google.com> <87ftexz93y.fsf@toke.dk>
In-Reply-To: <87ftexz93y.fsf@toke.dk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Feb 2020 08:31:23 -0800
Message-ID: <CAADnVQKYEk0yWzSoubV3_6G0Sx2ZA6KwERE+Cyg0nYKCRSEvEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kstats: kernel metric collector
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Luigi Rizzo <lrizzo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, ardb@kernel.org,
        rizzo@iet.unipi.it, Paolo Abeni <pabeni@redhat.com>,
        giuseppe.lettieri@unipi.it,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 7:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> > The tracepoint/kprobe/kretprobe solution is much more expensive --
> > from my measurements, the hooks that invoke the various handlers take
> > ~250ns with hot cache, 1500+ns with cold cache, and tracing an empty
> > function this way reports 90ns with hot cache, 500ns with cold cache.
>
> I think it would be good if you could include an equivalent BPF-based
> implementation of your instrumentation example so people can (a) see the
> difference for themselves and get a better idea of how the approaches
> differ in a concrete case and (b) quantify the difference in performance
> between the two implementations.

+1

kprobe/kretprobe are expensive.
That was the reason we switched to bpf fentry/fexit based on bpf trampoline=
.
The overhead is close to zero. Currently it's used to collect stats for
bpf programs themselves, but the framework is there to collect these
stats for any kernel function. Please see:
https://lore.kernel.org/bpf/20200213210115.1455809-1-songliubraving@fb.com/=
T/#mae90f23e545f03bde837239e159909f4e4a1acaa
One of the ideas that came up during discussion is to
teach 'perf stat' to do the same.
So the kernel has all the facilities to instrument itself.
Only user space work left.
