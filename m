Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1BAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6248920657
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PdWBXK5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgE0MF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgE0MF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:05:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014E0C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:05:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so18904411qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uxte5EQPgszUzCX1RbrYyIXtdmRWMdfuzaum0KwC3Ig=;
        b=PdWBXK5mf8ZciY2y3GAhhmpbRhZxKIMgpx1QNoG/iPMcBp9gAvx/pb797HHYEEswOY
         NCBjD1Bs3jQiCPa3BA7njU8brOjYSV84ChFwxk3YGf8zm5VBvFllIYDnjJCh2pxmd9p1
         /0dFDOs98gNM8bwM5IoRIiiUsIpsYB5L4asxyldzOocr5874Nn0mNWOhJoptR3uR6/Qz
         TqJC8pNZaKLz/DJSDS19tiuS2YM3nu2JZh9zo2AdjsEOSoEBJwGvdQf/q8Gi9EZoH0af
         AlPYzap9rTGvnlFAgJgaTq5GAjJ0S+4btMddOlVykVI3ggUcINtai80J9KFstx7SVSmi
         qPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uxte5EQPgszUzCX1RbrYyIXtdmRWMdfuzaum0KwC3Ig=;
        b=STvTHUreL0Nm1gs7iGznEzbIsqm4NbGmiOM+C7IOASMVYeCYFtlIIhhbGFWIJOQ2DB
         PVwFGFj2No990Y6ZWo2inpL/8S8bEx4QQxyltfn2MTdSid/PqVCDLeTmRBotL/RogwPi
         Zh/By/llriloRmUENyFI+WxA+vQWsoVzQTU05KaJOka+RjU6fC+Cr908t/IyGb3BSNdW
         UTbctxpAfyg8lyRJpGLh65Ar+mJUi/OLPH2oCLd871EDFr1GEekacVPovnrn22HdaxAC
         OWvv4IztcoBXX7oifTzvUn3DhsSUScMEVtChWw9jvokiXWhpKmkSHcuC97gXgiFvclwe
         1HmA==
X-Gm-Message-State: AOAM530Q1AAUxMJo9n8w8dHs1aTcEiy0tY8FuTiCQLfmpgL3izAiASbv
        zIZDN1p1XUe/X3O/cYEd61ngHA==
X-Google-Smtp-Source: ABdhPJzXsEhsKFILLogJWlbUI3Hi5BAfZ5dRdVD4Yp1e8MRUG4twD2Z1atHrL3kllQS3J0EP8oA8uA==
X-Received: by 2002:ac8:2979:: with SMTP id z54mr3922785qtz.14.1590581157021;
        Wed, 27 May 2020 05:05:57 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j3sm2173951qkf.9.2020.05.27.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:05:56 -0700 (PDT)
Date:   Wed, 27 May 2020 08:05:49 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200527120549.GA741@lca.pw>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527104606.GE93879@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:46:06PM +0800, Feng Tang wrote:
> Hi Qian,
> 
> On Tue, May 26, 2020 at 10:25:39PM -0400, Qian Cai wrote:
> > > > > > [1] https://lkml.org/lkml/2020/3/5/57
> > > > > 
> > > > > Reverted this series fixed a warning under memory pressue.
> > > > 
> > > > Andrew, Stephen, can you drop this series?
> > > > 
> > > > > 
> > > > > [ 3319.257898] LTP: starting oom01
> > > > > [ 3319.284417] ------------[ cut here ]------------
> > > > > [ 3319.284439] memory commitment underflow
> > > 
> > > Thanks for the catch!
> > > 
> > > Could you share the info about the platform, like the CPU numbers
> > > and RAM size, and what's the mmap test size of your test program.
> > > It would be great if you can point me the link to the test program.
> > 
> > I have been reproduced this on both AMD and Intel. The test just
> > allocating memory and swapping.
> > 
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c
> > 
> > It might be better to run the whole LTP mm tests if none of the above
> > triggers it for you which has quite a few memory pressurers.
> > 
> > /opt/ltp/runltp -f mm
> 
> Thanks for sharing. I tried to reproduce this on 2 server plaforms,
> but can't reproduce it, and they are still under testing.
> 
> Meanwhile, could you help to try the below patch, which is based on
> Andi's suggestion and have some debug info. The warning is a little
> strange, as the condition is
> 
> 	(percpu_counter_read(&vm_committed_as) <
>                        -(s64)vm_committed_as_batch * num_online_cpus())
> 
> while for your platform (48 CPU + 128 GB RAM), the
> '-(s64)vm_committed_as_batch * num_online_cpus()'
> is a s64 value: '-32G', which makes the condition hard to be true,
> and when it is,  it could be triggered by some magic for s32/s64
> operations around the percpu-counter. 

