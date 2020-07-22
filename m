Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32353C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB2F22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LDgxRU0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbgGVXBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:01:38 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C6EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:01:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t18so3047731otq.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMYtvDBeGfcQxAGCAdsv13lRzxlc7JtBvhHF/yrjphQ=;
        b=LDgxRU0PPlOqe+jIyOjiUKQdehMfoZWAjfvZ25p0KPl8vFDDdOtUj3vbuWcx1d2HiM
         bsCRH9MS1l8LDU98iOSE7GPEolaslu2fkxDb1T3PBTgCR24VzMdTGS6k/iPRG3QEztNe
         Em9GsZq+bVr765qjSjudsYKVBDe/BWvUycBl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMYtvDBeGfcQxAGCAdsv13lRzxlc7JtBvhHF/yrjphQ=;
        b=hTVoZWlieksQz9dvchQcRhrULIrxBdZKpfnYym9KirZRPHQJPNu9tPp3zwH+kCVZ4v
         pLWQGB66PPj7C1H8ddn9vTmB6R8r3NgB0ve/9jfP6E00fU9J+FjO6UDOBEmTGmuIAnJh
         OG6Q8ppela71fwzD5u5QPrnZ4WLs/Z/tfF0fFIMDQcj9nW4I7Lal7nw3+mYGNQBFvyBM
         ePBmm3CbLOEGAGkyVlmbPQvB++0JfA8Kq9mjYTxi/m2/kO7QXcYI4+m3VPWH0ta8JEKn
         PDn1d9kHCRVKWeB7O/9DmvGF2w3W1bo9i0j8so8gnn4FDYHXoi8OIgA1i9K9bhKCvmJs
         6siA==
X-Gm-Message-State: AOAM532jOw/N0mss8De4VjthLI+05AtykKcQGwQ0IUIxlBMp9Se6P3s3
        3K69eDP6fN2n8DWNDla5BXIrkWunLs8oKC6SXvgsVw==
X-Google-Smtp-Source: ABdhPJzMRGNhyEWDrKRLOE3infJnLErmNB6h5FHJQExFCTQdMa95a4Z/n+l6f4RR6YJ3xa3qMPCPWE5qcULyrQPYc4Y=
X-Received: by 2002:a9d:d55:: with SMTP id 79mr2018905oti.281.1595458897417;
 Wed, 22 Jul 2020 16:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <1594644106-22449-1-git-send-email-akhilpo@codeaurora.org>
 <CAF6AEGtAEwZbWxLb4MxaWNswvtrFbLK+N0Fez2XYr7odKZffWA@mail.gmail.com>
 <20200720100131.6ux4zumbwqpa42ye@vireshk-mac-ubuntu> <CAF6AEGurrsd3nrbB=ktZjWfKTNbKwPHYwTFiZdD-NOW1T7gePQ@mail.gmail.com>
 <20200721032442.hv7l4q6633vnmnfe@vireshk-mac-ubuntu> <CAF6AEGuhQcRskGhrFvmCf5T3EcZ9S+3LRdZBiaDYqF34yZjd+A@mail.gmail.com>
 <20200722053023.vwaoj5oqh4cazzzz@vireshk-mac-ubuntu> <CAF6AEGsOZshgBUnUKUF_hOLNHmvrvsDwPzX24-RKos6MZEeusg@mail.gmail.com>
In-Reply-To: <CAF6AEGsOZshgBUnUKUF_hOLNHmvrvsDwPzX24-RKos6MZEeusg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 23 Jul 2020 01:01:25 +0200
Message-ID: <CAKMK7uF=vhzZSKuy6XV=R7roabxMt104Vg_w8axNmLi4EE6+0g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add support for GPU DDR BW scaling
To:     Rob Clark <robdclark@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonathan <jonathan@marek.ca>,
        saravanak@google.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        dri-devel@freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 5:47 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Jul 21, 2020 at 10:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-07-20, 07:28, Rob Clark wrote:
> > > With your ack, I can add the patch the dev_pm_opp_set_bw patch to my
> > > tree and merge it via msm-next -> drm-next -> linus
> >
> > I wanted to send it via my tree, but its okay. Pick this patch from
> > linux-next and add my Ack, I will drop it after that.
> >
> > a8351c12c6c7 OPP: Add and export helper to set bandwidth
>
> Thanks, I'll do that
>
> >
> > > Otherwise I can send a second later pull req that adds the final patch
> > > after has rebased to 5.9-rc1 (by which point the opp next tree will
> > > have presumably been merged
> >
> > The PM stuff gets pushed fairly early and so I was asking you to
> > rebase just on my tree, so you could have sent the pull request right
> > after the PM tree landed there instead of waiting for rc1.
>
> I guess I should have explained that my tree gets pulled first into
> drm-next, which then gets pulled by Linus.

Yeah either topic tree or acks for merging in the other branch. No
rebasing in the middle of the merge window, that's rather uncool.
-Daniel

>
> BR,
> -R
>
> > But its fine now.
> >
> > --
> > viresh
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
