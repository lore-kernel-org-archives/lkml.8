Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C5DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036C020890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592491741;
	bh=MguRdOhey+Q6xncGYs9OsoOqQzCbvQ/7aOyoSQJBk/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RmE1DLcdYgKxg3CuLqUNgsrVNRAqLvJzqxvOL66qdCT+MTm76VGbiXMMHdBmhyylV
	 97CmOs5UXnupXb8UPh5qQ4wtKtIenfj5B1p6WhcrUUhJZQ+I3a6cxzCZ6yoiHKYb7F
	 bvU5m3n/4RDvFw2wYKEqU0ue3cBb5RWm7ZRskfaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgFROs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:48:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37707 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgFROs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:48:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id y20so5967608wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xS3z9u+PAZ22FkJniku1XAs3ZLGsalmC0ipzkp2/BQ=;
        b=D4kfswdnNORrNRMJeUqHYkCvMF6PIvZxq5wln2i+sUXq/ybUSDZUyMIFaQdO4SKOf7
         dt/Z3SS/BvVIGpkKXPsnEFzrU2n/y3+udRrOY0VRm9qrXx4RbL0EMJq+zzgL4/slLnvD
         OHIU5gqmBGIJj9zU+h2GmCtJAB6HANqWQVKGhfXyc/syTVC2zfPmHafIWBzVKRmhLKMb
         R9re0tY6MJOi0NmgGbYtUwebnudB2IaCjk6le6CFihflhMS6ZafxOzeQ2FkRzyJr5KfK
         B/8vEaP1u18Gr69efbnzOU0iVMwAJE7NDV2hi+QgSCrQAfEp0jSt1Raz5rS0jkUsKb97
         scjQ==
X-Gm-Message-State: AOAM533DqWzLVsE8bJo0sXSNMG2FIvQ0SA+zE7Pze9mJXvF4e4ShQxnf
        r9io7LDy2UGzqCS1JaiYaOLWtYV2vV0oh3LbqN4=
X-Google-Smtp-Source: ABdhPJx09H9X3Og+/6aJYhOo8Nm9bnQL+c6BrOd4ryoP7zIZb/TrGAmBGMB0s8tXFj10xALTUWbhSJIHMk453M/RYn0=
X-Received: by 2002:a1c:964d:: with SMTP id y74mr4655344wmd.154.1592491736234;
 Thu, 18 Jun 2020 07:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200618003916.26644-1-gaurav1086@gmail.com>
In-Reply-To: <20200618003916.26644-1-gaurav1086@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Jun 2020 23:48:45 +0900
Message-ID: <CAM9d7ciTTJ5e0JjrK0K7y5034kTQ08tcfvJ7wry6yY8O0BGDxg@mail.gmail.com>
Subject: Re: [PATCH] [perf] Fix null pointer deference in nest_epollfd
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 18, 2020 at 9:39 AM Gaurav Singh <gaurav1086@gmail.com> wrote:
>
> Add a NULL check for worker before dereferencing.

Did you actually see a segfault due to this?
It seems it's called with NULL only if multiq is false
so there should not be a NULL dereference.

>
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  tools/perf/bench/epoll-wait.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index 75dca9773186..42983eb7f82e 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -239,6 +239,9 @@ static void *workerfn(void *arg)
>
>  static void nest_epollfd(struct worker *w)
>  {
> +       if (!w)
> +               return;
> +
>         unsigned int i;
>         struct epoll_event ev;
>         int efd = multiq ? w->epollfd : epollfd;

Maybe it's more intuitive to check w instead of multiq here.

Thanks
Namhyung


> --
> 2.17.1
>
