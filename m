Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB85C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B6E2467C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YFJ/kMLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404229AbgBNRIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:08:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33807 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389975AbgBNRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:08:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so9900328qkm.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXvyu0kZf5A1U63q/YhyFfRXYuCW/78tH+0468+IS98=;
        b=YFJ/kMLjchBhiT8aNq0VrtM4AcJeWee2US4hluINe65IunCXS3vJuj4Bkbt4gqrlc9
         xSK8WM66btieYfHnX95r5cKhvH7E17po1pg7gSr6OevWFmVmk8Cql8RHZFeuHCv08hwf
         3/sxsLR7FFiN7OKwP0erO9lLPFlmPWzw4WIgrDmrtzTYg3Eav+OtYw0SPSr59xFJ5kcq
         teKwvCq9AEwvlyWG0mAayZa01tij9LomvrQ+gp5Wr2P3JSgZAUqg2qTZPUv8OPkhrrNf
         kGV8o4do/4/KGXvJrd/ylkT265lwoafDkZa+Ox1SowWFpDIen1G/c3gxYprXLAOJ/fLX
         gJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXvyu0kZf5A1U63q/YhyFfRXYuCW/78tH+0468+IS98=;
        b=qkamqkEhRHaDPqYrF7gNzKLZJVvYdQzQaQ1AW/6dfYtyGwevc3LkZLccYmnPTBolV3
         IkwNYMDTeZVNIWc4D+wi9okjRe2zy7uSRsO/KWzKBB+5e/uCaneWGq845zamdeyaR7gf
         PlljCD5VohhyqSeo4tne5CLE0gjI0vV615USqMmjt8Av49D5pwIBoY0jDd7r1edEJn/B
         qKd0qaNTEfg8SYzU0CCaz79pwPZqL71m+2Cd7UOR+kOi3PKPpc/csJ6O82YepB0fzzKA
         IIbEMHOKBephP6TwL5vKNVgur2fN6Mt9kJkXstU1v28ib4K5Xosb09E+no2MgGSlG4kb
         +5RQ==
X-Gm-Message-State: APjAAAUBk2ASVvKl2pQMjnLsuRiFoxkzahhuw5FzybKBupjZp3wGX5z1
        ZOZ8Ua4f3ttaD0bAl0yhC21OnSt/fhHIlQ==
X-Google-Smtp-Source: APXvYqyT/rOWJB967/ihSOHGw7VRvxvP2mM5AosTsnw/AhWVTsl2iZIE1fPQw2Z1aaAiOiJtR9sAQg==
X-Received: by 2002:a05:620a:13a9:: with SMTP id m9mr3571942qki.359.1581700126842;
        Fri, 14 Feb 2020 09:08:46 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r1sm3538113qtu.83.2020.02.14.09.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 09:08:46 -0800 (PST)
Message-ID: <1581700124.7365.70.camel@lca.pw>
Subject: Re: [PATCH] kvm/emulate: fix a -Werror=cast-function-type
From:   Qian Cai <cai@lca.pw>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Feb 2020 12:08:44 -0500
In-Reply-To: <20200214165923.GA20690@linux.intel.com>
References: <1581695768-6123-1-git-send-email-cai@lca.pw>
         <20200214165923.GA20690@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 08:59 -0800, Sean Christopherson wrote:
> On Fri, Feb 14, 2020 at 10:56:08AM -0500, Qian Cai wrote:
> > arch/x86/kvm/emulate.c: In function 'x86_emulate_insn':
> > arch/x86/kvm/emulate.c:5686:22: error: cast between incompatible
> > function types from 'int (*)(struct x86_emulate_ctxt *)' to 'void
> > (*)(struct fastop *)' [-Werror=cast-function-type]
> >     rc = fastop(ctxt, (fastop_t)ctxt->execute);
> > 
> > Fixes: 3009afc6e39e ("KVM: x86: Use a typedef for fastop functions")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/x86/kvm/emulate.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index ddbc61984227..17ae820cf59d 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -5682,10 +5682,12 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
> >  		ctxt->eflags &= ~X86_EFLAGS_RF;
> >  
> >  	if (ctxt->execute) {
> > -		if (ctxt->d & Fastop)
> > -			rc = fastop(ctxt, (fastop_t)ctxt->execute);
> 
> Alternatively, can we do -Wno-cast-function-type?  That's a silly warning
> IMO.

I am doing W=1 on linux-next where some of the warnings might be silly but the
recent commit changes all warnings to errors forces me having to silence those
somehow.

> 
> If not, will either of these work?
> 
> 			rc = fastop(ctxt, (void *)ctxt->execute);
> 
> or
> 			rc = fastop(ctxt, (fastop_t)(void *)ctxt->execute);

I have no strong preference. I originally thought just to go back the previous
code style where might be more acceptable, but it is up to maintainers.

> 
> > -		else
> > +		if (ctxt->d & Fastop) {
> > +			fastop_t fop = (void *)ctxt->execute;
> > +			rc = fastop(ctxt, fop);
> > +		} else {
> >  			rc = ctxt->execute(ctxt);
> > +		}
> >  		if (rc != X86EMUL_CONTINUE)
> >  			goto done;
> >  		goto writeback;
> > -- 
> > 1.8.3.1
> > 
