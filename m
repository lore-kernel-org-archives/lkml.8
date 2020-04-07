Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CBFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A652020730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIG+NjOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgDGStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:49:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37484 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:49:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id x1so1578957plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Suvq4awERSu9bs80SCBq2DlNufQxhmBcC3EIi1++Fao=;
        b=EIG+NjOVoVewtNoSIS22Haj7eCmbPISciyN5tPQN++I7aI2MMgHG4fM9SiURoPOZYM
         AUK3c58YTfua5utr1e+1lOdquYZx7xIQ8EtEyTOGA9VS7DyPBdwR0YSu03BtOSYONXvp
         BylB+tzgBcTby8Y2Fc2Zb9AuYrcicdNU5K5k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Suvq4awERSu9bs80SCBq2DlNufQxhmBcC3EIi1++Fao=;
        b=WP3cb6ETr6lORtzUjB8NUkkC5Ml35/be4/4OcVWWOLLv/R0LSD/+FIJ2GVLkkvuG+E
         rZqmxKXtsDiyXdlbSSAETktkriNrnzAvPBvI+RuCJtIxn9lbHGRkFectx1yKnbT/VtuJ
         V+QnuL/+iBWxqMTJLpVYgA9mOVMOfU4AndsNGBiAO61wGp9g5mfuHMG5Z+KruFbRT3oZ
         JNvQ8m+fJVIymAnpqz0goYXA/WxCAY9UbZPm4PDLVpnNcfRbLtvtesLJ73IcKECWHxZ2
         5ZgMxv6TQIAJ5KOSTJJI4MvMIXtxBvBKiE5YzvYUpz8n21TSr9nZFNRVKh0+l+Q4qlH9
         Simw==
X-Gm-Message-State: AGi0PuYmiVJ5Z2ueCQLIk0oh/s5n1URPlyr3uRxdqxh51txD85s4gDES
        wTW9bq3svSKiQQdBLbEdAc7PWA==
X-Google-Smtp-Source: APiQypImWdEod2WOPZLuEIKsHb0KHHfhhMLuwEViMDiFOA7F6x3uixjEpnBdyM/STfkkYJ0LyxFhJQ==
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr833912pjq.84.1586285374402;
        Tue, 07 Apr 2020 11:49:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w29sm13725421pge.25.2020.04.07.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:49:33 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:49:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <202004071148.DCC2365B@keescook>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <202004070958.CB8A3DA71D@keescook>
 <20200407181325.GJ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407181325.GJ20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:13:25PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 10:01:04AM -0700, Kees Cook wrote:
> > On Tue, Apr 07, 2020 at 01:02:40PM +0200, Peter Zijlstra wrote:
> > > Since we now have infrastructure to analyze module text, disallow
> > > modules that write to CRn and DRn registers.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/kernel/module.c |   21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > --- a/arch/x86/kernel/module.c
> > > +++ b/arch/x86/kernel/module.c
> > > @@ -266,6 +266,22 @@ static bool insn_is_vmx(struct insn *ins
> > >  	return false;
> > >  }
> > >  
> > > +static bool insn_is_mov_CRn(struct insn *insn)
> > > +{
> > > +	if (insn->opcode.bytes[0] == 0x0f && insn->opcode.bytes[1] == 0x22)
> > > +		return true;
> > 
> > I always cringe at numeric literals. Would it be overkill to add defines
> > for these (and the others that have comments next to them in 3/4)? It
> > makes stuff easier to grep, etc. (e.g. we have register names in
> > arch/x86/include/asm/asm.h, do we need instruction names somewhere else?
> > I assume objtool has a bunch of this too...)
> 
> objtool does not, have a peek at tools/objtool/arch/x86/decode.c

Eek.

> I'm not sure what the best way is here, the x86 opcode map is a
> disaster. Even the mnemonic doesn't help us here, as that's just MOV :/

Yeah, I'm not sure either. I guess leave this as-is.

-- 
Kees Cook
