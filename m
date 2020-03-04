Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80890C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FBD24654
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWmmsvlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgCDUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:39:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46313 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:39:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so1528745pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wNgtMzd+gzlBfLnh+JlMLwQ7VKkmR77B7QNl9jJRgI8=;
        b=JWmmsvlvaY1+Xsw8BMsiCecCaQ4C6vdTOgVcJbr16hxEsxKVvuVwmJF73Dg4cwtDrf
         V9iU+A0JOxLHP5L9HO6eHO8pu2LTPKSJScrKnX81yOqMuW1niTm8mGzyyZmEYnKqyYaL
         r//ADjUDdTtGj0GzxlvtVuacqu6ZeK4qcvuEiMiheL4nkpHyJ8uGxznOo7ZvaMtXvPsU
         4V7JGtKe5Gcl4Ow+qJpPF5ZMh3pYXFhXEnO8nwIyshZXY7rCzvQHSECjnI05bhci0Egz
         M4Daq/CBEiVT/mLECdhfvtGdfVNXTX7CqqMgweWmbvsI7tn2aHvYhjIQcf9YMRPP1JSD
         mfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wNgtMzd+gzlBfLnh+JlMLwQ7VKkmR77B7QNl9jJRgI8=;
        b=Q+NvhXFfgJtjz03wKZixi+UxjEOtWhnOYa7zqgIzxGwtccw4koJSPixFPz2UXYYeIr
         jbvYYUs5pYM4Zev/ZA3iLub11SIi1Qg5cyH5FUSgkGJtJhSfWfBxpg2qN8bO10OLYji2
         c0C41P4HbcpH8p2+S3nXvisPfXH2D66Vmmn/wZMoGxuKrh1allP+2zW68927O8/mj8Jp
         T99FUyyPydr2c4fD5lDsbGFd3pxxIrq+15dsJMxZxClzVcXd5aNLMFwuUwGlBRfyo8ma
         iYSUOiIRIGJU9wqQpOI4LQlES9IFV+LN46pJlU5qQpsa69aXiJn+AUjQyCrKoC/29hpz
         dC6g==
X-Gm-Message-State: ANhLgQ2CwG+6Xp2RIV2pXm0Z1aTkPeGXqs9chrIPgTDyC3asXgk6JinF
        +KAo/wY1oE6G93gRb6o85FNB4A==
X-Google-Smtp-Source: ADFU+vtdNfS/21YQBCu3RzuP8szM7y2EJjTVf2/6DbhY7+hK9OOE3GcBbqDmMsZNViPQRtxGytPoTA==
X-Received: by 2002:a63:565e:: with SMTP id g30mr4080275pgm.206.1583354394350;
        Wed, 04 Mar 2020 12:39:54 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g16sm29970389pgb.54.2020.03.04.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 12:39:53 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:39:52 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
In-Reply-To: <beb7abda-2648-aae7-31c5-51da6f02380a@suse.cz>
Message-ID: <alpine.DEB.2.21.2003041231020.260792@chino.kir.corp.google.com>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com> <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com> <202003031820.7A0C4FF302@keescook> <beb7abda-2648-aae7-31c5-51da6f02380a@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020, Vlastimil Babka wrote:

> > Seems reasonable!
> > 
> > For the race concerns, should this logic just make sure the resulting
> > order can never shrink? Or does it need much stronger atomicity?
> 
> If order grows, I think we also need to recalculate the random sequence for
> freelist randomization [1]. I expect that would be rather problematic with
> parallel allocations/freeing going on.
> 
> As was also noted, the any_slab_objects(s) checks are racy - might return false
> and immediately some other CPU can allocate some.
> 
> I wonder if this race window could be fixed at all without introducing extra
> locking in the fast path? Which means it's probably not worth the trouble of
> having these runtime knobs. How about making the files read-only (if not remove
> completely). Vijayanand described a use case in [2], shouldn't it be possible to
> implement that scenario (all caches have debugging enabled except zram cache)
> with kernel parameters only?
> 

I'm not sure how dependent the CONFIG_SLUB_DEBUG users are on being able 
to modify these are runtime (they've been around for 12+ years) but I 
agree that it seems particularly dangerous.

I think they can be fixed by freezing allocations and frees for the 
particular kmem_cache on all cpus which would add the additional 
conditional in the fastpath and that's going to be required in the very 
small minority of cases where an admin actually wants to change these.

The slub_debug kernel command line options are already pretty 
comprehensive as described by Documentation/vm/slub.rst.  I *think* these 
tunables were primarily introduced for kernel debugging and not general 
purpose, perhaps with the exception of "order".

So I think we may be able to fix "order" with a combination of my patch as 
well as a fix to the freelist randomization and that the others should 
likely be made read only.
