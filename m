Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2FCC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698A52073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/3YJatC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGMFqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMFqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:46:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB911C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:46:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l17so665889iok.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wI/wahgrpcGGXwEJI6DDCVP4TgfBXzG5ONbrhMQCAQ=;
        b=Q/3YJatCQENPGHS3j5tNO8vIdrAr/Qb/GXSSJGSyhFkZ/Efn01VyEar9dCNhyrrOFd
         +dc10pETc3Fjn0EDw3Nl+trFhYN8QixvXsMvwWuWhL4LCHrj3g5cF+d+igOFyOpvM9MN
         WyPt43JgTpuFMGbO2JLD2ze1SGUcMaESOLOGbabaCnKnvNK12tAZeJoea2VJHAZ/G74e
         c/3lvFJhRZOg7bcxSNlZY+FBE/Qi3sU7JqHe345umpKi0q4EEO332e1B6dFCyd2MEhgb
         kw5m4UFAGpK4ASBwOVwF///WgGyPrUknn2OrOwX60YZ/FX7wKCWvMdUjHQx1Zwz8+kHc
         x5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wI/wahgrpcGGXwEJI6DDCVP4TgfBXzG5ONbrhMQCAQ=;
        b=L8LfPFHU1rL9Yi1CaKa8svh/gVZed7It6z6IwycFarxo/8cosZcfQAi+JUYS8sbioL
         ysF2vbE2yG8gwjrUSUfZi1wZwg7HJMSatMHbzDhYgFKgdjUe6gzTMa+Tl6KYUEOTHDYN
         ue/Krv7DhJyXvr32RW4gLkj8KFfWCcCqYk/s+m/oSv7bH4AgU6Au60lRKv6C+h9xtT61
         zKVDiPNKTIeQIuMdEPXvQ8z4i5iqNAUhrpARchK2ILMv4+RPSC+G/QNfl7gKEBE4n81M
         NleU1eOuorAB1k4ySK64nXkp39WHIg2ZevHjcCrYTnew6kXs+TXuQv2LwZMq8EEJDek9
         cHjw==
X-Gm-Message-State: AOAM5325mKu9iZtI+QqHjb72F3PfTNX3JeOQPAxudRn19QYV7JJ8X7Cl
        yYoc+qFkf+SDY/68WiK+nmoMMI52khHfq45TVjzH1dA5Eto=
X-Google-Smtp-Source: ABdhPJxneK0E/u9NuBzLyxX0TgWKQwmJ5eiGW2UkW8SLWZtbJTL1gF2g1hQ69vgKn9Zz3yk2Pcq4l6wiNe59DXySLRE=
X-Received: by 2002:a6b:bb43:: with SMTP id l64mr59127682iof.191.1594619162048;
 Sun, 12 Jul 2020 22:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN2-TTemU8JOnh3YErxe2GH7xtG+EZrF9gn_JWLmMxRag@mail.gmail.com>
 <98b1ba96fca2c6e1a90ce4120b3f3201a3cefd43.camel@tsoy.me>
In-Reply-To: <98b1ba96fca2c6e1a90ce4120b3f3201a3cefd43.camel@tsoy.me>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 13 Jul 2020 10:45:51 +0500
Message-ID: <CABXGCsPUeH=YuxjWVd8Fx7j57qtNuBsoxDfO5aE-D3rwC08foA@mail.gmail.com>
Subject: Re: Beginning 5.8rc1 kernel USB headsets (ASUS ROG Delta and HyperX
 Cloud Orbit S) play sound as if in slow-motion.
To:     Alexander Tsoy <alexander@tsoy.me>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 at 17:15, Alexander Tsoy <alexander@tsoy.me> wrote:
>
> You've probably hit this bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=208353
>

The issue already not reproduced at least on commit git 0bddd227f3dc

--
Best Regards,
Mike Gavrilov.
