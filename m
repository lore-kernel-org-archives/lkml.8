Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BED22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZX5SRTkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgHGSIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:08:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:53718 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:08:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D459F2C5136;
        Fri,  7 Aug 2020 14:07:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2wgxhzQoKYeG; Fri,  7 Aug 2020 14:07:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8390E2C5135;
        Fri,  7 Aug 2020 14:07:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8390E2C5135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596823679;
        bh=zRX1O9Hp5u2oxqTYBLW6OkzFj3h9lFf45jqhiPIZNEY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZX5SRTkPorFmvMzezKgCAAO+sI+49flYmIj1BwliY1w4BXSv665pgBL7NaypYknFk
         ZPii6cdGJbX6CHdR/azTjMf5lQXuiZBwvfn5P8Cv2lD5XtQtI/FjPremV35N4twQ6F
         7kGhlbCgIYWSt3khbqmEeVSYXUkJIp0nu9gzeEiZh88OorTfBuxPdJcA2oB3rTcmtH
         o3alRwOxhZcAvfBhZQIPVCZLeYIY1A+90QvRljnys1fnst2W5b0Kz/sa9Xl+191afn
         a6yTT+l6qf3BnJ4ftp6QjTsoJI8I//bgPTYdGmymGaXTj8zIPrcd46k53VA/SOJte9
         7snqgalHIrB9A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PF4qG6Vg7Tx5; Fri,  7 Aug 2020 14:07:59 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 757822C4ECE;
        Fri,  7 Aug 2020 14:07:59 -0400 (EDT)
Date:   Fri, 7 Aug 2020 14:07:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1689650939.2607.1596823679392.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51VabphnoXOxLgUqDL288zfLpEugC-H5jxg=JGhTHB7QDg@mail.gmail.com>
References: <20200806000859.160882-1-posk@google.com> <20200806134828.GA165568@hirez.programming.kicks-ass.net> <CAFTs51Ufyds5mypiysL=2ZwtyMk9hjLm-9tJbYz=xciY1f2=5g@mail.gmail.com> <1668913120.1621.1596735425601.JavaMail.zimbra@efficios.com> <CAFTs51VabphnoXOxLgUqDL288zfLpEugC-H5jxg=JGhTHB7QDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] membarrier: add
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Thread-Index: Xx96NTYjLPZR8gb9GR8pxC4FdSAa7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 7, 2020, at 1:48 PM, Peter Oskolkov posk@posk.io wrote:

> On Thu, Aug 6, 2020 at 10:37 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
[...]
>> Also, should this belong to the membarrier or the rseq system call ? It just
>> looks like the membarrier happens to implement very similar things for barriers,
>> but arguably this is really about rseq. I wonder if we should expose this
>> through
>> rseq instead, even if we end up using membarrier code.
> 
> Yes, this is more about rseq; on the other hand, the high-level API/behavior
> looks closer to that membarrier, and a lot of code will be shared.
> 
> As you are the maintainer for both rseq and membarrier, this is for
> you to decide, I guess... :)

Considering that membarrier has been made extensible with the cmd
argument, and on the other hand rseq can be extended with "flags", but is
currently only about registration/unregistration, I think adding a command
to membarrier is indeed a natural approach.

I am not very fond on re-purposing the membarrier flags parameter into a
cpu number though. Maybe we should tweak the membarrier system call so it
can expect 3 arguments instead ?

  int membarrier(int cmd, int flags, int cpu);

where cpu is only used for specific commands.

One thing I find weird about Peter's patch is that it adds a
MEMBERRIER_CMD_PRIVATE_EXPEDITED_RSEQ without a corresponding
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ. Considering that
the SYNC_CORE variant already has its own register command, I
find it weird that the RSEQ counterpart does not have one.

Also, do we want to allow a RSEQ | SYNC_CORE private expedited
membarrier as well ? If that is the case, then we might want to
investigate exposing RSEQ-membarrier as a new membarrier flag
rather than as a stand-alone command.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
