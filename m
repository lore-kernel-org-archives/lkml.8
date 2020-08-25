Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7DFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F582075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="uUs54mDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHYSz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:55:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C99C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:55:56 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u126so13561213iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9uk4AMLpvzRAgzq0rqHpsTXVWbRiA2GeYuDtu/sc0s=;
        b=uUs54mDsCzNMq6oM+OHwokxMNdLcMeL723VOZvI9OBiLh6Uganid+kexMgqvabfxm5
         icbGpodVRZgsqpBW8/ccZxX9Xwoq1+J+7ar/QWmxgjKhTUR96ejFDrEjy/aO15wNZglD
         XxGIV7rCwfG4Sw3IrnyC3l7AVwlITjxNZDKaXet5eogwSjqgcheDVZeunE+xopwwyOnf
         wzQLgYrJ0kZ5XZHgJwLyJUVvA/UwHztMVYDso7KZSlFUsFBYJKN7wPZXFIEOD8g6n6f6
         ClETrR+hQVjbWIdTrzvUxKcn7BG8eiVhydS1prRnL6BXJam6k1gu1SiIKXt6rc3hv5me
         VfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9uk4AMLpvzRAgzq0rqHpsTXVWbRiA2GeYuDtu/sc0s=;
        b=d2669ms1fQp7CdcZ/O/j0D6oE4gX3YVvZX97wB2FYIT2TuTFG8iGz1m4U1Rzsety2u
         WPFZFOrAmJ+8YW40Av5w95i6HXnveuQX8c9OtetBPfyYaL1lYu7NbMtWCm31wBQsNO5E
         +ALvNDz7vr7SauS8mJqN8h6YpaJIx2JHVz5LSMBxzJLKh0fsWWRUICff26dIfI+I5isi
         Zs+/bI4dgwJ0xPeRfurFSeg4oF5dvKnW81zvj+QZlZbdRi/kJJVsxbVfBKytyEJ/LEhP
         C4QPfwvSf7tfjNRrZd5iYnaZ3qgc/OfV0WmAh8zSNBey+vmBmsDqP3yLzyzjiDg8jrh6
         X0Pg==
X-Gm-Message-State: AOAM530Xa4Ikw4SzsHOq522BI+mR8P9mbdhH3O2tvTxbxF3/vXYRKJ1s
        idqo7NrKxfeuSeZvJgDmsn0s9MfJpeLesOBwJtZD3A==
X-Google-Smtp-Source: ABdhPJx+ob/M28pOeAl3kt6mLnGqklY78HLbZa/gq1HlEJ8Yxtco7WcCkPUTffmLLFlreoxix4kFWnNHV3it3rBtNl4=
X-Received: by 2002:a6b:6204:: with SMTP id f4mr9990861iog.56.1598381755631;
 Tue, 25 Aug 2020 11:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200821151544.1211989-1-nicolas.rybowski@tessares.net> <20200824220100.y33yza2sbd7sgemh@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200824220100.y33yza2sbd7sgemh@ast-mbp.dhcp.thefacebook.com>
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
Date:   Tue, 25 Aug 2020 20:55:43 +0200
Message-ID: <CACXrtpQCE-Yp9=7fbH9sB7-4k-OO12JD18JU=9GL_sYHcmnDtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        mptcp@lists.01.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

Thanks for the feedback!

On Tue, Aug 25, 2020 at 12:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 05:15:38PM +0200, Nicolas Rybowski wrote:
> > Previously it was not possible to make a distinction between plain TCP
> > sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
> >
> > This patch series now enables a fine control of subflow sockets. In its
> > current state, it allows to put different sockopt on each subflow from a
> > same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
> > BPF programs.
> >
> > It should also be the basis of exposing MPTCP-specific fields through BPF.
>
> Looks fine, but I'd like to see the full picture a bit better.
> What's the point of just 'token' ? What can be done with it?

The idea behind exposing only the token at the moment is that it is
the strict minimum required to identify all subflows linked to a
single MPTCP connection. Without that, each subflow is seen as a
"normal" TCP connection and it is not possible to find a link between
each other.
In other words, it allows the collection of all the subflows of a
MPTCP connection in a BPF map and then the application of per subflow
specific policies. More concrete examples of its usage are available
at [1].

We try to avoid exposing new fields without related use-cases, this is
why it is the only one currently. And this one is very important to
identify MPTCP connections and subflows.

> What are you thinking to add later?

The next steps would be the exposure of additional subflow context
data like the backup bit or some path manager fields to allow more
flexible / accurate BPF decisions.
We are also looking at implementing Packet Schedulers [2] and Path
Managers through BPF.
The ability of collecting all the paths available for a given MPTCP
connection - identified by its token - at the BPF level should help
for such decisions but more data will need to be exposed later to take
smart decisions or to analyse some situations.

I hope it makes the overall idea clearer.

> Also selftest for new feature is mandatory.

I will work on the selftests to add them in a v2. I was not sure a new
selftest was required when exposing a new field but now it is clear,
thanks!


[1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples
[2] https://datatracker.ietf.org/doc/draft-bonaventure-iccrg-schedulers/
