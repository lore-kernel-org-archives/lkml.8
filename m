Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C460C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E678620748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586295079;
	bh=4MWrsrBm5dOOLQJQuXWUv07Ij/HFWZoU4sb7RtDs7Po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lOvJdptTvBnce4jTDgtxZGce9ESC868VQy3axC3J80TEjqT5G/40672c37/aOTU80
	 t74dtc/poIjYjouTPae28N2nIFGcMx7j6lNirLAUesJW5kTqX6w1JOSioj9PodbNZl
	 d/70nPaLKHJBvb72GR0w7KQkR/8It+C4ZFYRtdB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDGVbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:31:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45120 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgDGVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:31:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id f8so3504120lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaANTB9nNT6txCWkp5q0unn31Ph9MDDOGwo0378128g=;
        b=IG+R0/ryQyxsm3aoO9zzMJijTHkszFi1ngFSZdu48/cZWTT+aLwliZsS6eelWRzhug
         Y4uVdfeOZeYoqfZDuNzkFzie3apptpcnSHImYRC3jQuhjNBu1vpBPHVxFh8BADZ/HBCH
         KHCUUNqVfwbgte5zG7M9cn/4DkmoO81yuy+s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaANTB9nNT6txCWkp5q0unn31Ph9MDDOGwo0378128g=;
        b=pK8uQK+hlxoFnp8howi4uv+vRuNGXLycWcPs1eBcrHlcg/Dirhkz0NWHDZkiE3OKPs
         PiM/h1rAfV6BqAeuzxlBMzyGBrXGh3WZLWT8Q1uytnWmiJvNGFaq0SnPPPwZLGGm1HA2
         RFlCkakgayCwMeBQXMe/yS5gXztDTW4HN9TmjU2o75HH7TOWT6GX4KAIgaUIWpi780xN
         qJ4vvFV6qtDZBLKWmCbHHExsw0AcKTDhTGG7OA/WxfUwkV59PZeJU/ph9ZinTfZHt4Qw
         XUb5lgcIDQlqbnuJ7Ofban4E6ciiqpQccjx4J6Ls0X5ZgCLwHjLCR6Ky7DlwJCNk5WSC
         /8EA==
X-Gm-Message-State: AGi0PuZ59aVxjsdviZ8xn9jj6PFHi0g2syBu9NgPlY6FpoW02bDmKdTT
        OtpyOlTGLoi+vmGq7PmBUWhpDbcKfqs=
X-Google-Smtp-Source: APiQypJHXd1/zlz3sbHqqFmS/UNJQ3MYmv0SfGpGCLGVHtyJOuuuIlC3VzCA8PXGgCnd8+T+yKtLcQ==
X-Received: by 2002:ac2:457b:: with SMTP id k27mr2607437lfm.126.1586295074933;
        Tue, 07 Apr 2020 14:31:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id k3sm12460024lji.43.2020.04.07.14.31.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 14:31:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id z23so3535124lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:31:13 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr2619685lfl.125.1586295072951;
 Tue, 07 Apr 2020 14:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407200318.11711-1-longman@redhat.com> <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
 <67c51b03-192c-3006-5071-452f351aee67@redhat.com> <CAHk-=whV5Z4XioUOW0UM-PBrW7iqb0HwWKQU5Vn8b5pmsDm=Ww@mail.gmail.com>
 <20200407212447.GA29554@pc636>
In-Reply-To: <20200407212447.GA29554@pc636>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 14:30:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrZLs=+VkBXS_KWrMwoM2PRmw6mKEPJHRBQ_e3raFh9Q@mail.gmail.com>
Message-ID: <CAHk-=whrZLs=+VkBXS_KWrMwoM2PRmw6mKEPJHRBQ_e3raFh9Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 2:25 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Seems like there is only one place where we can "sleep". I mean when we
> call vfree(). That is free_vmap_area_noflush() -> try_purge_vmap_area_lazy().
> Basically try_purge_vmap_area_lazy() can call the schedule() what is not
> allowed for IRQs. Instead of inlining the try_purge_vmap_area_lazy()
> into current context we can schedule_work(). And i think it makes sense
> from many point of views.

I don't think that's the only case.

Or rather, that may be the only case of _sleeping_, but we also aren't
irq-safe wrt locking.

And I'm not just talking about the vmap_purge_lock mutex, but all the
spinlocks etc we have.

That said, I haven't looked at that code in _ages_. Maybe those things
would be trivial to just turn into irq-safe ones and there are no real
latency issues anywhere.

                Linus
