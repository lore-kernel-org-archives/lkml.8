Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039EF206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elv7wWPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgF3UEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgF3UEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:04:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAA9C061755;
        Tue, 30 Jun 2020 13:04:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so17387820edr.9;
        Tue, 30 Jun 2020 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u9erhzK7ImvW7Me63xkE/C2FsX+wgx90Oi1TUYfz8go=;
        b=Elv7wWPbyW4WWyjNieEXyItwnrQ/wZipO4ByArCj/1szmXRC1JP0IXK534X8TxfyVt
         uUguCh1uZnUJDR+Q6oGwqgO7HucUb0jzvIJYHixIOLcxPIFg4fNq9nFNO0aOKCf2PQiW
         nKlMFerJmnE2vGJ70/fmcOO294PfDV3M9q+oXvUTm3cnjePJqqr/cPUjqLO3A5OvoeVz
         KcZRk1JaH9mTFImjWJjY9Mpg5bQ3b6O52T4ZwdbYxCSeHR9v9vrmXscuqxlk5LyeO7ra
         lYn/FVpEdxbWHBq3FPyzBXAfPINhz9sLbj28zziylbEHVrTMRJkns5mnmJVGepjJiXgC
         Pn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u9erhzK7ImvW7Me63xkE/C2FsX+wgx90Oi1TUYfz8go=;
        b=LtxTICwvCd5ricDcJ4U8XuHcFePDr48UJd93wmqNMkD9dzXSty7mfT9VCpMAdhC6bY
         4Bo+VeWCRMuwhQVnGK2wHtB6xpcHehwNsaTQ+AY84WJI1/1rMR3y86tk49yyBXGwyXjR
         72OQACXdeUxZ7icBRfbYrl5g35KsJKZ3+xww9+4NcNrnkfWC+FbbQ/JkJ8D8h7L5imE0
         uT4X1MzwXEqnfnPe/QkfDAV33rA2ll74dyvAWZqJOM1x4KWXrMdRgYIc3XfmGZsRSOM2
         nam7kXDY3FVAX97WFZ18SCPVHs/ogyK1w4bE3FsFMRYe8NhNaSJp5Kq0BrDjmB6JWMOC
         gB3Q==
X-Gm-Message-State: AOAM530BI9OjHJzarE/H3HWxadx4LVHOyyIpKRAEPSmoqgkJCeKSAFQE
        6fkRpjrQE7hdw8CmoZR+BNDtspSG4p/49w==
X-Google-Smtp-Source: ABdhPJxVC+ClekMUZiNYvRSqqkeUJBo9S66WzVgcpBVBLSThFdbBykuMJuALbM7BAJb+U0ZhqxXn7A==
X-Received: by 2002:aa7:da06:: with SMTP id r6mr13613299eds.189.1593547453184;
        Tue, 30 Jun 2020 13:04:13 -0700 (PDT)
Received: from felia ([2001:16b8:2d31:bc00:cc6f:aee9:d326:7bf7])
        by smtp.gmail.com with ESMTPSA id x19sm3823881eds.43.2020.06.30.13.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:04:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 30 Jun 2020 22:04:11 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] MAINTAINERS: rectify MMP SUPPORT after moving
 cputype.h
In-Reply-To: <20200619213733.GA1105008@furthur.local>
Message-ID: <alpine.DEB.2.21.2006302201510.3966@felia>
References: <20200506053431.7464-1-lukas.bulwahn@gmail.com> <20200619213733.GA1105008@furthur.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jun 2020, Lubomir Rintel wrote:

> On Wed, May 06, 2020 at 07:34:31AM +0200, Lukas Bulwahn wrote:
> > Commit 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
> > added a file entry that does not point to the intended file location.
> > 
> > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > 
> >   warning: no file matches F: linux/soc/mmp/
> > 
> > Rectify the MAINTAINERS entry now.
> > 
> > Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Jiri, please pick this patch.
> 
> Jiri, I'm wondering if you could apply this? Otherwise maybe Olof could
> queue this via arm-soc?
>

I did not see Jiri respond here, he seems to busy. Olof, could you pick 
this for your arm-soc tree?

Thanks, Lukas
 
> Thanks
> Lubo
> 
> > v1 & v1-RESEND: was ignored.
> > 
> > v1 -> v2:
> >   - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
> >   ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
> >   ("MAINTAINERS: sort field names for all entries").
> >   - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.
> > 
> > v2-resend:
> >   - still applies on v5.7-rc4 and next-20200505
> >   - asking for inclusion through trivial tree, as maintainers are not
> >     responding.
> > 
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e64e5db31497..a0fef0c33ba5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11327,7 +11327,7 @@ S:	Odd Fixes
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
> >  F:	arch/arm/boot/dts/mmp*
> >  F:	arch/arm/mach-mmp/
> > -F:	linux/soc/mmp/
> > +F:	include/linux/soc/mmp/
> >  
> >  MMP USB PHY DRIVERS
> >  R:	Lubomir Rintel <lkundrak@v3.sk>
> > -- 
> > 2.17.1
> > 
> 
