Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A39C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D56620842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578754209;
	bh=8QvSqOgeVP2rsw7ZCTMW0XoG+gYPPRjf8fngQSBbE1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YXtfA3Ej+iUIO/PIExnInlTJFj0sAnt2Pq6Vg1EGDQsZLN+jeRuM0yE8qz43iXS9Z
	 uFtxkO1JeGMJQJbSOhkwaXUvBV738mlk9p0YqGrjkA7UMoyLVkiPhU/Lt2BOrI8JRu
	 HgMlmhaj0+dZxPCfC1ohg0bWlRgVD1oCD/j4u9PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgAKOuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:50:08 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40877 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgAKOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:50:08 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so2128414qvb.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 06:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XUwSj5JHipKODaQtAqTSVnH1IpII8bzoz4gqZnfsMg4=;
        b=iTc6aLCCoK16p/ElKy6SajpyBAZFAQ5yeBiS1yAGXRrVGgEtvhtJmYjlYDZlMsKkpi
         pLTO8CZgTUyFO4qN7dGm8mtPfuOSByjQ3mltyXZLs4GnYkiVWF7/6kvtyvrKR9h8+C0y
         CJJYIvI8wMAM63twmjovqZLNFcafPF0KLKFes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XUwSj5JHipKODaQtAqTSVnH1IpII8bzoz4gqZnfsMg4=;
        b=RPamLzHZ0lUnwcFo12Xbn3EzE4nsK3xn/aEnuw/Y5yO2K6E4Vblcn7gqpafyqhYB/v
         FkY7Asx0N5v0zHUzCXwYGRpYH/GmGjsuy4tIXnXDA9VOsGvmKjEFx4SN8xtY50+tC7hl
         VKddESo/w3NuOBiA+v8VxNa6lyfSjUXiG9QbnBGRwBvxoPxFMPacegkClDOyniyqH1b6
         PkMHoGzS7uqfYu4DzV3G63wdCwOA9agei3NCeMoHrrV40aFlj7+Lbr6H6iWFrzSoH4/m
         MCM2TxKu/FJmq0FsgaQlCTEokjSWYQLeBg16KvDmDCpzXB7HQI/enmQnyEqPFUbLjns2
         hpVA==
X-Gm-Message-State: APjAAAU/B/tykXiHz5dT80UaqSGv4mQZcMJLFXMsJJlY1uri8tSVILYo
        t9LCSrQnZ33zXZdF/vzHPnoiYQ==
X-Google-Smtp-Source: APXvYqwre4CtUI3xZX4g5Ox6GPGwYsULaFuQmUTA5IjSwjSLV3g8Czjha0JwkWCN1y6BeRbbAK6xmA==
X-Received: by 2002:a05:6214:1428:: with SMTP id o8mr3814903qvx.87.1578754207151;
        Sat, 11 Jan 2020 06:50:07 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id l25sm2323790qkk.115.2020.01.11.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 06:50:06 -0800 (PST)
Date:   Sat, 11 Jan 2020 09:50:04 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] mtd: Fixes for v5.5-rc6
Message-ID: <20200111145004.htnpdf6oaiksryxz@chatter.i7.local>
References: <20200110154218.0b28309f@xps13>
 <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
 <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:38:37PM -0800, Linus Torvalds wrote:
> On Fri, Jan 10, 2020 at 12:31 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Konstantin, can you see what's wrong?
> 
> It's not just Miquel's. The sound, thermal, and power management fixes
> pulls seem to also be lacking pr-tracker-bot responses.
> 
> But Jens got one for block - but that went to the block mailing list,
> not lkml. So maybe it's specific to lkml itself.
> 
> Maybe things are just slow, and I have gotten used to the
> almost-instant responses when I do a "git push" to publish my pulls.

Sorry about that. The public-inbox repository for LKML automatically 
rolled over to start a new epoch (from 7.git to 8.git). This only 
happens once about every 6-9 months and is such a rare occurrence that 
it's hard to properly catch all potential gotchas.

Things should be unstuck now, and at least this particular bug is fixed 
-- hopefully it'll be smooth and automatic the next time the epoch rolls 
over to 9.git.

Regards,
-K
