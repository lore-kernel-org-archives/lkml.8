Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED5720774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCHvi1Li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCZVet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:34:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33940 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZVet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:34:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so7632515otl.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7KjE8BYPTcZLDCq97CWYYuDqmaiTRHZ/8n160jP2as=;
        b=nCHvi1Li6nSC3/MTflGTFbq3zzKLbQfrKrJVdNTR5ttDdWG9uyOi1b/HOeNc97o/L6
         /3/NdGHtRrVlU7L07XCvOppt4NuwkrG40M5kWbY+XlHt1UvRwo4w7C94sDaZ/cbq2MTv
         PZoVEykvipXRECpY/7qLcKogxXa4mTw+tZ2D9u4l760s1toTobReOvf5Pz5h3Xj8fqmE
         21FZeu6Lh7M8e4aItk+1MevDMxiESHgQaC8o86wj+sq5aDMkGVuqFPmG+7r/4GVXDKEb
         yqgMcTC+5G6nwqQGowaRIkJC4XBbRoPk1QG1GfkL6KTQZbzGbNj0CrUzETXrJf3J3O6/
         73FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7KjE8BYPTcZLDCq97CWYYuDqmaiTRHZ/8n160jP2as=;
        b=ACCdtUsGP5lKiyuiaO7zbgx2WkhVmjnW63wo0m8Q/KzO1nYtGQOt0eNuG3ITEWTx/9
         KMR+NM2oJIrRIhNM+JVic2rIEP6t1sZVgZ31kZJnTgCCykSp84CQgIp5WS4d6Q8O7E9R
         MjJqQRQnSvEAL3PTiDCGC8X3H416R6Vxkwd3DUUPm2kENO6G0aFtdcK8HDT4ir0jNanp
         Ezp00QaIjm6CAYwJtc0tmnj7okuAh+fYQv8gLLFa+6xZL046KJkXd6dERLBeGWf5KT2h
         QWFXLhaoBCqbyNYTRHUW5E0x6MnGeJQs1Ayue1CU+i4LYpOIF6EVDXACeXaTmtwE/UYh
         nbcw==
X-Gm-Message-State: ANhLgQ1qbYIGmx3+ESavlJoFpF+bGVSMVyyUs1Fh6Hlc2DmW8hso4SIz
        PDdUi9+4+1Bf295bq0C/790=
X-Google-Smtp-Source: ADFU+vuPRb29E6lOeJhUVOOagNs1ZZX6ktUsoJcvTDvicoNKKUMPZKBPv5wTN71n4OQm8h6lPbapWw==
X-Received: by 2002:a05:6830:1e93:: with SMTP id n19mr8519892otr.153.1585258487962;
        Thu, 26 Mar 2020 14:34:47 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id v21sm935358oic.4.2020.03.26.14.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 14:34:47 -0700 (PDT)
Date:   Thu, 26 Mar 2020 14:34:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] tracing: Use address-of operator on section symbols
Message-ID: <20200326213444.GA390@ubuntu-m2-xlarge-x86>
References: <20200220051011.26113-1-natechancellor@gmail.com>
 <20200319020004.GB8292@ubuntu-m2-xlarge-x86>
 <20200319103312.070b4246@gandalf.local.home>
 <20200326194652.GA29213@ubuntu-m2-xlarge-x86>
 <20200326173152.06ef57d5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326173152.06ef57d5@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:31:52PM -0400, Steven Rostedt wrote:
> On Thu, 26 Mar 2020 12:46:52 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > On Thu, Mar 19, 2020 at 10:33:12AM -0400, Steven Rostedt wrote:
> > > On Wed, 18 Mar 2020 19:00:04 -0700
> > > Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >   
> > > > Gentle ping for review/acceptance.  
> > > 
> > > Hmm, my local patchwork had this patch rejected. I'll go and apply it, run
> > > some tests and see if it works. Perhaps I meant to reject v1 and
> > > accidentally rejected v2 :-/
> > > 
> > > Thanks for the ping!
> > > 
> > > -- Steve  
> > 
> > Hi Steve,
> > 
> > Did you ever get around to running any tests? If so, were there any
> > issues? This warning is one of two remaining across several different
> > configurations so I sent the patch to turn on the warning and I want
> > to make sure this gets picked up at some point:
> > 
> > https://lore.kernel.org/lkml/20200326194155.29107-1-natechancellor@gmail.com/
> > 
> > If you have not had time, totally fine, I just want to make sure it does
> > not fall through the cracks again :)
> > 
> 
> I have applied it to my queue. But the code I have in with it failed my
> tests, and I'm just about to kick off another round (I believe I fixed
> everything). And hopefully if it all passes, I can get it out to my
> linux-next branch by tomorrow.
> 
> -- Steve

Awesome, thank you for the quick reply and keeping me in the loop!

Nathan
