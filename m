Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A99C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2552076A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585473969;
	bh=IbVwj74urohLO6ukpWhPasEcU+sKMufjy+/siaOfrZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJAMvRuB+OlyspEyvanYy2NmaBpTikeonMbFIoJrqP50C2Vt5wZ0ei1d4QIs6y3FO
	 EknWYRzJ8xULvaSC+FGmeBy4YnU0/YDG2kAI8TDSIa8Q+1l1PoTGXs3eiXGtZWfgGV
	 p+3p+Sxjme/N/fiZuP4Io4z2o2uCofo4oByrsXZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgC2J0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:26:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46888 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgC2J0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:26:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so17189167wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmNzQK6VicfBeVwdRg4WyVYXgjEapni/LnOyaHJT9EM=;
        b=dvwQlyvtQUkMii5LxQX2zZLTSTox+rgC7sGG19cAR9XjDbjeIJgzR3f37iz9jQ+vKn
         kViHi85qB8JsWEM/RE5ytgakAHYyd37DZciPApHkiN0s+oeMBbseKlr2u9RUuhO1YykE
         1QYTmKeykPbqHyfLuAmrPzFIh0wGEMyRRkwkSAs5tlIRKdNPCFQ07cjFhv5u6siOLOHn
         h5OkKGX3BlOg1Y+C0Zme0x7d0mEi4785E1ItidXjArPtMZ0B7wDC/spUuIAM0VnJeyAp
         we3j+SysFjG+d209lS6jRusTAooJgLMte1hPM8YvlCrisb+y/ADOQSxwL6Vyp0hkAh8e
         vMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmNzQK6VicfBeVwdRg4WyVYXgjEapni/LnOyaHJT9EM=;
        b=XUnlZuxTd4qJvE4kT40UKlhMOezAvA3lFsALFlq+LTPP23iVZHg1JEwLGpVjrGTO4V
         jjjSg0/3UHb01p4PPAiwpXz5exk2D3amiPUpvKL3paB9RmewNP/uzMZ+n7lWLpLrQQs5
         FbdRVvA1G1J9a70XIcQCKM7c/bvBfC0Pv/yfEK3EQkU/29DxyaMwOfe8nVh9hZ8z2LSX
         jyKg5+E/TzxYHUThKbsGrL6zkMTl5Yo/QlnmsapxttZcYavu49WBzKiFKznKr121l5+4
         KAvJ0SwuDOPfFiFa2J1UF8JP/IDVdjn5/wydGn0nqO3msIhLJzo7UEvMhvl7OYjPBsGb
         pWxw==
X-Gm-Message-State: ANhLgQ3IkIUBOufl555EmgnRTt6lktPw9cvxGsaQuC6UUzaSXNjAqA8O
        8T0X8YsO5+ZEXKqNWJOFCoc=
X-Google-Smtp-Source: ADFU+vvJHQy0qyVnMzhtXgXFH9HDd5F7O6XNTKAZ98zJLdrz2i253GMwUmtL4zy/ozqiZjr5MBnIrw==
X-Received: by 2002:adf:aacf:: with SMTP id i15mr6795446wrc.31.1585473965516;
        Sun, 29 Mar 2020 02:26:05 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d13sm6020347wrq.11.2020.03.29.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 02:26:04 -0700 (PDT)
Date:   Sun, 29 Mar 2020 11:26:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Message-ID: <20200329092602.GB93574@gmail.com>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
 <20200328115936.GA23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328115936.GA23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@zeniv.linux.org.uk> wrote:

> > but the __get_user() API doesn't carry the 'unsafe' tag yet.
> > 
> > Should we add an __unsafe_get_user() alias to it perhaps, and use it 
> > in all code that adds it, like the chunk above? Or rename it to 
> > __unsafe_get_user() outright? No change to the logic, but it would be 
> > more obvious what code has inherited old __get_user() uses and which 
> > code uses __unsafe_get_user() intentionally.
> > 
> > Even after your series there's 700 uses of __get_user(), so it would 
> > make sense to make a distinction in name at least and tag all unsafe 
> > APIs with an 'unsafe_' prefix.
> 
> "unsafe" != "lacks access_ok", it's "done under user_access_begin".

Well, I thought the principle was that we'd mark generic APIs that had 
*either* a missing access_ok() check or a missing 
user_access_begin()/end() wrapping marked unsafe_*(), right?

__get_user() has __uaccess_begin()/end() on the inside, but doesn't have 
the access_ok() check, so those calls are 'unsafe' with regard to not 
being safe to untrusted (ptr,size) ranges.

I agree that all of these topics need equal attention:

 - leaking of cleared SMAP state (CLAC), which results in a silent 
   failure.

 - running user accesses without STAC, which results in a crash.

 - not doing an access_ok() check on untrusted (pointer,size) ranges, 
   which results in a silent failure as well.

I just think that any API that doesn't guarantee all of these are handled 
right probably needs to be unsafe_*() tagged.

> FWIW, with the currently linearized part I see 26 users in arch/x86 and 
> 108 - outside of arch/*.  With 43 of the latter supplied by the sodding 
> comedi_compat32.c, which needs to be rewritten anyway (or git rm'ed, 
> for that matter)...
> 
> We'll get there; the tricky part is the ones that come in pair with 
> something other than access_ok() in the first place (many of those are 
> KVM-related, but not all such are).
> 
> This part had been more about untangling uaccess_try stuff,,,

It's much appreciated! In my previous mail I just wanted to inquire about 
the long term plan, whether we are going to get rid of all uses of 
__get_user() - to which the answer appears to be "yes". :-)

Thanks,

	Ingo
