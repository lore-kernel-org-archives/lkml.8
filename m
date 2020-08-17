Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07998C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F3920578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIPhHRoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgHQSiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbgHQP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E30C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:58:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p24so18312914ejf.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDW9UCeKCT82tfxaSNxr50xbb9G40cITAcAS3tvi8v0=;
        b=fIPhHRoaOSDBb+ug606oRYS2+MH5nZe6EMkjdBne3K6gkNMRHGFl+IinNJuPE7HtDB
         0P5yIMQN0vJ+D7KsSmoTREIxQXfgHlgP8SLVIrk3NC4rU/MaKeLXMJGlTIJcN3K0LVcb
         8YQq4mPE/eHtEhAhLC0BW/HVfeotG0CFsfiPwcULNgc49IIp3BUAWu/j9DmJsEbY5Vix
         dSa/ahzIk6ZB1COkndigQ1FITezBhbrovkBjR4XKdS84FUjDweagcSiz/Xw4WHOrYy3K
         3hFGJOt8E4buK1kawUekKbFn9He3DVzGb0mVXYxUGMewA1jIhHXUBA22Uf/Fa9IvReEj
         ORPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDW9UCeKCT82tfxaSNxr50xbb9G40cITAcAS3tvi8v0=;
        b=R4cT6rzfBA9ycYn5rC8ENO1Bp2Dw4WCWPAnkV2Om8GRT1qAd2T2fdSZnl+/AsWmpB1
         X5FGtvH2UmRCkg3IYiYd2F+Op8ooQKQvGNBll5RPCBSAAlU80Il3Blb8vO40nAwdAJr+
         E2xZiEs6UjaPk0KDWZA/iNs49onEHzJUMvQXQvKUJuMLKJpY30sqtn3+nbv/I5ocD9Ud
         NS7hhqm7IgiIpw8MN5yrB4JT9uimB5yAQHt7SPY8DInCrXjOWdB6jE1zGWlMsi7joVsM
         mUQW+k67n6B5OlvBv3+jOAKHWrC6i45UhSKK6lXSgqDauwYL8cOchzUUH33ENuds5whr
         fxmQ==
X-Gm-Message-State: AOAM532WS2oew7UoQasEJ7zt2NcrziIBfLmZEvx7TmdUljpucQrs3tIc
        4pryxe79Z6AeFVrDb/WFfFxDdfuqvkJ4mMb+/ljueQ==
X-Google-Smtp-Source: ABdhPJxYeqZjXIthrlvMdVffSVE1rokkXKmYeaKq142LtxPwYHooYBJSF/6fA/EUW56GiEN2+N3Z1Iot+nCiSbSHmCs=
X-Received: by 2002:a17:906:7f05:: with SMTP id d5mr15464122ejr.122.1597679917222;
 Mon, 17 Aug 2020 08:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200805045955.GB9127@nazgul.tnic> <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
 <20200812210909.GA3283093@google.com> <20200817151357.GK549@zn.tnic>
In-Reply-To: <20200817151357.GK549@zn.tnic>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 17 Aug 2020 08:58:26 -0700
Message-ID: <CABCJKuccY-wOEuQm--TQYgJvErOXu5u-jBMgCrM7JYsNqYK=gg@mail.gmail.com>
Subject: Re: [PATCH v2] RAS/CEC: Fix cec_init prototype
To:     Borislav Petkov <bp@alien8.de>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 8:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 12, 2020 at 02:09:09PM -0700, Sami Tolvanen wrote:
> > The type mismatch broke allyesconfig in my test tree and your patch
> > fixes the issue.
>
> How are you building your allyesconfigs? Because allyesconfig works here
> fine on latest Linus tree.

Sorry for not clarifying. This was in a tree with patches for enabling
Clang's Control-Flow Integrity. However, this type mismatch looks like
something that should be fixed regardless.

Sami
