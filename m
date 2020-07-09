Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71332C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AB62070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594282699;
	bh=s7XIds1eruA+Gzxbif6QMcB+BjO87Ln768NMv9ihoxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ULCQBGt9GaNg9hKNPVP7DIDzNHhNdZoxxMqcx8p0/VsGOhgVJp+OvJJbvHg0v/UzM
	 uMnyfyvJ61rmm0KfHPb7GTVPkYZscc+O0S0TLweB89vfcUbVmkWSNsGn6vepFhfGaj
	 KeOdItx/DBL1dMPTAr4pIYGYGhb5bVy70H5d3e/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGIISS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:18:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40412 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgGIISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:18:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id f2so1345026wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 01:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sepqVQOjzQvJiSCh/8vOPtsthbitpZEiGbAn8HBa/z8=;
        b=lhlr3YkEmDqhJ/1u6yXqFKZO0yKBx69vm25gG0Ewt+iBcf46zb3lYiymz0b3kxHnq7
         xj1KT5ykECsO2TGi26K/MImvMZZp1YW80fcjNeF+DMl4xL9GtMdvvskapsb3M8W3S4qq
         nipCaxz9jZ/f37WNUjQ+itgdbHzVv1wfSBJKTwYUKD4tR1vy1DTRw/AL1jokEeTfne7G
         aalJk+pYqBHYX0xTkcfeL/QGkvjpjQJyp9jVJUHGHxvjzzSN+6cdqZouTjWZp6lIXLw+
         OZ/KE+eQfd2RUP63HI/j3TFtCRKw6wBfa2/mDbcuOvhD+sQjdWutH4VEf0y+8thKfVvS
         jkcQ==
X-Gm-Message-State: AOAM533j1St/Tt8sAJ8h1E8NOklDWk2HJFqbTI6UKYvLOucmn4rbqnea
        U5sEnNi3JWT+6/JvTWYG5AY=
X-Google-Smtp-Source: ABdhPJx1RzMKlSFTEJXpVfhAum9xG36F8crT8y5bzsVvjlBHnhyyn9NUEXp1RKb0byqUZDSXl9qUXw==
X-Received: by 2002:adf:94a1:: with SMTP id 30mr31427064wrr.37.1594282695190;
        Thu, 09 Jul 2020 01:18:15 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id k20sm3588934wmi.27.2020.07.09.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 01:18:14 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:18:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] doc, mm: clarify /proc/<pid>/oom_score value range
Message-ID: <20200709081813.GD19160@dhcp22.suse.cz>
References: <20200709062603.18480-1-mhocko@kernel.org>
 <20200709062603.18480-2-mhocko@kernel.org>
 <CALOAHbAezHHN58cn0unLNbOjHJyYW=zhzQxpQD8_rD4O7qmYRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAezHHN58cn0unLNbOjHJyYW=zhzQxpQD8_rD4O7qmYRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-07-20 15:41:11, Yafang Shao wrote:
> On Thu, Jul 9, 2020 at 2:26 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > From: Michal Hocko <mhocko@suse.com>
> >
> > The exported value includes oom_score_adj so the range is no [0, 1000]
> > as described in the previous section but rather [0, 2000]. Mention that
> > fact explicitly.
> >
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  Documentation/filesystems/proc.rst | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 8e3b5dffcfa8..78a0dec323a3 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1673,6 +1673,9 @@ requires CAP_SYS_RESOURCE.
> >  3.2 /proc/<pid>/oom_score - Display current oom-killer score
> >  -------------------------------------------------------------
> >
> > +Please note that the exported value includes oom_score_adj so it is effectively
> > +in range [0,2000].
> > +
> 
> [0, 2000] may be not a proper range, see my reply in another thread.[1]
> As this value hasn't been documented before and nobody notices that, I
> think there might be no user really care about it before.
> So we should discuss the proper range if we really think the user will
> care about this value.

Even if we decide the range should change, I do not really assume this
will happen, it is good to have the existing behavior clarified.

-- 
Michal Hocko
SUSE Labs
