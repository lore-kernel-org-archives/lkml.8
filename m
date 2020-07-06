Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A46C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B959920722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2900dOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgGFPx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgGFPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:53:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF4DC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 08:53:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so15607170pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaQi7Xp42ftquKfgwNd6G15TPvj7K9LsvnIqneB2JPM=;
        b=E2900dOp6ACJ2Rm6CME9oay/0h85cf3q6yzSh/VapfNYjWBQz9pWrlJ6JipPzD+tPH
         7b4oYeCKTTv8mcNfjO2fSIyDDD78dsLcpTt2MOEYEjkLTes4QZVrOVXjXB9rW14fBNmw
         UlL1NFzXiL0Q3iFUMOrU5nnao1wywsR8TZ4/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaQi7Xp42ftquKfgwNd6G15TPvj7K9LsvnIqneB2JPM=;
        b=UjSjzP4maeVSbT56FZp6B/cgxBn9mwDyVdZHNw2n0y4j1/yFjTyKaFFwWgiCOpHo7Q
         IhWWYZNY+Xv9sizHabX9lbCI80v8IB2FFzbaEI9mj521eDXXrHBzZNLvyuJlEu1CJwR1
         R+/R1qiY+62gAyCzCZkpwZ3kVvq88hw8xdiiodjj+XlSZkOqAQWMbCFsiqPylzHEMplh
         /6sW+Qn3gSdyEspqajggJKCjydOBloJL4CfPI95YhJUmUEO8iPkbxdPUnGh63v9/cy5b
         vpA3qXIDgJckSxOMjf4N5uJONWGVGpnB9aLEtfqphIzh2ihfuP86hX2n7irzjNcudoSL
         pFpA==
X-Gm-Message-State: AOAM530+NEsH6fyc4KgAwZBdXCEnFMOm9lC4T3Qdog4BGKyWcs46jW8m
        1YIW4bFTXinLJ2WJM7oEVW48vQ==
X-Google-Smtp-Source: ABdhPJyJlovwNXf7zCxj78F7E5i5D4JnbKX+EyYsl0M3/qGMeuAx1r4WbCmBjeR9tYH0R5iv7TEDzQ==
X-Received: by 2002:a62:8489:: with SMTP id k131mr45654008pfd.4.1594050807911;
        Mon, 06 Jul 2020 08:53:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e191sm19488211pfh.42.2020.07.06.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 08:53:26 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:53:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Matthew Wilcox <willy6545@gmail.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, expensivestephen@hotmail.com
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <202007060853.07B4D4F9@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <920e6dc0-628b-9bad-926a-d1238a373cda@infradead.org>
 <CAPM=9ty0tiL_qM_UFv0S0VtARKz_f-Anngc+amDM5LjGAHazhA@mail.gmail.com>
 <CAFhKne9MA_G-UsvBFfX-gZRcu9Gb7Xt7UxQ14MTppdU3X1VYdQ@mail.gmail.com>
 <202007041804.B5E229E2B6@keescook>
 <8c0c1050-3beb-86f6-f184-4687acffd61d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0c1050-3beb-86f6-f184-4687acffd61d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:15:38PM +0200, Michael Kerrisk (man-pages) wrote:
> On 7/5/20 3:10 AM, Kees Cook wrote:
> > On Sat, Jul 04, 2020 at 08:10:33PM -0400, Matthew Wilcox wrote:
> >> Left-right tree makes no sense. It doesn't distinguish the rbtree from its
> >> predecessor the avl tree.  I don't think it's helpful to rename a standard
> >> piece of computing terminology unless it's actually hurting us to have it.
> >> Obviously if it were called a "master-slave" tree, I would be in favour of
> >> renaming it.
> > 
> > (No one has suggested renaming red/black trees, so I think the
> > slippery-slope argument can be set aside here.)
> > 
> > As for the actual proposal on white/black-list, I've always been annoyed
> > by the poor description it provides (and I get to see it A LOT being
> > the seccomp maintainer). I welcome allow/deny-list (though the change is
> > not new for seccomp -- the man pages were updated last year (thanks
> > mkerrisk). :)
> 
> Actually, the manual pages are ahead of the game only thanks to
> a nice presentation last year @OSS from Stephen Kenigbolo :-).

Ah-ha, cool. I think I found it here:
https://www.youtube.com/watch?v=XtS_t3FHWe0

-- 
Kees Cook
