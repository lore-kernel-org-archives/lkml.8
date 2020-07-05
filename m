Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25290C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3B020782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="r2gPJc/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGEDVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 23:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgGEDVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:21:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E1C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 20:20:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so26622406qts.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 20:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D18mmp9P6jeB9iInjvujaEk2HmQ6rnaKuW92WMHT5vg=;
        b=r2gPJc/fBDYs78syoqOiv9tRHOreotYvTv9uBk11ItKDwUpAC+HrjxDd1FeflaLHD9
         JDgU32TaKjmiM8i80rGXDvG84NmMz7xGZnIoB8ELXsIICKv7jLGuB5F4gi+M+SK86GFa
         7lmir8HjmokW7P2/5NmIJmPZeUa/F4zsS9s5DrRk9sIBx7+wI7A1Fts0q4zayyYZPR6c
         DF5NSfOiX+pxhtDR0JSN3mVp5AshR3yx6lTyyOCQyYKP9/vXMP6ou+Qmf3anHPnC+IWJ
         AiVcshyQnU1/4utVZNCqadWwcewIwz5T/zUeZbkCLkgVhYRjdKD1sjy/R2G2BoX434Va
         dP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D18mmp9P6jeB9iInjvujaEk2HmQ6rnaKuW92WMHT5vg=;
        b=WvF5oQenEQf7X0Ugd0KLWbXCo1vCl/KpC84gmxDNe61cMywxuJQSX7FvJ/59SFi5fB
         M+D0pUudfdOoigZllUlGuQvq53ofu8Dfae6RqpnW7SROp+WSx9m9I++4qWLM6JvvG+Lt
         6wdI9WhL/1wOp5HK6cnN6bCoYraGFhWFoSDWoJUnSjEYd/cVruJjGLp/qixOpVXXEwyY
         rpWFfHa357bwo5OIOOPtgZfPaxlDINNDWmWZwPo4Ws/lpWuJw8vd5g+Z7nmZplNugDbJ
         6gRX/EwZezSCK6huD/MWhEXni+qC/5QJgEsbYcHELATapn86dCXB+nF7uXPvu0YWqJWs
         87tg==
X-Gm-Message-State: AOAM532646thgmqyLjemn9oy8wbFjGBzWnEfxlQ5eL4XA0NhdM3igJbp
        3PD7mAS2s1ARVZ1BVzyl8Kk+Mg==
X-Google-Smtp-Source: ABdhPJy1BIutVGB8TCFqu9AzK/YzBjmW8ozLo0GTOSSdngDXxlGJfkCYs+PlpB4ZwHy3jEwCSlnP0g==
X-Received: by 2002:ac8:4507:: with SMTP id q7mr42901172qtn.142.1593919259177;
        Sat, 04 Jul 2020 20:20:59 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v10sm16348492qtk.14.2020.07.04.20.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 20:20:58 -0700 (PDT)
Date:   Sat, 4 Jul 2020 23:20:49 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200705032049.GA1487@lca.pw>
References: <1592725000-73486-4-git-send-email-feng.tang@intel.com>
 <20200702063201.GG3874@shao2-debian>
 <20200702071230.GA17007@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702071230.GA17007@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:12:30PM +0800, Feng Tang wrote:
