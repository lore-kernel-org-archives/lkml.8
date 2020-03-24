Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A6C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B182070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A56HSAs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCXVZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:25:15 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:44994 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgCXVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:25:15 -0400
Received: by mail-qk1-f169.google.com with SMTP id j4so158996qkc.11;
        Tue, 24 Mar 2020 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=eD5Dd9pQbOHWz1I/VV0+OE79XLSILdsUaoiPbisRrS4=;
        b=A56HSAs5W4MoYsCQD0IJ27zH7qXr4WarPRwLMYsoIKuqgVjnp12ohAe1IsdLnOhpRe
         WQywVo/+d97g+ZHXCgLp8p7ulnyALWbZ+FfEYRoW07rSn1XumwVxm9v3sbLOG3AC1Yak
         sAslDG8PtSKGb0MN+p9VvzwIy8m7NAJglRi81PNty/+dGsGQ4mtEU2SxT0UpZ/61ULny
         By6kpeh19BrJqd3ER7g7UggpaKB6j1oelycJuhPgwkLwfKUJidERq5Ku68uER8pAJfRl
         XhuQk1mP6zii2J1RRD/CDvqHnqOjEYQ2/nymVIbSMZjW4jtZkx3NhAIWE5uYYInZRJk1
         edPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=eD5Dd9pQbOHWz1I/VV0+OE79XLSILdsUaoiPbisRrS4=;
        b=MUuuL8LujgjFIplJk1yaI6Y9TkMkf4tf89KmhTlI05YoI+CbVdv1G7s0DOuMmfJ+gY
         WHt/+T4VadiJzccyuEmXKX/0o5sdrqOQstVXmyrOg5noxSiFinWzzyBYBn/0Fo29Up4W
         5u2yDYfInfgwk8TJp53D5GOYPix5LoU7v8ZeP2VPnDuYdO6uU0eyJH1XDqZgiUjJcHUN
         Q/7zFngJ0d9DIRZ5/P0bZQsiJbhj6FTzA2eLbY7rXZVFWaktiEPMJk9/4bI7BTj4VVrj
         FmCIGj6efVXk1YsUvwjREcO6BH6WMiXBvFXmPQWKnkpbgEBjBE9uDzTxkrEq8KAi6+ZO
         4hPQ==
X-Gm-Message-State: ANhLgQ3VncbHNOy/Q5F03g7PQiHV9nart6IXoSkhMjgGjgjn9H6eGp4d
        aLcN56uuH5xAyBpi+uge1oY=
X-Google-Smtp-Source: ADFU+vvnnFRV7+6xiqxA3i5iiKElP3U5xxZpyKTU4/vSJHEGHvZcSKJGxDfKdnL83o61CEENS29iUA==
X-Received: by 2002:a05:620a:13a7:: with SMTP id m7mr24976009qki.181.1585085113730;
        Tue, 24 Mar 2020 14:25:13 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u15sm15911755qte.91.2020.03.24.14.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:25:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 18:24:09 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200324201522.GP2452@worktop.programming.kicks-ass.net>
References: <20200224043749.69466-1-namhyung@kernel.org> <CAM9d7chneHzibiQFopmN1rED=mf-nBpy58kauXWSOSYy2zCtzQ@mail.gmail.com> <20200324163444.GA162390@mtj.duckdns.org> <20200324201522.GP2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHSET 00/10] perf: Improve cgroup profiling (v5)
To:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <D53AD1F8-4B2B-4B30-BC72-59CCA7F0D268@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 24, 2020 5:15:22 PM GMT-03:00, Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>On Tue, Mar 24, 2020 at 12:34:44PM -0400, Tejun Heo wrote:
>> On Mon, Mar 23, 2020 at 08:58:04AM +0900, Namhyung Kim wrote:
>> > Hello Peter, Tejun and folks=2E
>> >=20
>> > Do you have any other comments on the kernel side?
>> > If not, can I get your Ack?
>>=20
>> Everything looks good from cgroup side=2E I think I acked all cgroup
>parts already
>> but if not please feel free to add
>>=20
>>  Acked-by: Tejun Heo <tj@kernel=2Eorg>
>
>Yeah, looks good to me too=2E Since it's mostly userspace patches, will
>you route it Arnaldo?
>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>

Thanks for the acks, I'll process it tomorrow, so tests passing it'll go I=
ngo's way for 5=2E7 tomorrow=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
