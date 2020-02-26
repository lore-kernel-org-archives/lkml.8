Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A70C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6C92468F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582726754;
	bh=JrOb9fpSsSweBkTnvOSYMWvZ3tMhx6pvrRcTHy5Lu6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=puzOJcVQIEi3FZC5qrRp4KKo66/4fhAeE/DyrBHID4DEN53LpqYGtN1dZCQwN76pg
	 hLPNtnovXJwP3dGLK6AdvNNOEGM7rxFTKtZ4aIjDDMOsYbVZRr3JpTGKFAXZVoCjBd
	 Aa3limx3cm3LFk/Z/XtJ5F7v4lBILaZxkTscOFv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgBZOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:19:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52079 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:19:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so3268621wmi.1;
        Wed, 26 Feb 2020 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=teY+ShH6FpF5Pey2qKDW8ZfyDtQWGpcngT7dla6Rm3Q=;
        b=m6hU20FyA4pMvU3AmaQj0isibyS5z42oIkT+6vdFUadfKDh3QI2V36DbIlYO3sKTyT
         kGOh7Flq+sdMrrj7+zle9jkPI2u6S3WjjeD8pIVA0WmyxdDHK6rdjE1Ii4NC9Bi1OfBS
         TCr3zfGDYhZrotnjGEsBVXWSKKeDTkfwbtwnqgVeb6aJoVvBSUGRKiLT9e//OWCROdwl
         baJ6OJoTOStZgvVGeYlhKQTT329xQe//dkNSew3+ZkvP61uhIQdze6Y36HddvOvwwxA9
         3DVxwPB3vgknmEmCwlBE/Y1YNryiWMeCSZn+NUcrb6Vvlpwfl/v/PHkZrpJDpGc4fwcj
         Ud4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=teY+ShH6FpF5Pey2qKDW8ZfyDtQWGpcngT7dla6Rm3Q=;
        b=gXh8HX3mqn98zJDtCjT96d/1RmO6f87Dy1BqXzWvJ0skLFrOPWKhcNFPiAB/iDHB5M
         ElNLFIunjb5sXqPKWGz3QaepAQkDbKkAj7PYmDutvwEegYFQpBx33Hx5KZm23Gpv93su
         WodCHmlgFxoiZw6N+w4KDsyBct7iJfONSRvkyEoCJeLtjlTv8rvZ5W8q33l4NGipNudq
         C7lu7GSUxCX/7R9iD7P6p9oFLza5Xg6Ge+CViSDRXoiVUgGW05FWgTbM5Wbn7yIt56kI
         vC4vKhsFMk6Gjfod744k47uDs8ONBbjlt9fJoSNqLjKlL3Fw3bk/W0X8PqKJNPekE/1n
         7kTQ==
X-Gm-Message-State: APjAAAX4kWOmeYqbm5FOoevLTuwjxyyYRkPzqjJqEtDQPnCu37RmHolB
        13nRyMGpSyMxTDXYNf2riV4=
X-Google-Smtp-Source: APXvYqyk2a/8dkUCVjKw1gBP4ww+8UCifGlUP3M/qWT2VRh9VvY9QlZdvl0qprE0OCI8hqAS/UKtDw==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr5760396wmi.168.1582726750710;
        Wed, 26 Feb 2020 06:19:10 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e18sm3402737wrw.70.2020.02.26.06.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 06:19:09 -0800 (PST)
Date:   Wed, 26 Feb 2020 15:19:07 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Message-ID: <20200226141907.GA3100@gmail.com>
References: <20200221015310.16914-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> The following changes since commit b1da3acc781ce445445d959b41064d209a27bc2d:
> 
>   Merge tag 'ecryptfs-5.6-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs (2020-02-17 21:08:37 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200220
> 
> for you to fetch changes up to b103de53e09f20d645eb313477f52d1993347605:
> 
>   perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources (2020-02-18 13:36:57 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> auxtrace:
> 
>   Adrian Hunter:
> 
>   - Fix endless record after being terminated on arm-spe.
> 
>   Wei Li:
> 
>   - Fix endless record after being terminated on Intel PT and BTS and
>     on ARM's cs-etm.
> 
> perf test:
> 
>   Thomas Richter
> 
>   - Fix test trace+probe_vfs_getname.sh on s390
> 
> PowerPC:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync powerpc syscall.tbl with the kernel sources.
> 
> BPF:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Remove extraneous bpf/ subdir from bpf.h headers used to build bpf events.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf arm-spe: Fix endless record after being terminated
>       perf auxtrace: Add auxtrace_record__read_finish()
> 
> Arnaldo Carvalho de Melo (2):
>       perf bpf: Remove bpf/ subdir from bpf.h headers used to build bpf events
>       perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
> 
> Thomas Richter (1):
>       perf test: Fix test trace+probe_vfs_getname.sh on s390
> 
> Wei Li (3):
>       perf intel-pt: Fix endless record after being terminated
>       perf intel-bts: Fix endless record after being terminated
>       perf cs-etm: Fix endless record after being terminated
> 
>  tools/perf/arch/arm/util/cs-etm.c                  | 18 ++----------------
>  tools/perf/arch/arm64/util/arm-spe.c               | 17 ++---------------
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  2 ++
>  tools/perf/arch/x86/util/intel-bts.c               | 17 ++---------------
>  tools/perf/arch/x86/util/intel-pt.c                | 17 ++---------------
>  tools/perf/include/bpf/pid_filter.h                |  2 +-
>  tools/perf/include/bpf/stdio.h                     |  2 +-
>  tools/perf/include/bpf/unistd.h                    |  2 +-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh    |  2 +-
>  tools/perf/util/auxtrace.c                         | 22 +++++++++++++++++++++-
>  tools/perf/util/auxtrace.h                         |  6 ++++++
>  11 files changed, 41 insertions(+), 66 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
