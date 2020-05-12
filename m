Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B024ACA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B1A206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMN75WZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgELP4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgELP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:56:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC38C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:56:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x8so11380421qtr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:resent-from:resent-date:resent-message-id:resent-to:date:to:cc
         :subject:message-id:references:mime-version:content-disposition
         :in-reply-to;
        bh=YTol6dHr+6rHPhQFDRRXm4Yh0yJozmGBuLj8k4WvEXE=;
        b=aMN75WZGYLhraM9q8J4y6dRaNMfAK8+tZq5w7XkhLPGY2zitLnMUdQERdS4NHKVTDQ
         h2Rn1D0XSS/B0JfGGE+XtcoIN8Xtbmlhaf2Nh4s84d/ub+b9AOXsAexjcCLj8P1qLiaO
         yXYT85ZimX22iDivrYDoGBs+SiCWkcLiRIZGjkQQwfnxbsjMzqqB822Uvr0JUIEAYNrH
         D4gpKYsv98e7Lnt6KiSHofV2sLZRH+gog2wzqOjiWGZ69Tq/0lFXOY8W+LrrrDjvWVud
         aytGn+zfaT38ysy00ox56i+S5y/RrbONBumSEn/80rTck3LKO6MGekFgJG+C+5Xh88Cb
         jcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:resent-from:resent-date:resent-message-id
         :resent-to:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YTol6dHr+6rHPhQFDRRXm4Yh0yJozmGBuLj8k4WvEXE=;
        b=mVNpHWPAwBLUArx/s9TdkUot0VqHxPpTgoCnj4qGHAsRxoijuOkq255rZHcoMkyuHf
         /zXHZXZ+Mni0SwTsPLGwD8EpN9QP/qSYifZYxPlQwCR9S7UECw1jK9rU4LoZpyBJ8/su
         LA9uAr0vS/TFvAvfFo1Kk0naIHT/Hkqaap0hehYG74/n42HEu6r5HXTzc5mB95Yj+Crj
         X0r/DFa6ceUVxgBSBu69aTf7qg69EzEaiAvSYv4QlTk2ru5PiTxDUXKEz7RBW1cXimIQ
         b2eRvpKh3m7xibbE/vueHvri3fqeoDLNGaoY9fRjYYB3OAzjCOxcztftg9oZ/7ezUgMC
         rc8A==
X-Gm-Message-State: AGi0PuaG0Y2MGATkKSUl/VuYAQ/sKX4OBDxHP+bQ9bsMY6rt4QDXRr1E
        HCJEzvv5gqbC69+FH3/qRH8=
X-Google-Smtp-Source: APiQypL/8GMVSzXHs4wqXLlheSbmcLArUlohtgLXWOFITrF8iC0731T8d0ad/GXUJyKoKtIcho1cJQ==
X-Received: by 2002:ac8:2a70:: with SMTP id l45mr23119755qtl.232.1589299006116;
        Tue, 12 May 2020 08:56:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 62sm11250431qkh.113.2020.05.12.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:56:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6D6A40AFD; Tue, 12 May 2020 12:56:43 -0300 (-03)
Date:   Tue, 12 May 2020 12:41:25 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: perf seg fault
Message-ID: <20200512154125.GO28888@kernel.org>
References: <0cad7834-07b4-ec2f-13b5-d6a10b21ce48@intel.com>
 <0517775a-3e0f-f900-4687-069d115077bd@intel.com>
 <20200512151043.GC3158213@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512151043.GC3158213@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 05:10:43PM +0200, Jiri Olsa escreveu:
> On Tue, May 12, 2020 at 05:58:29PM +0300, Adrian Hunter wrote:
> > Forgot to cc mailing list
> > 
> > On 12/05/20 5:50 pm, Adrian Hunter wrote:
> > > Hi
> > > 
> > > I am getting a seg fault from your perf/core branch, as follows:
> > > 
> > > # perf record uname
> > > Linux
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.005 MB perf.data (7 samples) ]
> > > perf: Segmentation fault
> > > Obtained 6 stack frames.
> > > [0x4e75b4]
> > > [0x5d1ad0]
> > > [0x5c9860]
> > > [0x4a6e5c]
> > > [0x5cb39b]
> > > [0x76c89f]
> > > Segmentation fault
> > > 
> > > It goes away with --no-bpf-event:
> > > 
> > > # perf record --no-bpf-event uname
> > > Linux
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.005 MB perf.data (7 samples) ]
> > > #
> > > 
> > > kernel is from the same branch
> > > 
> > > # uname -a
> > > Linux buildroot 5.7.0-rc2-00028-g0fdddf5a583a #165 SMP Tue May 12 16:27:53
> > > EEST 2020 x86_64 GNU/Linux
> > > 
> > > # perf version --build-options
> > > perf version 5.6.g0fdddf5a583a
> > >                  dwarf: [ OFF ]  # HAVE_DWARF_SUPPORT
> > >     dwarf_getlocations: [ OFF ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> > >                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> > >                   gtk2: [ OFF ]  # HAVE_GTK2_SUPPORT
> > >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> > >                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> > >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > >                libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> > > numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> > >                libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
> > >              libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
> > >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> > >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
> > >     libdw-dwarf-unwind: [ OFF ]  # HAVE_DWARF_SUPPORT
> > >                   zlib: [ OFF ]  # HAVE_ZLIB_SUPPORT
> > >                   lzma: [ OFF ]  # HAVE_LZMA_SUPPORT
> > >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > >                    bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT


Humm, maybe this?

make -C tools clean
rm -rf /tmp/build/perf
mkdir -p /tmp/build/perf
make -C tools/perf O=/tmp/build/perf install-bin

[root@five ~]# perf -vv
perf version 5.7.rc2.g2dbd8814c26b
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
[root@five ~]# perf record uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.029 MB perf.data (7 samples) ]
perf: Segmentation fault
Obtained 6 stack frames.
perf(sighandler_dump_stack+0x3e) [0x4fc7be]
/lib64/libc.so.6(+0x3c6af) [0x7f073b8a16af]
perf(perf_mmap__read_init+0x20) [0x5d9570]
perf() [0x4c7758]
/lib64/libpthread.so.0(+0x94e1) [0x7f073c28a4e1]
/lib64/libc.so.6(clone+0x42) [0x7f073b9666a2]
Segmentation fault (core dumped)
[root@five ~]#

?

> > >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> > >                   zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
> > > 
> > > 
> > > Any thoughts?
> 
> hum, I don't see that, do you reproduce with DEBUG=1?
> to get more verbose backtrace

[root@five ~]# uname -a
Linux five 5.7.0-rc2 #1 SMP Tue Apr 21 11:06:25 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]# perf record uname
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.030 MB perf.data (7 samples) ]
[root@five ~]# uname -a
Linux five 5.7.0-rc2 #1 SMP Tue Apr 21 11:06:25 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]#

[root@five ~]# uname -a
Linux five 5.7.0-rc2 #1 SMP Tue Apr 21 11:06:25 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]# perf -vv
perf version 5.7.rc2.g2dbd8814c26b
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
[root@five ~]#
