Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C501EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A11B206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Ta1Kv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgGGVsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgGGVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:48:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB60C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:48:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so32980203qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kea5lz5SuEVjMYthwUPDUREfiUZ4imDQ4+lMs08zB6U=;
        b=S6Ta1Kv+P7Eg1sW5CWt+ahJt07X+1kO7D8SmRfRyR/GN3XSrYWuchEH82VMppIlBTm
         9rNp0tV1WORXPSiQPYBv/W9eRs9VHILhguUh4V0kIsX/5fsa4wlaSiqsjPCRAf5Je704
         V7gte79Kr6uk6ZsRX1e81zPc0/iReVb6G4Or31edv7NGdpfHo8GDT6wRiu2HByS4qnjK
         UK1HQM+2S+whIr63pSsErzlA8Y4uoqIKDdNI9QOliKKcnBcBL4+k+rRKgCqkWAx05iv7
         qdqeL5Xhw1NAUsM6Z+3BtcEMQZKpG9sMavMaZ5c6V8VE7JQFvcL+vQ665tie91AGCHLb
         eZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kea5lz5SuEVjMYthwUPDUREfiUZ4imDQ4+lMs08zB6U=;
        b=ZIG7kTcsbiQr2Qjvc3aznJ9QOwGIuK40aqP8zcL6exJhkBiOdpJlA4yhX+x90Gfyso
         vZY8OTmyFkkQ4wy5SInlX23V8XX0EiIRh7/STGiwoYPkjhjZWk/Tb0fHqbxV31Cex83v
         Kx+lyXXtgdvhAZBzePDvz5vhQL2ecUj3vFc9hCS+gY2ZmsfOrZVNa37v306YpsrizSwi
         XbraEUvzsCoO/PFAvCYM5uNrR36yOTIX4T9YLx4htOVrZGAnOwsAuF34n4ZfZwMnxll/
         Qii0R97jnmgkTfV9afY4skiiBU3LH/Je/PJgGuy24ktBWvcb1setUaINOqHjHou7/fkk
         EzhA==
X-Gm-Message-State: AOAM530N17njY/Ha4rMALjksfQjtSdFfGzhTE/7/q4xP/uJ8ft3Ghi2M
        3Le7GVURa0qKfduOszqrydU=
X-Google-Smtp-Source: ABdhPJwST4ORT9+NOST6EufPbIia2FmPxXFBTvW3IBn571c6j8gcIDV2QsJHi3xAKoz99PN6PV84vA==
X-Received: by 2002:ac8:4250:: with SMTP id r16mr43504761qtm.378.1594158486843;
        Tue, 07 Jul 2020 14:48:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t48sm29525053qtb.50.2020.07.07.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:48:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jul 2020 17:48:04 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>,
        Andy Lutomirski <luto@amacapital.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200707214804.GA1582632@rani.riverdale.lan>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook>
 <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
 <202007070137.3ADBEDC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007070137.3ADBEDC@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:54:23AM -0700, Kees Cook wrote:
> On Tue, Jul 07, 2020 at 06:56:53AM +0000, Harrosh, Boaz wrote:
> > Kees Cook wrote:
> > > I have struggled with this as well. The parts of speech change, and my
> > > grammar senses go weird. whitelist = adjective noun. allow-list = verb
> > > noun. verbing the adj/noun combo feels okay, but verbing a verb/noun is
> > > weird.
> > 
> > > And just using "allowed" and "denied" doesn't impart whether it refers
> > > to a _single_ instance or a _list_ of instances.
> > 
> > > But that's all fine. The change is easy to do and is more descriptive
> > > even if I can't find terms that don't collide with my internal grammar
> > > checker. ;)
> > 
> > But why. In English many times a verb when it comes before the noun means an adjective, or an adjective like, describing some traits of the noun.
> 
> This is kind of my problem being a native English speaker: I can't
> entirely describe _why_ a grammar construct feels wrong. :(
> 
> > Example: 
> > I work - work is a verb here.
> > I used the work bench. - Work is saying something about the type of bench, an adjective. Same as you would say "I used the green bench".
> 
> Right, so the verb-noun being used as a noun is find, just as adj-noun
> is. To me, "add it to the allow-list" is entirely sensible just like
> "set it on the work-bench." It's the "verbing" of a noun that trips me
> up.
> 
> "I will whitelist the syscall" -- sounds correct to me (same for
> "it is whitelisted" or "it is in whitelisting mode").
> 
> "I will allow-list the syscall" -- sounds wrong to me (same for
> "it is allow-listed" or "it is in allow-listing mode").

I suspect it's at least partly because "allow" and "list" are both verbs
-- in fact, "list" is the actual verb in "I will allow-list it", and
"allow" is being used to modify the verb "list". But because "allow" is
usually a verb, the sentence sounds like there are two verbs in there
when there should only be one. I expect our ears will get trained to
accept that sentence once you encounter "allowlist" often enough.
