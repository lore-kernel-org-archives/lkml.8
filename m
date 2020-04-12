Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517CD206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 06:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDLGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 02:01:22 -0400
Received: from mail-am6eur05olkn2058.outbound.protection.outlook.com ([40.92.91.58]:39376
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbgDLGBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 02:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNq66iy82kejVR1nHFXA+CbpgzrjxvONfPysb0i2GVb85MzHzIRbmNdt2htJhzuo48FD7cLgMNfbUjdU1i914uFxRGV2ruHXKPAMyuvL9bIcxz0Ht/PNmuOk8M0+IXx9BEbXewKhmWr0UEIAwdcFgev3ATYoC23dXeun95IWPmtaGHCg4btExQUwQGSjigx1hIieF6ZeqPXT1SuZHpG0R3rQT+AgoutryOW0U4BW0ykcdBJD6ylgbd5IDVPK6v8ylOVh83LRfPlN0bl98iUTY/sa3+g8MM2KHUFVKuCzlR7Iqh3oA6PAIMNwMmo9jQ39NtQ/424CRKzBFbzhcrZ7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng92p1eMq5K4s7OVJDyuxCPpUyAfWOjQJmMWJ5zDVkE=;
 b=KP1213+6s82CVBkTeqwGwj3bv/9Erw31z3zsxr8UxaLY8Hde7i23+RuTa5U6kQFSxanzscs3aKLvOieV2YO/C6XPl6RYToNsHyDkZev6D+65TE0F/GbL5OlziD71FobYf0iHr56ytcaTkN5/dgjweOggdDcccB2pQ7jwVJ4pXWVPMJXZOT4Ms9BEOePWeEw5B9jH5JKotpCyGbw+ih/Dfwsfsqe6uIsDrMJ2iRvPoNLtUzInV/e4WEtU1nSoo9Iz1nXF7UzGAd5nwHN4mxxIFFTNHgTmOCp6WrHH9ZLoUcjzJ8kKt/sZeCMlTnr2B9X75Zhon1hvi41SzG1SHhumSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR05FT059.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::48) by
 VI1EUR05HT053.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::456)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Sun, 12 Apr
 2020 06:01:13 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc12::46) by VI1EUR05FT059.mail.protection.outlook.com
 (2a01:111:e400:fc12::335) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Sun, 12 Apr 2020 06:01:13 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:AB219588BB39977EE4508FB6582F43B650366961B91D41B26AA90FD349ADFDAB;UpperCasedChecksum:5F03EC52E0E724C0A0D472AA8AFE03C27A8ED069917312726188E5D992CE1A0E;SizeAsReceived:10015;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 06:01:13 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <AM6PR03MB5170660DA597EAAAC0AC1B5BE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjXxM0VnLN6iwVeORwxED5QgXS_AXUJ4+Af3jUeFY21gw@mail.gmail.com>
 <AM6PR03MB5170E360AE2E27F632874DAEE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wgWHkBzFazWJj57emHPd3Dg9SZHaZqoO7-AD+UbBTJgig@mail.gmail.com>
 <CAHk-=wiMm+LC7vwjtCXs9qp2t+Qp=N=Bzv8_R_=NVFDO4QHN7A@mail.gmail.com>
Message-ID: <AM6PR03MB5170B4426D360326DA86FE60E4DC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sun, 12 Apr 2020 08:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wiMm+LC7vwjtCXs9qp2t+Qp=N=Bzv8_R_=NVFDO4QHN7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::46) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <a1801c61-38ee-50fc-39ce-130de04e2feb@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR01CA0141.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Sun, 12 Apr 2020 06:01:11 +0000
X-Microsoft-Original-Message-ID: <a1801c61-38ee-50fc-39ce-130de04e2feb@hotmail.de>
X-TMN:  [exOKeDkfWCiryE8OvGMTtJ1r0JtPusNw]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 02ca92ff-700b-4f10-b9d2-08d7dea6e783
X-MS-TrafficTypeDiagnostic: VI1EUR05HT053:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xDJIdT4oBftxTnTy6N06sUehbX/2YdRxwIqhXon8BC2y+zDppTVJdKQ56U8KSmY4K0zJjE5ayrv3lRABLTEhqhMTMUxgRlDrNmNYH8PrgOFaP7hFsEViQ7T3ySwK7SDt2315+/W/U3rRzektrAR2NMZGgNh/af077giHNmkk9894X7vvk5JPAQ3TQ6fjdV6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 1+aBHBq0SpZXXVd4K8F+CwuMFhv7pcHBOMimt1274bpQ7W3axrpWeAGo7O6SreO5MzTKKWTN+1eXpt0QMB/OpWKmqe+tEbuO3RdUkrF4x0pEuMu2+FL2N4CW+kfn99eqLa2HK6uk6r+7vm362UwcTQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca92ff-700b-4f10-b9d2-08d7dea6e783
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2020 06:01:13.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On 4/11/20 11:57 PM, Linus Torvalds wrote:
> On Sat, Apr 11, 2020 at 2:21 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> You're confused.
>>
>> There *was* that callback already. It happened when the thread exited and became a zombie. No ordering has changed.
> 
> Also, stop calling this a "deadlock" like you do, when you're talking
> about the kernel behavior.
> 

