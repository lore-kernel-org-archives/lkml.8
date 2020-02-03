Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1116FC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E6C20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCUdKkI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBCIur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:50:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36513 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgBCIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:50:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so15906590wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 00:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E9yD/JzO7wOM/RD5gPdB58qIR7x/yAibGDSYxkuUsus=;
        b=uCUdKkI9CniAQzpRtV8zjdm2ZMon8dvQrbqM9q2lkZcC486D20/zhL01Gi/SNDgp3N
         h0LSRik+HIUR0hUw57H/U35rGcpiq5TGwgWK9SYfC3eST3P64x7MmMh/QxwPDyKVT+5d
         +7qofLwVOH5s/9pgiWF6ZspEhnW4wkeMpa8f3UQTi3xBHaeQsgvc0VtPxdfwTJ4qAo+Y
         WPfJCYUnIuTmpGQxxD7/xqq3uAmzG2pc/d+OE2DpglXHSdgFjv4tJ8CZCcoEWImdrWJq
         Gk4Vyt3LEATq2ZVzhV0eI3yXm6xLh3l06+Jmi6Kk32kJ9VkyyIdzPyuLPpcKkKK5GqVi
         rppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E9yD/JzO7wOM/RD5gPdB58qIR7x/yAibGDSYxkuUsus=;
        b=IPfjJCpdN00vVJa7m24FSLibT8ZzkLKCl3JIyllmwNxUXd6DRd9HleNkraBzMuFKrg
         xx6F/1hBB3xypxoCE4kP0/vpN9dUT0j/YxvSGE0REf5SNe43KAPKIohp63XxC4/oGW6F
         WuJ/xvXokFCQW8TW3VIeIcT2dJfDe4FWykW9rkQzLOIj36zDwPn1h5bZ7BpuXCSCVVm1
         Vvxj61iVyK5WGrd5oO4hi0fjs5vLMAT/LsfdZViym90LacR3eJSOtrqMKr7cznUwZPjI
         xH5FKO177R4fTLMN2zz03BkLpOu8vUtDgni7cyn1fK/RFPgFRrPnTTpQmNpVo66oPIA1
         +9Xg==
X-Gm-Message-State: APjAAAVRl25jbznFvw8/sO001JKT9GHe9QdeN9QtBjhT2HlRuRfRZiQX
        Ppl4uTC7pUgEN3YhJ5lUT7eERw==
X-Google-Smtp-Source: APXvYqyJT4BM0VJDnRhFsNGgIOgprVcAlif2kPfzDo6GSwh62Cee6KOeqyh5Qvz5AlOcVRMwtovRPA==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr27539348wml.103.1580719844806;
        Mon, 03 Feb 2020 00:50:44 -0800 (PST)
Received: from [192.168.0.102] (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id a16sm23596922wrt.37.2020.02.03.00.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 00:50:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX 0/6] block, bfq: series of fixes, and not only, for
 some recently reported issues
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <f0480d87-41a3-c056-854e-e480461bbd96@kernel.dk>
Date:   Mon, 3 Feb 2020 09:50:42 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        patdung100@gmail.com, cevich@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D495E7DF-DF7D-4762-BE9F-913DF631D254@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
 <f0480d87-41a3-c056-854e-e480461bbd96@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 1 feb 2020, alle ore 05:48, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/31/20 2:24 AM, Paolo Valente wrote:
>> Hi Jens,
>> these patches are mostly fixes for the issues reported in [1, 2]. All
>> patches have been publicly tested in the dev version of BFQ.
>>=20
>> Thanks,
>> Paolo
>>=20
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1767539
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D205447
>>=20
>> Paolo Valente (6):
>>  block, bfq: do not plug I/O for bfq_queues with no proc refs
>>  block, bfq: do not insert oom queue into position tree
>>  block, bfq: get extra ref to prevent a queue from being freed during =
a
>>    group move
>>  block, bfq: extend incomplete name of field on_st
>>  block, bfq: get a ref to a group when adding it to a service tree
>>  block, bfq: clarify the goal of bfq_split_bfqq()
>>=20
>> block/bfq-cgroup.c  | 12 ++++++++++--
>> block/bfq-iosched.c | 20 +++++++++++++++++++-
>> block/bfq-iosched.h |  3 ++-
>> block/bfq-wf2q.c    | 27 ++++++++++++++++++++++-----
>> 4 files changed, 53 insertions(+), 9 deletions(-)
>=20
> I wish some of these had been sent sooner, they really should have =
been
> sent in a few weeks ago. Just took a quick look at the bug reports, =
and
> at least one of the bugs mentions looks like it had a fix available 2
> months ago.

The first fix(es) didn't work with the issue reported in [2], which
was in turn very similar to that in [1].  Since I didn't know why, I
couldn't be sure that the first fix was correct and did not introduce
other issues.

> Have they been in -next?

Nope. I proposed the full series in this thread, the day after the
full fix was confirmed to work.  I didn't propose any partial series
patch before, for the above reason.

> They are all marked as bug fixes,
> should they have stable tags?

I guess they should, as fixes to bugs that may cause crashes.  If
there are other rules for these tags, I'm sorry but I'm not aware of
them.

> All of them, some of them?

The only two non-fix patches are non-functional, trivial code
improvements made along the way.

Submitting a V2.

Thanks,
Paolo

>=20
> --=20
> Jens Axboe

