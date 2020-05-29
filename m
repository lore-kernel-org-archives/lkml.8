Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C2FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DE120721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="tZVJVopV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437247AbgE2Djc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436751AbgE2Dj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:39:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE6C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:39:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so671194ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gkHrDdBZqERh5JBp6Y5+S43JYLC8jaN53SGk0qrPig=;
        b=tZVJVopV+f4WJUZpvluec/FtHcYdjJXPP2ck6LxU8clVsVj9zgyZtBVUjciDg8Ig6V
         JCJG0m20tjPin5MieQiZ/EbVrZCvK+fiwoRH/VMDXCf7FejLjIFyCQENT/alqmF87xco
         J1vrCZLiBUHa07qm9vpJdL8/hiWCjMIy/gZDBTT9x78lfAl69zaBmWfWWHbDZnW4UK/f
         k7CU3tF1sTI1HIWtG7v3zAUfpFVEEbbrWALS0lCXk2X3NBpAjhHbGfDxMNZ3DWltS9wi
         ELn/uZqcOCUDw+ljkrkBAS6gB0dCRSnk/cGEtTQHOB4ssecCWLiBlCENZF2abBmglV5i
         lEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gkHrDdBZqERh5JBp6Y5+S43JYLC8jaN53SGk0qrPig=;
        b=My7OFyFj8mYvytFdP7LmEL4SM39Pd/c5lW6vpIglt6JY+pP2+3CpmWgqA7YxbLR2xT
         A9aaOaNuIHChKzKQgflSUogrL50RLUR1K3Aqb7Ba2v6SBK1J50cTssR62SawnVA7oYwa
         lpV3OIspQ8mS9NEVAnIBbFVZTcTx/aHehVvvNe1ry2OAemw7417bPXyiFh75z8ldv5j8
         MzS4bN3E6MLvKRHZsc7RHdW+02ViMf2JZxyTfkx3wkuFEAj9LbwgPSxVireGKXdeZdh4
         dqz9ejykFIP9NECWoQKTW49EWbUFJ6LZhRxCumTYmaOcTDQ5Li408uSheL3cONWa7sxp
         xxqg==
X-Gm-Message-State: AOAM531vK57lly+ZAQ4pBHBoUaxTA36QAWfFIi8fBjqnAzbrT5taMAAp
        TRjjEHq5ZEhcXNddq1VvLIkMqGfK6eNua4fB0kLvgA==
X-Google-Smtp-Source: ABdhPJzFjMAgGzbJf9X7YASkkjr3BxDpArKTPedMsTfDqle3ScyLuzBrbqg1nfHwvrNcbo0gM0Xef9axKVwGV/pRcdM=
X-Received: by 2002:a17:906:1a06:: with SMTP id i6mr6213718ejf.9.1590723567709;
 Thu, 28 May 2020 20:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200514092637.15684-1-John.Mathew@unikie.com> <20200525103511.6966206b@lwn.net>
In-Reply-To: <20200525103511.6966206b@lwn.net>
From:   John Mathew <john.mathew@unikie.com>
Date:   Fri, 29 May 2020 06:39:17 +0300
Message-ID: <CAJz2qX=omnxpXKhkdWNgb9z3zw0froqfzzhne0wCJTtTZOnobQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/3] Add scheduler overview documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, tsbogend@alpha.franken.de,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        mostafa.chamanara@gmail.com, willy@infradead.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 7:35 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Thu, 14 May 2020 12:26:34 +0300
> john mathew <john.mathew@unikie.com> wrote:
>
> > This patch series updates the scheduler documentation to add more topics
> > wrt to scheduler overview. New sections are added to provide a brief
> > overview of the kernel structs used by the scheduler, scheduler invocation,
> > context switch and Capacity Aware Scheduling. Previous version of
> > the patch was reviewed at:
> > Link: https://lore.kernel.org/lkml/20200513134338.19688-2-John.Mathew@unikie.com/
>
> Did we ever reach a conclusion on this series?  I don't see a lot of acks
> there yet, so I'm a little leery about applying it...
>
> Thanks,
>
> jon

Jonathan,  the latest version iof the patchset is at at
https://lore.kernel.org/lkml/20200527084421.4673-1-John.Mathew@unikie.com/
Peter, Daniel, Matthew, Juri, Valentin, Randy, Tao and Dietmar can you
take a look and give acks if ok?
