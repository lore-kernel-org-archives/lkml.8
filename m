Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51724C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B3E21655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnWHnWr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgCIN1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:27:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33560 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgCIN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:27:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id p62so9173175qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CkpyZVM4qc6rvH01h9mhJ0L3H6e6RlzQmeQDPa3isww=;
        b=AnWHnWr0EAok5vbRz2SoOeI9TSqGkM8pEkD93/xilcV6hI+GMIY3bdM3dsBFKdldJQ
         VwAS5HddBfQ1GeZCnHazjWY8pyR07sRfmBmtYOVpvXUJv+FsjFtlP1O7QSylm6hdeEYm
         wRoJ2uz7lV2FEzC8Y4PWJmrL1ynJmBy3UGGjmz64y3jF1eAThLQLUsujbyJN+d6AQVpP
         QAdUh518x2AQfN1lyvw788/izdM1SB3+MUM7scN9hjyQ7klP/pP1S2J46dAbwGnzO0uG
         PezkK/sXX67W6DwGXaa51Kl39rLXfOS7C+PmguiZqnVnDR7gQ5OJq0O1/WbBYy+NM93+
         wUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CkpyZVM4qc6rvH01h9mhJ0L3H6e6RlzQmeQDPa3isww=;
        b=CuXZUZwuE5jntkebYK76jSsntYyQKsoA4a6aewgP4CpCwWw6m0krE/aeErG6pOwV+0
         nubUfIX97et+dhy35kk8M0oZcpG72bynLM1DQL9UeSV6/ndvJE1ZeTSfqy1nLtFVn49T
         77leJ3wPK7OLutTTXLOjpfkVBlJu72IOB4m7YhmVfRdglMjj0rKVIEfVvWUF9zfQDnXR
         TrYoxNP/HlAmNjflOHfdchV88O8pXQWOrzbiEFByqTLjD91KvZKYNCEvOLgbHCh33ECg
         JvJSx7GgQaYQJjiXoUdFUbwtbCSgX0o5fL/1jcOGuloC1j9Bympm3b2S4w210WGnfVMj
         yBJA==
X-Gm-Message-State: ANhLgQ3G9rhtM5ikeGRYMAgboQWeWixoFwFIffYe7A0QSD6UjIlcn+mN
        +7m98Yc0lB8uyacVaQy1KZI=
X-Google-Smtp-Source: ADFU+vtDstsbIVWiekKDZd3Y3iIJX218MsrMaPEEWaHYYtn159XRC1IwaraGjLAL7R0ZyT/WyYURSA==
X-Received: by 2002:ae9:c10c:: with SMTP id z12mr14083265qki.56.1583760433882;
        Mon, 09 Mar 2020 06:27:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o14sm2655166qtq.12.2020.03.09.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:27:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88F9E40009; Mon,  9 Mar 2020 10:27:10 -0300 (-03)
Date:   Mon, 9 Mar 2020 10:27:10 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
Message-ID: <20200309132710.GA477@kernel.org>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200306093940.GD281906@krava>
 <243484a9-5d64-707e-4abb-dd8813a8755e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <243484a9-5d64-707e-4abb-dd8813a8755e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 06, 2020 at 02:13:15PM -0500, Liang, Kan escreveu:
> 
> 
> On 3/6/2020 4:39 AM, Jiri Olsa wrote:
> > On Fri, Feb 28, 2020 at 08:29:59AM -0800, kan.liang@linux.intel.com wrote:
> > 
> > SNIP
> > 
> > > Kan Liang (12):
> > >    perf tools: Add hw_idx in struct branch_stack
> > >    perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
> > >    perf header: Add check for event attr
> > >    perf pmu: Add support for PMU capabilities
> > 
> > hi,
> > I'm getting compile error:
> > 
> > 	util/pmu.c: In function ‘perf_pmu__caps_parse’:
> > 	util/pmu.c:1620:32: error: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
> > 	 1620 |   snprintf(path, PATH_MAX, "%s/%s", caps_path, name);
> > 	      |                                ^~
> > 	In file included from /usr/include/stdio.h:867,
> > 			 from util/pmu.c:12:
> > 	/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 2 and 4352 bytes into a destination of size 4096
> > 	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
> > 	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	   68 |        __bos (__s), __fmt, __va_arg_pack ());
> > 	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	cc1: all warnings being treated as errors
> > 
> > 	[jolsa@krava perf]$ gcc --version
> > 	gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1)
> 
> My GCC version is too old. I will send V2 later to fix the error.

So I stopped at the patch just before the one introducing this problem,
i.e. now I have:

[acme@seventh perf]$ git log --oneline -10
5100c2b77049 (HEAD -> perf/core, five/perf/core, acme/perf/core) perf header: Add check for unexpected use of reserved membrs in event attr
1d2fc2bd7c1c perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX
1fa65c5092da perf tools: Add hw_idx in struct branch_stack
6339998d22ec tools headers UAPI: Update tools's copy of linux/perf_event.h
401d61cbd4d4 tools lib traceevent: Remove extra '\n' in print_event_time()
76ce02651dab libperf: Add counting example
dabce16bd292 perf annotate: Get rid of annotation->nr_jumps
357a5d24c471 perf llvm: Add debug hint message about missing kernel-devel package
1af62ce61cd8 perf stat: Show percore counts in per CPU output
7982a8985150 tools lib api fs: Move cgroupsfs_find_mountpoint()
[acme@seventh perf]$

Please continue from there, I'll process some other patchsets,

Thanks,

- Arnaldo
