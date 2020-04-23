Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC5C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9BF20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR8hDR+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgDWSrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgDWSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:47:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BD9C09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:47:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so2696233plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+wAZ+L0hlrTQ6+bTifPXFWaL5DgCyVYBW9QyGb8kMY=;
        b=bR8hDR+mzaoHgNGpJnRn8ZAiHrQhaMuIfSSzHSRsOLKXDNe6eSKFZKgF/RExSQxrcJ
         ef5vSFdlC/FV9+MMy8uFld+YVf1Sg6Q7ZSZLiyq9DHUtyPChN7BtLaIJC1CAmfygQ3vd
         j8ubSnVyDQO5RohKa1DORoZltv0uzh9zK6B8PKdYLOJu0QaDaR82zQ2DIjkybEaKESWA
         FSljcBim1JbTXgPXTH2wNuXj1R78lrDDRc11FiS4GNCLzuNny7yZAq3SXYUQSHVtJ1IO
         zzkDVGBb5PeNel3SfOVpCZ29nKGXlcA4CWgmwX9awHlJYgCDB6JtUrvoAVX44/b2uW8W
         QA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+wAZ+L0hlrTQ6+bTifPXFWaL5DgCyVYBW9QyGb8kMY=;
        b=Px6j4JABp9BTiaxKYe5AitKPoOgdmQ8qOdYD5ucIik/ZqcdtPIMYdG09lmKAlKzFTg
         z8oJeTbzYJ3lVqHLUcylg0SHEVAsOuVYLsDkpgqPZ+kbzSEqprjAq+byHaOTAomvFYv9
         4rufv82iy0jNt2GozjdlKsYSRs+fSsQsts+NsYVHa7QDrLi+wGVk0z00QoHg6Ivg9TS6
         A4UX5Gdy1HhbTA40pQhGbMilqfCGDuvH/PhGj3O5KqhYj8G6UAK+0jinND/jnvWeK3fn
         jvFLL09r86FTL71VID1a2RDH0kh7OyEX2j54cojZrO4UZVOpeUpFYG4VfI8lgfP+baA0
         pV0w==
X-Gm-Message-State: AGi0PubX38uPAOwmyGZLj9OEUrtCLXVKLNWS7A+GLicwaaY0s34qTZN5
        HjfLaIrdeFYX/comMRLlo/GKdQ==
X-Google-Smtp-Source: APiQypLGWwTV56tnjOkx9OOlWfrW0Dfh2W2HlNEVLY73VZd8xyW71IIxwv8uE0Bb69TXlpo7+zB7NQ==
X-Received: by 2002:a17:90a:bf8c:: with SMTP id d12mr2153843pjs.11.1587667642270;
        Thu, 23 Apr 2020 11:47:22 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id g25sm3209697pfh.55.2020.04.23.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:47:21 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:47:16 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: support >64k sections
Message-ID: <20200423184716.GA257363@google.com>
References: <20200422232417.72162-1-samitolvanen@google.com>
 <20200422200532.480face2@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422200532.480face2@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:05:32PM -0400, Steven Rostedt wrote:
> On Wed, 22 Apr 2020 16:24:17 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
> 
> > When compiling a kernel with Clang and LTO, we need to run
> > recordmcount on vmlinux.o with a large number of sections, which
> > currently fails as the program doesn't understand extended
> > section indexes. This change adds support for processing binaries
> > with >64k sections.
> 
> Thanks! As you have also Cc'd Matt Helsley, perhaps you have noticed we
> are trying to get this code merged with objtool.
> 
> How would that affect this?

Yes, I saw the patches. If you are copying over code, a similar fix
might be needed, but otherwise I don't see any issues. I also sent a
patch for objtool a couple of days ago to support >64k sections:

  https://lore.kernel.org/lkml/20200421220843.188260-2-samitolvanen@google.com/

Sami
