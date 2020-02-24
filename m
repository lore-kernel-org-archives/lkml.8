Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0EC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815CE21556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582581019;
	bh=SByL9yxoZU3/7NUw/JDYEsdEaf+wwkao6X+0htKhiEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bE0Tb4Kmh1N2kQ43Fv0U5YQPrioN/rfvstZR6c4WgClGag3Lk+9n+TVv4m2FsLVzH
	 v/W1j/JkmvSIdCwu+fFOv2we3JAElTyqOKHNVir4HUkTBDVwyzhK6CQvk9QYVMHYM8
	 aMXlu+QPzgkzqVuXoLq8pMcu3wG+aVsoE1rE2Gpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:50:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43254 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:50:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so13725804edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpRlNJyxjURpxSeo9TgDWjOVoYB3eEWq/qH5+c8IPvQ=;
        b=eyZAPIDtfYGAJMFSbiOA8WQ5iUhe96wmEjyfCJ34B+4o7j9kYZVEhFkBmiZl7ADo+f
         PyP6gf2SNcUFSNj7E6uihJH7h9RPze99rK4fpnXvren68bqmdd2LQKtC1k1NOzSOjcLo
         1YoTHieJQZU3MaTRlKUzerS3gODLbLoBhaXeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpRlNJyxjURpxSeo9TgDWjOVoYB3eEWq/qH5+c8IPvQ=;
        b=fH09HLc0N+ePWhTa6AHDpU7f7NC9gQZFbWbxdbhlui+28rVavz/MudSsIFY0ioSwGp
         QrjsskxaosSfmwjx92ls/S9FT9vgyV8nCiu1FHWcNYPbTa3ZBZo/cO1Cp2SWVJUDj0Db
         7MGa+25newOlZ1tu+3qs+yurMyAZ12/X9LIryvvltm5gDGIoiSX3KgZZLSA6xwtokxRU
         yNOKMZroyIk3He13x3kKORPs2PF8X7zHa8d17TNrxgOaeE22MNehfOURXGf4fDExl50s
         vOL8/A3VmAvTWITQC5IR1C5cUIPGng2qj3AWVbHswKopbV9A3wSioqW22aKVRSVpY2tL
         7vlg==
X-Gm-Message-State: APjAAAXOR93EdVpYAjdbXhtRSoOTAOY4lXmdiwkVLQegjRkYDeWyAcMi
        nDgOfqJlJXQfwZqgw3DSLNxqcjAEEIo=
X-Google-Smtp-Source: APXvYqxuh8lMpC3ktOOu/YZa4gbcXc09qkEGn3GPZbSHUSO+hbMFrF3PDo1iQbmwjXIfzOg7a83jCg==
X-Received: by 2002:aa7:c803:: with SMTP id a3mr46470366edt.99.1582581015992;
        Mon, 24 Feb 2020 13:50:15 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id ck19sm853924ejb.48.2020.02.24.13.50.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:50:15 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id r18so13772788edl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:50:15 -0800 (PST)
X-Received: by 2002:a19:6144:: with SMTP id m4mr1561198lfk.192.1582580600346;
 Mon, 24 Feb 2020 13:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com> <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com> <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com> <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
 <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
 <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com> <87a757znqd.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a757znqd.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 13:43:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
Message-ID: <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Feng Tang <feng.tang@intel.com>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I keep looking at your patch and wondering if there isn't a way
> to remove the uid refcount entirely on this path.

I agree. I tried to come up with something, but couldn't.

> Linus I might be wrong but I have this sense that your change will only
> help when signal delivery is backed up.  I expect in the common case
> there won't be any pending signals outstanding for the user.

Again, 100% agreed.

HOWEVER.

The normal case where there's one only signal pending is also the case
where we don't care about the extra atomic RMW access. By definition
that's not going to ever going to show up as a performance issue or
for cacheline contention.

So the only case that matters from a performance standpoint is the
"lots of signals" case, in which case you'll see that sigqueue become
backed up.

But as I said in the original thread (before you got added to the list):

 "I don't know. This does not seem to be a particularly serious load."

I'm not convinced this will show up outside of this kind of
signal-sending microbenchmark.

That said, I don't really see any downside to the patch either, so...

                Linus
