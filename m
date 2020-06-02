Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE04206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS1cNpg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgFBMWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFBMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:21:57 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B77C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:21:57 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id f126so821114vkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhS6wUtL1nQqq687nk7bY+rt6oHfCz/bP20I3cjBhSw=;
        b=iS1cNpg05xcEK6kyHjMSJ22ATuO9KFDUcoDquBU2iOe8OtEp/aHvoOY+Hc1jbuHZ1j
         /Zf/spKV28Tbu++/etF4Zjj4sXvh8pAXYEwRxpTd1PNTIZGqQQJMnllTJIXyTvig+rl7
         ONIP/BDM5lHyDtCrPjr1f21Oc9Ywr8DNAM0/z8teiTSPg84vkpYs7bwL7S0qIB8mmj3v
         mf9cWjDavFRqvO/HxzSGtzUfqAggg0QxBs0uvP1uv0pRsy+lSebm+Nv0HhZ2FR2wX0HW
         cXjB8Ebc8hym8wolXa/Elydr/XWJoBacagzzpPtMsoudz8jLUVGbIiOVugOlM5dRixRi
         NKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhS6wUtL1nQqq687nk7bY+rt6oHfCz/bP20I3cjBhSw=;
        b=E8MEKPAqWSiMahOR8GQkrMF79zA+ah8APGD3ViUpiXJ7KcLXBqZTQ9WAiPILQXiwXJ
         meQtdpnutX0DM39OGGuEIspjWeMc7MTu4J3ETRAD/4xkL/IiN6GROJjILiQqsmFNOdVL
         y20bkiVaKac1RgjYvRLTQn37sJZ4xt/XImoQSAAxI6wcPj2/3FQwyo+viLXFSThhFrT4
         ksPw2oeV1RQOVS2s0Ihtw3FCH05yBTMKN93ctx+jWLLh7e8QvjQ3jLfugU7l/ugBglrc
         nHU39uBgbdIRW9sckI20jVpRDzhtEPublPAu0+1JNBmHIP4nKnveQh8CAoxFjIbJrDia
         pbuw==
X-Gm-Message-State: AOAM532ieD9DxvmP3p+dGiJdtTeUlKefhAaeBSOO1JD22euVVsQkeG31
        +OhzppmX3X+fzdejnHi8Hjl1T3XXBzc30KoXs+4Exw==
X-Google-Smtp-Source: ABdhPJyFkrbYplf5gWUM2GeUq/gzW7pUpT6I7Z+yO1zl/pK104ACL5dbJongfx+Bv5rPOloANFKde8VOkcaaziUl7fU=
X-Received: by 2002:a1f:2ac6:: with SMTP id q189mr8911630vkq.28.1591100516362;
 Tue, 02 Jun 2020 05:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200531131237.24781-1-realwakka@gmail.com> <CACvgo50SzjUe6usELF33qXW3BWZmH5U4ynPTBorZLDrG-Nx2Pw@mail.gmail.com>
 <20200601002520.hajvtpefi7yzvmuq@smtp.gmail.com>
In-Reply-To: <20200601002520.hajvtpefi7yzvmuq@smtp.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 13:18:38 +0100
Message-ID: <CACvgo52Vh92TFwMqgagMsopW9yAZ6FGXgyXHu9Bhe3qqPSPcHg@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: Optimize compute_crc(), blend()
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 at 01:25, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> Hi,
>
> First of all, thanks a lot for all your patch. And thanks Emil for your
> feedback.
>
> I have a suggestion here:
>
> Emil:
> Could you give me your Acked-by or maybe Reviewed-by for the writeback
> series? With that, I can finally apply the series.
>
Sure, once the issues highlighted are resolved. Just left you some
more comprehensive feedback.

-Emil
P.S. Something something top posting sucks :-P
