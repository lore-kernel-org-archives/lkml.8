Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D29C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742C020873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="p0ZiIJkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbgE0Pm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgE0Pm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:42:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37CC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:42:55 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k22so4736827qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WMJebq3Hh+s5Z0QcM5uJG07mcNLMXzjCS2MDwWHQC0Y=;
        b=p0ZiIJkQ9li1YIAfuDCce5BfJ7GfHKeSACkEUvfXFMK5lw5KQYdKs3u5LHtlJrbr+R
         lZIs3ubmr7kwcRRGqBrpQjZ0RvErNYIygHlSSHiQEcE1bhAE/KF5S6BE4yxjIB6NFYQH
         AnaN7FgUQNFGig5A1wglkSBCxlvNrH5aWbaacEjXmUL+lc+LFaxvMi2YqVf+HsOuBMbw
         upN+UL7iFcamlIXpTXdE2gR+0q5a1MPYR4mACNqDpnGMYaQz7FckZ3W/zh9cAuRsBViV
         257hyauo2qrviPoZL6BYKvqdmc/2yq+tu63Jgo7TAFyFB4oqtehbMIOMcODcMyMz8lJD
         As5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMJebq3Hh+s5Z0QcM5uJG07mcNLMXzjCS2MDwWHQC0Y=;
        b=ckf6V3ItNBWu6Yr32O+AM6B+ogddpGZnlBFsWtWJyYIzZ9l0nJzTdB3h57eN/89WEt
         73EPXcK20cs3EwvPkrffhe7qlF7PUOYXJCuftMvgGOahjLM/IICH3uCNun7i3vfZ96fG
         z1Trbj0Tjzwt0VktWFiY3NTRj/lFle9Q3LhmHvI9EEifoafBRwJ5mWGmR69TcgmqrKv9
         OP0UDV8aLbvsholbzjz4VOGsJUopfVXAU5AR9HZ0cGoIEkGspTH1V5bZ0ITPmG1vVzA6
         0BtuYOH99GuqOXOd+MqNzS6DUO20ttNrazvE2ZB/hXH/46Eyj/eDKq+w7PvcR0bPO0ki
         loIQ==
X-Gm-Message-State: AOAM5310Kgbfe/21aWSImGbP+oMgHJcuEi0rq0TIz4LaCz3osF/pd2jj
        5sAmmkkDmfMozjrFf/cowzByzw==
X-Google-Smtp-Source: ABdhPJyVUDY9vXio+CND9Nt9MXb2iOZ21jv1FSDbexrs+kwHzs5vcR6w+sjXZHcc62o0Ofom+adZkg==
X-Received: by 2002:ac8:82b:: with SMTP id u40mr4830976qth.369.1590594174986;
        Wed, 27 May 2020 08:42:54 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v1sm2496825qkb.19.2020.05.27.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:42:53 -0700 (PDT)
Date:   Wed, 27 May 2020 11:42:50 -0400
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
Message-ID: <20200527154250.GB741@lca.pw>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200527120549.GA741@lca.pw>
 <20200527133332.GA20232@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527133332.GA20232@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:33:32PM +0800, Feng Tang wrote:
> Hi Qian,
> 
> On Wed, May 27, 2020 at 08:05:49AM -0400, Qian Cai wrote:
> > On Wed, May 27, 2020 at 06:46:06PM +0800, Feng Tang wrote:
> > > Hi Qian,
> > > 
> > > On Tue, May 26, 2020 at 10:25:39PM -0400, Qian Cai wrote:
> > > > > > > > [1] https://lkml.org/lkml/2020/3/5/57
> > > > > > > 
> > > > > > > Reverted this series fixed a warning under memory pressue.
> > > > > > 
> > > > > > Andrew, Stephen, can you drop this series?
> > > > > > 
> > > > > > > 
> > > > > > > [ 3319.257898] LTP: starting oom01
> > > > > > > [ 3319.284417] ------------[ cut here ]------------
> > > > > > > [ 3319.284439] memory commitment underflow
> > > > > 
> > > > > Thanks for the catch!
> > > > > 
> > > > > Could you share the info about the platform, like the CPU numbers
> > > > > and RAM size, and what's the mmap test size of your test program.
> > > > > It would be great if you can point me the link to the test program.
> > > > 
> > > > I have been reproduced this on both AMD and Intel. The test just
> > > > allocating memory and swapping.
> > > > 
> > > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
> > > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c
> > > > 
> > > > It might be better to run the whole LTP mm tests if none of the above
> > > > triggers it for you which has quite a few memory pressurers.
> > > > 
> > > > /opt/ltp/runltp -f mm
> > > 
> > > Thanks for sharing. I tried to reproduce this on 2 server plaforms,
> > > but can't reproduce it, and they are still under testing.
> > > 
> > > Meanwhile, could you help to try the below patch, which is based on
> > > Andi's suggestion and have some debug info. The warning is a little
> > > strange, as the condition is
> > > 
> > > 	(percpu_counter_read(&vm_committed_as) <
> > >                        -(s64)vm_committed_as_batch * num_online_cpus())
> > > 
> > > while for your platform (48 CPU + 128 GB RAM), the
> > > '-(s64)vm_committed_as_batch * num_online_cpus()'
> > > is a s64 value: '-32G', which makes the condition hard to be true,
> > > and when it is,  it could be triggered by some magic for s32/s64
> > > operations around the percpu-counter. 
> > 
> > Here is the information on AMD and powerpc below affected by this. It
> > could need a bit patient to reproduce, but our usual daily CI would
> > trigger it eventually after a few tries.
> > 
> > # git clone https://github.com/cailca/linux-mm.git
> > # cd linux-mm
> > # ./compile.sh
> > # systemctl reboot
> > # ./test.sh
> 
> I just downloaded it, and it failed on my desktop machine as it failed
> in 'yum' and 'grub2' setup. The difficulty for me to reproduce is the
> test platforms are behind the 0day framework, and I can hardly  setup
> external test suits, though I have been trying for all day today :) 

I tried your debug patch and it did not even compile on linux-next
(where the issue was happened) and I am running out of time today. It
probably need to reproduce on large systems as it did not happen on one
of our small s390 system here.
