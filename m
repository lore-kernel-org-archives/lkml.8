Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F91BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771422075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594852635;
	bh=EkTQvvfDhODnxkOSW/i/V5N2QZLjiVhhzF8MvMyM2L8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m2oLtzhg3szkTWM7J5PQXw6o+SXqPZY/KpiDB0xEtXmQFB55r8fxu8aWfOLKhscRr
	 pWmfSHJyRlekLr87fRE+BFqd8SYtjDdUsKE+JrjSPnx+rlCJGAmDj0GV+1Q3AZ5yvz
	 JOFfkMrKiYtRAxFgF9w/E2t7WHiAj/H09SunZLD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgGOWhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGOWhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:37:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38258C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:37:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so4586799ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOWfGZA7k6hIdV7V6n9+qCud/9qKWH+HAC/vZRUdmS4=;
        b=IcGNuUH1BKUwSkrx/EgqlTo6+E7FzXj2OG0iQyabq+IT7BQ15J6Om6PnqPm8pQOCyn
         rUyiPYxoW3SD+O9P5Gjre0iSU5P/IqkJ57KSG+pLGiLP7H5qxi0Cq3Al+RtkjFARW+jr
         BBWRueFACLIYjrd95lHug6pfOL6WEKQMDcvQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOWfGZA7k6hIdV7V6n9+qCud/9qKWH+HAC/vZRUdmS4=;
        b=Gk9UGgMNzFLApbw4y9FFBgKxLaJUe2Jd92OYTHsp/tWOTGJoxe070Xw0R4RMl5lOEL
         F9U/F8ysrOwYKKQT+NpyQyLL+/hkAZjl6gzNdErrmwRPiUxmRY8lrjITHnZAr/Kestwy
         hmvoF0r4xse9GCVwHnYYD0jTgIq/+bKA2ylMXYcZlv9bjrF8z65zRsThfdi8bFqB/uXh
         9Uk5RSh2QJPupbfdcdEp4J+pV1vtVzmc1mD8YUfy1F+sQcnWx6pPsULxuuqbMR2iokCi
         +S4Pi2jt0JGBMs9p6rI7AIOUJlcAGxXtTE5pTQLWnTT59sV+ZRNtgFPgBTr0MOZFGKHE
         mVQQ==
X-Gm-Message-State: AOAM531bZFgop212FSci4tKY0y0eDAtI0VvH8Q26a+DRhpg3KTRTgYbL
        4e2aYZlYvePB8S8W7MNEqkT4tNYW7wA=
X-Google-Smtp-Source: ABdhPJwf+ISlsTmGYTwh2Fw8Nvgw7BnIhz99NN8edkW76n09pjxCCvQqHeLnXkecAYpRQu5WQvYFMQ==
X-Received: by 2002:a2e:b167:: with SMTP id a7mr601175ljm.83.1594852631413;
        Wed, 15 Jul 2020 15:37:11 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o4sm759561lfb.52.2020.07.15.15.37.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 15:37:10 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q4so4663746lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:37:10 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr568865ljj.314.1594852629926;
 Wed, 15 Jul 2020 15:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com> <20200715222228.jf2pv5u2wyhtc5o5@box>
In-Reply-To: <20200715222228.jf2pv5u2wyhtc5o5@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 15:36:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg50=7QJzd4No6HXQEpBAVfL+DbQ5+pq4MyERk0p_p2jg@mail.gmail.com>
Message-ID: <CAHk-=wg50=7QJzd4No6HXQEpBAVfL+DbQ5+pq4MyERk0p_p2jg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 3:22 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Sorry, but the patch is broken.

I should take up some other hobby. Maybe knitting.

But then I'd probably end up with sweaters with three arms, and
there's a very limited market for that.

Oh well.

           Linus
