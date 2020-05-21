Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D64BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E259C207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmUCxNDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgEUTH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgEUTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:07:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A85C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:07:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so10188344ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsSPUhpJYq73nfHib5c1j0os+u2XY4uTeNRmqrqb5mQ=;
        b=CmUCxNDgIi9qt6Q51kYVv8cFYZP4VEdLcAfjYqxn2qIZvUtue5c2fyvygZREGpwI/I
         tJb6hl3rKHFKaoBTMP89eAd5lK/gvCB5918Ju881W2CrP4VbdppU15ZViA7z5qhRr6EA
         1NvHnsGrU68uXBlLj/C1Oi49N91W+p2BZiJQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsSPUhpJYq73nfHib5c1j0os+u2XY4uTeNRmqrqb5mQ=;
        b=HyeRgBsLCIY+JK4c3iTcWvhXli93IviVb+baSdtqmr6t8ivIWaFiM9ThgxW5OzvAsQ
         peRBkLTMWxCXMLN5bJwZvVamU4Tnk/AwQfIWTbjI8qEq7kJWiXa2pDciu/tGIyui4zKk
         nTAR/+aLdAVz/VACI9PqycGQ1RLIXmf4I+aCByhjRRmpng2J32CyYmUQjpLxm+SSZSsV
         CvMOMQuz2YYtSfEXzLLHR/OSoH6YZpRauIym6j6mK45AxdzRbs4iiDFdnW6IxKxwV+lQ
         9ApNsmrk8DVP1UBFRuqYKmuUhhu7CdHaK8uET6rpv509X+DylYuOFQM+MdFnjJqC+sUb
         vINw==
X-Gm-Message-State: AOAM530H3xbQc/qsSeMVY13Ga5ZGGiIFoRZzNU19dZbptMDNVswoSF/E
        2CGo4HP8HIBo5HqOHoI/X9EecdvDUsw=
X-Google-Smtp-Source: ABdhPJxzs4N7Mrt/IAyg0t3HKIyY+BUtkZsQB0dO4GPmRQkRKcojEVjx/38Zc6tomQNIYOp9rlrmag==
X-Received: by 2002:a17:906:7684:: with SMTP id o4mr5187738ejm.449.1590088073725;
        Thu, 21 May 2020 12:07:53 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id g20sm5726252ejx.85.2020.05.21.12.07.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 12:07:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id yc10so10104776ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:07:53 -0700 (PDT)
X-Received: by 2002:a2e:9896:: with SMTP id b22mr5475234ljj.276.1590087687179;
 Thu, 21 May 2020 12:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200515212846.1347-1-mcgrof@kernel.org> <20200515212846.1347-13-mcgrof@kernel.org>
 <2b74a35c726e451b2fab2b5d0d301e80d1f4cdc7.camel@sipsolutions.net>
 <7306323c35e6f44d7c569e689b48f380f80da5e5.camel@sipsolutions.net>
 <CA+ASDXOg9oKeMJP1Mf42oCMMM3sVe0jniaWowbXVuaYZ=ZpDjQ@mail.gmail.com>
 <20200519140212.GT11244@42.do-not-panic.com> <CA+ASDXMUHOcvJ_7UWgyANMxSz15Ji7TcLDXVCtSPa+fOr=+FGA@mail.gmail.com>
 <CANUX_P1pnV46gOo0aL6QV0b+49ubB7C5nuUOuOfoT7aOM+ye9w@mail.gmail.com>
In-Reply-To: <CANUX_P1pnV46gOo0aL6QV0b+49ubB7C5nuUOuOfoT7aOM+ye9w@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 21 May 2020 12:01:14 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPAVJwyThAXRQT0_ao4s1nDYOEQifxMc+JsEMa=cTEGJA@mail.gmail.com>
Message-ID: <CA+ASDXPAVJwyThAXRQT0_ao4s1nDYOEQifxMc+JsEMa=cTEGJA@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] ath10k: use new module_firmware_crashed()
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        aquini@redhat.com, peterz@infradead.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        mchehab+samsung@kernel.org, will@kernel.org, bhe@redhat.com,
        ath10k@lists.infradead.org, Takashi Iwai <tiwai@suse.de>,
        mingo@redhat.com, dyoung@redhat.com, pmladek@suse.com,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, gpiccoli@canonical.com,
        Steven Rostedt <rostedt@goodmis.org>, cai@lca.pw,
        tglx@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        schlad@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>,
        jeyu@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:37 PM Emmanuel Grumbach <egrumbach@gmail.com> wrote:
> So I believe we already have this uevent, it is the devcoredump. All
> we need is to add the unique id.

I think there are a few reasons that devcoredump doesn't satisfy what
either Luis or I want.

1) it can be disabled entirely [1], for good reasons (e.g., think of
non-${CHIP_VENDOR} folks, who can't (and don't want to) do anything
with the opaque dumps provided by closed-source firmware)
2) not all drivers necessarily have a useful dump to provide when
there's a crash; look at the rest of Luis's series to see the kinds of
drivers-with-firmware that are crashing, some of which aren't dumping
anything
3) for those that do support devcoredump, it may be used for purposes
that are not "crashes" -- e.g., some provide debugfs or other knobs to
initiate dumps, for diagnostic or debugging purposes

Brian

[1] devcd_disabled
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/devcoredump.c?h=v5.6#n22
