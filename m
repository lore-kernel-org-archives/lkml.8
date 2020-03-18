Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB60CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C9F20773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L84CQAC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCROVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:21:03 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:34495 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCROVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:21:03 -0400
Received: by mail-qk1-f174.google.com with SMTP id f3so38938594qkh.1;
        Wed, 18 Mar 2020 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sy5iHcrtX1pHBM/PUWynkqV0cManlXIA2qvlXZPPxk0=;
        b=L84CQAC6SZLAsmZKDXtRlslDkaqbiRMMVs5Of3MV1eCny6z87iSSJS5+SCC/F/x4/O
         D0Cecz1Gi+ggDGpC0ZNnNTx0iV4IzR/mu7zUUqAr2jgms32GPoBdybzuZqK5yx8z4GQW
         2FAMNrNK42lVaOIc8q4pYc7NEsKsk6kW4w8PBsZluOHFyPAAJySFLSP+5OGwAd0qPmRq
         qG+LZPap9xdYqCic0WvLZV/BgMrg7jP6EGQsLTNQHFeuD1ATg5Vw3m1YKQ4jNd8t1U+H
         0hiMp6TjTcv173Cs2jR9I3xrYIdGP0qx6gOSY7XmiBAvNOEOG3ZV1N9dOcxUC3wDweeW
         3Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sy5iHcrtX1pHBM/PUWynkqV0cManlXIA2qvlXZPPxk0=;
        b=tVE+qRFCJZTjZwzJt0MUUAJQi2ChhzEppg4cXRcA+F0NA4KgdC3EsND90w2bwNtVDM
         F04wJJj8hbhO3oZT+/YvGgCroI64jk6I2smYCHJLFi2EcnabjOsCAloELXqU9/XKToku
         Fx5zAC1TvXQ4Oyjpyoj3R7QzUwLhsunSIX02oRF3zQKoz8tfnQg90Is0nxJDofGxHlEC
         7x3dxFu1EqBQH/UmGsGdAJmV1quSC0/HgrulD6nyCtN6jK3n+W7uqNlBQT0C5xVKepCR
         PgWT/Fvbsa4Lar4TAEZNdmEUZm1Fh2Umq+5iBuI3XF9bVbx62sWBC0vvsF0lMtj7krBv
         nlvA==
X-Gm-Message-State: ANhLgQ3A1iLD5d7L1SyfJ0UZ5lZYcUNWz3l3tbJs1fTJAoQWBBfTu/EB
        uhQoWEmVZjEPg7VFNLyGninA1Jbe
X-Google-Smtp-Source: ADFU+vsMZIDPdlHUq8IodyfeE8xQwEGqgSSgsoiun5s+cldMVhiGuHAfmBFE/XlX+wuRzODuOUdaNw==
X-Received: by 2002:a05:620a:1192:: with SMTP id b18mr4041984qkk.334.1584541260815;
        Wed, 18 Mar 2020 07:21:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h25sm4083190qkg.87.2020.03.18.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 07:21:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08F41404E4; Wed, 18 Mar 2020 11:20:58 -0300 (-03)
Date:   Wed, 18 Mar 2020 11:20:57 -0300
To:     Vijay Thakkar <vijaythakkar@me.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200318142057.GD11531@kernel.org>
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-3-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316225238.150154-3-vijaythakkar@me.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 16, 2020 at 06:52:37PM -0400, Vijay Thakkar escreveu:
> This patch adds PMU events for AMD Zen2 core based processors, namely,
> Matisse (model 71h), Castle Peak (model 31h) and Rome (model 2xh), as
> documented in the AMD Processor Programming Reference for Matisse [1].
> The model number regex has been set to detect all the models under
> family 17 that do not match those of Zen1, as the range is larger for
> zen2.
> 
> Zen2 adds some additional counters that are not present in Zen1 and
> events for them have been added in this patch. Some counters have also
> been removed for Zen2 thatwere previously present in Zen1 and have been
> confirmed to always sample zero on zen2. These added/removed counters
> have been omitted for brevity but can be found here:
> https://gist.github.com/thakkarV/5b12ca5fd7488eb2c42e451e40bdd5f3
> 
> Note that PPR for Zen2 [1] does not include some counters that were
> documented in the PPR for Zen1 based processors [2]. After having tested
> these counters, some of them that still work for zen2 systems have been
> preserved in the events for zen2. The counters that are omitted in [1]
> but are still measurable and non-zero on zen2 (tested on a Ryzen 3900X
> system) are the following:
> 
> PMC 0x000 fpu_pipe_assignment.{total|total0|total1|total2|total3}

