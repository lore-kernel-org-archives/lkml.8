Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DADCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED71C20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgELPpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:45:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:49286 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgELPpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:45:07 -0400
IronPort-SDR: 5HR6PUv9qA+EESdhHEcjOg0lz+wA3sFxft0GCVoFfOqaivvPKQ/uESVrjnkktP4dp5zsCtwzKM
 ItDGiyYdJ2yA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 08:45:06 -0700
IronPort-SDR: kdwaEERtU8Q3U80PSAnCsVPCMcs0+yipSalKLK8GG4YPaPjxjCCZevzK9nJD0hAqSY0oHPQfMQ
 rdKgAJwQAGeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="251498502"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2020 08:45:05 -0700
Subject: Re: perf seg fault
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <0cad7834-07b4-ec2f-13b5-d6a10b21ce48@intel.com>
 <0517775a-3e0f-f900-4687-069d115077bd@intel.com>
 <20200512151043.GC3158213@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b0d5769b-9b2b-3e05-5ced-5cae2c50f674@intel.com>
Date:   Tue, 12 May 2020 18:45:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512151043.GC3158213@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/20 6:10 pm, Jiri Olsa wrote:
> On Tue, May 12, 2020 at 05:58:29PM +0300, Adrian Hunter wrote:
>> Forgot to cc mailing list
>>
>> On 12/05/20 5:50 pm, Adrian Hunter wrote:
>>> Hi
>>>
>>> I am getting a seg fault from your perf/core branch, as follows:
>>>
>>> # perf record uname
>>> Linux
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.005 MB perf.data (7 samples) ]
>>> perf: Segmentation fault
>>> Obtained 6 stack frames.
>>> [0x4e75b4]
>>> [0x5d1ad0]
>>> [0x5c9860]
>>> [0x4a6e5c]
>>> [0x5cb39b]
>>> [0x76c89f]
>>> Segmentation fault
>>>
>>> It goes away with --no-bpf-event:
>>>
>>> # perf record --no-bpf-event uname
>>> Linux
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.005 MB perf.data (7 samples) ]
>>> #
>>>
>>> kernel is from the same branch
>>>
>>> # uname -a
>>> Linux buildroot 5.7.0-rc2-00028-g0fdddf5a583a #165 SMP Tue May 12 16:27:53
>>> EEST 2020 x86_64 GNU/Linux
>>>
>>> # perf version --build-options
>>> perf version 5.6.g0fdddf5a583a
>>>                  dwarf: [ OFF ]  # HAVE_DWARF_SUPPORT
>>>     dwarf_getlocations: [ OFF ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>>>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>>>                   gtk2: [ OFF ]  # HAVE_GTK2_SUPPORT
>>>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>>>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>>>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>>>                libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
>>> numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
>>>                libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
>>>              libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
>>>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>>>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>>>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
>>>     libdw-dwarf-unwind: [ OFF ]  # HAVE_DWARF_SUPPORT
>>>                   zlib: [ OFF ]  # HAVE_ZLIB_SUPPORT
>>>                   lzma: [ OFF ]  # HAVE_LZMA_SUPPORT
>>>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>>>                    bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT
>>>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>>>                   zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
>>>
>>>
>>> Any thoughts?
> 
> hum, I don't see that, do you reproduce with DEBUG=1?
> to get more verbose backtrace

It will require a kernel with support for bpf events otherwise the
--no-bpf-event option would have no effect.
