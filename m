Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71315C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478512075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596045105;
	bh=B8emZY3q2/WUpiB2hTscZV1YZLKD3nR3u/zwjnJyuiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=f6PoppFaWNSZuXHRs021ZjFY8ck+J2F4G5ySzWv4wkrjRvabyB8Izl/P3gg/G5spg
	 95OdvsqCSjxrPBv2CfaH6BlZLMJAPdFXlGhDo4Vr8LQKUJsMntys1HBtcEexKGU55C
	 l/GVrpP8+wgiD+l9H1Xrn+lRJBz7MWfIQvBmzrHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgG2Rvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Rvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:51:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B0C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:51:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so7887170lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=M8EEzQgedASRzziAlVDiAKTIfPr1kKdI9aJL7xZj35I=;
        b=Avfq4sQKVEg2XPwPbiU8kQbX0afWtDg8GvOGJu3topccu/yIq0pEIwM3DYccHYnHQD
         zz2PpmdVhy3VPbgBuLXyv4eVyZ+O3SEEwjm7dJLAPEv2bYc/ITzzys9gCaaRZM5w1S9y
         O8oQ/aZAjl4SzMP46wY/xkHoH3L+BzhCNNL90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=M8EEzQgedASRzziAlVDiAKTIfPr1kKdI9aJL7xZj35I=;
        b=oK21ab6Bb0mQxkcJn+O7PgX8zzGdPrSv9RF5ThQP6Gt+hYM27IlZ83S8oaz9OhaOyQ
         i6S9zbhcTT8jd7A+/4uR7Wv7C2qUTGHONrVU2mob+WL5it0gvDL5Z0myHUO7VwAiseU0
         QGGT0RXkTCG1B0ODUNw0jxugo3CgnDlTYJBEfHbCeXpuRUvjMee+kbgAWq3oYL3TvyOr
         F/kKuNwXPltKY16QiktJaEBRJV6vZ6Y53uZa8otPL9DM+kQjBYzVwAvNtZhGryuHr2bd
         909C1/OhgJBX/kSO4cQk9blfHUSHLhJfusSTqZJ/TSdyUmeJYWyQHURNoA/dDu/98SjZ
         lnjA==
X-Gm-Message-State: AOAM532mRgnbJ2ihiFRTqK0ZZbATUOc0wahKYgNeo9oqAKMZplckdSoF
        GWiyfNWoJeU1jD/ciR4ObEG6iTdVN3Y=
X-Google-Smtp-Source: ABdhPJzBNdGolOtWTHXT8RiRVgcTa2qCVyaNWWhRHVLogYH3aZqrkF3/+nJXmecogFUw3YKLkWwh8A==
X-Received: by 2002:a19:8295:: with SMTP id e143mr17387445lfd.95.1596045101219;
        Wed, 29 Jul 2020 10:51:41 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h26sm516083ljb.78.2020.07.29.10.51.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:51:40 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q6so26001271ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:51:40 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr14828926ljj.314.1596045099867;
 Wed, 29 Jul 2020 10:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200708131751.334457-1-lionel.g.landwerlin@intel.com>
 <20200708131751.334457-3-lionel.g.landwerlin@intel.com> <CAKMK7uFkMKiwyTFMRASk5L=1NdFqeuKfCh_FHRLg4FxzHpXpfw@mail.gmail.com>
In-Reply-To: <CAKMK7uFkMKiwyTFMRASk5L=1NdFqeuKfCh_FHRLg4FxzHpXpfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 10:51:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD-6phO85fvLMt7rvk5ZwaJ1Q5Zor4urYps6C8vG_Txg@mail.gmail.com>
Message-ID: <CAHk-=wjD-6phO85fvLMt7rvk5ZwaJ1Q5Zor4urYps6C8vG_Txg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v12 2/3] drm/i915: add syncobj timeline support
To:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 5:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Do we have a access_ok_array or so? Instead of duplicating overflow checks
> everywhere and getting it all wrong ...

I really really think you should get away from access_ok() entirely.

Please just get rid of it, and use "copy_from_user()" instead.

Seriously.

access_ok() is completely wrong, because

 (a) it doesn't actually protect from any fault returns, it only doe
sthe high-level check of "is the pointer even ok".

So you can't say "ok, I did access_ok(), so I don't have to check the
return value", and you're actually making the source code more
complicated, and only introducing the possibility of bugs.

Overflow is just _one_ such bug. Missing the access_ok() entirely
because it was in some caller but not another is another common bug.

 (b) it no longer even makes the code faster.

It never really did for the the copy_to/from_user() case _anyway_, it
was always for the "I will now do several get/put_user() accesses and
I only want to do the range check once".

And that has simply not been true for the last few CPU generations -
because the cost isn't in the range check any more. Now allk the real
costs are about CLAC/STAC. The range check takes two cycles and
schedules well (so it's generally not even visible). The CLAC/STAC
takes 30+ cycles, and stalls the pipeline.

>Similar I guess for copy_from/to_user_array.

No. I refuse to add complexity onto the garbage that is access_ok().

Just remove it. It's not helping. People who think it's helping
haven't actually looked at profiles, or are working with hardware that
is no longer relevant.

                Linus