So trying to test this a bit, can you take a look at the examples
below? I.e. it would be really nice to have at least some of these
examples tested programatically.

So, picking this one:

    "EventName": "fpu_pipe_assignment.total",
    "EventCode": "0x00",
    "BriefDescription": "Total number of fp uOps.",
    "PublicDescription":

    "Total number of fp uOps. The number of operations (uOps) dispatched
    to each of the 4 FPU execution pipelines. This event reflects how
    busy the FPU pipelines are and may be used for workload
    characterization. This includes all operations performed by x87,
    MMX, and SSE instructions, including moves. Each increment
    represents a one- cycle dispatch event. This event is a speculative
    event. Since this event includes non-numeric operations it is not
    suitable for measuring MFLOPS.",


Committer testing:

On a AMD Ryzen 5 3600X 6-Core Processor, model 113 (0x71):

Before:

  [root@five ~]# perf list *fpu_pipe_assignment*
  
  List of pre-defined events (to be used in -e):
  
  
  [root@five ~]#

After:

  [root@five ~]# perf list *fpu_pipe_assignment*
  
  List of pre-defined events (to be used in -e):
  
  
  
  floating point:
    fpu_pipe_assignment.total                         
         [Total number of fp uOps]
  
  
  Metric Groups:
  
  [root@five ~]#

Using it:

  [root@five ~]# perf stat -I1000 -e fpu_pipe_assignment.total
  #           time             counts unit events
       1.000781022         71,830,536      fpu_pipe_assignment.total                                   
       2.001835955         69,017,141      fpu_pipe_assignment.total                                   
       3.002498539         79,561,420      fpu_pipe_assignment.total                                   
       4.002922910         79,834,539      fpu_pipe_assignment.total                                   
       5.003545481         76,197,236      fpu_pipe_assignment.total                                   
  ^C     5.288876179         36,038,036      fpu_pipe_assignment.total                                   
  
  [root@five ~]#

  [root@five ~]# perf stat -e fpu_pipe_assignment.total sleep 1
  
   Performance counter stats for 'sleep 1':
  
             396,722      fpu_pipe_assignment.total                                   
  
         1.000777226 seconds time elapsed
  
         0.000712000 seconds user
         0.000000000 seconds sys
  
  
  [root@five ~]#

  [root@five ~]# perf record -e fpu_pipe_assignment.total sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.020 MB perf.data (7 samples) ]
  [root@five ~]# perf report --stdio --no-header
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 7  of event 'fpu_pipe_assignment.total'
  # Event count (approx.): 120733
  #
  # Overhead  Command  Shared Object     Symbol                    
  # ........  .......  ................  ..........................
  #
      96.44%  sleep    ld-2.30.so        [.] _dl_map_object_deps
       3.44%  sleep    [kernel.vmlinux]  [k] __do_munmap
       0.12%  sleep    [kernel.vmlinux]  [k] kfree
       0.00%  sleep    [kernel.vmlinux]  [k] perf_event_mmap_output
       0.00%  sleep    [kernel.vmlinux]  [k] kmem_cache_alloc_trace
       0.00%  sleep    [kernel.vmlinux]  [k] prepend_name
       0.00%  sleep    [kernel.vmlinux]  [k] shift_arg_pages
  
  
  #
  # (Tip: If you have debuginfo enabled, try: perf report -s sym,srcline)
  #
  [root@five ~]#

  [root@five ~]# perf annotate --stdio2 kfree | egrep '^ {0,2}[0-9]+' -B5 -A5
                 mov    0x8(%rbp),%rax
                 lea    -0x1(%rax),%rdx
                 test   $0x1,%al
                 cmovne %rdx,%rbp
                 mov    0x8(%rbp),%rdx
  100.00         lea    -0x1(%rdx),%rax
                 and    $0x1,%edx
                 cmove  %rbp,%rax
                 mov    (%rax),%rax
                 test   $0x2,%ah
               ↓ je     1bc     
  [root@five ~]#

  [root@five ~]# perf annotate --stdio2 _dl_map_object_deps | egrep '^ {0,2}[0-9]+' -B5 -A5
                  cmp     $0xfffffffffffffffd,%rax
                ↑ jbe     559     
           c7b:   xor     %ecx,%ecx
                ↑ jmpq    56f     
           c82:   mov     %r10,-0x4c0(%rbp)
  100.00          mov     -0x4b8(%rbp),%r14
                  movl    $0x1,-0x4dc(%rbp)
                ↑ jmpq    13b     
           c9f:   mov     -0x4b8(%rbp),%rax
                  cmp     %rax,_rtld_global
                ↑ jne     7a0     
  [root@five ~]#


