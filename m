Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E255C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F1020672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLJUInBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGIWRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:17:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 15:17:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i14so1592117pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FiAy+9W4WVzXTp4F7MCeeffFT0MFu1Vbn8lNj/ZUnd0=;
        b=FLJUInBtJ6m486Lvow5lgZgLXj19Nr38WvIIlQmB1sCr0ztBeL80VtD00uqBI2jgr5
         5jzWtAQhSDgEo/9eG9XPHKpBP59CKYxibi2ZKuoJgjbpoEIuRUNFgAIEeNcLXOFDYbwk
         A7LPf8KMo8DnKy3Bd6Eej8jfZYMOnBjnKEb4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FiAy+9W4WVzXTp4F7MCeeffFT0MFu1Vbn8lNj/ZUnd0=;
        b=VX13xVe4zGiCOxIr90ftx4zAyTScwZ1BwJSKDw4vLiKooM3Y4Y5Y5IamSfqXvfJxWn
         cxgXUbWRzYqVCixphv8GcDWupdek+UB0BAN55CvKLmq3ttTn0w8vw0Opxlcdz6giVJl7
         l6KujD8wm+Qe0vXaiAf/LLQiYxYwOGyzO6Xo+HICBWbyQB0/z8lHCsGsaA1uCtNQCRS+
         QqzR3TFW+NmUpzGiT/L7AfVlo34lAVPopE7ZYkySFFYAOiaUXZy0CdpCfKRlWGmMsbNR
         Nh7SCcGk57FGq/kLrN7pa/IKpnGS6DWNBbRgrC1Gxh7DFVhSnAAaGTC2aPGWiTqVQBqp
         XmCQ==
X-Gm-Message-State: AOAM531+BHZtr9ojCBCMdPdOtSbDU05U2V2U0GFu9y7eHhSqAvDP0ZUt
        IGJ8T1xv3RNM/6qHLaPtswGDEA==
X-Google-Smtp-Source: ABdhPJwx6ges8PBNafGeYIpzQB0HxoBrCSMLNc4bkVT6yAMYOm4wSbWW8AR2QXLoowJyBH67sH8o/g==
X-Received: by 2002:a63:5806:: with SMTP id m6mr16772223pgb.362.1594333024182;
        Thu, 09 Jul 2020 15:17:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm4030088pfe.174.2020.07.09.15.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:17:03 -0700 (PDT)
Date:   Thu, 9 Jul 2020 15:17:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <202007091515.EC09267FC@keescook>
References: <202007091110.205DC6A9@keescook>
 <20200709204255.GA29288@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709204255.GA29288@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 09:42:56PM +0100, Will Deacon wrote:
> On Thu, Jul 09, 2020 at 11:11:30AM -0700, Kees Cook wrote:
> > The security contact list gets regular reports contained in archive
> > attachments. This tends to add some back-and-forth delay in dealing with
> > security reports since we have to ask for plain text, etc.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Documentation/admin-guide/security-bugs.rst | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> > index dcd6c93c7aac..c32eb786201c 100644
> > --- a/Documentation/admin-guide/security-bugs.rst
> > +++ b/Documentation/admin-guide/security-bugs.rst
> > @@ -21,11 +21,18 @@ understand and fix the security vulnerability.
> >  
> >  As it is with any bug, the more information provided the easier it
> >  will be to diagnose and fix.  Please review the procedure outlined in
> > -admin-guide/reporting-bugs.rst if you are unclear about what
> > +:doc:`reporting-bugs` if you are unclear about what
> >  information is helpful.  Any exploit code is very helpful and will not
> >  be released without consent from the reporter unless it has already been
> >  made public.
> >  
> > +Please send plain text emails without attachments where possible.
> > +It is much harder to have a context-quoted discussion about a complex
> > +issue if all the details are hidden away in attachments.  Think of it like a
> > +:doc:`regular patch submission <../process/submitting-patches>`
> > +(even if you don't have a patch yet): describe the problem and impact, list
> > +reproduction steps, and follow it with a proposed fix, all in plain text.
> > +
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!

> 
> Hopefully "plain text" implies unencrypted as much as it does "not html".

I decided not to write a paragraph about how security@ isn't a
role-account with a separate GPG key etc etc. Those cases are rare
enough that I don't think it (yet) warrants a paragraph here. I want to
strike a balance between "all your questions are answered" and "there's
too much here for me to find the answer to my question". :)

-- 
Kees Cook