> Hi,
> 
> On Thu, Jul 02, 2020 at 02:32:01PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 4e2c82a40911c19419349918e675aa202b113b4d ("[PATCH v5 3/3] mm: adjust vm_committed_as_batch according to vm overcommit policy")
> > url: https://github.com/0day-ci/linux/commits/Feng-Tang/make-vm_committed_as_batch-aware-of-vm-overcommit-policy/20200621-153906
> > 
> > 
> > in testcase: ltp
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	test: mm-01
> > 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > 
> > <<<test_start>>>
> > tag=overcommit_memory01 stime=1593425044
> > cmdline="overcommit_memory"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> > overcommit_memory.c:116: INFO: MemTotal is 16394252 kB
> > overcommit_memory.c:118: INFO: SwapTotal is 268435452 kB
> > overcommit_memory.c:122: INFO: CommitLimit is 276632576 kB
> > mem.c:817: INFO: set overcommit_ratio to 50
> > mem.c:817: INFO: set overcommit_memory to 2
> > overcommit_memory.c:187: INFO: malloc 551061440 kB failed
> > overcommit_memory.c:208: PASS: alloc failed as expected
> > overcommit_memory.c:183: INFO: malloc 276632576 kB successfully
> > overcommit_memory.c:210: FAIL: alloc passed, expected to fail
> 
> Thanks for the report!
> 
> I took a rough look, and it all happens after changing the
> overcommit policy from a looser one to OVERCOMMIT_NEVER. I suspect 
> it is due to the same cause as the previous warning message reported
> by Qian Cai https://lore.kernel.org/lkml/20200526181459.GD991@lca.pw/ 

Hmm, the LTP test [1] looks like a faithful implementation of
Documentation/vm/overcommit-accounting.rst which is now failing because
of this patchset.

Also, It was a mistake to merge c571686a92ff ("mm/util.c: remove the
VM_WARN_ONCE for vm_committed_as underflow check") separately (I am
taking a blame to ACK it separately and I forgot to run those tests to
double-check earlier) which is now making me wonder that VM_WARN_ONCE is
actually legitimate to catch the sign of brokenness in the first place.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c

> 
> Will further check it.
> 
> Thanks,
> Feng
> 
> > overcommit_memory.c:183: INFO: malloc 137765294 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > mem.c:817: INFO: set overcommit_memory to 0
> > overcommit_memory.c:183: INFO: malloc 140770308 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > overcommit_memory.c:187: INFO: malloc 569659408 kB failed
> > overcommit_memory.c:208: PASS: alloc failed as expected
> > mem.c:817: INFO: set overcommit_memory to 1
> > overcommit_memory.c:183: INFO: malloc 142414852 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > overcommit_memory.c:183: INFO: malloc 284829704 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > overcommit_memory.c:183: INFO: malloc 569659408 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > mem.c:817: INFO: set overcommit_memory to 0
> > mem.c:817: INFO: set overcommit_ratio to 50
> > 
> > Summary:
> > passed   7
> > failed   1
> > skipped  0
> > warnings 0
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=1 corefile=no
> > cutime=0 cstime=1
> > <<<test_end>>>
> > <<<test_start>>>
> > tag=overcommit_memory02 stime=1593425044
> > cmdline="overcommit_memory -R 0"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> > overcommit_memory.c:116: INFO: MemTotal is 16394252 kB
> > overcommit_memory.c:118: INFO: SwapTotal is 268435452 kB
> > overcommit_memory.c:122: INFO: CommitLimit is 276632576 kB
> > mem.c:817: INFO: set overcommit_ratio to 0
> > mem.c:817: INFO: set overcommit_memory to 2
> > overcommit_memory.c:187: INFO: malloc 534667184 kB failed
> > overcommit_memory.c:208: PASS: alloc failed as expected
> > overcommit_memory.c:183: INFO: malloc 268435452 kB successfully
> > overcommit_memory.c:210: FAIL: alloc passed, expected to fail
> > overcommit_memory.c:183: INFO: malloc 133666730 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > mem.c:817: INFO: set overcommit_memory to 0
> > overcommit_memory.c:183: INFO: malloc 140770304 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > overcommit_memory.c:187: INFO: malloc 569659408 kB failed
> > overcommit_memory.c:208: PASS: alloc failed as expected
> > mem.c:817: INFO: set overcommit_memory to 1
> > overcommit_memory.c:183: INFO: malloc 142414852 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > overcommit_memory.c:183: INFO: malloc 284829704 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > overcommit_memory.c:183: INFO: malloc 569659408 kB successfully
> > overcommit_memory.c:202: PASS: alloc passed as expected
> > mem.c:817: INFO: set overcommit_memory to 0
> > mem.c:817: INFO: set overcommit_ratio to 50
> > 
> 