These look reassuring:

  [root@five ~]# perf record -e fpu_pipe_assignment.total -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.351 MB perf.data (2112 samples) ]
  [root@five ~]# perf report --stdio --no-header | head -30
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 2K of event 'fpu_pipe_assignment.total'
  # Event count (approx.): 1408125294
  #
  # Overhead  Command          Shared Object                 Symbol
  # ........  ...............  ............................  .............................................
  #
      10.24%  Compositor       libxul.so                     [.] 0x00000000041bf629
       5.90%  Compositor       libxul.so                     [.] 0x00000000041bf63c
       5.15%  DecodingThread   libxul.so                     [.] vp9_variance_and_sad_16x16_sse2
       2.87%  Compositor       libxul.so                     [.] 0x00000000041c421b
       2.56%  Compositor       libxul.so                     [.] 0x00000000041bf611
       2.30%  Compositor       libc-2.30.so                  [.] __memmove_avx_unaligned_erms
       1.39%  Compositor       libxul.so                     [.] 0x00000000041bf307
       1.21%  Compositor       libxul.so                     [.] 0x0000000003b485de
       1.09%  Compositor       libxul.so                     [.] 0x0000000003b4a9b0
       1.02%  Compositor       libxul.so                     [.] 0x00000000041bf2f9
       0.98%  DecodingThread   libxul.so                     [.] vp8_variance_and_sad_16x16_sse2
       0.97%  Compositor       libxul.so                     [.] 0x00000000041c41cf
       0.81%  Compositor       libxul.so                     [.] 0x00000000041c41bc
       0.79%  Compositor       libxul.so                     [.] 0x00000000041bf2cd
       0.73%  Compositor       libxul.so                     [.] 0x00000000041bf2de
       0.72%  Compositor       libxul.so                     [.] 0x00000000041c4225
       0.70%  Compositor       [kernel.vmlinux]              [k] clear_page_rep
       0.69%  Compositor       libxul.so                     [.] 0x00000000041bf2d2
       0.68%  Compositor       libxul.so                     [.] 0x0000000003b48524
  [root@five ~]#
  
  [root@five ~]# perf annotate --stdio2 vp9_variance_and_sad_16x16_sse2 | egrep '^ {0,2}[0-9]+' -B2 -A2
                   movdqa     %xmm1,%xmm5
                   pavgb      %xmm3,%xmm5
    2.15           psubusb    %xmm1,%xmm4
                   psubusb    %xmm0,%xmm1
                   psubusb    %xmm3,%xmm6
  --
                   movdqa     (%rsp),%xmm2
                   pxor       %xmm1,%xmm1
    0.74           movdqa     %xmm2,%xmm7
                   psubusb    %xmm4,%xmm2
    0.99           psubusb    %xmm6,%xmm7
                   pcmpeqb    %xmm1,%xmm2
    2.29           pcmpeqb    %xmm1,%xmm7
                   por        %xmm2,%xmm7
   14.96           neg        %rax  
                   movdqu     (%rsi,%rax,2),%xmm1
                   movdqu     (%rsi,%rax,1),%xmm3
  --
                   pavgb      %xmm3,%xmm1
                   psubusb    %xmm2,%xmm6
    2.70           psubusb    %xmm0,%xmm2
                   psubusb    %xmm3,%xmm4
                   psubusb    %xmm0,%xmm3
  --
                   movdqa     (%rsp),%xmm2
                   pxor       %xmm1,%xmm1
    1.68           movdqa     %xmm2,%xmm3
                   psubusb    %xmm6,%xmm2
    0.92           psubusb    %xmm4,%xmm3
                   pcmpeqb    %xmm1,%xmm2
                   pcmpeqb    %xmm1,%xmm3
    1.84           por        %xmm2,%xmm7
    5.95           por        %xmm3,%xmm7
    2.93           pavgb      %xmm0,%xmm5
                   pand       %xmm7,%xmm0
   10.03           pandn      %xmm5,%xmm7
    0.96           paddusb    %xmm7,%xmm0
                   movdqu     %xmm0,(%rdi)
    2.60           neg        %rax  
                   add        $0x10,%rsi
                   add        $0x10,%rdi
                   add        $0x10,%rdx
                   cmp        -0x28(%rbp),%edx
    1.20         ↓ jge        b67   
                   movdqu     (%rbx),%xmm2
                   movdqu     %xmm2,(%rsp)
                   add        $0x10,%rbx
    2.50         ↑ jmpq       a78   
            b67:   sub        %rdx,%rsi
                   sub        %rdx,%rdi
  --
                   punpcklbw  %mm1,%mm1
                   punpcklwd  %mm1,%mm1
    1.14           punpckldq  %mm1,%mm1
                   mov        $0xfffffffffffffff8,%rdx
                   movq       %mm1,(%rdi,%rdx,1)
                   movslq     -0x28(%rbp),%rdx
                   movq       -0x1(%rdi,%rdx,1),%mm1
    2.16           punpcklbw  %mm1,%mm1
                   punpcklwd  %mm1,%mm1
                   punpckldq  %mm1,%mm1
  --
            bb6:   movdqu     (%rdi,%rdx,1),%xmm0
                   movdqu     -0x2(%rdi,%rdx,1),%xmm1
    0.60           movdqu     -0x1(%rdi,%rdx,1),%xmm3
                   movdqa     %xmm0,%xmm4
                   movdqa     %xmm0,%xmm6
  --
                   movdqa     %xmm2,%xmm7
                   psubusb    %xmm4,%xmm2
    1.19           psubusb    %xmm6,%xmm7
    2.37           pcmpeqb    %xmm1,%xmm2
                   pcmpeqb    %xmm1,%xmm7
                   por        %xmm2,%xmm7
    4.40           movdqu     0x1(%rdi,%rdx,1),%xmm1
                   movdqu     0x2(%rdi,%rdx,1),%xmm3
                   movdqa     %xmm0,%xmm6
                   movdqa     %xmm0,%xmm4
    3.07           movdqa     %xmm1,%xmm2
                   pavgb      %xmm3,%xmm1
                   psubusb    %xmm2,%xmm6
                   psubusb    %xmm0,%xmm2
    2.05           psubusb    %xmm3,%xmm4
                   psubusb    %xmm0,%xmm3
                   paddusb    %xmm2,%xmm6
                   paddusb    %xmm3,%xmm4
    1.98           pavgb      %xmm1,%xmm5
                   movdqa     (%rsp),%xmm2
                   pxor       %xmm1,%xmm1
                   movdqa     %xmm2,%xmm3
    1.94           psubusb    %xmm6,%xmm2
                   psubusb    %xmm4,%xmm3
                   pcmpeqb    %xmm1,%xmm2
                   pcmpeqb    %xmm1,%xmm3
    2.42           por        %xmm2,%xmm7
    1.49           por        %xmm3,%xmm7
    1.78           pavgb      %xmm0,%xmm5
                   pand       %xmm7,%xmm0
    2.89           pandn      %xmm5,%xmm7
    3.24           paddusb    %xmm7,%xmm0
                   movq       %mm0,-0x10(%rdi,%rdx,1)
                   movq       %mm1,-0x8(%rdi,%rdx,1)
                   movdq2q    %xmm0,%mm0
    6.83           psrldq     $0x8,%xmm0
    1.97           movdq2q    %xmm0,%mm1
    4.03           add        $0x10,%rdx
                   cmp        -0x28(%rbp),%edx
                 ↓ jge        caf   
  [root@five ~]#
