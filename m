Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B1920738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgFWK0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbgFWK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:26:18 -0400
X-Greylist: delayed 1897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Jun 2020 03:26:17 PDT
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA045C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 03:26:17 -0700 (PDT)
Received: from ip4d142d01.dynamic.kabel-deutschland.de ([77.20.45.1] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jnfdW-0005yl-2o; Tue, 23 Jun 2020 11:54:38 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 mQINBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABtCdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz6JAj0EEwEKACcFAlJ4A3UCGwMFCQ0oaIAF
 CwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQcrbm70xYPS0OOw/+OM+pakOz+MDn9vAgc5Xj
 dVqxjH1+cg7UWkW6UrkniT3i+THv535lGwwB93iQpG0eaLqIPcfFqWGHCJDY4ys8AdCiGA55
 D8eX/A/94Dboz6hzxfu2M4KvpiV2FQrklIZXGiLfr0+ybBUu+PoiS4OA8UzNc/rtAZivb6qm
 T62uUGtmWoj86hDSual9Syi1dn4ff9PVJcGMFk4URkg83qZpVeU/iOnPO7mfhV5l9yfuvP9h
 zhHQOTDrcOm8vJVgcs3TAd8WKke7ueBxuwlDS4a9X0ohT3MycO1sUSx5VpnHsZynvvyITEOW
 njjuBhIJrbjt+c/9HWz+5cJJ7QZOE1KrOAN+u6N4yFZrMFFKKug/s/z9wy7Cg5ANphJ/35to
 nZDV9MCw96sDONEdwEl2u4ZwN5oNJGdFm93odoGSvzu0LNgGi1AWE38pOKmq8EVDYJNMhsv+
 V0oj9vJJso22F5LBJjg233PIdvkF6KwihTiryVZUi3rX1RSwH8HFzVDCETW7bp3EAyUPuoTD
 f8vb7/5RZpNFzy/WtAt80hqp773+PAgPJuXGliI2uJol3nz9PWRhf6yn3U2VSkbiIG3MjwpJ
 vJL/dbiiKWn932U/JV8OKA4m7GKy44ZnTL0nYf/30/5gEVMM8FiPiY1Cybw907WYUxW+dboi
 eu8fdvHIi0xIBWu5Ag0EUngBDQEQAM7v97GrVs5cuvi6ouXUxUvfoSrxTLXUW/71uKPQkLDK
 i9gSRqBOLl78t3Gp3L3MqHc01wlMW3rDT++/Sanh8rO1pBdprS1V9pZ8l0lAZvzjcGrLiuyi
 8/KrrLHlLLL4yTw3cPJkSwFr43LGLGdKoCFOpAW72HJFFpGyY/9JLkApprpUTHGkEa0WK5O2
 XVDo2mJoykflCR5Y8S4Hq3oMol7pUScQqYT+ZooKMoqGtXrHrfIhfX4W/mFmNel9SN057nFQ
 ol4sc8cJ97sIlRoNvJ/r3X2eZWnJAjo+oiuPpX85Xc+DXyFyvvP0dcA/cjo9a69zrIw6jmro
 KDMYBBTosIUA4iZUSlWg235gtRuTdWH0CJ/dM5xGHDO/kqfEXOUVIDecn7sMonInyCUArYlo
 IxfLbXCBLioNE5hm+h0BwLRmgVyslxkLpQ9QpgRyFs4O2xoHuUeuoXW6tQYjF+UHZP6N0q9j
 iwq8VoajHa3iRS826BHNEtdwQsVYJZz6nb+bHe73m9Gs+Sxkus8lU3U27j1LuAtWW7LT27gg
 cEsHtxEab6ZnSMx7SCuBvYhiEd0nqNKFjs0L5BZ/JtpOh9vw3pc/SHBxHn0nubtBoyANfG2R
 Le0dpPAjGfOL6cljnIYMFytgzVwDs6uM8FfFuE4mIhYiFV30o9fObwqbhO49LoKdABEBAAGJ
 AiUEGAEKAA8FAlJ4AQ0CGwwFCQ0oaIAACgkQcrbm70xYPS2OxxAAr8OqW+bEjQV2PLLAHIh6
 fmhajXtSn9bzULofgyD4PsgMsG25di74GbegGyTIwt7cS7Z5ZR5KL7ZkN1GTDFGlWyiZ+6NC
 VsWR62+eujnYvtHsQPaTo8A/uFV+Too4v4ikS4ZD0ondWa1FimLouem9QwOSnyn4yErxUQcU
 yUXHLhUtYs7MO5R4G++Ev+9eK7rRqPeUOqTjQV6Eigi5Ny4536fKMJDNp+YhlRopWBA0fVjf
 tF0MJTV0ShFK1YWLOADJYo9NG+KOeyUqesOvRSxtpQcdcrwPFjkJ3JcknxZstvWid4goqMY7
 l/vGoG7zQDSxUDpXcG9X70yHrmVK/w0dn/PHalfUnOsQpvQYTjGhZ4UnXAVaBsouYLGFo9AL
 lLNERHY4eRR4MEYvk6ABZ1AEaJwiwyZuPRt/iN1EIMM7fnQQcdBYHGJzaV8a3jwHeLAPY1e/
 hS1OsrR9pqGvqQsagYkiZFOCjZxx0IQhokMSIxbFvNfLHTqXXpJzlCv9QGj3s2ZG6o36u42k
 yc+mP1ya8uxIFEwcp6C1h4TTisVFC2DXxDi7pqUd9oTuI4Hg19/i07cdYUHDiraDXSXW5zH9
 5ZDV+rSqDU3ercoRd2qjGUOIXWOytHTeJhVOWqM0vOmXDUwwYHuEb0HFn3d/tz+idSrXUSXZ
 5iv6NKaV29GWHbY=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     lwn@lwn.net
Subject: kcbench, the Linux kernel compile benchmark, version 0.9.0 is out
Message-ID: <5b2e2f50-a222-81e9-4383-c503d9a8fbe4@leemhuis.info>
Date:   Tue, 23 Jun 2020 11:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1592907977;f2886b3a;
X-HE-SMSGID: 1jnfdW-0005yl-2o
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: I released version 0.9.0 of kcbench, a simple Linux kernel
compile benchmark. It basically downloads a Linux version (which one
depends on the compiler used), extracts it, creates a configuration
('defconfig' by default), before it compiles a kernel ('vmlinux') in a
temporary directory ('O=/tmp/foo/') while measuring the time it takes to
build. It compiles a few kernels that way using different number of jobs
(make -j #). After each run kcbench prints the time it took and how many
kernels the machine can build per hour at this rate.

This is how it looks:


> [cttest@localhost ~]$ kcbench

> Processor:           Intel(R) Core(TM) i5-3350P CPU @ 3.10GHz [4 CPUs]

> Cpufreq; Memory:     powersave [intel_pstate]; 7895 MiB

> Linux running:       5.6.2-125.vanilla.knurd.1.fc31.x86_64 [x86_64]

> Compiler:            gcc (GCC) 9.3.1 20200317 (Red Hat 9.3.1-1)

> Linux compiled:      4.19.0 [/home/thl/.cache/kcbench/linux-4.19/]

> Config; Environment: defconfig; CCACHE_DISABLE="1"

> Build command:       make vmlinux

> Filling caches:      This might take a while... Done

> Run 1 (-j 4):        288.16 seconds / 12.49 kernels/hour [P:384%]

> Run 2 (-j 4):        288.19 seconds / 12.49 kernels/hour [P:384%]

> Run 3 (-j 6):        291.01 seconds / 12.37 kernels/hour [P:384%]

> Run 4 (-j 6):        291.28 seconds / 12.36 kernels/hour [P:385%]



You can use the benchmark to compare different machines, just make sure
they use a similar compiler. Kcbench can be useful for stress tests,
too. It's also a good tool to find the optimal number of jobs for
compiling source code, as 'just use all cores' sometimes is not the
fastest setting, as a quick test on an AMD Ryzen Threadripper 3990X (64
cores/128 threads) recently showed:



> [cttest@localhost ~]$ kcbench -s 5.3 -n 1 -m

> Processor:            AMD Ryzen Threadripper 3990X 64-Core Processor [128 CPUs]

> Cpufreq; Memory:      Unknown; 63736 MByte RAM

> Linux running:        5.6.0-0.rc2.git0.1.vanilla.knurd.2.fc31.x86_64

> Compiler used:        gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1)

> Linux compiled:       5.3.0 [/home/cttest/.cache/kcbench/linux-5.3/]

> Config; Environment:  defconfig; CCACHE_DISABLE="1"

> Build command:        make vmlinux

> Run 1 (-j 128):       260.43 seconds / 13.82 kernels/hour

> Run 2 (-j 136):       262.67 seconds / 13.71 kernels/hour

> Run 3 (-j 64):        215.54 seconds / 16.70 kernels/hour

> Run 4 (-j 72):        215.97 seconds / 16.67 kernels/hour

(this is a quote from the man-page, which has a few more results)

For more general information about kcbench see:

 * its project page:
https://gitlab.com/knurd42/kcbench/

 * its README:
https://gitlab.com/knurd42/kcbench/-/blob/master/README.md

 * the man-page for kcbench, which tries to compile one Linux kernel
really fast by using many jobs:
https://gitlab.com/knurd42/kcbench/-/raw/master/kcbench.man1.md

 * the man-page for kcbenchrate (which is new with 0.9.0 [thx arnd for
the suggestion]), which by default compiles one kernel on each CPU using
one job to measure the rate and keep the all cores busy all the time:
https://gitlab.com/knurd42/kcbench/-/raw/master/kcbenchrate.man1.md

 * the release page for kcbench 0.9.0, which list all its major
improvements:
https://gitlab.com/knurd42/kcbench/-/releases/v0.9.0


To quickly outline the potential briefly, here is what a
'kcbench --help' will show:

> Usage: kcbench [options]

> 

> Compile a Linux kernel and measure the time it takes.

> 

> Available options:

>  -b, --bypass                 -- bypass cache fill run and measure immediately

>  -d, --detailedresults        -- print more detailed results

>  -i, --iterations <int>       -- number or iterations per job

>  -j, --jobs <int> (*)         -- number of jobs to use ('make -j #')

>  -m, --modconfig              -- build using 'allmodconfig vmlinux modules'

>  -o, --outputdir <dir>        -- compile in <dir>/kcbench/ ('make O=#')

>  -q, --quiet                  -- quiet

>  -s, --src (<dir>|<version>)  -- take Linux sources from <dir>; if not found

>                                  try ~/.cache/kcbench/linux-<version>/ and

>                                  /usr/share/kcdata/linux-<version>/; if still

>                                  not found download <version> automatically.

>  -v, --verbose (*)            -- increase verboselevel

> 

>      --add-make-args <str>    -- pass <str> to make call ('make <str> vmlinux')

>      --cc <exec>              -- use specified target compiler ('CC=#')

>      --cross-compile <arch>   -- cross compile for <arch>

>      --crosscomp-scheme <str> -- naming scheme for cross compiler

>      --hostcc <exec>          -- use specified host compiler ('HOSTCC=#')

>      --infinite               -- run endlessly

>      --llvm                   -- sets 'LLVM=1' to use clang and LLVM tools

>      --no-download            -- never download anything automatically

>      --savefailedlogs <dir>   -- save log from failed compilations in <dir>

> 

>  -h, --help                   -- show this text

>  -V, --version                -- output program version

> 

> (*) -- option can be passed multiple times


Ciao, Thorsten

P.S.: kcbench is written in Bash, as it started quite small and grew a
lot over time. Maybe at this point bash might not be the best choice,
but OTOH it's something that runs nearly everywhere; it also understood
by a lot of people, which makes it easy to adjust to specific needs.
