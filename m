Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF53C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3020730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dUI5OE+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDPKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:10:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35552 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgBDPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:10:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so13405463qtv.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kTpygplqJdOI3iDEuAgKqhHQxR7LHiWxABHJf7/AXk=;
        b=dUI5OE+c5BnUgX5djqCb1smQKnzp0w/LfaqJbpTTk1LiUuNRu4NE0PfLyBhYJx0WRk
         oBXAOZCTK49KRMLpKuQqbnnmWyzA8IPy9oORpMj5DEArQR4mpWX9ACL+pkzuZHk0Qc6e
         JoNmyoa9Cxyl71jaxpHq4CMWQQmmmWHpo8WVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kTpygplqJdOI3iDEuAgKqhHQxR7LHiWxABHJf7/AXk=;
        b=e0K8udg48DnYUu+xXejAK4pbrI50qGqKWIO3kegKWFdcwlx4lqyF6/umgvDROA50zZ
         21CliUBXATo5MDgJXPTZ/kyH939LbIYy8FimagTYq17UXtR5UbOYOYDNMWpqpoCkJjGo
         9g7WEyr2HGw9xZMsmiMuxL4mQdYbhFcEprtct1KLVAw3gvArePavspoHV4SVC5F1qaFo
         Bqth71g5ku5akLPqnCzJ4pMgAwa7Y4Gv1zSHzzRET+MbV0UCyiQVHOFjbwtWZM07WHpq
         XEo3aFs7p5TgtcqQQC10hmqF0ar43j5ESG7MQwuJJRVmC4Ca/KL/QST5lpT+CuSrKmIp
         9feg==
X-Gm-Message-State: APjAAAUCpHs8dd/M7nHR6m5QwGIH+a4GKGukvK8UuZZeKZgpbSxHjLuP
        qTmw2xGUlTzvdZqxmsTrQvdQXJ140WMFNJCwZBdNrQ==
X-Google-Smtp-Source: APXvYqyuX63SBC0NbgswvGMZ4JUNym8VPwQ5Q/VdLwrbtKrAW8hmK/dzTwc89g31Vo5d27dTxBuNLuKfX4Lexu6A5Sk=
X-Received: by 2002:ac8:460a:: with SMTP id p10mr27557344qtn.98.1580828999868;
 Tue, 04 Feb 2020 07:09:59 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org> <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
In-Reply-To: <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Tue, 4 Feb 2020 15:09:48 +0000
Message-ID: <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com>
Subject: Re: perf not picking up symbols for namespaced processes
To:     Ivan Babrou <ivan@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 2:17 AM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> I'm not very good at this, but the following works for me. If you this
> is in general vicinity of what you expected, I can email patch
> properly.
>

Thanks for the patch, I can confirm it works. I had this problem today
when playing
with gvisor. Gvisor is starting up in a fresh mount namespace and perf fails
to read the symbols. Stracing perf shows:

11913 openat(AT_FDCWD, "/proc/9512/ns/mnt", O_RDONLY) = 197
11913 setns(197, CLONE_NEWNS) = 0
11913 stat("/home/marek/bin/runsc-debug", 0x7fffffff8480) = -1 ENOENT
(No such file or directory)
11913 setns(196, CLONE_NEWNS) = 0

Which of course makes no sense - the runsc-debug binary does not exist in the
empty mount namespace of the restricted runsc process.

Marek
