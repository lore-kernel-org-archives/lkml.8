Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266DEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E321720658
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 08:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOw2PCDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHIIhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 04:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHIIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 04:37:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60079C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 01:37:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so3268854pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=effaZxDoaPjAVLtSBxTjGyQSyg5AQ1OCLPD98F6vZZU=;
        b=pOw2PCDNzyhV+BalCz8X7TiYGqtLVoyHeD1Cwg1Fwb41scx8+5bq5Nx/x5+nTylCXl
         OqZTv29FIBO7psYi/Lbrlrqg1ZytFXb/fa8Uwme4rzZQ5hG55aUia5A3QJVOlxALZLnC
         2PluKIdr7iv2U5AaQMLqV5JOG00FgENu/eskg7XG4/BnAoig5V7orHyrtQkKHPaV+z3m
         E+W1QMtk65QPeErY1HF4J5pKSGBVyq0vz3oThSAsLP48/l+dGupq58LJAwg4FjvC+y8q
         6I0/cMJlbNsaouq9Xe4wAeybvdTPanIOVKR1zRCWUZiv214Yo29kRg9R5H3Xh7kgeRlR
         7IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=effaZxDoaPjAVLtSBxTjGyQSyg5AQ1OCLPD98F6vZZU=;
        b=XGJCCbPvmR2dWwKx0vS6HUSN0s0W5b7wncvpi7pYogT9NLA7f3r9Q08xO2+HEkk3f4
         xb2+wbXn7I3VK3MXh6RXDDUR2g9ghdEnnscrmyGL6UMQvaA0V40N7as1Kw27aioiGw1A
         IdwbuzlYU2/a8IkmWgSkCALo7YTPqiktCRcscFQwal31k9yFLkr3v6CLPMgWsPRetKj7
         LMZc8TZ7T+QCmswbfjWHJ8UtyVtrpmjrgFDZTpEdl7d7Tiew1IeDf547XfJZrzlZe9W9
         DEM79rD5YOxm5KfWm6/rsSrC7UtkIBkxHuER5iDe5CxKlwiJm4NZf1uMSQrbB2CcnYmG
         pxQw==
X-Gm-Message-State: AOAM531AFCqPO+cJ1VrmDTGaGayEMl0kTouBUmF5V2OlNjW9FU+H45b6
        5Crd6MSCAMn3lvVEXpmnW/k=
X-Google-Smtp-Source: ABdhPJzJ6PyzofN3DmXQ31M1LSv44ZrdGfruc2zeZg12q1HJ9zZeHmGm9Jhy9S6HFE7F3zuYQ9TREw==
X-Received: by 2002:a63:6dcd:: with SMTP id i196mr707641pgc.70.1596962252669;
        Sun, 09 Aug 2020 01:37:32 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id 25sm18861661pfh.133.2020.08.09.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 01:37:31 -0700 (PDT)
Date:   Sun, 9 Aug 2020 17:37:29 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 5/6] openrisc: signal: Fix sparse address space
 warnings
Message-ID: <20200809083729.GS80756@lianli.shorne-pla.net>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-6-shorne@gmail.com>
 <20200806190449.xqflhmbiiv5btusf@ltop.local>
 <20200808224822.GQ80756@lianli.shorne-pla.net>
 <20200808230842.4bdwrvuz3lbgkcom@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808230842.4bdwrvuz3lbgkcom@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 01:08:42AM +0200, Luc Van Oostenryck wrote:
> On Sun, Aug 09, 2020 at 07:48:22AM +0900, Stafford Horne wrote:
> > On Thu, Aug 06, 2020 at 09:04:49PM +0200, Luc Van Oostenryck wrote:
> > > On Thu, Aug 06, 2020 at 06:07:24AM +0900, Stafford Horne wrote:
> > > > ---
> > > >  arch/openrisc/kernel/signal.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> > > > index 4f0754874d78..7ce0728412f6 100644
> > > > --- a/arch/openrisc/kernel/signal.c
> > > > +++ b/arch/openrisc/kernel/signal.c
> > > > @@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
> > > >  	 * then frame should be dword aligned here.  If it's
> > > >  	 * not, then the user is trying to mess with us.
> > > >  	 */
> > > > -	if (((long)frame) & 3)
> > > > +	if (((__force unsigned long)frame) & 3)
> > > >  		goto badframe;
> > > 
> > > Same as patch 6, the __force is not needed.
> > 
> > Thanks,  I thought this was complaining before, I tested now and there is no
> > problem so I must have been mixed up with something else.
> 
> Sparse should have complained with with the cast to long but
> purposely doesn't with unsigned long (or uintptr_t).
> So, no mix up, I think.

You are right, I noticed that right after I sent that email.  Thanks a lot.

-Stafford
