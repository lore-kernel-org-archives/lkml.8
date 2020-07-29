Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D4F2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgG2SLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2SLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:11:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3A6C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:11:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0636728EB45
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH 2/6] arch: x86: Wrap TIF_IA32 checks
Organization: Collabora
References: <20200728202229.1195682-1-krisman@collabora.com>
        <20200728202229.1195682-3-krisman@collabora.com>
        <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
        <878sf3j5cl.fsf@collabora.com>
        <CALCETrUVQw4EUyEFQ4xdWBrxVKJtNmrZurGccXtn8i9nNAYufg@mail.gmail.com>
Date:   Wed, 29 Jul 2020 14:11:44 -0400
In-Reply-To: <CALCETrUVQw4EUyEFQ4xdWBrxVKJtNmrZurGccXtn8i9nNAYufg@mail.gmail.com>
        (Andy Lutomirski's message of "Tue, 28 Jul 2020 22:09:26 -0700")
Message-ID: <874kpqjin3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Tue, Jul 28, 2020 at 9:46 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>>
>> > On Tue, Jul 28, 2020 at 1:22 PM Gabriel Krisman Bertazi
>> > <krisman@collabora.com> wrote:
>> >>
>> >> In preparation to remove TIF_IA32, add wrapper that check the process
>> >> has IA32 ABI without using the flag directly.
>> >
>> > Thank you for doing this, but let's please do it right.  There is,
>> > fundamentally, no such thing as a "process with IA32 ABI".
>>
>> Hi Andy,
>>
>> Thanks a lot for your review.
>>
>> As you can see, I'm learning my way here. Can you clarify "there is no
>> such a thing as a 'process with IA32 ABI'"?  I'm not sure if I confused
>> the terminology or if (more worrisome for me) I got the concepts wrong.
>>
>> My understanding is that TIF_IA32 marks a thread that is running under
>> the 32-bit compat mode, which would be running a 32-bit process (as in
>> compiled with -m32, for instance), while TIF_X32 marks a process running
>> under the X32 ABI.  Each process would have only one of these
>> "personalities". This is what I meant by a process with IA32 ABI (which
>> is wrong in any case).  Is there more to it, or is the problem the
>> terminology I used?
>
> There's more to it.

Thanks again for the explanation!

>> I don't have any comments on the other things you mentioned, except that
>> I need to go through them and better understand your suggestions.  Would
>> you prefer me to rework this patch series with what you suggested or is
>> this something you want to take over and do yourself?  Both ways are
>> fine by me.
>
> Please rework it :)  I have seriously limited bandwidth right now.

Will do.

-- 
Gabriel Krisman Bertazi
