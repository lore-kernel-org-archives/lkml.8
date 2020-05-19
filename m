Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF50C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6599A20756
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNbDK0sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgESJQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgESJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:16:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:16:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so14959128wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvsA9hOlkYDHUBf93/zCtkYfj1yjexkczlakdR3k0gs=;
        b=UNbDK0sm2tqypIANAN/jPZp6rzoJ1aQh6eVSontFFtPNh4rh9zSRomjDjybQIlfNXf
         VPVvRYiTH9FHLyZS5+H1DxyRRa8PUfhzAkQc285OlIDNChHIvhRTEMa3iFG5+YHUt+mz
         E0c8VItID5EdHN6KBfncxV+fRWTUhjgQBD4HNUqxIbGdJ3MsP+Q33rqsi7NEfN6palg2
         fP6aC5P7XG7256vHfpZVT4mNYvGDAv2+hj9/7DZUVWKrBECnEFHMy8XjHBHCVzyUZ+tG
         Lb/N2DbOk+GPuhcY/UDyfzbuUf4i0z3JgGEUOvHo4kEYaegR9RA0rBemIO6lTlPoIR8g
         wIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvsA9hOlkYDHUBf93/zCtkYfj1yjexkczlakdR3k0gs=;
        b=g/liVsXZjC6QSgnu5tFS9GwHm5k9acuHXVE0KsnCT3AFGRsMd673bimvxej+jMOhnm
         w/rX6cPIb3I1Pws8KSVuUsnF6XjO1dQD15td/XNZ4nGgI81p5c+TjO1NfF6cCMAsDqSQ
         /CRWR0i4dNsyGc8GAa7Is1rATAxKslLTmJuFvMHaG16dzAHLzJtqcFi+JD9Rxr2CgsVY
         QCY13qe6vpr1XyjpxP/1EVxyvm+P8C3YJdWXsw8G6hY5hI55QbTkrU7+hywx92IW2Oe0
         5o3Kn3P+c48K3+ALNPekf075AR0IGpFXSrjyRbr3THe4PBFPN/73xrc8kjQTt1UJ62ou
         VQ+g==
X-Gm-Message-State: AOAM5333WEWxJ1gBvkCqwPjHqazkRcYBOa7mAnyyZNSfUrPycNDsaAAY
        D7ETWXKxAiLKNrMbvrQInJA=
X-Google-Smtp-Source: ABdhPJxJ2gDZDn3hvEwAhiB7igo/FQL/uK0t2STq4tAiEqmOU2jl/hNQwcMPOW7xg9lyilYt/j5xBA==
X-Received: by 2002:adf:806e:: with SMTP id 101mr25062695wrk.225.1589879790599;
        Tue, 19 May 2020 02:16:30 -0700 (PDT)
Received: from ubuntu-g3.micron.com ([165.225.86.140])
        by smtp.googlemail.com with ESMTPSA id d126sm3238159wmd.32.2020.05.19.02.16.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 02:16:30 -0700 (PDT)
Message-ID: <a9529da36e73116a65a9bc8bd40b5ef54661e3d1.camel@gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: rawnand: micron: Micron SLC NAND filling
 block
From:   Bean Huo <huobean@gmail.com>
To:     Steve deRosier <derosier@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, s.hauer@pengutronix.de,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Date:   Tue, 19 May 2020 11:16:25 +0200
In-Reply-To: <CALLGbR+MWz82hcC6jrv+MrH6Rhj5McW5vt9V+x4UhiZdsoqkRg@mail.gmail.com>
References: <20200518135943.11749-1-huobean@gmail.com>
         <20200518135943.11749-6-huobean@gmail.com>
         <CALLGbR+MWz82hcC6jrv+MrH6Rhj5McW5vt9V+x4UhiZdsoqkRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 11:32 -0700, Steve deRosier wrote:
> On Mon, May 18, 2020 at 7:00 AM Bean Huo <huobean@gmail.com> wrote:
> > 
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > On some legacy planar 2D Micron NAND devices when a block erase
> > command
> 
> I object the use of the qualifications you're putting in this
> sentence. By saying "some legacy...." you're implying that there's a
> set that does and a set that doesn't require this. Which then leads
> the reader of this commit message to #1 look for which ones this
> applies to vs not, and #2 want to remove/exclude the feature when
> they're using a "current" device. The wiggle-word wording is
> confusing
> and dishonest.
> 
> I've followed this discussion now intently and it seems like Micron
> is
> either unable or unwilling to determine which specific devices this
> does or doesn't apply to. If you are unable to identify and restrict
> this functionality to a specific subset of devices, then the fact is
> it's "all."  Let's just say that and eliminate the confusion. And
> please also update your datasheets to indicate that this is the
> correct algorithm for working with these devices. Better would be to
> issue an errata on the chips and notify your customers. I feel for
> those customers who aren't using Linux and don't know the reliability
> problem they've been tracking down for the last couple of years is
> already known but they don't have any way of knowing about it.
> 
> In your commit message, rewording to "On planar 2D Micron NAND
> devices
> when a block erase command..." is sufficient.
> 
> - Steve
> 
ok, you are native English speaker, I will take this suggestion in the
next version.

thanks.
Bean

> 

