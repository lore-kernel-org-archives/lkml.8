Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EDD204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SiRgFI/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHGRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:42:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:42:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so1404653plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3or5Uc/EoDqPWURPsRB27O8EdmQJvFJDjXDNilQ2W/o=;
        b=SiRgFI/BFbh9JTxI3YwMHZSDmB7howP4OchHiXcHKJFY8YCK5Q3Wuy0Xwcr4Yi4mft
         pbITlt7SMmCxbYRtE2CxRtDVzUlWU+4RTeRDeFwHpCf0M8E9vKPe0n0cWeW1WcpXti1V
         qUFOlBKxqusGOtX+vNfbIEktsb8Il6URA4hWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3or5Uc/EoDqPWURPsRB27O8EdmQJvFJDjXDNilQ2W/o=;
        b=cakG7yHsOlNUwC7BWL/ViWpudGSgAAAZJ/nrORjYHIGbA3Jr8I+C+cTXd4Qw9dC6bI
         mXJrqdGC/JFlLbtzAWhPSTJLY/URaRsH6jcg3nsfcDFk3BPsa54h5QN3UqjV3VQQ3r78
         +O0w5sOt/ToRXAdEZvytbrv3nPhQUxjM5GRh3zT9z7JH9Q9WYv0GfDXqXnZER0aib7O5
         FdZIrRkt5l6sBvpql6MiMq2UDHdUPx+tcmB6RzW58KIa/WeB8eC/EpmNGxeoD8PWFmn/
         R0yiz8RGQF7vNbFebH+HKc9O50UzX6G7PczzCZvEeH0sdQwrgC5ejJA9OIduN3TSPmXu
         8Mig==
X-Gm-Message-State: AOAM53237myJx62uQPsfHEU93RzpsQYi57mVzV2pRGJcGmf83h1uP123
        hK7bgkgoeHdX/Twc50NypCIWHA==
X-Google-Smtp-Source: ABdhPJwqOqYTYh4JReBUX4c3HOE9kTIdYkHO3Wb+ZMZk+NJndqxFeOBssIAcr7au4wLDl8M1JElxFg==
X-Received: by 2002:a17:902:9f94:: with SMTP id g20mr12241520plq.14.1596822126947;
        Fri, 07 Aug 2020 10:42:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6sm12670167pfb.50.2020.08.07.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:42:05 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:42:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: wine fails to start with seccomp updates for v5.9-rc1
Message-ID: <202008071038.3F308DEEE@keescook>
References: <1596812929.lz7fuo8r2w.none.ref@localhost>
 <1596812929.lz7fuo8r2w.none@localhost>
 <CAHk-=wi41L-OXCPQJi4dtc_7SmYTzXGz0XM=39rjiTNAi2gn3g@mail.gmail.com>
 <20200807173609.GJ4402@mussarela>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807173609.GJ4402@mussarela>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:36:09PM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Aug 07, 2020 at 08:48:46AM -0700, Linus Torvalds wrote:
> > On Fri, Aug 7, 2020 at 8:19 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> > >
> > > On Linus' master, wine fails to start with the following error:
> > >
> > > wine client error:0: write: Bad file descriptor
> > >
> > > This issue is not present on 5.8. It appears to be caused by failure to
> > > write to a pipe FD received via SCM_RIGHTS. Therefore, I tried reverting
> > > 9ecc6ea491f0, which resolved the issue.
> > 
> > Would you mind trying to bisect exactly where it happens?
> > 
> 
> This report [1] seemed related and pointed out at c0029de50982 ("net/scm:
> Regularize compat handling of scm_detach_fds()"). The use of CMSG_USER_DATA
> instead of CMSG_COMPAT_DATA seems fishy.

Argh; yes. Thank you for finding that! That's what I get for trying to
regularize the compat path. :(

> Alex, can you try applying the patch below?
> 
> Cascardo.
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-August/216156.html
> 
> > I don't think any of the commits in that pull are supposed to change
> > semantics, and while reverting the whole merge shows that yes, that's
> > what brought in the problems, it would be good to pinpoint just which
> > change breaks so that we can fix just that thing.
> > 
> > Kees, ideas?
> > 
> >                  Linus
> 
> ---
> diff --git a/net/compat.c b/net/compat.c
> index 703acb51c698..95ce707a30a3 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -294,7 +294,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
>  		(struct compat_cmsghdr __user *)msg->msg_control;
>  	unsigned int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
>  	int fdmax = min_t(int, scm_max_fds_compat(msg), scm->fp->count);
> -	int __user *cmsg_data = CMSG_USER_DATA(cm);
> +	int __user *cmsg_data = CMSG_COMPAT_DATA(cm);
>  	int err = 0, i;
>  
>  	for (i = 0; i < fdmax; i++) {

That almost certainly will fix the problem.

-- 
Kees Cook
