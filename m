Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC78C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE42071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp6OCDY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDZAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDZAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 20:07:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B116C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 17:07:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o185so6702965pgo.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzMxlvsZdY3F2jNP3M1a1yilRwL8c1I8SUF9ftDT+UY=;
        b=cp6OCDY+S7VRLhztJuHqgoNFhYIeXviwHtgxUOsIWNXgyb7fGVgCAL2gh6A4gTqqI9
         asa8exs/QR2SJABOZVusPpmCpgjvSZQHwczndTzNXO8LZKYrbfStGYswukuMG3pRVJtX
         W/t5k36Ps5TucWvy8DmTiHBqsdeWlAOqima0gQ+abAklDC0fb1IVC6tBtd8tWAdMxn86
         RwkRHycg4HrMyhuv8M+Bx3V2qtv0xc9a0MjL5gaKX1LUw4Gh1156QxTE8hamJcMXVnl9
         f/9SOLuHqEEdQ4qa0C8B9CrcGQ5m1MesyiTFD8pW7L+x0NkPeOp24BYBGy92XOdWe+8b
         alaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzMxlvsZdY3F2jNP3M1a1yilRwL8c1I8SUF9ftDT+UY=;
        b=jzg5qj1bAOm4PU7abk5LUjs3RJY1P+j4sGl7BjiaqHbkuqnBvTsFPZXdM6Y5Yt9fMC
         MUbwZOt8EEWAAhpj0l+pKeXQDhu+6lwAQxfnWGzE7NAZUAkuX2XzAaOC6IdhKxR9cqwT
         MVkzBC+rdQ7mPpo82lbiDKj40uJbkNWluemfd8DL0HjbMKgMctUNOCwlj/USU+vfplwQ
         FMCEG3G/T+M6ate80QC4xI5rNMC5cLwXMobDQ2qbf2SpS97EVzK1ZYQNYmoBGPLW9YD6
         KD831HHD472c/0MkZk6t+KHy56j8vOZH14Eo0+6MCg95S4rrMsX7eQKlIe4HegsI7S1u
         YyVg==
X-Gm-Message-State: AGi0PuZDNHIbl7N9NbWjviXOAmzc8Rah75Y24JClB/1NWuYfRK39bKou
        /2drKB8kvQ+IAvni/kiJGDpjYrTp
X-Google-Smtp-Source: APiQypKAsuFitmtwBwKxE3b9+iCnvPp7RR6x1GEzjuAnZGh4D4bTC7dGmBdoZP+Jm2BF7waQ1AxRmQ==
X-Received: by 2002:a63:7c4:: with SMTP id 187mr5984692pgh.59.1587859656609;
        Sat, 25 Apr 2020 17:07:36 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id t188sm7747502pgc.3.2020.04.25.17.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 17:07:35 -0700 (PDT)
Date:   Sun, 26 Apr 2020 08:07:27 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: do not place freelist pointer to middle of
 object if redzone is on
Message-ID: <20200426000727.u2gfxwfsrvme3a6b@mail.google.com>
References: <20200425091338.24283-1-changbin.du@gmail.com>
 <202004251547.0F8E6856B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004251547.0F8E6856B@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,
On Sat, Apr 25, 2020 at 03:48:31PM -0700, Kees Cook wrote:
> On Sat, Apr 25, 2020 at 05:13:38PM +0800, Changbin Du wrote:
> > The recent kernel fails to boot when slub redzone is turned on. This is
> > caused by commit 3202fa62fb ("slub: relocate freelist pointer to middle of
> > object") which relocates freelist pointer to middle of object. In this
> > case, get_track() gets a wrong address and then the redzone is overwritten.
> 
> Hi! A fix for this is already in -next:
> 
> https://www.ozlabs.org/~akpm/mmotm/broken-out/slub-avoid-redzone-when-choosing-freepointer-location.patch
> 
> the above doesn't disable the mitigation when using redzones, so I
> prefer that to this suggested solution.
>
Glade to see it's been reported. But I am sorry that your patch cannot fix it.

With your fix, I suppose the layout of slub is:
|obj-fp-obj|redzone|track|...

While get_track():
	p = object + s->offset + sizeof(void *);

Then we still get a wrong location. I just tested linux-next and the problem is
still there.

Is the right and left redzone good enough to protect the freepointer? If not,
I will send a patch to fix get_track() along with your patch.

> -- 
> Kees Cook

-- 
Cheers,
Changbin Du
