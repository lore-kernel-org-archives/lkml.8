Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76692C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524462065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbgEZUgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:36:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59680 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390386AbgEZUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:36:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdgIp-0004Ve-Su; Tue, 26 May 2020 14:35:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdgIp-0001UA-4D; Tue, 26 May 2020 14:35:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <871rn6a6e5.fsf@x220.int.ebiederm.org>
        <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
Date:   Tue, 26 May 2020 15:32:10 -0500
In-Reply-To: <CAHk-=wh5cddDjyS2Av57Oc=qaowkx0XrtuJN=sErcq08qpnb7w@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 26 May 2020 12:09:16 -0700")
Message-ID: <87pnaq5tf9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdgIp-0001UA-4D;;;mid=<87pnaq5tf9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ejwF8OQ6gu/SpOahkBL41C3oTr2N+Lbk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, May 26, 2020 at 11:42 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> While working on my exec cleanups I found a bug in exec that winds
>> up miscomputing the ambient credentials during exec.  Andy appears
>> as to credentials are computed for both the script and the interpreter.
>

> Can you rephrase that?

yes.

The sentence should have read: 
"Andy appears to have to been confused as to why credentials are computed
for both the script and the interpreter."

If that is not enough ask and I will rewrite and resend the pull
request.

> I tried to figure out what you were trying to say, and I can't. I
> suspect a whole line or two is missing, or you were re-writing that
> thing and stopped in the middle or something.
>
> I'm also somewhat confused by your placement of that
>
>         new->cap_ambient = old->cap_ambient;


I am restoring the work usually done by prepare_exec_creds, that
happens to get messed up when cap_bprm_set_creds is called multiple
times.

Since that happens before cap_brpm_set_creds is ever called I figured
doing it at the top of the function in case there is something subtle
is the path to safety and reliability, especially if the code will
be backported.

I don't see us touching cap_ambient anywhere except the line that does:

	/* File caps or setid cancels ambient. */
	if (has_fcap || is_setid)
		cap_clear(new->cap_ambient);

But I am human and miss things occasionally.

> which doesn't seem to make a lot of sense. It's before the code even
> checks that the old ambient is valid, which I guess doesn't really
> matter (an error is an error, and the newly set state will not be used
> in that case), but aside from that it's just in an odd place.
>
> It's not near any other code that affects the new capabilities.
> Wouldn't it have made more sense to do this where we then clear
> cap_ambient if it's a setid binary?

That was my first thought but then I got defensive.

I think setting new->cap_ambient unconditionally at the top of the
function is the most robust way to code it. (see above).


The distance for other code clearing variables is also a mirage.  The
get_file_caps function 3 lines down in it's first line clears
new->cap_permitted.

> So this pull just confuses me for a couple of reasons - I'm not saying
> it's wrong, but at a minimum I'd like to get a merge message that
> makes more sense..

I am going to dash to get my allergy injection today, and then come
back and address whatever concerns you might have.

Eric
