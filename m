Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1AB206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591133000;
	bh=kkx7fGs6jeYVdPKSsMauo1P5rKlO6XDb8G8IY8wNyhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NR7E7v8lpmk5yI2tc8ZCXkBMzMy57QykezxInBatxUaZPxZ0pErKbq+k77/0hWsID
	 z4uB1GIwAGb+H9eI6X2RopL6JjzJZR9RwyVg5BVKBNGysupla3XkDKPfkVYo+SjRQo
	 1ZhKDY0x+ZtTI4/YntFfufVcpYJS9mmrIvPkghzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFBVXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgFBVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:23:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:23:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x27so7070146lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bg4oW0zzhC9DoMLi8s0gmV/2hMWzV2pEV315rgs2iaw=;
        b=QCn5mx8zXRosBimgjKhFTsn+FeGhvDrnReeXotHK6uQy9JXxxeEZAhHc+iXozHQCg0
         YBbNn5UKAcy2/JQotpmW1NtgSYBASdcaAgUeq+zo+TIz43XBTOkK1l9mZ9vhTsMkWeiB
         st+js1iwZWx8t6+ZZV/2EF3DBmjhWLIeWmHiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bg4oW0zzhC9DoMLi8s0gmV/2hMWzV2pEV315rgs2iaw=;
        b=dfNMSpig9kjIZByBt7ZpAWKtjqefzCcRuxvQa+MdUfNCl6gebsUf7EwjY5XHDlIXuK
         RfxeOys6/538195BEsz6y13gva0UJxvt5ILzrDOxXoDzx23bV4TBfPE71R2XcFTkuHWF
         82JKJSto7T9yywaWTFFxB0k3rKNAYVTLg/1TSimq2up2FCERalv47kfJyDRtvZblusNt
         FVZQWTf8BB0DIPogxu6RLmmioPLFk5mJM6DThukLiM8D5Rt/wikPtzVjBy8dFDyQ5/r8
         lH7E7M6qaOsgbDzo7Z4wkc9M7EyW4B/mRpIVqWmCQTEogRiJwxA7wtc9jT2XAFYs0Jqq
         314Q==
X-Gm-Message-State: AOAM533+uTkHXrtB6e1MsHzp7Tk2Kr5TUu7m2V3JAqpiHuq0RhLQ+PQx
        jHjqsQyN/yjFJJ3du+sZOexsTVGKeFY=
X-Google-Smtp-Source: ABdhPJzlUpwvtp6C9jJrzDoPKaKRUWBBaz396JhvzVa80mTPJu1MLhECBvL80kiArznU6fahTHmsWA==
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr157035lfc.142.1591132996800;
        Tue, 02 Jun 2020 14:23:16 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h6sm19863ljg.38.2020.06.02.14.23.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:23:15 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z9so16312ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:23:15 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr489958ljc.314.1591132993601;
 Tue, 02 Jun 2020 14:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 14:22:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB_J6mWkiAB5Z8SdCGR=jr+N5sMVB0wGvrzg1MkxXOZg@mail.gmail.com>
Message-ID: <CAHk-=wiB_J6mWkiAB5Z8SdCGR=jr+N5sMVB0wGvrzg1MkxXOZg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 2:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Some of them are due to your previous mis-merges.
>
> Your commit 937eea297e26 ("Merge tag 'amd-drm-next-5.8-2020-04-24' of
> git://people.freedesktop.org/~agd5f/linux into drm-next") seems to
> have mis-merged the CONFIG_DEBUG_FS thing in
> drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.

Sorry, wrong filename. That should have been
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c, I cut-and-pasted
the wrong path from the conflict list..

               Linus
