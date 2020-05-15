Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DEC207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd9ZIIqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEOQqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbgEOQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:46:41 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10759C061A0C;
        Fri, 15 May 2020 09:46:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so3478770ion.0;
        Fri, 15 May 2020 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMMZB+JJUc5qOhBX30QBDnuLbX4rAj6sJgfoOfzhTFo=;
        b=jd9ZIIqmnVwcFulPqO2uRcF1lTkQA5Qjj7Pz7UvCRcQNcFp6/T08hPQ8o5XsacIFkM
         7qe7gg1MRBRkL08HnDdyO6JIxIsnjS7zn/wu9kWXLSSetKntC80LPEf/z7+rer1D2hYW
         0w8CziOoGZoNwjORGfnl871aV7NgnO6G2a0lKUjhkmoz+grRZN1rmB+UH21bvQX9jxSY
         T9aWhxkeGHPAExBHJNx9G77/MilqiZEot7ElYC4NgTxp9AOr3UN+Cw3JCjcqblXpfNGk
         Rvq0HtS1hpo8ju5+/bjCUfIClpB2u0XgGkEZpf8Tp/Tf5i4rO42BIEUaDsbg6m1iY+Jt
         zdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMMZB+JJUc5qOhBX30QBDnuLbX4rAj6sJgfoOfzhTFo=;
        b=pzF/J89PXNqTpLHk61wiTgiM96qU9FdAGQlLQzZFCvxlSJxrZ6CtikeD7b+LJMzt5z
         71bk/fe5dmFaOqFUGjL+M8XCl0awVOIJ0sXfA9GN1DDKPRf90P5up0w26QncsArmTNHx
         Qbxzi1eAkFdB1FTNiwUvFGnHD9tzj1qMx6WbL2NX4nzLHnAy1fB2mViejxgWtFyKg2ke
         H4tgjSpJ1EgVfuY39Fjg/OcHn1OLS1gC6qN1yq1l6UjWmWN0yY5iozZlfiw+yzI3iWkQ
         ZIIAzwJMRzAvAwjHTeqwYKunoDy5i7X7tXIL3eeECRp/PcAaZt0it0zjf3hK19DasSxW
         8eKQ==
X-Gm-Message-State: AOAM532atvaZxPbR9Alb0l/8EOQvhsKjqoVDLwGVc95+WMAKSHAG0/p/
        BJyuwi9OHJcAGh7IaQBy/u/dER46RtaHiECgZZ8=
X-Google-Smtp-Source: ABdhPJzC3X3JusgKAS/v3FgUIMyfhdCffuY2x8sqOBBV7q9YUvBYNbZ+ftC93DN0kkxM1kr6nsLzm7Rn8ArTRZkg/CQ=
X-Received: by 2002:a02:70c8:: with SMTP id f191mr2113705jac.117.1589561200309;
 Fri, 15 May 2020 09:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
In-Reply-To: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 15 May 2020 11:46:29 -0500
Message-ID: <CABb+yY1wJMzakpz0h6ZxAh4Z3OB718f+Wq3RP0R4NZ_U=vRMkw@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> - The hardware gives us the capability to write the register in
>   parallel, i.e. we can write 0x800 and 0x400 together without any
>   software locks, and so these 32 bits should be considered as separate
>   channel even if only one interrupt is issued by the hardware finally.
>   This shouldn't be called as virtualization of the channels, as the
>   hardware supports this (as clearly mentioned in the TRM) and it takes
>   care of handling the signal properly.
>
I'll leave this one open to bikeshed arguments.

> - With serialization, if we use only one channel as today at every
>   priority, if there are 5 requests to send signal to the receiver and
>   the dvfs request is the last one in queue (which may be called from
>   scheduler's hot path with fast switching), it unnecessarily needs to
>   wait for the first four transfers to finish due to the software
>   locking imposed by the mailbox framework. This adds additional delay,
>   maybe of few ms only, which isn't required by the hardware but just by
>   the software and few ms can be important in scheduler's hotpath.
>
As I asked you yesterday over the call, it may help if you could share
some numbers to back up the doomsday scenario.
I don't believe mailbox will be a bottleneck, unless you send commands
in a while(1) ... but even then you have to compare against the
virtual-channel implementation. (Not to forget one usually doesn't
need/want the dvfs, power, clock, hotplug all happening at the _same_
time)

Please note, SCMI... lets not pretend it is not about making scmi work
with mhu :) ...  itself uses shared-memory transfers and
wait_for_completion_timeout  in scmi_do_xfer().   If some platform
_really-really_ faced speed bottlenecks, it would come to want to
exchange 32-bit encoded command/response over the mhu register,
asynchronously and totally bypassing shmem... which is possible only
now.


> - With the current approach it isn't possible to assign different bits
>   (or doorbell numbers) to clients from DT and the only way of doing
>   that without adding new bindings is by extending #mbox-cells to accept
>   a value of 2 as done in this patch.
>
I am afraid you are confused. You can use bit/doorbell-6 by passing
0x40 to mhu as the data to send.

Cheers!