Agreed, we must first define the terms.  Let's call this a pseudo-deadlock.

I always talk about the tracer, so it is a deadlock in the tracer yes.
And it is also a deadlock in the process trying to execve the process
that execve's is doing something silly.  That is not shutting down
the threads that are maybe doing dangerous things, while one of them
does execve.  In my programs I do never do that because it is always
a race condition and dangerous not shut down threads before exiting
or execve.  But the tracer wants to debug this silly program, just to
understand why it is occasionally malfunctioning.  Then a deadlock in
both processes happens at the same time, repeatably.  Now a user called
Bernd is scratching his head why that happens.....

> That only - again - shows that you're confused.
> 

Sorry, I was writing another more important mail :), and interrupted
that quickly, to help you with one aspect of the problem that may
have been overlooked, so it is quite possible that I missed something.

So the intention was just to make sure you make your decisions based
on the some facts that I realized because I have debugged the tracer,
and found out that the kernel is expecting the tracer to have knowledge
of future events, and that is impossible for the tracer, so the tracer
must fail when he predicts the future wrong.  Again that is just my
impression I had when debugging the tracer.

The trace looks like this
do {
   wait()
   if(needed) ptrace_access();
   if(needed) ptreace_otherstuff();
} while(1);

when the thread death event is in the tracer's input queue,
the tracer does not know of it unless it looks,
but from time to time the tracer wants to do other things
like attach a process that may be doing random things.
But if I think about it, the parent changes in the moment.
The original parent did not listen and make the zombie
thread go away, but now the trace is the parent, but
it is unable to call wait since it is just doing
ptrace_access.  It is possible that I have missed something,
then it woud be good that others with more experience help
with me putting the puzzle together.

> The kernel at no point was deadlocked.
> 
> The kernel had two events - the exit of one thread, and the execve()
> of another - that it wanted to return to the tracer.
> 
> The tracer isn't listening to the first one, and the kernel is waiting
> for the tracer to do so. The tracer wants to get the second one, but
> it's not happening until the tracer has dealt with the first one.
> 
> That's a deadlock FOR THE TRACER.
> 

I just say, changing the order of the events is not what the tracer
wants.  The tracer wants to get out of the ptrace_access and do
listen to the events, in the correct order.  If the events happen
in a different order than before the tracer may be confused.
That is the point I am trying to make.  And yes I may be wrong.
So please correct me, if that is the case.

> But it's not a deadlock for the kernel. See the difference?
> 
> It literally is absolutely not at all different from a user space
> application that deadlocks on a full pipe buffer, because it's not
> emptying it - and it's not emptying it because it's trying to just
> write more data to it.
> 
> See? It's a user space bug. It really is that simple.
> 
> Here, I'll give you this program just so that you can run it and see
> for yourself how it hangs:
> 
>     #include <unistd.h>
> 
>     char buffer[1024*1024];
> 
>     int main(void)
>     {
>         int fd[2];
>         pipe(fd);
>         write(fd[1], buffer, sizeof(buffer));
>         read(fd[0], buffer, sizeof(buffer));
>     }
> 
> and it's *exactly* the same thing. The kernel buffer for the pipe
> fills up, so the write() ends up hanging. There's a read() there to
> empty the buffer, but that program will never get to it, because the
> write hangs.
> 

Yes, and no.  To solve this problem we have non-blocking sockets
and pipes.  When I write a server I never use any blocking APIs
because I know a write can block at any time, when the server and
the client use a blocking strategy.  So also when I write a client
it is always using non-blocking sockets.  But not all clients are
written this way, therefore the server must be forgiving.

> Is the above a kernel deadlock? No.
> 
> And anybody who calls it a "deadlock" when talking to kernel people is
> confused and should be ignored.
> 

