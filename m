Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338EEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1743215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWj2iioF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIIKGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgIIKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:06:09 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2B2C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 03:06:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so2027228edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rYuQ9FT+4m9DZF/zl6tu1R42tR6bJhq4IHrczHtHxTo=;
        b=GWj2iioFTE0yKF2+rMUo93NPAu9EfreyVb6Xkw1GODQRyL/neHXuuXOYtjxrIRldJZ
         016K09m57fsMl6gEoBUfy2TeDR6WZyxKzKeIQS4F7NQAlEIa2lqrDznlJTQKwlokuLUA
         isI9SfjW7/m9dpJFCaRLVmdkxqzTYWhLcMpiD8eeJZBpd7ysVoiv9qLwNzRh3PlQXRrD
         rrPq6e+1gfSw3XN+JiWfR9O5E1at1VnnnOIyfN3D4ktWRJ/+fkiGZwiNbH4M+PzzELpd
         Ct1OU6BxQhDmJsUyiKDOhBtOpLb1IA8x0bQxUtbelbuP4J8LlHeiZ1HRwojMMmq2kNSF
         7ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rYuQ9FT+4m9DZF/zl6tu1R42tR6bJhq4IHrczHtHxTo=;
        b=sG+ipO/L6OsZyPkumqdjrUzFOaWtrw9FrD4/ZhuL9JUThTaVqIw4P3t2G8HgVbgsgC
         ufuFvskZG3YUwEhQsQDxRb2qj/OT5ktdu50sSbAHPmmWvy4/ni7Az7KJzVhcRzhnylvA
         7C7HJa1/PeCsQAhgZwsT5dkmZt2AOcm1poRDDbauqXdN7zgPBnqO8knVGxIbCVzBVLhs
         o+YUhflUREXSXrAeCovVmVlOXKqJMLolsD7jtW07J/F/Pq0815uGKkOjMAdlI8+hFb98
         xmUPEdB+HvjooPqcTOT7U6aGG78nLGDUHWOOOycl+H4F7huDACTmkuf40Hl6Ad+uiiun
         H9FA==
X-Gm-Message-State: AOAM532sgGBjMgIm1FGuph68Q7wk6fjp1Tr2L9XflL5mLqNqPgReTMZf
        e+4VfVR6h/iyemPQMWtVogg=
X-Google-Smtp-Source: ABdhPJwqzsZFPacwfD7vzqPUXRVINBaFATYFLDGAMQz0Vz7Fr8o3Rx1HqXczCJ/z/yfAPVlUlsk2ZA==
X-Received: by 2002:aa7:d558:: with SMTP id u24mr3342099edr.336.1599645967911;
        Wed, 09 Sep 2020 03:06:07 -0700 (PDT)
Received: from felia ([2001:16b8:2d44:6000:6108:df55:7b8e:67d4])
        by smtp.gmail.com with ESMTPSA id t4sm1593478ejj.6.2020.09.09.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:06:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 9 Sep 2020 12:06:06 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Ayush <ayush@disroot.org>
cc:     Joe Perches <joe@perches.com>, apw@canonical.com,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID: handle
 commit messages with multiple quotes
In-Reply-To: <22db634e7be36f4514f0c9b3ecf0060a@disroot.org>
Message-ID: <alpine.DEB.2.21.2009091152530.5622@felia>
References: <beed63208cc412f122fe273602675801add08ede.camel@perches.com> <20200907151417.44453-1-ayush@disroot.org> <22db634e7be36f4514f0c9b3ecf0060a@disroot.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Sep 2020, Ayush wrote:

> > I think all your examples are broken.
> > 
> > I think all should start with revert
> > i.e.: Reverts commit <SHA-1> ("description...")
> 
> Actually I am talking about those commits which referenced a revert commit.
> 
> For example:
> 
> If I want to mention a revert commit in my commit message, I will do something like.
> 
> This bug appeared first in commit 1234567890ab ("Revert "abc: foo bar"").
> (Just an example)
> 
> Here, according to syntax, it is right but checkpatch.pl gives an error as multiple
> quotes in commit messages are not handled in checkpatch.pl.
>

As the mentor in the linux kernel community bridge program, I usually 
inform the mentees when the review on the mentee mailing list has 
successfully concluded to a first acceptable state and I think it is well 
advised to reach out to the maintainers for further discussion.

You did not do that, but just send some patch to the maintainers.
That is fully up to you, but I will not support the patch acceptance in 
any way, and it suggests that you do not see the need to be mentored.

If you can land patches without mentoring support successfully, that is 
great, but then you do not need a mentorship.

Now, to the commit:

Ayush, your commit message is largely incomprehensible.

Your follow-up explanation that was needed should have been in the commit 
message in the first place.

Ayush, you did not sign-off with your full legal name.

So, I advice NOT TO TAKE this patch.

I did not even start testing and reviewing the code yet.

Lukas
