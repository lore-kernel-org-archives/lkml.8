Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71990C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422FD2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2m0lsnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAOPlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:41:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbgAOPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579102878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3l69K3PDMlJemoFXpDZpBSROJVwgjnc3IAfTJYLJE1A=;
        b=B2m0lsnGUNo5ArHnmDUISwbD55qbMy8TzhNN0v5BspXXCVOhspRne2JEk/5YDABsnA579/
        wrHFwbL0P9lhtSWsVnZ3QlrM0Uik6fh5cT4l3LUO9+UhuXdkU0rOvJBR4olbWyn3n+5VgD
        dGRACogrLErhOg+PQrXOMa7IIc8cvVM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-eKGJJ5gSNZ-hWf8JPkTAjQ-1; Wed, 15 Jan 2020 10:41:15 -0500
X-MC-Unique: eKGJJ5gSNZ-hWf8JPkTAjQ-1
Received: by mail-lj1-f198.google.com with SMTP id t11so4260898ljo.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3l69K3PDMlJemoFXpDZpBSROJVwgjnc3IAfTJYLJE1A=;
        b=WxEIXlJvvvPGt082X+bLKg1s362XVDLt38GWKi0Bz71TZgW1oysizxA+bIdoXmigGr
         zZVf3p6eWDsdvRSRZUkgLfST87OFYee+ZyNeElMGIwGJsWlv0payMh0KLAuO45GrBB0W
         GYpPtebiuh3kTquy9sPBhp+gLl3DZzlCSgqEwggA/nbhy+2E1Vkotj9uD9TFYfgN1qNd
         59ZR0CfJVT0TINLQYj4QTqrEosEo+6SLGGkijNbHbyWrVwR+RKcL8pVPQrQAmW33nHrY
         82lIQQfKbtSD/0hCDIpmztQHcynfSJ9pqsblPxkB4zumfHu28xaZzKqG6/qqqFjH72+Q
         xcTw==
X-Gm-Message-State: APjAAAWwdjmpj622OvlHFOUjA7RhjiHfQWC/eM6agleoGrWFkPrqC4sM
        hbE493Y62kxFqA9DrSqPKPQ2RhBhc5ueB3+DDjfldi7jB9pBTkUcKVeX5l/CA/89eHxLYepYFfy
        rWQxu/ybW//cfqj8n20DgNd7S
X-Received: by 2002:a19:5e0a:: with SMTP id s10mr5018196lfb.165.1579102874487;
        Wed, 15 Jan 2020 07:41:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyazUrqAH6dclikkhYZ4/DJpUS4QXtSoJ0WpysfA1lHkQWnuS6US8Z0PNCGkK1YfaYA0049DA==
X-Received: by 2002:a19:5e0a:: with SMTP id s10mr5018171lfb.165.1579102874260;
        Wed, 15 Jan 2020 07:41:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s22sm9557271ljm.41.2020.01.15.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:41:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DB6C51804D6; Wed, 15 Jan 2020 16:41:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
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
Subject: Re: [PATCH bpf-next v2 07/10] samples/bpf: Use consistent include paths for libbpf
In-Reply-To: <20200115161825.351ebf23@carbon>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <157909757639.1192265.16930011370158657444.stgit@toke.dk> <20200115161825.351ebf23@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 16:41:12 +0100
Message-ID: <87y2u8u3qf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Wed, 15 Jan 2020 15:12:56 +0100
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Fix all files in samples/bpf to include libbpf header files with the bpf/
>> prefix, to be consistent with external users of the library. Also ensure
>> that all includes of exported libbpf header files (those that are export=
ed
>> on 'make install' of the library) use bracketed includes instead of quot=
ed.
>>=20
>> To make sure no new files are introduced that doesn't include the bpf/
>> prefix in its include, remove tools/lib/bpf from the include path entire=
ly,
>> and use tools/lib instead.
>>=20
>> Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken =
from selftests dir")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I like this change. Maybe the reason so many samples/bpf/ files
> still included "libbpf.h" was that once-upon-a-time we had a "eBPF mini
> library" in the file samples/bpf/libbpf.h that were included.

Yes, I think something similar is the case with bpf_helpers.h - that
used to be outside libbpf, and I guess no one bothered to do a cleanup
such as this one when it was moved...

-Toke