Here is the information on AMD and powerpc below affected by this. It
could need a bit patient to reproduce, but our usual daily CI would
trigger it eventually after a few tries.

# git clone https://github.com/cailca/linux-mm.git
# cd linux-mm
# ./compile.sh
# systemctl reboot
# ./test.sh

== AMD ==
# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              128
On-line CPU(s) list: 0-127
Thread(s) per core:  2
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        8
Vendor ID:           AuthenticAMD
CPU family:          23
Model:               1
Model name:          AMD EPYC 7601 32-Core Processor
Stepping:            2
CPU MHz:             3184.974
CPU max MHz:         2200.0000
CPU min MHz:         1200.0000
BogoMIPS:            4391.87
Virtualization:      AMD-V
L1d cache:           32K
L1i cache:           64K
L2 cache:            512K
L3 cache:            8192K
NUMA node0 CPU(s):   0-7,64-71
NUMA node1 CPU(s):   8-15,72-79
NUMA node2 CPU(s):   16-23,80-87
NUMA node3 CPU(s):   24-31,88-95
NUMA node4 CPU(s):   32-39,96-103
NUMA node5 CPU(s):   40-47,104-111
NUMA node6 CPU(s):   48-55,112-119
NUMA node7 CPU(s):   56-63,120-127

# numactl -H
available: 8 nodes (0-7)
node 0 cpus: 0 1 2 3 4 5 6 7 64 65 66 67 68 69 70 71
node 0 size: 20028 MB
node 0 free: 3837 MB
node 1 cpus: 8 9 10 11 12 13 14 15 72 73 74 75 76 77 78 79
node 1 size: 0 MB
node 1 free: 0 MB
node 2 cpus: 16 17 18 19 20 21 22 23 80 81 82 83 84 85 86 87
node 2 size: 0 MB
node 2 free: 0 MB
node 3 cpus: 24 25 26 27 28 29 30 31 88 89 90 91 92 93 94 95
node 3 size: 0 MB
node 3 free: 0 MB
node 4 cpus: 32 33 34 35 36 37 38 39 96 97 98 99 100 101 102 103
node 4 size: 31391 MB
node 4 free: 21309 MB
node 5 cpus: 40 41 42 43 44 45 46 47 104 105 106 107 108 109 110 111
node 5 size: 0 MB
node 5 free: 0 MB
node 6 cpus: 48 49 50 51 52 53 54 55 112 113 114 115 116 117 118 119
node 6 size: 0 MB
node 6 free: 0 MB
node 7 cpus: 56 57 58 59 60 61 62 63 120 121 122 123 124 125 126 127
node 7 size: 0 MB
node 7 free: 0 MB
node distances:
node   0   1   2   3   4   5   6   7
  0:  10  16  16  16  32  32  32  32
  1:  16  10  16  16  32  32  32  32
  2:  16  16  10  16  32  32  32  32
  3:  16  16  16  10  32  32  32  32
  4:  32  32  32  32  10  16  16  16
  5:  32  32  32  32  16  10  16  16
  6:  32  32  32  32  16  16  10  16
  7:  32  32  32  32  16  16  16  10

== powerpc ==
# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              128
On-line CPU(s) list: 0-127
Thread(s) per core:  4
Core(s) per socket:  16
Socket(s):           2
NUMA node(s):        2
Model:               2.2 (pvr 004e 1202)
Model name:          POWER9 (raw), altivec supported
CPU max MHz:         3800.0000
CPU min MHz:         2300.0000
L1d cache:           32K
L1i cache:           32K
L2 cache:            512K
L3 cache:            10240K
NUMA node0 CPU(s):   0-63
NUMA node8 CPU(s):   64-127

# numactl -H
available: 2 nodes (0,8)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 0 size: 130138 MB
node 0 free: 125654 MB
node 8 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
node 8 size: 130781 MB
node 8 free: 124756 MB
node distances:
node   0   8
  0:  10  40
  8:  40  10
