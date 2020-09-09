Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0383C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CE4206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIIMNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:13:53 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:49916 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730174AbgIIMDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:03:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D2987100E7B43;
        Wed,  9 Sep 2020 12:02:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch41_4202f16270dd
X-Filterd-Recvd-Size: 3596
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 12:02:12 +0000 (UTC)
Message-ID: <1d6548cc89bf89a0bea9a2d84a94a01cebc4ec7b.camel@perches.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID:
 handle commit messages with multiple quotes
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Ayush <ayush@disroot.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Sep 2020 05:02:11 -0700
In-Reply-To: <alpine.DEB.2.21.2009091324590.5622@felia>
References: <alpine.DEB.2.21.2009091152530.5622@felia>
         <beed63208cc412f122fe273602675801add08ede.camel@perches.com>
         <20200907151417.44453-1-ayush@disroot.org>
         <22db634e7be36f4514f0c9b3ecf0060a@disroot.org>
         <3dea1eefdbbf97791bed3f838d4f06a7@disroot.org>
         <alpine.DEB.2.21.2009091324590.5622@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 13:32 +0200, Lukas Bulwahn wrote:
> dropped the maintainers.
> 
> On Wed, 9 Sep 2020, Ayush wrote:
> 
> > Sir,
> > 
> > > As the mentor in the linux kernel community bridge program, I usually
> > > inform the mentees when the review on the mentee mailing list has
> > > successfully concluded to a first acceptable state and I think it is well
> > > advised to reach out to the maintainers for further discussion.
> > > 
> > > You did not do that, but just send some patch to the maintainers.
> > > That is fully up to you, but I will not support the patch acceptance in
> > > any way, and it suggests that you do not see the need to be mentored.
> > > 
> > > If you can land patches without mentoring support successfully, that is
> > > great, but then you do not need a mentorship.
> > 
> > I am extremely sorry for my mistakes. It won't happen again.
> >  
> > > Now, to the commit:
> > > 
> > > Ayush, your commit message is largely incomprehensible.
> > > 
> > > Your follow-up explanation that was needed should have been in the commit
> > > message in the first place.
> > 
> > It was my first patch, so I had very little idea of forming commit messages. 
> > I will discuss it with mentors next time before sending the patch next time.
> > 
> 
> Let us start with the simpler patch and then see if you can write a commit 
> message that convinces Joe to ack your patch.
>  
> > > Ayush, you did not sign-off with your full legal name.
> > 
> > My legal name according to all official identification documents of India is Ayush. 
> > I have no surname registered legally.
> > So should I include "Ayush <ayush@disroot.org>"  or do I need to include my last name too (Which is Ayush only)?
> > 
> 
> Okay. If you say so, I cannot judge but you should try to use a name that 
> others can with a fair chance uniquely identify that is you.
> 
> The name is used in git log summaries, pull requests, etc.; so, it should 
> be a name that with high chance to refer to one person.
> 
> Maybe you find a good way that works as suitable name for 
> unique identification?

I believe the Developer's Certificate of Origin (DCO) in
Documentation/pr
ocess/submitting-patches.rst just asks
for a "full name".

If Ayush has no surname, then I imagine that his actual
full name Ayush should be good enough for the DCO.

A line like "Signed-off-by: Ayush <ayush@disroot.org>"
should be fine.


