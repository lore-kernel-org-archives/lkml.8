Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B36C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C392078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598475573;
	bh=Ayj4L9M3PetRCnfzXhnW7OqNgd5PVRnr2yyURQmQivw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GoEpyBN1KoOiT5In3enAIGWj4Z24KNDMEpzQN6DbgeMzD6RF9cSOUmb421BvlVNUo
	 /MdYgLVfiR+yqLhEGpP38IkmjdflrIIwH7WqWSaCizKi96v8ncsUFfvRC6FmSgXC/S
	 05AOHN4DuNMABHiusfqUbWL7vplhhsmHuVxycJuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZU7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:59:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5916C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:59:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so3950407ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkBcAXTmytaTd+hMgMm0aIJlKCAnI1YMBzYoHxnXAe8=;
        b=TY+hs1symzGhziPeKV17+nHR3J/iqCecA9q65RbgFTEkpTYCqVMUyVP9RPmJzpp0Y5
         qMBstF4l+J8+/rYW1YhpGi/MxGfT0WJzJSW29PRbJhAb17GNKS0yYRDJ+kTf05zoQaXx
         MP14o9gFQTrYgyeD1MgtPuHBTYr0FPu6IpzJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkBcAXTmytaTd+hMgMm0aIJlKCAnI1YMBzYoHxnXAe8=;
        b=Eu36jQQHmGyrdq/qYPhoAazPde7oo59hu0/yf9VJ5hNkvA7YuINRrG2bkF62Bmc8oL
         y2BZZoLoUFN9y322crOVypyNRN3iwaOX8atQK42MVXSr0RRYNrnWopcAwhU7l93TIIqZ
         wrX0nfA6+ArqHcZcoGW4Mk/P8qi3AKwXMIMOu6YQc64KYdfsyGCV4NoyhmWiEnWbZ3vq
         IHEBOLHGzJrW6lwd48kP6wYZj2LnrhYaCifKHFIOZclB/41Z4c1xaXxgxdbNsQ0E9NIL
         d4CfJjME3+ziLnXM2hmh0DBfGLlRyDGb1siG1GM5E2hflab++g9Wt+eExE+ZfcmP392I
         DNmQ==
X-Gm-Message-State: AOAM532t7Wv264arsEv1qt8t7MBKu0IPHLl/WZ5sMtgHRewbI6T7leui
        6TcMu78ISVT/NuWLfxQ6nJgxxbtmzoZc0g==
X-Google-Smtp-Source: ABdhPJyjlN9xgTZ+tEDI3qKPaXlrjYm7lEsIDRWn49Msr/HCtovcrs9BRh2s5X8zZrCEYC1TmlcMlw==
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr8224689ljn.97.1598475568832;
        Wed, 26 Aug 2020 13:59:28 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e10sm830479lfs.4.2020.08.26.13.59.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 13:59:27 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id t23so3985775ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:59:27 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr8744434ljp.312.1598475567101;
 Wed, 26 Aug 2020 13:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
 <20200820092349.GA3792@amd> <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
 <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz> <87tuwr59te.fsf@intel.com>
 <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org> <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
 <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org> <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
 <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com>
 <101bff45-0ebd-8fb6-7c99-963aa4fcc588@skogtun.org> <CAPM=9twLvHu_XLJ89GVXpNo=PHPZLJuRpHggkfzvvuVf+xrwoA@mail.gmail.com>
 <0f06d704-c14e-0d86-c8bb-8c7b3a34758a@skogtun.org>
In-Reply-To: <0f06d704-c14e-0d86-c8bb-8c7b3a34758a@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 13:59:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=MjX6+Bn-ooHT_wf4VTpe7y-5czbAUT=vaAn2VCBNBQ@mail.gmail.com>
Message-ID: <CAHk-=wh=MjX6+Bn-ooHT_wf4VTpe7y-5czbAUT=vaAn2VCBNBQ@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 1:53 PM Harald Arnesen <harald@skogtun.org> wrote:
>
> It's a Thinkpad T520.

Oh, so this is a 64-bit machine? Yeah, that patch to flush vmalloc
ranges won't make any difference on x86-64.

Or are you for some reason running a 32-bit kernel on that thing? Have
you tried building a 64-bit one (user-space can be 32-bit, it should
all just work. Knock wood).

               Linus
