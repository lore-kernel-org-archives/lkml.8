Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF0FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 23:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662AD20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 23:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijV3p0mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgIEXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 19:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgIEXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 19:16:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F471C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 16:16:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so7615345qkc.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kI4V/ahU3BYgz++tM9NELKbYkCbYwuyU++xD5Hv5/94=;
        b=ijV3p0mCyNP0aIoNeFoxWzGUC062WR2YWR1yJFKKgls9VSdNWag4Iq85jjcGd3/7/E
         USPAVpvB/Ua5oUj+PdaK+rjtjOtqocnam+l2t++xOlvXijZnIIXepAPINgONeHhfeJ8B
         pJUqyCML/p+msa50YaasdOnlcYsTqHuCqhb1CLsgre1Czd+eyJOvc5HYZigSkzNw3MAV
         eZKS9LJ+VtJ0U7HVGx+WlaqVl/tctSqHNypmFq6OAzycSfyk1I9S18yPeLGtX47e+h1k
         sATBaLIPz4/K4Wj+hlZxgmBpqLQ6cyOOdwS9vRj/5K1c7P4Jr81SI+lygvF9FGyvYAMO
         dsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kI4V/ahU3BYgz++tM9NELKbYkCbYwuyU++xD5Hv5/94=;
        b=MekNNOmj2H9a1VhGaxGIjlmde1xUgxTk6Jddl5Xznr4P9BhDXuqy2yb4NoSbnaiZ8Y
         +JxOymgQBBlcfU6pN/eEtLMuI9d8WTEBAG6VMaq19rfBomhNzaM+zIQABKWf9kyNgN8w
         mojhuxLr0/GOHVXkj/1wW3/9Z741tcqwFsq/FrRnmTf/cFtMAlFXUGpLUNVln87mXpsP
         oeZNEw/uQRr9qleyoL5aw/j9QthgjyE+DEQAqTi6FIhSLaXgl+vSsKKOMCmOm6xhStSF
         gl1v9d2uY3fKhnuEAVva33oADalx9C5koHk3hXo0RcDM1UmWARZFrf+SYxNDxdTyb25m
         rslw==
X-Gm-Message-State: AOAM5331Vst+0zzXQS0pwsLnxK/Luct4J/eifp0Qaeh8WYDLnHeOnNAH
        MJpDHDGf0j8oWheyooutfvUBT/Hrvlo=
X-Google-Smtp-Source: ABdhPJz9NEVrKYBdps5+v2JxXTVStIbMoGIY5nguP6a3xNOef7gcfAIwRWGErhWXgbimAXF5N6D5zA==
X-Received: by 2002:a05:620a:4c3:: with SMTP id 3mr14499449qks.105.1599347806988;
        Sat, 05 Sep 2020 16:16:46 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l5sm7742648qkk.134.2020.09.05.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 16:16:46 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 5 Sep 2020 19:16:44 -0400
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/cmdline: Use strscpy to initialize
 boot_command_line
Message-ID: <20200905231644.GA1506363@rani.riverdale.lan>
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
 <20200905222323.1408968-3-nivedita@alum.mit.edu>
 <f5a29e70-7d11-16ec-8d72-ed71da4124c1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5a29e70-7d11-16ec-8d72-ed71da4124c1@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 03:59:04PM -0700, Randy Dunlap wrote:
> On 9/5/20 3:23 PM, Arvind Sankar wrote:
> > The x86 boot protocol requires the kernel command line to be a
> > NUL-terminated string of length at most COMMAND_LINE_SIZE (including the
> > terminating NUL). In case the bootloader messed up and the command line
> > is too long (hence not NUL-terminated), use strscpy to copy the command
> > line into boot_command_line. This ensures that boot_command_line is
> > NUL-terminated, and it also avoids accessing beyond the actual end of
> > the command line if it was properly NUL-terminated.
> > 
> > Note that setup_arch() will already force command_line to be
> > NUL-terminated by using strlcpy(), as well as boot_command_line if a
> > builtin command line is configured. If boot_command_line was not
> > initially NUL-terminated, the strlen() inside of strlcpy()/strlcat()
> > will run beyond boot_command_line, but this is almost certainly
> > harmless in practice.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Hi,
> Just for my enlightenment, what would be wrong with:
> 
> (which is done in arch/m68/kernel/setup_no.c)
> 
> > ---
> >  arch/x86/kernel/head64.c  |  2 +-
> >  arch/x86/kernel/head_32.S | 11 +++++------
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index cbb71c1b574f..740dd05b9462 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -410,7 +410,7 @@ static void __init copy_bootdata(char *real_mode_data)
> >  	cmd_line_ptr = get_cmd_line_ptr();
> >  	if (cmd_line_ptr) {
> >  		command_line = __va(cmd_line_ptr);
> > 		memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
> > +		boot_command_line[COMMAND_LINE_SIZE - 1] = 0;
> >  	}
> >  
> >  	/*
> 
> 
> thanks.
> -- 
> ~Randy
> 

That still accesses beyond the end of the bootloader's command line,
which could theoretically be a bad thing: eg the EFI stub only allocates
enough space for the actual length of the command line, rather than the
full COMMAND_LINE_SIZE. But yeah, that was my first version of this
patch.

> > NUL-terminated, and it also avoids accessing beyond the actual end of
> > the command line if it was properly NUL-terminated.
