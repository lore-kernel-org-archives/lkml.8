Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74668C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12C2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKA+/fFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgA1H1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:27:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39429 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgA1H1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:27:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so617444pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4ysd6ZONvrJekdELS+lflS6Juecahijzrxi9ANa1zk=;
        b=fKA+/fFQ7qPq332zsF2XfZGlJykHcOpSuxmBkE3YhPAaRKVME4MH18/ew49ayqBQ6L
         7k6yukLl9hZ0z9zoqKZUg5QlTflo70PkhO9j0ZUaX257lIxB6pcDJcqPCrg+Vl2i34LP
         hxpUYbcXEJgqkFiZLnZmYHUzxlrOHMLAzeI8kpL2IfBoidoT2mCx1VF0pIQl6xf228bR
         H/GV99f45fOpOVLp2Q69+C9y99im7CtKbdYqc+Sj79BAcJHNbpRw90/wD17oTvFtwkSn
         eX6l/wkA86s235JyOx6izRC++7scd2XRbwGxMrpB90lf1ElUgUi8Kl8UcedEzwyWew2d
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4ysd6ZONvrJekdELS+lflS6Juecahijzrxi9ANa1zk=;
        b=EYesvciA7aqHpZ+Qk4aS0gWlRsp47ctBkmoybShk5m1P+jp4RwEsQgqO7wJvV8KIbP
         6sD8kJMhYMet64u9araeOAaey/4lLfeWuLUIElE7lmQVcrMSd0dTGwOLbRqTMQS8+Bwm
         1KKzgKjGuCGjiERXFJUXLML67imdQ78xEvdUMUHrzh7oSBTGDE4kaoe3upICnyymIY3W
         DdKXtYReF2IVKxBxFa+r9CO75GOGU2UE3/FRea034cxzPyoKa7KDlPTX5KY1jStk2ZP7
         JKl8JSqfXo1J0PXCeFoay3MlmEFHZIr61N3InSjcA3kJx3imcq1nPO2h1u8xvQ081oaH
         7hog==
X-Gm-Message-State: APjAAAW4hHPzJqAdnz2H4oUuVGu4PyUBUtLJlOWvACHrf9VoCTDDxNtP
        1nMIXbMRIci+eUINISJF4Ttw
X-Google-Smtp-Source: APXvYqxF/o1YG/1FN9IWvc8Qyr9wyEgv6+WlfMY5+avAxYLxnnZz2I4pKbgxZObevKoML8QAwBIkCA==
X-Received: by 2002:a17:90a:7303:: with SMTP id m3mr3246741pjk.62.1580196440505;
        Mon, 27 Jan 2020 23:27:20 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:51b:fd92:c4d8:fa98:b986:266d])
        by smtp.gmail.com with ESMTPSA id n4sm18106567pgg.88.2020.01.27.23.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2020 23:27:19 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:57:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>, arnd@arndb.de,
        smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200128072712.GA29071@Mani-XPS-13-9360>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-3-manivannan.sadhasivam@linaro.org>
 <c8fdf0b0-eaec-9672-4f43-f0254d6dbf0e@codeaurora.org>
 <20200127115627.GA16569@mani>
 <c542b098-3c68-2730-87fb-1b679379f9b9@codeaurora.org>
 <20200128063757.GA27811@Mani-XPS-13-9360>
 <20200128072453.GA2103724@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128072453.GA2103724@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 08:24:53AM +0100, Greg KH wrote:
> On Tue, Jan 28, 2020 at 12:07:57PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 27, 2020 at 07:52:13AM -0700, Jeffrey Hugo wrote:
> > > > > MHI_EE_PBL does not appear to be defined.  Are you perhaps missing an
> > > > > include?
> > > > > 
> > > > 
> > > > It is defined in mhi.h as mhi_ee_type.
> > > 
> > > mhi.h isn't included here.  You are relying on the users of this file to
> > > have included that, in particular to have included it before this file. That
> > > tends to result in really weird errors later on.  It would be best to
> > > include mhi.h here if you need these definitions.
> > > 
> > > Although, I suspect this struct should be moved out of internal.h and into
> > > mhi.h since clients need to know this, so perhaps this issue is moot.
> > > 
> > 
> > Yep. I've moved this enum to mhi.h since it will be used by controller drivers.
> > You can find this change in next iteration.
> 
> Both of you please learn to properly trim emails, digging through 1200
> lines to try to find 2 new lines in the middle is unworkable.
> 

Oops. Sorry! Will do it for future replies.

Thanks,
Mani

> greg k-h
