Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6982DC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FD820674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhPI8t2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgELPK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:10:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38473 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727832AbgELPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589296256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKC3u2rWAincJlOpFZyksKgLLZopfVm+v57ObhgEs6s=;
        b=QhPI8t2ndYkQ2KHUrk2nJwkXr98GECkVKSI23eNhOn/+uJz9qqf17gwiR2pMtYCrJy3bpn
        dPzpM3IAAUNH89Ks76rmj5MMeqDCgCPxsLKtEEDp97zqb8byoPhftWp0t7qsTprmeSpajj
        eocDpqkhJmPDXuFDzGJ9du6e7elXyXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-pGNyNtgvOae-r3AaJ9SE6w-1; Tue, 12 May 2020 11:10:46 -0400
X-MC-Unique: pGNyNtgvOae-r3AaJ9SE6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92169801504;
        Tue, 12 May 2020 15:10:45 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA0EE10001B3;
        Tue, 12 May 2020 15:10:44 +0000 (UTC)
Date:   Tue, 12 May 2020 17:10:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: perf seg fault
Message-ID: <20200512151043.GC3158213@krava>
References: <0cad7834-07b4-ec2f-13b5-d6a10b21ce48@intel.com>
 <0517775a-3e0f-f900-4687-069d115077bd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0517775a-3e0f-f900-4687-069d115077bd@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:58:29PM +0300, Adrian Hunter wrote:
> Forgot to cc mailing list
> 
> On 12/05/20 5:50 pm, Adrian Hunter wrote:
> > Hi
> > 
> > I am getting a seg fault from your perf/core branch, as follows:
> > 
> > # perf record uname
> > Linux
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.005 MB perf.data (7 samples) ]
> > perf: Segmentation fault
> > Obtained 6 stack frames.
> > [0x4e75b4]
> > [0x5d1ad0]
> > [0x5c9860]
> > [0x4a6e5c]
> > [0x5cb39b]
> > [0x76c89f]
> > Segmentation fault
> > 
> > It goes away with --no-bpf-event:
> > 
> > # perf record --no-bpf-event uname
> > Linux
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.005 MB perf.data (7 samples) ]
> > #
> > 
> > kernel is from the same branch
> > 
> > # uname -a
> > Linux buildroot 5.7.0-rc2-00028-g0fdddf5a583a #165 SMP Tue May 12 16:27:53
> > EEST 2020 x86_64 GNU/Linux
> > 
> > # perf version --build-options
> > perf version 5.6.g0fdddf5a583a
> >                  dwarf: [ OFF ]  # HAVE_DWARF_SUPPORT
> >     dwarf_getlocations: [ OFF ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> >                   gtk2: [ OFF ]  # HAVE_GTK2_SUPPORT
> >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> >                libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
> >              libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
> >     libdw-dwarf-unwind: [ OFF ]  # HAVE_DWARF_SUPPORT
> >                   zlib: [ OFF ]  # HAVE_ZLIB_SUPPORT
> >                   lzma: [ OFF ]  # HAVE_LZMA_SUPPORT
> >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                    bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                   zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
> > 
> > 
> > Any thoughts?

hum, I don't see that, do you reproduce with DEBUG=1?
to get more verbose backtrace

jirka

