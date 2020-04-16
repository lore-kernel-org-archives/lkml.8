Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C843C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CA521D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047606;
	bh=rBfYVgzqaXNXJ3d9X1+p40wbhKpuonfJlXM9Z5iyP1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PmWTnZI+/OkM734e5cLnGdFzbZfNWgBRKVnA1se+bVU7GoaGbWFSkIA4e5mMfqx64
	 RiU3FUrFi7RQ+L+pJDsqrjdER0GKtkilS/gQO3h0PgWvHAHyPmbzRJj9OHF8MTsF79
	 zmYy0phiDTwyHHRTR3wIrJym8lKTqwPKqLMN8YpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394402AbgDPOdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:33:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35684 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442467AbgDPOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:19:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id x18so5082858wrq.2;
        Thu, 16 Apr 2020 07:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0VhAW35sYGbmqBDqDgP95uCn4UOL5vdZQ31iJuOhmg=;
        b=o18st+ZqXrvuci9Frv/Pqbpa17HcON1LX8Ts6mmxZmx0duMYkwr+SFaD2du3/pCw7A
         XpMt3SJEFsQAMqlIg9yUBuhBYYFYEwr1BKRZTUSpp0+DB1xe/zDMIFCzR8LD0elGXLFt
         VFR4HCE4UQ8pO9Q5oX3WeMs0V8IsU7iOJDpcJ/dEaTvCa8TZ9u2nJAAaykXOMK0roUNy
         w7oxY3+3qX9Ip1VvTdw8tqDhI0cLraVcbsd3MvfJTePWgWZcuVv3sebD9pKEvea9eHCb
         UrbKCK/ZEmAFfHvk525Ih7xYCFXF/h3RzxEzpnP8QSVjcH+oQd+AbiB3TB89LQFirYnj
         vvqg==
X-Gm-Message-State: AGi0PuZt6wOGq77lxczXily4SRxhADi5lyJfh0Twz+ImDJGkSNR1wGn6
        y+YYtXhwwklq66gmuSy47Zqg96BVfFyfV2tPtBE=
X-Google-Smtp-Source: APiQypIqoZ6A7S4FfBq8sVfVTZby+9I0Eqg8qgFjmcGTcyUMg0hmBXSJVIJulNZbU/jAyc3qaTpFfqZPcFZxevJ7H9k=
X-Received: by 2002:adf:8149:: with SMTP id 67mr36997629wrm.60.1587046771019;
 Thu, 16 Apr 2020 07:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200415054050.31645-1-irogers@google.com>
In-Reply-To: <20200415054050.31645-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 16 Apr 2020 23:19:19 +0900
Message-ID: <CAM9d7cj4fMsnDLgq0rHwqb6_ZLKP-AOzyyAP4kd=b=P5-t5NGQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf synthetic events
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Apr 15, 2020 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
>
> Add a multi-threaded version of the internals synthesize benchmark. It
> attempts to compute a time per event synthesized, but as it is reading
> /proc there are issues:
>  - permissions if not run as root
>  - "random" nature of /proc
>
> By default the benchmark is disabled but can be enabled with a
> flag. It has been useful in gauging the value of multi-threaded
> improvements not included here as their value appears minimal.
>
> The patch set includes 2 patches that improve synthesis performance
> and updates the benchmark numbers:
> https://lore.kernel.org/lkml/20200411064248.247530-1-irogers@google.com/
>
> v4 added a missing test file
> v3 improved documenation, return values and added testing to the io framework
>    following feedback from namhyung@kernel.org.
> v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
> https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/
>
> Ian Rogers (3):
>   perf bench: add a multi-threaded synthesize benchmark
>   tools api: add a lightweight buffered reading api
>   perf synthetic events: Remove use of sscanf from /proc reading

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung
