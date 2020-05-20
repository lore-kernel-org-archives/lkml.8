Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D1C20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAMH1927"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgETU7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgETU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:59:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F774C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:59:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so3219972lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/Xdk+2Qjc16LzOVa9lnuQqAqYFbaHhJYfbPjyOMWM0=;
        b=jAMH1927IOAoBJgvE2Gbj2cFEfC8mJsV3BVmnk97PIGu2VwPko5fwcFleC8sU0XF/G
         ITqIoW9YRkeABtk+sSwOOTV+vC5TF+URq5GRPfWFvNrh9ZDc41Ack3poVNcJGSL2iOnv
         ExgXaWUZCNd7yo8NhRoyf0iALymd6I61WzQ9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/Xdk+2Qjc16LzOVa9lnuQqAqYFbaHhJYfbPjyOMWM0=;
        b=hy+YEeGztlBp9gqZwN0oTKLXqes8vxJ7RRWW9RDalo00ZS++vPwxefYCFubRtBhWq9
         juefp6tJ20wdNJcn/9H2OmrrYR8d46nJW64ybSCCtsSca8YlYjbYGuE+chH2AVHeZhio
         8ZY7sikklSj+OvnFpG4GM7zTsJuvhoO28Y7pqooQ5sU/8rUbPMSAl5PQyAyQGW7T5/Hd
         ArgLTU8fckkpoXHemswcNXScruBccMHANth4Nc9N+xE91cNRcKfJEsf3pGfeJW1d4yd6
         faezPkxi/rqSvcv4BBcbfOBKQGAL2Yrv+bWHC2TntsZmu6pegx1s+EFPwq7cUTWCxEay
         jOtg==
X-Gm-Message-State: AOAM530p8bEbVm9f28XSMnr9riJK+w0mb0tBwOjw9NLESBVvhYLrJkT9
        cVPUwqHVjZS9KeUWE/EkTsL7L1uMYTk=
X-Google-Smtp-Source: ABdhPJwXV2MusE6afo0ZkmlW6HKHPLkXxWRp26wge9Ksm4PdMhq/rRRFisyooFSzOjIQeSLPGfu9AQ==
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr3454053lfn.77.1590008375449;
        Wed, 20 May 2020 13:59:35 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v17sm1269883ljd.76.2020.05.20.13.59.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:59:34 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id g1so5515832ljk.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:59:32 -0700 (PDT)
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr3496652ljp.138.1590008372306;
 Wed, 20 May 2020 13:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185931.19288-1-navid.emamdoost@gmail.com>
 <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com>
 <878shwtiw3.fsf@kamboji.qca.qualcomm.com> <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
In-Reply-To: <CA+ASDXOgechejxzN4-xPcuTW-Ra7z9Z6EeiQ4wMrEowZc-p+uA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 20 May 2020 13:59:20 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM6w-t85hZWcbTqTBA8aye0oka3Nw5YYZH2LqixO-PJzg@mail.gmail.com>
Message-ID: <CA+ASDXM6w-t85hZWcbTqTBA8aye0oka3Nw5YYZH2LqixO-PJzg@mail.gmail.com>
Subject: Re: [PATCH] ath9k: release allocated buffer if timed out
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:02 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, May 13, 2020 at 12:05 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > Actually it's already reverted in -next, nobody just realised that it's
> > a regression from commit 728c1e2a05e4:
> >
> > ced21a4c726b ath9k: Fix use-after-free Read in htc_connect_service
>
> Nice.
>
> > v5.8-rc1 should be the first release having the fix.
>
> So I guess we have to wait until 5.8-rc1 (when this lands in mainline)
> to send this manually to stable@vger.kernel.org?

For the record, there are more reports of this, if I'm reading them right:

https://bugzilla.kernel.org/show_bug.cgi?id=207797
