Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E170C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E7C206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REr80juD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGGV0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgGGV0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:26:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA82C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:26:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w27so9917284qtb.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0huEUzYXA/GGYX5cduiY4exKC/PaSEcRPcqWa+ZwYFA=;
        b=REr80juDXRALebLkMrnwFOFOGJ4dV88o4rqAdC2cmyAwlETmOxJIjyBd8GLtZ+jRE8
         lMVzMkOOlJSLf+vE0eZZJzH7aMrse+BOKTz6R/U3hXQkZ+eVRMg/B0KAF1yk35Ibas37
         aiLYM3OIw9MKD9xhBAcspmb23w/Az1DFqUXnUwK1d4CtGditLu2xitN+DA1fPTkyur0B
         eb0mkvs5JBgS980el5Dec3jJZe5/puri/tjr6VWLZyyjk8yQc9fwTz5HpOR//LSLHpzO
         Fc/D5pGSXk2f4EuGmfmOLQG/mfh17vsN7Ck3jPymI2Vq3neKgmv5E+nZBcU8zR5SQeK/
         EhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0huEUzYXA/GGYX5cduiY4exKC/PaSEcRPcqWa+ZwYFA=;
        b=gd6Jc0LwrLqCnSJBGVkdoEauHQIEYrrZlon4EHjhWUbIAcWMZ9xGCtx0VayZvdcpeH
         nUNkNjPNFnFZp8DfDD7vjWNhLM4m9PZSp8j4NMGzYNS4GUp9p6YH0ifw/F9njRrwp+6M
         Hmbkvdw6g2sLwfmDRjvDtcLzdXap+0Wy+AW32eRkiTE8hVRAzi2A+dmvpMmRwNeOiDYv
         7tyWA/VBk93zkLZ1QVvAr3tDWOdExp/dQJmEnMVgmraoj4Ci4/0vlxeJEzleT61mQXu/
         r1/CscXwduCIcdfgV1WafmgPoKLF4jq6/H4uKlxvTkuAR2K3Mqqq7LkbA+gpED02dOP8
         XkJA==
X-Gm-Message-State: AOAM533iS+aKhmKZBbUdog5wk6vEKcAU4sGaY+JlxQ3LwTtpv+kth68z
        NFAVB1PPT/9w5HEUuvfq2lHxAPqIFSs=
X-Google-Smtp-Source: ABdhPJycxBI3L6mHLW9ZeEhqJ97T1JwvRZzRT2q282phik7lUgrm8zzQ/btIIqB+Py2upRI1cSHPUw==
X-Received: by 2002:ac8:134a:: with SMTP id f10mr58330231qtj.131.1594157203241;
        Tue, 07 Jul 2020 14:26:43 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f4sm26775479qtv.59.2020.07.07.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:26:42 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jul 2020 17:26:41 -0400
To:     Tibor Raschko <tibrasch@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200707212641.GA1575320@rani.riverdale.lan>
References: <20200706191555.GD6176@sirena.org.uk>
 <44713cf0-db41-bdd0-a41e-d710c346be12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44713cf0-db41-bdd0-a41e-d710c346be12@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:48:25AM +0200, Tibor Raschko wrote:
> > More generally etymological arguments are just not super relevant here
> > anyway, the issues people have are around current perceptions rather
> > than where things came from.
> 
> This is where ignoring etymology in this case falls apart, claiming that the
> current meaning is more important than the historical one. Yes it should be more
> important, but it suggests that the current meaning is negative, which it is
> not. In computer science (context!) these words do not have any negative
> perception or connotation, and people in this field know this. Yes, outsiders
> might not know this and could misunderstand them. But since when do experts in
> computer science (or in any field of science for the matter) care if a layman
> can correctly understand the field's technical terms? We never did and never
> will, except in this particular case for some odd reason.
> 
> Be honest: "blacklist" is a technical term where the actual meaning has no
> negative connotation despite what people outside the field might think. But
> apparently we don't care about the actual meaning. We also don't care about the
> historical meaning or etymology. We only care about... well if not about the
> meaning in the past or present, then I don't know what. Looking good in the media?

Blacklist most definitely has a negative connotation in technical use.
You blacklist devices that don't work properly, you blacklist drivers
that don't work for your hardware, you blacklist domains that are
sending spam or trying to mount network attacks on your servers. Things
on the blacklist are "bad" in one way or the other, that's the reason
they're on it.
