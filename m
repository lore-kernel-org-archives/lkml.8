Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A5C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577F7214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZuqAMQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAQJ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:58:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726688AbgAQJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579255125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uf1keSD3DOZ8jh4mCSz+0fhQb4Z+vPKdygjWjY+hlbM=;
        b=NZuqAMQHdmeU601OrxePBrd966BxNqTEgfw5R1mDKKlzoMCLtfBAMfdQJQcMkHc6ssNurk
        XAJCledikqC8sM82Bx1gZE+3zf4TRc2v4ZDsm464PMe4QEMK6Jyqh+45fE4RNTpiLpNyZq
        yxTOyKuAoXXYsyF5qUexLdNL+f1K0fM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-hLzf4peXPYKM3erIJvsGnA-1; Fri, 17 Jan 2020 04:58:44 -0500
X-MC-Unique: hLzf4peXPYKM3erIJvsGnA-1
Received: by mail-lj1-f199.google.com with SMTP id d14so6029943ljg.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Uf1keSD3DOZ8jh4mCSz+0fhQb4Z+vPKdygjWjY+hlbM=;
        b=DLNmldEN9VsGCLbWcu4yjuM0I4GaSPuP8/fn/is+XISNqd+rEYQJhgAQwpzyE+4wHN
         kuwqZ9TSSSEGz+usQDKJUrWYEd3XIfU+rF9bU/yfRA54F5TKoNerTRAtclAqM9Q7C8oN
         A7mzJtYtoMSAmXBBROr6OxnUs7qIZb158h1sS0w7L8SIJ3pEUfmrfOqLC5wkizES3yp2
         U/odV3ZSbABiLQh+8T1m0/ECUe+7aFgC8zSkF4kCa0BtHoUE/UmUvB8PYCZDSM1Y1NAJ
         Sv6qhllvzazG69HKPV+4rlY1yYVUIV/ybsME8BB/cIwNAfjE+uP6UuvCE49XO7I97eC9
         /5hg==
X-Gm-Message-State: APjAAAX7312UB80mFLjNd2KF3whlZaNBjynZtgEsqPctKUgl9k18TJog
        gm9ILs+lS0yzCiEcDjpI3LBWikKGuQd5kWO58adpKfX5+59v/6y0zPNFfjPLD7d6OqATaiEkCwH
        A8LclvIXz/YjNtDCD9r0AIHDG
X-Received: by 2002:ac2:4849:: with SMTP id 9mr4975735lfy.11.1579255123124;
        Fri, 17 Jan 2020 01:58:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx3OTlP+sKcKqC8lWpUkR48Xy7KHR8XB1tnfvUp3Gadttkq8Vpe8cxhtUqaWxJHiUphB7sig==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr4975702lfy.11.1579255122857;
        Fri, 17 Jan 2020 01:58:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r21sm12164399ljn.64.2020.01.17.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:58:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 341A91804D6; Fri, 17 Jan 2020 10:58:41 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, brouer@redhat.com
Subject: Re: [PATCH bpf-next v3 00/11] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <20200117095721.0030f414@carbon>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <20200117041431.h7vvc32fungenyhg@ast-mbp.dhcp.thefacebook.com> <20200117095721.0030f414@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:58:41 +0100
Message-ID: <87lfq6qu9a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Thu, 16 Jan 2020 20:14:32 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> On Thu, Jan 16, 2020 at 02:22:11PM +0100, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > The recent commit 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs=
.h are
>> > taken from selftests dir") broke compilation against libbpf if it is i=
nstalled
>> > on the system, and $INCLUDEDIR/bpf is not in the include path.
>> >=20
>> > Since having the bpf/ subdir of $INCLUDEDIR in the include path has ne=
ver been a
>> > requirement for building against libbpf before, this needs to be fixed=
. One
>> > option is to just revert the offending commit and figure out a differe=
nt way to
>> > achieve what it aims for.=20=20=20
>>=20
>> The offending commit has been in the tree for a week. So I applied Andri=
i's
>> revert of that change. It reintroduced the build dependency issue, but w=
e lived
>> with it for long time, so we can take time to fix it cleanly.
>> I suggest to focus on that build dependency first.
>>=20
>> > However, this series takes a different approach:
>> > Changing all in-tree users of libbpf to consistently use a bpf/ prefix=
 in
>> > #include directives for header files from libbpf.=20=20
>>=20
>> I'm not sure it's a good idea. It feels nice, but think of a message we'=
re
>> sending to everyone. We will get spamed with question: does bpf community
>> require all libbpf users to use bpf/ prefix ? What should be our answer?
>
> The answer should be: Yes. When libbpf install the header files the are
> installed under bpf/ prefix.  It is very confusing that samples and
> selftests can include libbpf.h without this prefix. Even worse
> including "bpf.h" pickup the libbpf version bpf/bpf.h, which have
> caused confusion.  The only reason for the direct "libbpf.h" include is
> historical, as there used-to-be a local file for that.

Agreed. Also, we are already telling people what the right include path
is in at least two ways - and currently they are incompatible:

- The pkg-config file included with libbpf has a notion of include path;
  which does *not* include the bpf/ subdirectory.

- The skeleton generator puts an '#include <libbpf.h>' line into the
  generated files.

With this series we'll at least be consistent.

>> Require or recommend? If require.. what for? It works as-is. If recommen=
d then
>> why suddenly we're changing all files in selftests and samples?
>> There is no good answer here. I think we should leave the things as-is.
>
> I strongly believe we should correct this.  It doesn't make sense that
> someone copying out a sample or selftests, into a git-submodule libbpf
> (or distro installed libbpf-devel) have to understand that they have to
> update the include path for all the libbpf header files.

Yeah, I think being clear and explicit about what is the recommended way
to include libbpf is strictly an improvement. And making it possible to
move example programs seamlessly in and out of the kernel tree will only
make things easier for people.

I'll rebase and respin this series on top of the revert (and fix
Andrii's comments).

-Toke

