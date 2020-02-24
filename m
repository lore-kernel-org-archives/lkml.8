Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1DC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E23218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582582789;
	bh=SpqMquaLiMdlIYmgDgUBa/NScKO2YXql62ts3Rj0R9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fRi9LpapKNO7nPjziQxrqDepAdbJ8MkopytSXrRo0SklnuhZqcDM0poSIV7s3tMYl
	 3N8MrzHOpTw5SYr/GhXCPW8bZjSWXjRMEHCoOG9YJ7uIT+oYkTkNeSbgnxKBw7BP3Z
	 iW7ez2/pXENfMjl2P4kYmxUOdRfuCqqtUKBdz//s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBXWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:19:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43098 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:19:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so13806937edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ua04IHV/ut+warGhjtTc9FaMw6Bd0KLfUZB1G7Gfy5Q=;
        b=ElTkCgl31gTmXuIVqXl/uPaWGalYNpP+qRWjSoF43DlMSMCKC+/cickD9VJi+HW9vS
         stai2Vrem28ry4B9BhC8qkINuTx4zxYCZ4PdQfuoOkmReszGllzOPpNEYYLazhf7GJiq
         wYPvn2CW4vjLZ5FQ5ISPxpeav1N9/ta9w8lbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ua04IHV/ut+warGhjtTc9FaMw6Bd0KLfUZB1G7Gfy5Q=;
        b=fyMLDCBgql8Rp/Y8RIB6iK1Yq/wKuzFiDuzQjaJ/NnN8aZZxVnjMhWSALJd34RN4mw
         JsKRLKgwPsI8SU/vMmHa3ysFo4Qon7SobJtMxYXO+7+mlmSC8ORt36y65wdQ/wz4qr/u
         DlDRmrRf/AhkXL+/J6R+MNmNH1Rzntp8vVDx/ymUsg6Wuy1qwTMfWihVQW/imhk6RcFk
         751Jqq6JWVWxKa9O0jDhuU20bSmzTxkzOQDr9aYoTvTQ4My9SB6exDuG8j76OnfShHVW
         cnh2cXWmZq4BLAq58OxVMiAoqXe4eO/WVVPjxs09S46a2fdhL4ozMH7WEu1+gUL6Lrti
         ygoQ==
X-Gm-Message-State: APjAAAVq/yIoYQ49IsZ+QmVHt6nU3LD/cvmvxonK+C8KCMA9I6k3n7Zx
        jIXPjfLAfo/QrVLL4eNIQLX+8jvx7mU=
X-Google-Smtp-Source: APXvYqwYoAoSg2zlaGKLnZp8Os91SFoWr4ybIXkE4YSVBI2TFt1GhnCMjqSwUkDhGTUmYFobxQud5g==
X-Received: by 2002:a17:906:d0d1:: with SMTP id bq17mr49722875ejb.55.1582582785492;
        Mon, 24 Feb 2020 14:19:45 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id dc5sm1093425edb.61.2020.02.24.14.19.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 14:19:45 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id m16so12279133wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:19:45 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr11413148ljj.265.1582582387885;
 Mon, 24 Feb 2020 14:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com> <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com> <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com> <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
 <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
 <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
 <87a757znqd.fsf@x220.int.ebiederm.org> <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
 <8736azzlwq.fsf@x220.int.ebiederm.org>
In-Reply-To: <8736azzlwq.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 14:12:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXr1JcW3hyomWh8Y8Kr9wNq-+6r+CocY8EfXvuW7giHg@mail.gmail.com>
Message-ID: <CAHk-=wgXr1JcW3hyomWh8Y8Kr9wNq-+6r+CocY8EfXvuW7giHg@mail.gmail.com>
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

On Mon, Feb 24, 2020 at 2:02 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Other than scratching my head about why are we optimizing neither do I.

You can see the background on lore

  https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/

and the thread about the largely unexplained regression there. I had a
wild handwaving theory on what's going on in

  https://lore.kernel.org/lkml/CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com/

but yes, the contention only happens once you have a lot of cores.

That said, I suspect it actually improves performance on that
microbenchmark even without the contention - just not as noticeably.
I'm running a kernel with the patch right now, but I wasn't going to
boot back into an old kernel just to test that. I was hoping that the
kernel test robot people would just check it out.

> It would help to have a comment somewhere in the code or the commit
> message that says the issue is contetion under load.

Note that even without the contention, on that "send a lot of signals"
case it does avoid the second atomic op, and the profile really does
look better.

That profile improvement I can see even on my own machine, and I see
how the nasty CPU bug avoidance (the "verw" on the system call exit
path) goes from 30% to 31% cost.

And that increase in the relative cost of the "verw" on the profile
must mean that the actual real code just improved in performance (even
if I didn't actually time it).

With the contention, you get that added odd extra regression that
seems to depend on exact cacheline placement.

So I think the patch improves performance (for this "lots of queued
signals" case) in general, and I hope it will also then get rid of
that contention regression.

                   Linus
