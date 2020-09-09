Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F062C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F0721D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCC/h+mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgIINPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbgIINK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:10:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E1C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:10:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so3416659ejr.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=a5nFoefz0dFapmLX5QbAwgV5kNLDauws60Ngd59ih9w=;
        b=YCC/h+mFrFOJRWmQ50ujG0S7DCsUpfdcAg3vnlSZkBp6DS/QcmZG7jtmlMIp/kSbkw
         OEhf4Buvc4opIRoOaEEBubSiozcTJppgEgq3rdyypAhDudLOJcpIqpvAMyaT0cb+bPyd
         EUnaJiIXOpko9mjZ0iWWQEKKHckN7HJrd14NR2JrB30tzQU2aEBVGgiSt8yIoaECpZkB
         wcw0RCBuTW7q6G22w7oc7AB6QUGLVAzqnG+8j0yX7iHcyyvD/9PafD38rEp2DrukxXQg
         xQHdcV2PMuYzVmUmzW7m6xM1FqAgpfKvevGWnEiMLUPAGwy0qti1lzwMlqNz61S5Vo1U
         WCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=a5nFoefz0dFapmLX5QbAwgV5kNLDauws60Ngd59ih9w=;
        b=BB+92WsLESGJVNtnjFg6XhJd9iV9LsYK/fgpQU3kO+boG1W53ifbdiV2ypDHqszDig
         /6V2EuQrxhNPAuVEp38YGB1EeQaTXt9T7z8TlgncMPhRMpIm0VyfP4iLYjd4BrrdugQ7
         IRBeW3mmnjSENGzedmLSapd398OiewiaIOp0kvNdloDowoCnztoWVZvT9R8b+btc45hP
         XWWBYZRAiTsKWK5DgKfUBtJw6tytT5WmYG3pyEL0QWaR4PEqF9pVNF/b+3JlpQ8G3Sse
         RZ/e/56+m4PLZb3YSabfMHhUQxus0bFLOyH9HmOcxvdIrcYYVlHpcgdcPRMnr2Dqh6mf
         MsZw==
X-Gm-Message-State: AOAM533fSiMMfXyhpNiYGxL0XOp3hUEKuKodKsXQlpKVlGLk6glz3nUm
        ERCiits24Px9K+VTSBwdASuXNt65Lp0rdQj9
X-Google-Smtp-Source: ABdhPJw6XUmZ4wEEGWjyIQ+GAjfbu0fNByX8pihDQyn5SaTmNibqLGCtDv49AEOdIb5Z0nyvJy9FDw==
X-Received: by 2002:a17:906:ae8f:: with SMTP id md15mr3375412ejb.131.1599657032100;
        Wed, 09 Sep 2020 06:10:32 -0700 (PDT)
Received: from felia ([2001:16b8:2d44:6000:6108:df55:7b8e:67d4])
        by smtp.gmail.com with ESMTPSA id bn14sm2242200ejb.115.2020.09.09.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:10:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 9 Sep 2020 15:10:25 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Ayush <ayush@disroot.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID: handle
 commit messages with multiple quotes
In-Reply-To: <1d6548cc89bf89a0bea9a2d84a94a01cebc4ec7b.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2009091506130.23843@felia>
References: <alpine.DEB.2.21.2009091152530.5622@felia> <beed63208cc412f122fe273602675801add08ede.camel@perches.com> <20200907151417.44453-1-ayush@disroot.org> <22db634e7be36f4514f0c9b3ecf0060a@disroot.org> <3dea1eefdbbf97791bed3f838d4f06a7@disroot.org>
 <alpine.DEB.2.21.2009091324590.5622@felia> <1d6548cc89bf89a0bea9a2d84a94a01cebc4ec7b.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Sep 2020, Joe Perches wrote:

> On Wed, 2020-09-09 at 13:32 +0200, Lukas Bulwahn wrote:
> > dropped the maintainers.
> > 
> > On Wed, 9 Sep 2020, Ayush wrote:
> > 
> > > Sir,
> > > 
> > > > As the mentor in the linux kernel community bridge program, I usually
> > > > inform the mentees when the review on the mentee mailing list has
> > > > successfully concluded to a first acceptable state and I think it is well
> > > > advised to reach out to the maintainers for further discussion.
> > > > 
> > > > You did not do that, but just send some patch to the maintainers.
> > > > That is fully up to you, but I will not support the patch acceptance in
> > > > any way, and it suggests that you do not see the need to be mentored.
> > > > 
> > > > If you can land patches without mentoring support successfully, that is
> > > > great, but then you do not need a mentorship.
> > > 
> > > I am extremely sorry for my mistakes. It won't happen again.
> > >  
> > > > Now, to the commit:
> > > > 
> > > > Ayush, your commit message is largely incomprehensible.
> > > > 
> > > > Your follow-up explanation that was needed should have been in the commit
> > > > message in the first place.
> > > 
> > > It was my first patch, so I had very little idea of forming commit messages. 
> > > I will discuss it with mentors next time before sending the patch next time.
> > > 
> > 
> > Let us start with the simpler patch and then see if you can write a commit 
> > message that convinces Joe to ack your patch.
> >  
> > > > Ayush, you did not sign-off with your full legal name.
> > > 
> > > My legal name according to all official identification documents of India is Ayush. 
> > > I have no surname registered legally.
> > > So should I include "Ayush <ayush@disroot.org>"  or do I need to include my last name too (Which is Ayush only)?
> > > 
> > 
> > Okay. If you say so, I cannot judge but you should try to use a name that 
> > others can with a fair chance uniquely identify that is you.
> > 
> > The name is used in git log summaries, pull requests, etc.; so, it should 
> > be a name that with high chance to refer to one person.
> > 
> > Maybe you find a good way that works as suitable name for 
> > unique identification?
> 
> I believe the Developer's Certificate of Origin (DCO) in
> Documentation/pr
> ocess/submitting-patches.rst just asks
> for a "full name".
> 
> If Ayush has no surname, then I imagine that his actual
> full name Ayush should be good enough for the DCO.
> 
> A line like "Signed-off-by: Ayush <ayush@disroot.org>"
> should be fine.
>

Agree. Let us, Ayush and me, focus on getting some patches technically 
ready for your review, Joe, and with that, continue to improve 
checkpatch.pl.

Lukas
