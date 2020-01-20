Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E6C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B37F20678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMRCjq8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgATM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:57:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51079 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbgATM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FEDkrujKlTJc5+7hmDpzcA7gq/UPeEUXrVOs87I/0F4=;
        b=PMRCjq8r3kflwb+497XgRMs6YzZG95l6goXTdFI0PNTAJFeEM/LR2Z/2wQOnxvxjCpa6f0
        RBKedeVmwaaN6MYEmVfMaGiHxeXBdNG1ru7GSATFxLW9Wl/vkX0O/jIsDhAOnXX5DJojab
        RsrwLlPxviQA5TzNlF5kB35UFibZtqE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-vl_qzjN0NhGrL6xjVBCcAQ-1; Mon, 20 Jan 2020 07:57:02 -0500
X-MC-Unique: vl_qzjN0NhGrL6xjVBCcAQ-1
Received: by mail-lj1-f197.google.com with SMTP id b15so7513348ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 04:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FEDkrujKlTJc5+7hmDpzcA7gq/UPeEUXrVOs87I/0F4=;
        b=tDXUWb66nw9qZAaTTZl6REheNZDzEk1aA1OBPJVxhquvgB5kyR3fqJ5+yPJv8GMrXc
         6fscGkayu5WVYGdWincA+HgAuKQVWWO4GxAb7ejv42G3ee5/MgxcAD/gqUH86AoOaxbE
         4JxQZbOwjBUkHs46CMhXvrHTSFpmXmTNMfkh+8sWfJ5Zf2caClkCv2mgmQocQeH8qeVr
         yM5AIo7uP1vWAzQKv3h6rIqu1HpRV3p1q9u8uVAU+jSuqfRrGb9nPk0sj6V8FBRJ3EBa
         26vZvnraJB0Keyx7RPKr6lQ9w5zr92ie/ZKtoJ2D4nFL2Bt4K3n6Sby/JnLeEXcHCWFn
         mZsA==
X-Gm-Message-State: APjAAAUAG9Uw8+sPMWpaJr0AkdSQopYDWnkl6fypp8IQd47x3LEJp70M
        N4Kzgn1JGDi2cD+ikayqSpHczpENXylp6z1Ok46HLLMT3HYx4PUJyqN2EMTh9WA9i5PaCuOo1w8
        o9q6b1eskhcUUlw1HNCGUhlIz
X-Received: by 2002:a2e:721a:: with SMTP id n26mr13678542ljc.128.1579525021238;
        Mon, 20 Jan 2020 04:57:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqylZwrQxfS+zP3D15CF1fcweaXgkNnfdqeyFKArvqvKbNKna0d4DC4s5krAr4PrBm9NHLxAlw==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr13678516ljc.128.1579525020966;
        Mon, 20 Jan 2020 04:57:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2sm16813782ljq.38.2020.01.20.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:57:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5785F1804D6; Mon, 20 Jan 2020 13:56:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v4 04/10] tools/runqslower: Use consistent include paths for libbpf
In-Reply-To: <CAEf4BzbAV0TmEUL=62jz+RD6SPmu927z-dhGL9JHepcAOGMSJA@mail.gmail.com>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk> <157926820131.1555735.1177228853838027248.stgit@toke.dk> <CAEf4BzbAV0TmEUL=62jz+RD6SPmu927z-dhGL9JHepcAOGMSJA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 20 Jan 2020 13:56:59 +0100
Message-ID: <875zh6p9pg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Jan 17, 2020 at 5:37 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Fix the runqslower tool to include libbpf header files with the bpf/
>> prefix, to be consistent with external users of the library. Also ensure
>> that all includes of exported libbpf header files (those that are export=
ed
>> on 'make install' of the library) use bracketed includes instead of quot=
ed.
>>
>> To not break the build, keep the old include path until everything has b=
een
>> changed to the new one; a subsequent patch will remove that.
>>
>> Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken =
from selftests dir")
>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/runqslower/Makefile         |    5 +++--
>>  tools/bpf/runqslower/runqslower.bpf.c |    2 +-
>>  tools/bpf/runqslower/runqslower.c     |    4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index b62fc9646c39..9f022f7f2593 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -5,6 +5,7 @@ LLC :=3D llc
>>  LLVM_STRIP :=3D llvm-strip
>>  DEFAULT_BPFTOOL :=3D $(OUTPUT)/sbin/bpftool
>>  BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>> +INCLUDES :=3D -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/=
bpf)
>>  LIBBPF_SRC :=3D $(abspath ../../lib/bpf)
>
> drop LIBBPF_SRC, it's not used anymore

It is: in the rule for building libbpf there's a '-C $(LIBBPF_SRC)'

-Toke

