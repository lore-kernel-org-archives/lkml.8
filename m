Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D952EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01EB20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585241886;
	bh=zgGTy2wBEludJkWdHzz8qHDYr5ncygsF68vdD3uqArQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pgVL+K3dDe0zRYOiPpvPMLm1dRgxKTNyZKYmowq+NW9yiygkgC0Qh5rFbwJTCiULT
	 m4nqUGKjarHl6qzwdSeBpW8Xk1ig3aEpBAB9iozKbNy+4o1jinmrYOXCio/zs/dmyI
	 98qF0jjraxE68zWTOLb5QnbpTLEy1jXQR+/zMnXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:58:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46339 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:58:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id v16so7114161ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfUkhBFRLFwePrsRa48kFE9ampgS1I4KqeLZEsewsfI=;
        b=QanaqOqz+yuymxm+3w42k8DN3GP1JG+w+QCwpzCUzMsRQbQEJy2otQKTO3Zrug3nS/
         ji+I1auUM2U9F8Hv54+LMMeT0UrZCMm/X25ChNwfSjDjTWPXM44JFhWpdanFMUq9yz5w
         j8osn2Hb38FF3cZG1b6JYRzF60WKLe6TpL6Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfUkhBFRLFwePrsRa48kFE9ampgS1I4KqeLZEsewsfI=;
        b=J1SFCIKawZJwMN4+/dLXQJ1dACmlCSgvvWC2rohQZW1aa/zvXStwMQrXsAj9cQLVot
         uNJD3LTT3274W3HFyvGqeknj41IWw8yjRE6rNBdy0aPhv8NmJkvTxcaG8IWkn4IDba//
         /SsKlJC6K21U0LqxL8hN7zv5FUjsfs1k8JZYoz37yraNl6/l9/ZdJ8uzEBocy/SwzQd5
         JZRGkk2ng1nRnaNubGps7SRBAuurCTp9HVCrAqjEIEG/ZFawgoZpbOTnkM2h1V3RNiqy
         sd0ClqsUq6S5H1tK4dqCrDhHo0ZT4xZWv/iv5RZzg9xzjh9G2EzLTCMHsvoUndPDR7nm
         SIYQ==
X-Gm-Message-State: ANhLgQ0JqOCYUdph1Uvo7tqP510iOhu7QQCSskW41lO0cxGdguU28OPi
        sjIyAGaqXAIm/+d4FBdutMzwAgEr8R4=
X-Google-Smtp-Source: APiQypLLWHdJe/jX0D4wf+OxQL8tGQLj4ucOq7rKIqeciTvRrWp1JdptziyJkfQdPzvMUZKpSDn7EA==
X-Received: by 2002:a2e:9194:: with SMTP id f20mr5994347ljg.33.1585241882591;
        Thu, 26 Mar 2020 09:58:02 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t144sm1877627lff.94.2020.03.26.09.58.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 09:58:01 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id q5so5456425lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:58:01 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr6681163lfg.142.1585241881094;
 Thu, 26 Mar 2020 09:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200326055723.GL11705@shao2-debian>
In-Reply-To: <20200326055723.GL11705@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 09:57:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2c3UcK4fjUR2nM-7iUOAyQijq9ETfQHaN0WwFh2Bm9A@mail.gmail.com>
Message-ID: <CAHk-=wi2c3UcK4fjUR2nM-7iUOAyQijq9ETfQHaN0WwFh2Bm9A@mail.gmail.com>
Subject: Re: [mm] fd4d9c7d0c: stress-ng.switch.ops_per_sec -30.5% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jann Horn <jannh@google.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:57 PM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a -30.5% regression of stress-ng.switch.ops_per_sec due to commit:
>
> commit: fd4d9c7d0c71866ec0c2825189ebd2ce35bd95b8 ("mm: slub: add missing TID bump in kmem_cache_alloc_bulk()")

This looks odd.

I would not expect the update of c->tid to have that noticeable an
impact, even on a big machine that might be close to some scaling
limit.

It doesn't add any expensive atomic ops, and while it _could_ make a
percpu cacheline dirty, I think that cacheline should already be dirty
anyway under any load where this is noticeable. Plus this should be a
relatively cold path anyway.

So mind humoring me, and double-check that regression?

Of course, it might be another "just magic cache placement" detail
where code moved enough to make a difference.

Or maybe it really ends up causing new tid mismatches and we end up
failing the fast path in slub as a result. But looking at the stats
that changed in your message doesn't make me go "yeah, that looks like
a slub difference".

So before we look more at this, I'd like to make sure that the
regression is actually real, and not noise.

Please?

             Linus
