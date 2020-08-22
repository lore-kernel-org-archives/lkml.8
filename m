Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F681C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E708D2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598129208;
	bh=Kd7l0YZwvYXyMb0V4y9MVfSiHY89saiwsHZKWk69C4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IH868bvohuuVbsF+/aqD8IFTIcUF/DUkaoEPVuwzeZbIuOHYZoPWj+YQQM/oO7qLK
	 EAMnj5dLO/3No0vyvtW5nrJaUlxqrrkay0YBbca+yun95DXGSTF9Ssb7kUtxvVYv7s
	 s/mWNPXyQbM/36pMJCYR/DTAI0iicn2tTP5Crf3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgHVUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:46:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgHVUqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:46:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so5055046wrw.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Gr2xPffZVQRfoQAWmaOU6SNPwZWSiCj059azzpqn7w=;
        b=OaMVT4EbdV4RWjYta1ctqhMWRCb41FVGDOarUyEFyjmrQjur9o3+VWYe4fy1bnEWuT
         xNtR0QCPTJH1opM3Kw8Jio7P2f/Nc/rT6bT+BVvY3/gstIOBBkFGRThFTmvXBAOCSP5a
         zTBoq2y5pvb2szWgvSY56DoJW40Gtgs+hDx/VTX+nGPtsGOBVQdd9wHnYQbQYxfCYPK4
         6pPBQd4f9ZhBkKhHw4AyoKwcVmEWs3ml9SUdxm1peJrsnpGce/C3rG/523E4NM1njtq8
         wysnC3moLaCegXaeuKUyeIWFMxpN6egVySqmUfRdBvkWkYthqbTEHF5neCARuXXCeNiK
         LFIw==
X-Gm-Message-State: AOAM531EryB4/CmHmIxmubMhOH+3cBGwvbuplBfbmxhWLX+dlxxEIc8i
        2KfsgaKxP43EfxLlX2xCBP0=
X-Google-Smtp-Source: ABdhPJzJ7F1ohCnzWKk78wVbBNfSi0oqyaDYqHUrkCC9qOsbkeGL9hUiLgDPy+LNElntvl6nwoGmmw==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr8503345wrn.10.1598129202990;
        Sat, 22 Aug 2020 13:46:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id j24sm14532716wrb.49.2020.08.22.13.46.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 13:46:42 -0700 (PDT)
Date:   Sat, 22 Aug 2020 22:46:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
Message-ID: <20200822204640.GA8064@kozik-lap>
References: <20200821165221.32267-1-mmayer@broadcom.com>
 <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
 <20200822164619.GA24669@kozik-lap>
 <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
 <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 01:21:47PM -0700, Florian Fainelli wrote:
> 
> 
> On 8/22/2020 1:14 PM, Markus Mayer wrote:
> > On Sat, 22 Aug 2020 at 09:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > 
> > > On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
> > > > On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > > 
> > > > > On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> > > > > > We would overrun the error_text array if we hit a TIMEOUT condition,
> > > > > > because we were using the error code "ETIMEDOUT" (which is 110) as an
> > > > > > array index.
> > > > > > 
> > > > > > We fix the problem by correcting the array index and by providing a
> > > > > > function to retrieve error messages rather than accessing the array
> > > > > > directly. The function includes a bounds check that prevents the array
> > > > > > from being overrun.
> > > > > > 
> > > > > > This patch was prepared in response to
> > > > > >      https://lkml.org/lkml/2020/8/18/505.
> > > > > > 
> > > > > > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > > > > 
> > > > > Your Signed-off-by does not match From field. Please run
> > > > > scripts/checkpatch on every patch you send.
> > > > > 
> > > > > I fixed it up, assuming markus.mayer@broadcom.com is the valid email
> > > > > address.
> > > > 
> > > > No. I have always been using mmayer@broadcom.com since it is shorter.
> > > > That's also what's in the MAINTAINERS file. Please change it back. I
> > > > accidentally used the long form for one of my e-mail replies which is
> > > > where the confusion must have originated.
> > > 
> > > I'll drop the patch then. You need to resend with SoB matching email.
> > 
> > Oh, I am starting to see what's happening here. This is new and
> > apparently due to some changes with the mail server setup on our end.
> > 
> > I have this in my patch file:
> > 
> > $ head 0001-memory-brcmstb_dpfe-fix-array-index-out-of-bounds.patch
> >  From 6b424772d4c84fa56474b2522d0d3ed6b2b2b360 Mon Sep 17 00:00:00 2001
> > From: Markus Mayer <mmayer@broadcom.com>
> > Date: Fri, 21 Aug 2020 08:56:52 -0700

Which means your patch actually passed checkpatch on your computer so my
comment about running it was not smart... :)

> > Sending patches like this used to work. Clearly our SMTP server has
> > now taken it upon itself to rewrite the sender e-mail address. I
> > wasn't expecting that. Let me look into it. Sorry for the hassle. It
> > was not intentional.
> 
> Yes, if you used to use the SMTP relay server which did not require
> authentication for internal hosts, and now you use smtp.gmail.com with your
> broadcom.com username, the SMTP server will rewrite the From: to match the
> username used to authenticate with the server.

Markus' patch did not go via GMail.  It was the Broadcom server which
mangled the things.  The email headers:

  Received: by mail.kernel.org (Postfix)
  Received: from rnd-relay.smtp.broadcom.com (rnd-relay.smtp.broadcom.com [192.19.229.170])
          by mail.kernel.org (Postfix) with ESMTPS id D5B3B20702
  Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
  Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
  From: Markus Mayer <markus.mayer@broadcom.com>

Neither kernel.org nor my final server (Gmail) cares about usernames in
From fields of some specific domain.

I guess you could try configure you git send email to use email of
"markus.mayer" while keeping Author "mmayer".  You have to configure git
send email for this and such configuration results in proper two "From"
fields which maybe smtp broadcom won't change.

Best regards,
Krzysztof
