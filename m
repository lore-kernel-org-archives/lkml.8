Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C08C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7A21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3940jiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgBRStj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:49:39 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32985 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:49:39 -0500
Received: by mail-yw1-f68.google.com with SMTP id 192so9891530ywy.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rsvcf6nEyweqvzaXVtO81ERnYCMGFqf7irfRI+SZdXk=;
        b=E3940jiGUF1Uagjna8ef3NgmN+ostg/I0dw5cE1R5zeXMMRWwv1EqbFgbyRLTcKlZF
         Fzm+K+hrXXQ2VPVx3vG9l4ag3zpMRTwx0Ut5LmBv/acM+dD7ZkP2FKmkH0we1oKBYkaP
         rXYvmQFRNrKJ/BPTJoCyG2vrN57gEmEeFwgT5SUpSkyWoGZRF5/MSVCwNACq4PQ7Ik8k
         +rXbZSBQl6NVkEa/4K7Gf6HeHh76j/vcF/X3bjB+DVgi9ARv7qmANY+z2qesaCPkmPOz
         VFEbQwPaHIQnqUjE7qHL+2Tmku10RGfY4JjZYFDbMWGOmB+AADDSxvZ+nJjBkw5mdoyy
         z4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rsvcf6nEyweqvzaXVtO81ERnYCMGFqf7irfRI+SZdXk=;
        b=DkmHO++CDEFVZDMOGvVMIGEwRUy8lohT/laKPkMJ+iHpAbOWSOArT4hlj4e/1lY3ah
         wIwF+UI8I4M22qmusuDSWcN1FS+SnKjSnA9+Q59qGtSqUDCJKe2gEySMJLbonTO3VTsn
         YwepvGEVoxYpWHhpDwKm3uSJEmRxItNmj7pyaUtJZXLMSnOjbgnSrLjiJOa5j1BOkS9J
         fMK3+gxG05JwMC/HKGoKemHTtzlQvmyYDvqf+A020xacyhcyv2HvR2wZTwPEBoC+JviX
         lctTBywDKWODpIASChkhH0iuKhqQr+YP4g/zwgBMGuVTSIMAXDFFGClJJOy1FFON6h2v
         eofg==
X-Gm-Message-State: APjAAAUFTJQe0uuDB0TMmQC8rgDHE6h8su8/kZIO/EDcmn0Q1590dVZP
        vMxVkzCa9fdV4ubSYpRtBnThxQ==
X-Google-Smtp-Source: APXvYqzRCBhILjOad1Afntyy2VV/HNgWp+4H7xiesfGuqB8WMfOpZ7DpnMFd6fDluVqK9E0lOxPYsQ==
X-Received: by 2002:a81:9bc4:: with SMTP id s187mr18147859ywg.285.1582051778613;
        Tue, 18 Feb 2020 10:49:38 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w5sm2308936yww.106.2020.02.18.10.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:49:37 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:49:34 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v4 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200218184934.GA11448@xps15>
References: <20200213094204.2568-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213094204.2568-1-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:41:59PM +0800, Leo Yan wrote:
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
> 
> Leo Yan (5):
>   perf cs-etm: Swap packets for instruction samples
>   perf cs-etm: Continuously record last branch
>   perf cs-etm: Correct synthesizing instruction samples
>   perf cs-etm: Optimize copying last branches
>   perf cs-etm: Fix unsigned variable comparison to zero

For all the patches in this set:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Unless Arnaldo says otherwise, I suggest you send a new V5 with Mike's RB for
patch 3/5 and mine for all of them.  That way he doesn't have to edit the
patches when applying them.

Thanks,
Mathieu

> 
>  tools/perf/util/cs-etm.c | 157 +++++++++++++++++++++++++++------------
>  1 file changed, 111 insertions(+), 46 deletions(-)
> 
> -- 
> 2.17.1
> 
