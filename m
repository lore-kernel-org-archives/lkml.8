Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFCC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D925724673
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRC+I6Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgCDSNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:13:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35665 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:13:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so1369816pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hO3w4DJRn7wTnz66wgWmC++WgyY9DoLHVWfMImbW8/o=;
        b=MRC+I6IuPV6i8l4nSO0sW2+Ske/TqndiMSE3AxrrUaGT0c+zsVsFNOA0AdsgeSdxaY
         wLcg8ECuDYkTG40t4WEVikBHsMUXIXNz0thls9PuvC14LtzJlgC+yiw+mnwcYqD8ABmk
         /+XAkn4ZLwqUqi8dU6gNFCIXzXZfOWgOyQAsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hO3w4DJRn7wTnz66wgWmC++WgyY9DoLHVWfMImbW8/o=;
        b=ipelihwuqPScUFBiLRIxeKypX5MZjNPf0mao9a7kmBk6Ctai0Hyw1/GAeQRbSekzBR
         HNALAyRitKtkdFrmaI5t7/DL7D7t15DaWeFl93q09Bp9wrMS+w1iM4cIYVW30EC5oTHN
         NA3bsLNFVH4+x7JPz0VgHpKHE7UqgWkcA2yCzed7QIBllaUraVmaT1miqRiiWFnLqgfG
         P3k4aBFwFAGpK1+bvJcpPnCMzvl/IXxJkfFOOUIxyiDl65GhPHQzGJFLZHbDkC4rC6WS
         S21CEwwH3UvyL2q6Xv+/nqmbip+6iNyGvoOPheZBFsGhb+zJH+9J5BUCWBFyFgNe3YAN
         fskg==
X-Gm-Message-State: ANhLgQ07YZfHsE5Fy2sRoiUQzjh5QjmmRVgaBvaYsW62/F1tgT8XLAMm
        Y3uoyGgUYwuxMjnDh0KgdeyN7g==
X-Google-Smtp-Source: ADFU+vvL8XSLOA0GTBkkKw2dgU6SPfjDqx9VbF027Nkp1x/qfEkrey4TGjVh6Ja3hQMfaMCMT0BRnA==
X-Received: by 2002:a63:1926:: with SMTP id z38mr3591934pgl.303.1583345622972;
        Wed, 04 Mar 2020 10:13:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm28275304pfh.170.2020.03.04.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:13:41 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:13:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
Message-ID: <202003040951.7857DFD936@keescook>
References: <20200302130430.201037-1-glider@google.com>
 <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
 <CAG_fn=U2T--j_uhyppqzFvMO3w3yUA529pQrCpbhYvqcfh9Z1w@mail.gmail.com>
 <20200303093832.GD24372@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303093832.GD24372@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:38:32PM +0300, Dan Carpenter wrote:
> The real fix is to initialize everything manually, the automated
> initialization is a hardenning feature which many people will disable.

I cannot disagree more with this sentiment. Linus has specifically said he
wants this initialization on by default[1], and the major thing holding
that back from happening is that no one working on GCC has had time to
add this feature there. All the kernels I know of that are built with
Clang (Android, Chrome OS, OpenMandriva) either already have this turned
on or have plans to do so shortly.

> So I don't think the hardenning needs to be perfect, it needs to simple
> and fast.

I think it should be able to be intelligently optimized, so I'm all for
finding ways to mark function arguments as "will be initialized" in some
fashion.

-Kees

[1] "Oh, I love that patch." https://lore.kernel.org/lkml/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com/

-- 
Kees Cook
