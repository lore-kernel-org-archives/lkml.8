Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35ACC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A798420721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF/MzuOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbgDCMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:40:33 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38171 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgDCMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:40:33 -0400
Received: by mail-qv1-f68.google.com with SMTP id p60so3462514qva.5;
        Fri, 03 Apr 2020 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VilFbN+omgRvrmIqV7s6l706pX+Ofk14Kvo+wU+Vr80=;
        b=VF/MzuOMECsjbFEL3x6b18b2/JLnNLnAODTum27u6/3XujirZlXazu3f+LxmZY1YtD
         bEAqGfne2dgkKiXK90naidWkeVr33A76i91mrQ81RKyiPgNfoEJPtRlkXYYVjSwa6TFV
         N+trl6ChVCVsgMNecYba/kS1bTsx+//DH62HxgZIaWwkebqthxWm5O6pavZvaVKNJViO
         rF9KJlcVfiwx4O49JXQf+bj+S6IOTcgDzKL59tS9oH1OJLZRrr7ZA4MtXb8vv/TMFroz
         feX4ZFTBxCsw/PfVbqb7XywkiT10DkdkVsjXAs3B1+uvoNoeanXC1wktjiNhrpktzftu
         iLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VilFbN+omgRvrmIqV7s6l706pX+Ofk14Kvo+wU+Vr80=;
        b=r72r17c9MH3mGoXuwwU0LnLzznKonjNqC1c6JjyMP0pio+it5Vd6L5795Vk2QRBDH4
         vEhqc8NXvhocxgdeZS3t2kOvmqlfGMvR2xHgT/7W8Spa79hS2Ksa7jmr8PUJQuTIDfJ2
         PRF2fLdaBDbt54n7Icv3VqSEwu8h4s9EkWcEreEByYH8uBKCr6gIMyws6iLcR5z7zPoN
         G5e3/82DonfG3ovjpMY8IEiFayHCmNAGX52i2OPz0MdkCRomD+hkVeEJOG8VyqnzeuW5
         y2ZHkz81vjyWnf2lVMx1RgEY6yuQpyraKFSrp3CnuZBSiRMXicmDvIPhpvlvbq/bUhf8
         CBwg==
X-Gm-Message-State: AGi0PuZNcxtSwoV2tDK9/xssgrb9l7LyTiw7xdmM4WRrTwDMG3CK16Wq
        kAid8prcQ6MR7nmNTVThnZA=
X-Google-Smtp-Source: APiQypL34uB/up7mEqlWauUaQtqmyDbKLKjd0ElexwxsJ+YVjXP8rs7r+juN6cC481TQZ+1jRsVHrA==
X-Received: by 2002:a05:6214:12cf:: with SMTP id s15mr8077606qvv.241.1585917630734;
        Fri, 03 Apr 2020 05:40:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v19sm6496267qtb.67.2020.04.03.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 05:40:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E38A409A3; Fri,  3 Apr 2020 09:40:28 -0300 (-03)
Date:   Fri, 3 Apr 2020 09:40:28 -0300
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
Message-ID: <20200403124028.GA18559@kernel.org>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
> > When running perf script report with a Python script and a callgraph in
> > DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
> > function.
> > 
> > Added a check for this condition (same check as in builtin-script.c:595).
> > 
> > Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> > ---
> 
> Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks, added this to that patch.

- Arnaldo
