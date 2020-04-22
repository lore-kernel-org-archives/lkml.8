Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF96C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7790B20780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587557389;
	bh=IY+tedtIcS7K+V1TYW/S4EUgvgOFuS/6peZPNSM8pP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nj23zNgzUWcgxS7bInKqDmeZHHR6VLCdM++RIfDNPnVNR1aihhEHLFrPik+2fXinb
	 vbupW0bVzplgfzSmtXCiTOmSbeMrRQlNBzraFPHr3uDFo1XyGFvA9G/fXYWgMnfAOF
	 eHNVohF2O32zdzGaiuH9qhXtj6pC3a+Lw3V3F11o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgDVMJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgDVMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:09:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7CC03C1A8;
        Wed, 22 Apr 2020 05:09:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b11so2099879wrs.6;
        Wed, 22 Apr 2020 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvqYruWYfHT7ASyvb8cck4F/WUjHt2b44E2w05ejnqY=;
        b=I48Am3s/CigVFjSyz4laBhYyfckOYR4g67adqtAGRZ9mKwvMeoQ7bXKbYkZrhLuXIe
         JA2qTPzCo0/Mlxl5BeIODaPbI7Gjl/JwiEeoUXxGyGkOD10jPJGoXb8oF16Q6WMA1+tw
         FKe4z/7RnIooIYyvr5pK/bnsvIiH9nggRWZzzN7tJZGpPAECZKFbx2LgccYwjeFGbhFl
         QBvy/REoPTboJ4P9HrjjJrb2CIrNgTa6dFsg5PX8lFix1lvih5ck4wmRFGdQtPEikBlj
         EiqytkfeUHnWl5CO6GSWck2SiJ6FXPng+ehztTm5u1EMTqrwnX1jWHGLJYSpFa3k7bsf
         f8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvqYruWYfHT7ASyvb8cck4F/WUjHt2b44E2w05ejnqY=;
        b=jOJ8uOxNYXn84AlK1c4Aozk7Qz9phPwNUX74MLOu+M0zDnLDlXTpGWdVqtHmDKdj7V
         fCi1FkpbKUU/z66wH+9Unqu4weldRIFO4Jw6B82PqIumid/8hQvz99Cd5u1TWlF8r8MW
         FNrsRbEi8G6AePE5VdoQBiksFgxOFsZR0qsEZI/3ostIk1ZcuINsd9KqNqXIwYjNwDId
         hTKdL8CwRky2k4CuZDHxpm0wO5jzAmfPVSQFBluxZDKkXd1XSmrY5AikO+xqBgw8A9vu
         HDtyF9a0M6Erdb1IeXfGuZKsmmh8O5jZAFIykKc7X80/L+uo75sjWEGUyj5zh3JGnai0
         Z97Q==
X-Gm-Message-State: AGi0Puajb3aVRPB5h2KL2NQXONMkGbYfxzUoUVqktL9n5zfziaAYCLpa
        aw3kH/0KWXvrsRQ6uftabdCb+F0D
X-Google-Smtp-Source: APiQypImzIuOQWS8QX20yIOzj+742Obum4/tSlPOjx6t4l2XXsNeoBjv8cI567rOU/Y7mKVk1a6gCg==
X-Received: by 2002:adf:e681:: with SMTP id r1mr32097666wrm.213.1587557386803;
        Wed, 22 Apr 2020 05:09:46 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i17sm7614660wml.23.2020.04.22.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 05:09:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:09:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200422120943.GA110748@gmail.com>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
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
> Test results at the end of this message, as usual.
> 
> The following changes since commit cd0943357bc7570f081701d005318c20982178b8:
> 
>   Merge tag 'perf-urgent-for-mingo-5.7-20200414' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-04-16 10:21:31 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.8-20200420
> 
> for you to fetch changes up to 12e89e65f446476951f42aedeef56b6bd6f7f1e6:
> 
>   perf hist: Add fast path for duplicate entries check (2020-04-18 09:05:01 -0300)

>  85 files changed, 1851 insertions(+), 513 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
