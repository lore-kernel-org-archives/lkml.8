Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A0C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB391206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1O7lCLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgEDO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgEDO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:57:19 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F949C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 07:57:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b24so10017813lfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXTeEx6IisqAOCmfPVwDlnFlnDkJiSAj9MRHccmyI/s=;
        b=f1O7lCLc9F+EoW79NTRjesPk5eQ7p4Q7MnxAp+szu+ekyG67HHuZaHvrobdUzOqBlb
         yxPAcF6Rs6WCFXCs4xqx5LEJ4GGkKVujqbgVq9W4LCfPYWNecwVz+m0SBfRVrXYINYKo
         yLmS5ygJkWMdj3uUMxFXDwwSobIvM4pzAw1+2UFB5+XOnVwN0y9pLSOq4yTLfyX4xxav
         1BzzHnHZ096oMNL+SaMPBB0D7qGRTnxD13SNoNHNIILeSzitLEO2SFfMC1sVuuY8RJT+
         UZ58sL0B1Mzmxy6NSJbmzTax5111MpmwldblyZhlWiaGY/fMAkXVTB5bSCMQ4i9oDf3B
         nGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXTeEx6IisqAOCmfPVwDlnFlnDkJiSAj9MRHccmyI/s=;
        b=jtENcCYts57DnKllh0XPcT4/4C9zv2ZUTE0/79EZOoHV0uDPVSaCtvPyc+LYexODCu
         LdrSR8b1H/MuN47scV3wCKikrdCuX9Up59vtdfmyPnuBH1OGtqae2xL4OfdLXIQ3vMRi
         vpR69Sq93NFB3DRWJeF82UnlpiOSuWhgwhtJ3D1jXYHL2V1eFtiesNUx/YtbFv0VQKOB
         ViWuf0Ku4XW64fL/OzsA3qfGWypVnt0EKPvIWi9Obew53C3dnB1jYWyTJhuDIlD6SWoW
         2K/weS9pWYjIlNCMt/90OHPl6Mv8pJABIeWV0r3dP9bna9e5VfwgniRd6zhsI6RErhCc
         fLww==
X-Gm-Message-State: AGi0PuaI8ZfgE/R3sLHtFI7gLMQJ1wr8nruZUMQo+wUPdO3oRs6PcAsN
        XKCer9gHLPilJmEzYSfCheCLERpEXY19zRzxucsyBg==
X-Google-Smtp-Source: APiQypLeWlS/2tJFxpoWroiqoFWA9TyTM5cYPxWBjGApMajaaMz7gQOa5MU4ttHNy7FkO2WJK1Rul1KNGmjOa5S7i08=
X-Received: by 2002:ac2:4466:: with SMTP id y6mr12025645lfl.125.1588604237015;
 Mon, 04 May 2020 07:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com> <939b6744-6556-2733-b83e-bf14e848dabd@I-love.SAKURA.ne.jp>
In-Reply-To: <939b6744-6556-2733-b83e-bf14e848dabd@I-love.SAKURA.ne.jp>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 07:57:05 -0700
Message-ID: <CALvZod5T9pYG1xVHqNM=c68jgKPVXtKjuvV0DSAR+Ld_Mm1c4A@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 7:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/05/04 22:54, Shakeel Butt wrote:
> > It may not be a problem for an individual or small scale deployment
> > but when "sweep before tear down" is the part of the workflow for
> > thousands of machines cycling through hundreds of thousands of cgroups
> > then we can potentially flood the logs with not useful dumps and may
> > hide (or overflow) any useful information in the logs.
>
> I'm proposing a patch which allows configuring which OOM-related messages
> should be sent to consoles at
> https://lkml.kernel.org/r/20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp .
> Will that approach help you?

From what I understand, that patch is specifically for controlling
messages to consoles. The messages will still be in logs, right?