It is not a good idea to ignore people who are barely aware of the right
terms.  It is better to try to understand what they really mean and
translate what they said to what they meant, then ask if you understood
correctly what was meant.  At least that is how I would like the discussion
like that to be.  It is a suggestion and not meant as an offense.

> So stop calling the ptrace() issue a deadlock when talking to kernel
> people - it just means annoys and confuses them. I literally thought
> something completely different was going on initially because you and
> Eric called it a deadlock: I thought that one thread was tracing
> another, and that the SIGKILL didn't resolve it.
> 

Once again, I am new to this lkml list, and it is not meant as an offense.

Yes SIGKILL does resolve this.
Either the tracer, or one of the tracess, but which one?

But SIGKILL is impolite, I prefer SIGTERM. And that does not resolve
the pseudo-deadlock.

> But no. It's not a kernel deadlock at all, it's something much
> "simpler". It is the same exact thing as the stupid buggy example
> program above, except instead of using "write()" and waiting for
> something that will never happen because the write needs another thing
> to happen first, the buggy ptrace test program is using 'ptrace()' to
> wait for something that will never happen.
> 
> Now, admittedly there is _one_ big difference: ptrace() is a garbage
> interface. Nobody disputes that.
> 
> ptrace() is absolutely horrible for so many reasons. One reason it's
> horrible is that it doesn't have a nonblocking mode with poll(), like
> the write() above would have, and that people who use read and write
> can do. You can fix the stupid deadlock with the above read/write loop
> by switching over to nonblocking IO and a poll loop - doing the same
> with ptrace is more difficult, because ptrace() just isn't that kind
> of interface.
> 

What my other patch (you know the one you hated ;-) ) does, is making
ptrace non-blocking when it must, by returning -EAGAIN.
But keep the order of events as they are.
I think your solution will change the order of events in order
to make the kernel more simple.  Right?

> And with read/write, you could also (and this is even more common)
> just used multiple processes (or threads), so that one process does
> reading, and another does writing. Again, ptrace() is a shitty
> interface and doesn't really allow for that very well, although maybe
> it could be made to work that way too.
> 
> But even with ptrace, you could have made the tracing program set a
> signal handler for SIGCHLD *before* it started doing forks and stuff,
> and then exit of the first thread should have caused a signal, and you
> could have reaped it there, and it should work with ptrace.
> 
> But that garbage ptrace() test program didn't do even that. So it ends
> up hanging, waiting for an event that never happens, because it didn't
> do that other thing it needed to do - *EXACTLY* like the "write()"
> ends up hanging, waiting for that read() that will never happen,
> because the garbage test-program did things wrong.
> 

The test case does that on purpose to demonstrate something that
may also happen in strace, but in a very unlikely case, but the
likelihood is not zero and when it happens users are surprised.

> So as long as you guys keep talking about "deadlocks", the _only_
> thing you are showing is that you don't understand the problem.
> 
> It's not a deadlock - it's a buggy test.
> 

The test case makes only sense together with the last part of
the patch.  If you prefer another solution then you must change
the test case as well.  That is allowed.
Changing strace is not allowed.  And breaking something in the
strace-5.5 test suite is also not allowed.

> Now, what I've suggested are a couple of ways to make ptrace()
> friendlier to use, and thus allow that stupid test to work the way you
> seem to want it to work.

No do not make my test case happy.  That is not what it was written
for.

> 
> Basically, execve() doesn't have a lot of reasons to really wait for
> the threads it waits for, and the only real thing it needs to do is to
> make sure they are killed. But maybe it can just ignore them once they
> are dead.
> 
> Or alternatively, it can just say "if you didn't reap the zombie
> threads, I'll reap them for you".
> 

Isn't that is an API change?

I think, there is no way how we can avoid an API change, but we have the
choice which API change we want.

> Or, as mentioned, we can do nothing, and just let buggy user space
> tracing programs hang. It's not the _kernels_ problem if you write
> buggy code in user space, this is not anything we've ever helped with
> before, so it's not like it's a regression.
> 

Also that is a possible allowed solution.
Just leave the test case as is, or change to KFAIL so known FAIL.

The remaining problem is certainly not important enough to make you
unhappy.


Bernd.

> (Although it can be a regression for your buggy program if you used to
> - for example - do threading entirely using some user-space library,
> and didn't have threads that the kernel knew about, and so when your
> program did 'execve()' it just got rid of those threads
> automatically).
> 
>                  Linus
> 
