Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3040C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5901206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591132932;
	bh=wssekSwupkgcp9xc4v8LjyJGjbMhckCUb3ejRT9Wmn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ORX+aoGBszdA2GgykV/DYLDvQksv17tHP2+9Og/aP2CjVE2rSZxIjJsnnDil2lETx
	 qZg7PgSkM1tbwNsw0kWLl5m6swxd+V+fmK3DCl5FvTGkayB/UHJUSSq55uQlCz9Fha
	 emvICuuPTFgkf1EFE4xWtu5i2vlRf28y9RwkEf/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFBVWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFBVWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:22:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:22:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z206so7078486lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SbTnu2Joe/UmPFYZAmB5Tz+5GBec7GBEWVsnaWkdrg=;
        b=ABcLIDWzz1tu1GxHTVMe7bjHac2QIuX7rTxa1aa3QDOFpZ/9DRCPuAFOILb1zcCXs0
         7oUcgqs5wDu6bDImq/IzRWVqXPzk1Z2lJmThYxYj/arN3jC60c31M2tmQB5Ue9KM6qt/
         pb18/JsW9x4nynCcy3hfXBohGrqvWxPqFBFSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SbTnu2Joe/UmPFYZAmB5Tz+5GBec7GBEWVsnaWkdrg=;
        b=O54fjxZuuNb/3GNjaNEvrXjJGXdbRK2bUrrwo9iTTiqQuipPIFugBxVa+ypDknEjsZ
         Y8c7hbTFcBHeWAwAKzCHRgWxV8dcfTzS9w85MJs9QWcE7h4B8SS15zg9VqysAqHAXeYg
         uZ5Vzucu7byI4jy8I1M565TXfIzgmpnThJjnvNzfGu7UNQ30R6ab0twWptwSdzcY3B6v
         yTy8dVOIjW7PUAs66e23D4TqafI6gEvEbEnCQHckAK71PAK1MpCQ4DLzhMBDIQw7EnwF
         P4mXuM9IngMSlwxlYtL8abtdP9PrF/1OveeseqKyHM2v/qL8/RtD9FUzk++M7lS7M/yQ
         eNug==
X-Gm-Message-State: AOAM531sNNIMTrOwvqV3wPcy1SDTN8pz8ofPL/0KTt7LTVrNw8+LycJT
        c0FTDl+6JMffcL7FD3E0LBx0PePXGxE=
X-Google-Smtp-Source: ABdhPJx7oUq35kczZuLVU8c8GWbquV4m4BxrSM3loHP9YPPcx5q8FoFBaj39oD1z2AyldwN5BOj73g==
X-Received: by 2002:a19:150:: with SMTP id 77mr645438lfb.71.1591132929147;
        Tue, 02 Jun 2020 14:22:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w17sm18736ljj.108.2020.06.02.14.22.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:22:08 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a25so76594ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:22:07 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr252353ljn.285.1591132927271;
 Tue, 02 Jun 2020 14:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
In-Reply-To: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 14:21:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
Message-ID: <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
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

On Mon, Jun 1, 2020 at 11:06 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This tree is a bit conflicty, the i915 ones are probably the hairy
> ones, but amdgpu has a bunch as well, along with smattering of others.

Hmm. Some of them are due to your previous mis-merges.

Your commit 937eea297e26 ("Merge tag 'amd-drm-next-5.8-2020-04-24' of
git://people.freedesktop.org/~agd5f/linux into drm-next") seems to
have mis-merged the CONFIG_DEBUG_FS thing in
drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c.

I'm still working through the rest of the merge, so far that was the
only one that made me go "Whaa?".

                Linus
