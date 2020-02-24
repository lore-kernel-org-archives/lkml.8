Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4392C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23B820CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBXWBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:01:55 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57726 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:01:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LnU-0002wT-Gz; Mon, 24 Feb 2020 15:01:52 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LnT-0001Jy-Q0; Mon, 24 Feb 2020 15:01:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        andi.kleen@intel.com, "Huang\, Ying" <ying.huang@intel.com>
References: <20200205123216.GO12867@shao2-debian>
        <20200205125804.GM14879@hirez.programming.kicks-ass.net>
        <20200221080325.GA67807@shbuild999.sh.intel.com>
        <20200221132048.GE652992@krava>
        <20200223141147.GA53531@shbuild999.sh.intel.com>
        <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
        <20200224003301.GA5061@shbuild999.sh.intel.com>
        <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
        <20200224021915.GC5061@shbuild999.sh.intel.com>
        <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
        <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
        <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
        <87a757znqd.fsf@x220.int.ebiederm.org>
        <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
Date:   Mon, 24 Feb 2020 15:59:49 -0600
In-Reply-To: <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 24 Feb 2020 13:43:02 -0800")
Message-ID: <8736azzlwq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6LnT-0001Jy-Q0;;;mid=<8736azzlwq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/MXa+JssMEncMrZMpgoryMCXD2Md2TvzQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops -5.5% regression
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Feb 24, 2020 at 1:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I keep looking at your patch and wondering if there isn't a way
>> to remove the uid refcount entirely on this path.
>
> I agree. I tried to come up with something, but couldn't.
>
>> Linus I might be wrong but I have this sense that your change will only
>> help when signal delivery is backed up.  I expect in the common case
>> there won't be any pending signals outstanding for the user.
>
> Again, 100% agreed.
>
> HOWEVER.
>
> The normal case where there's one only signal pending is also the case
> where we don't care about the extra atomic RMW access. By definition
> that's not going to ever going to show up as a performance issue or
> for cacheline contention.
>
> So the only case that matters from a performance standpoint is the
> "lots of signals" case, in which case you'll see that sigqueue become
> backed up.
>
> But as I said in the original thread (before you got added to the list):
>
>  "I don't know. This does not seem to be a particularly serious load."
>
> I'm not convinced this will show up outside of this kind of
> signal-sending microbenchmark.
>
> That said, I don't really see any downside to the patch either, so...

Other than scratching my head about why are we optimizing neither do I.

It would help to have a comment somewhere in the code or the commit
message that says the issue is contetion under load.  So the next time
someone goes through the code and goes why aren't we doing the stupid
and simple thing it will be clear.

Eric
