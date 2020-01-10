Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B5DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD372084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N73cnUbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgAJRez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:34:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33204 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgAJRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:34:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so1470473pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frDYfmzQTI0EMaWE6658ab2eLSTin+SBIqqIVrOqR4c=;
        b=N73cnUbpACZcVh+U2+tEavSUeCYg72+NvztLRhjD8PxdDhZBO/toTy+sZo06+xyJWT
         7X/kNLiFI5luWCkKFZ5rmG4lPcnD75vhs2kMHvEiLpqKyn6RattR7B56K6GmcRJ/8DTu
         0Sblq4/Xn/kRHQBW084fRDko7CEQdEmgfPeDKUXPemAZeGJEZGkiV9d5tVVFvgbII7/2
         y2nvfLCT5ZdokAh9Rn4Gttz28Bn9HF/2skA2nxcTcGvlRDMnxsgguLtl1Ce9kjmqYai6
         Mf2s/afNRqy8V3wU5vomeyDxcyeYG3ZLCbewwRCYCcUWeiRbNV1rEM0Fw8sLGTCI0sAo
         KWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frDYfmzQTI0EMaWE6658ab2eLSTin+SBIqqIVrOqR4c=;
        b=iOZL9z9NYPM9MApK4G0XvYM42c0Ek7IfLp6l1ou5PhzULualPUH/VtZUf050wdIlMM
         CdU93mysw/W2H4gyYgKqqNR9MARHJj465M0Ai84BEjPrrZgDAqibVCfLZTUXvHKwLfdS
         PFaQTOqDLlNnW8dn9WN2MwPzZulwNO84I1x/1Mn84cteZEZ57RFpVKYu4n+f9M1GtPCX
         fysGao0i1CnpnJxX0234bZNrjq97YqrebAMilzEWU+4HoFhXhWXJdgj2rW0QmMi5yP3m
         ZY45PRYCodpsBgMheHuKlQyXYNn5azcDfGZwk8398eLWBoSf4iDSArTE/pzhrR/82knR
         eKgA==
X-Gm-Message-State: APjAAAX02hF4EVdvdS2xNXJSPOa/rP9uqP68kO8D/Gyc8A3lcuBfETnt
        AyvN5BwqwnW5qlXUyunI2crKKyfKAag=
X-Google-Smtp-Source: APXvYqw81aeV66mF8/NqHoOKMbgSJ/YTCR4ry9Wa7zzCUY9UbAII9IooyVAXrOzkufOCfgUyGRUang==
X-Received: by 2002:a62:1746:: with SMTP id 67mr5365085pfx.45.1578677694456;
        Fri, 10 Jan 2020 09:34:54 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id 133sm3686685pfy.14.2020.01.10.09.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 09:34:53 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:34:50 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/nmi: remove the irqwork from long duration nmi
 handler
Message-ID: <20200110173449.rhr5p4lal3aul43g@mail.google.com>
References: <20200101072017.82990-1-changbin.du@gmail.com>
 <877e20bb8o.fsf@nanos.tec.linutronix.de>
 <20200109210225.GK5603@zn.tnic>
 <20200110140549.xqjhrdpxllkvqbuk@mail.google.com>
 <20200110151329.GF19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110151329.GF19453@zn.tnic>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:13:29PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 10:05:49PM +0800, Changbin Du wrote:
> > I added a new function nmi_check_duration(), so shoudn't this check be
> > done in that function?
> 
> Why should it be done in that function? Your patch is removing irq_work
> - why is it doing additional changes?
> 
Just to move all the check code together and be a standalone function.
yes, this somewhat does code refining after the irqwork is removed but
I think it is normal.

> > Don't worry about performance, this function will be inlined by
> > compiler.
> 
> I'm not worried about that at all.
> 
> Btw, why are you sending private mail and not keeping the discussion on
> the mailing list?
> 
oops, typed wrong key. Just added back.

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Cheers,
Changbin Du
