Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA8C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159D224673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gChH3PS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJFnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:43:20 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53638 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJFnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 01:43:20 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so926642pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F25Z6JOMg3VYYeS0Ph17/tK9FAZWHrNbdM4PzCWFQu8=;
        b=gChH3PS1Ahx4kjgjmib1NgIky08oV7TsTD369DupZ3qTEaWaIL8bL1V8Yqy85SlZSx
         XofjzRdyK/ZgT7pbeM6FhDwzyoJF6CscxXa6XE5ga8eAHHj4GJfQx6cwKFUsw0rkwLKY
         tU6+oauZM8ktgjO8lnrklWew6Uvm/VcrQZ8FPyGVSEOvFPaH4H0n2drzFthrm5ft+3RZ
         VxWP43OKxBolA4Utm1IMjeC5oaWOrU5xrQ9t1l08MrygvCGrIkmX3wmgP1cLRHmHmYz0
         jJ8jR3Evj+msL9T0efnedWvBGv7WjgLOaHKfMJOcg/Gv0OHKdLamLVq3/Cl6WkS11r05
         J1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F25Z6JOMg3VYYeS0Ph17/tK9FAZWHrNbdM4PzCWFQu8=;
        b=Bsz1bFHt2qU9ulRog+dyudmVLcbhVTZbyPCSSyUjEBFqTBLfh6T3uSt7DwUHWU9GK1
         8a1eLie9DEkCQYec8aeYj/mQ+NpiYThxlxNSddhLl8afNVkOmqEqgCsbyguigCnggIeo
         NBje/9rL6/HKJilcTJszWquaBsp67dSWp27biCppfpLNURf2q7LgBt5WRRYqYEAFx4wi
         qDAPTY+QG3q2jymZRIvZmWkJj4C5nntLH+EjUmTshstqA5Pf0MmoHaWZjCmO5qYKHn9K
         ikh/dJlC/TDORHk0+UAOK8ZET1pOMA33YVfucQe3vd57iRUOXmFv1PSVkTfI5BsI1PR1
         wjLQ==
X-Gm-Message-State: ANhLgQ2TySgDVkJS++gC9asCQz1iOfskuHDC+zXsfbpc9IoCtmMYblm0
        yvgkf8NrD4LNhMsICERLLbfxxFMEaKjAMkLs
X-Google-Smtp-Source: ADFU+vsXDgkhbqbgEl4Jn5PjWcUx6mjmhk+iK35QWzx5tHigdCQgJMA6OZ+XlXSIjbrH2oaJMWgY/Q==
X-Received: by 2002:a17:90b:19c3:: with SMTP id nm3mr1367661pjb.149.1583818998924;
        Mon, 09 Mar 2020 22:43:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id t142sm37183481pgb.31.2020.03.09.22.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 22:43:18 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:43:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v5 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200310054305.GA21545@leoy-ThinkPad-X240s>
References: <20200219021811.20067-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219021811.20067-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Feb 19, 2020 at 10:18:06AM +0800, Leo Yan wrote:
> This patch series is to address issues for synthesizing instruction
> samples, especially when the instruction sample period is small enough,
> the current logic cannot synthesize multiple instruction samples within
> one instruction range packet.
> 
> Patch 0001 is to swap packets for instruction samples, so this allow
> option '--itrace=iNNN' can work well.
> 
> Patch 0002 avoids to reset the last branches for every instruction
> sample; if reset the last branches for every time generating sample, the
> later samples in the same range packet cannot use the last branches
> anymore.
> 
> Patch 0003 is the fixing for handling different instruction periods,
> especially for small sample period.
> 
> Patch 0004 is an optimization for copying last branches; it only copies
> last branches once if the instruction samples share the same last
> branches.
> 
> Patch 0005 is a minor fix for unsigned variable comparison to zero.
> 
> This patch set has been rebased on the latest perf/core branch; and
> verified on Juno board with below commands:
> 
>   # perf script --itrace=i2
>   # perf script --itrace=i2il16
>   # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
>   # perf inject --itrace=i100il16 -i perf.data -o perf.data.new

Could you pick up this patch set?  I confirmed this patch set can
cleanly apply on top of the latest mainline kernel (5.6-rc5).

Or if you want me to resend this patch set, please feel free let me
know.  Thanks!

Leo

> Changes from v4:
> * Added Mike's review tag for patch 03;
> * Added Mathieu's review tags for all patches.
> 
> Changes from v3:
> * Refactored patch 0001 with new function cs_etm__packet_swap() (Mike);
> * Refined instruction sample generation flow with single while loop,
>   which completely uses Mike's suggestions (Mike);
> * Added Mike's review tags for patch 01/02/04/05.
> 
> Changes from v2:
> * Added patch 0001 which is to fix swapping packets for instruction
>   samples;
> * Refined minor commit logs and comments;
> * Rebased on the latest perf/core branch.
> 
> Changes from v1:
> * Rebased patch set on perf/core branch with latest commit 9fec3cd5fa4a
>   ("perf map: Check if the map still has some refcounts on exit").
> 
> 
> Leo Yan (5):
>   perf cs-etm: Swap packets for instruction samples
>   perf cs-etm: Continuously record last branch
>   perf cs-etm: Correct synthesizing instruction samples
>   perf cs-etm: Optimize copying last branches
>   perf cs-etm: Fix unsigned variable comparison to zero
> 
>  tools/perf/util/cs-etm.c | 157 +++++++++++++++++++++++++++------------
>  1 file changed, 111 insertions(+), 46 deletions(-)
> 
> -- 
> 2.17.1
> 
