Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB00C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCE52098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587583360;
	bh=y19iQaF6zElpKu2jsUezwfBR/R7RmCgllha7AezTsmM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=H9gnhFr7xvtEBu9UhDXuV7Bi5cDPAUBs3KvBLXqqCOy5bmJ0ep9ZIAQHlt4LhfpTL
	 VPf06EYIU4AB36LcJOeGWYC7FDzIpr9Ko65N8ziorHUR40MhoQt0MWMwuLKYCEsInZ
	 wAhghh39VkhkSbLFoS91URramQR55ZmJ7miRGC1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDVTWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbgDVTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:22:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF25C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:22:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so3819968wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ggd3OIjBv3dR5xy/lEmsuN9469kzc86BjkEQ6GMIu9o=;
        b=i18Pfsg3/DO5uj5DUYW8ByxiX2qR0HCoQ6oi2b93yaDWT4RH7BY71fn3diHXqLuuLt
         r58fhj6BAJRu+2Daa/ydBbT45hm4aEyNUi8Z/WFW9Wo4fEjDxDWISjhuoeUa8LACT0cT
         p8d5yfoJBFn+Sdt1f/l8h1I4tnCZx8INam0430mUgHdwQ0/XtF0Cv3zgXvKoF5i1M3jd
         Lt4taitDNHhqZISPWpulJIQFjnAl+JD9dMnGwHUXZYjK/3InyNg8pd0rFLCTORO1HGEy
         lnbshhuBvq+kAVbUHMe+Ys0XMkFitcfU+xJEwnS9HGTHgST0MH40uZOpFpJXAi0MKF6C
         Bkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ggd3OIjBv3dR5xy/lEmsuN9469kzc86BjkEQ6GMIu9o=;
        b=BGZkOfkhW6HnuIvq1pXz0L+ZfY8+oSMZFqlpdGSBtGusogvCzzCIhbFeAqs357tIwu
         emwROoL5sl+LTPcwrPzzigxEZEuvMIY+FQ/0fTVVQli4416emuAV72ZMI3CcjOzZjZQF
         /xktbGUkkY8nL1zOsyW0HMTrqvzWHidjf7yt7osSogjxdNHXWSjTc64fsyaB9/4ifiR4
         Vz1dDZFXW4i68Ox/mEQCSYZuCVFjvI6yLoGLBWkVSkztfKqHZnCN7t4LAqaMTRN4vwpP
         1c+zsL38jjzFMdnIWolp5n4GujKVtDPzxrr8omqvEQsNpDGHnRoyAwH+jjvX8Bpb/bOB
         e65g==
X-Gm-Message-State: AGi0PubB3VhTDP7d+2pPNPIGZRmuSMIxKXQZR1a8SU5q8AwSq4s+hckp
        SFiT/Te15tCCB8OPtZQMjCnk2vZ0
X-Google-Smtp-Source: APiQypIvKGsabExT8mWSuvexT41OVi2rEVEmTLZxuXvZ5UBxU/qc06ublrqgIxFQaQm3OZI1v4JwCQ==
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr11379018wmf.143.1587583357728;
        Wed, 22 Apr 2020 12:22:37 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y5sm255394wru.15.2020.04.22.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:22:37 -0700 (PDT)
Date:   Wed, 22 Apr 2020 21:22:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Matt Helsley <mhelsley@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] objtool: Rename elf_read() to elf_open_read()
Message-ID: <20200422192235.GA14331@gmail.com>
References: <20200422103205.61900-1-mingo@kernel.org>
 <20200422103205.61900-3-mingo@kernel.org>
 <20200422114342.GD20730@hirez.programming.kicks-ass.net>
 <20200422142235.GA2840@gmail.com>
 <20200422170048.GA9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422170048.GA9040@rlwimi.vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Helsley <mhelsley@vmware.com> wrote:

> On Wed, Apr 22, 2020 at 04:22:35PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Apr 22, 2020 at 12:32:04PM +0200, Ingo Molnar wrote:
> > > > 'struct elf *' handling is an open/close paradigm, make sure the naming
> > > > matches that:
> > > > 
> > > >    elf_open_read()
> > > >    elf_write()
> > > >    elf_close()
> > > 
> > > 
> > > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > > index f2a84271e807..12e2aea42bb2 100644
> > > > --- a/tools/objtool/check.c
> > > > +++ b/tools/objtool/check.c
> > > > @@ -2614,7 +2614,7 @@ int check(const char *_objname, bool orc)
> > > >  
> > > >  	objname = _objname;
> > > >  
> > > > -	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
> > > > +	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
> > > 
> > > Note that I have a patch pending that makes that unconditionally O_RDWR,
> > > which sort of seems to suggest elf_open() might be the better name.
> > 
> > Ok, done!
> 
> It might be a better name but there could be a problem with it --
> see 8e144797f1a67c52e386161863da4614a23ad913
> "objtool: Rename elf_open() to prevent conflict with libelf from elftoolchain"
> 
> Unless I'm forgetting something I think that'd still be an issue.

Indeed, that's a good point - I'll move back to elf_open_read()! :-)

Thanks,

	Ingo
