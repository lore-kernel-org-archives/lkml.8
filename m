Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFFC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4DA221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVI41oES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgDPV5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgDPV5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:57:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F36C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:57:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so132324pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vT/IDBelAw7Iy+8YBhPmkWx+lnZLFsGUZ4SFQAWcjxQ=;
        b=tVI41oESvCCPr8Ececz5o8F3KdRBC7ry8L7wX2JsvWBs2rUMz3AC+j2D0QQaMQIXQ+
         j/Dw/fBaNzWjW4FpDv5BLfX04j59jDFs5dVT9PbOH7w95HabJHDCG/tIQWBh5b8j9Is7
         PnkE9mCLHX0L+5oK4s90NNTjZPe8mDU68iD/kF9+HuOVKRAv9hPHVhyx7kh71YkdPjBm
         Xscz0SDkpHhvbL9/MLiUbqW90IdL/s6Por3L1aQK0dPM59Fpj7/biv1x6RK3CAdaDALC
         ixXtAGh9eqnys1xnn6fWeB9gPH9J7YTb89uKLieM2xNs9AuE3Etfgwe+YxCaEhnu4ewO
         OXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vT/IDBelAw7Iy+8YBhPmkWx+lnZLFsGUZ4SFQAWcjxQ=;
        b=GrKEHeA20I3NlrIW/y9qSasrKLjektKvYboOEv+xu6gQEO43z6v8jjemIVFtTMf07N
         2eka5Tfgh/uHe4QBnTD2dfn0Q9ml7AWrOYAGtIreUjIFEiJVWVB6Nn8immcDm55tgNHX
         tBjUqWrHt0UL1FtcLIExY9BiUi9osS/PFT+W4gYyZNPhl4ciq41DedQB3Xcp/daU5Tqt
         UnE2XI5oP6YxC7+K7mHY2Ymfg3gUMqyr83p36Gp29BxUSHa1WR3uvKccQybUveqScDor
         rGmf3506VP8Y5qq2CcSbc5IvKSDOulmgIGJ/6pYUaMM/l1me/H8OiyDRk9/ZF0SPpl92
         QAkQ==
X-Gm-Message-State: AGi0Puapyqb/S8kiHIw9BsRIckAjRnrp7mKkvS5HYftQmmyEwq6bbKFs
        4BnEOb5hD8Pv5asnvU4R2HXttL3g8lvy4cjogoF4mQ==
X-Google-Smtp-Source: APiQypKmFgSJy36kGS/EGXGzzpW3Ru3JFxbzm9/6qpvVJMa/1ZXMilvSBlxTsge8uhbeUdIh+hrcBbzEnpGrTTMcJoY=
X-Received: by 2002:a17:902:7e42:: with SMTP id a2mr289439pln.223.1587074269243;
 Thu, 16 Apr 2020 14:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200416182402.16858-1-natechancellor@gmail.com>
 <CAKwvOdkCMsDUGK88xGqfsA5Nc1eNmR+PbLBoHE0dv65aimcJyQ@mail.gmail.com> <20200416202415.GA30964@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200416202415.GA30964@ubuntu-s3-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Apr 2020 14:57:37 -0700
Message-ID: <CAKwvOdk3iQdqeLON8VNRb-9eHJruQPxi-7P5_aqt5M9oyz=GVA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Remove uninitialized ret variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 1:24 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Apr 16, 2020 at 01:16:27PM -0700, Nick Desaulniers wrote:
> > On Thu, Apr 16, 2020 at 11:24 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns:
> > >
> > > drivers/mmc/host/sdhci-of-arasan.c:784:9: warning: variable 'ret' is
> > > uninitialized when used here [-Wuninitialized]
> > >         return ret;
> > >                ^~~
> > > drivers/mmc/host/sdhci-of-arasan.c:738:9: note: initialize the variable
> > > 'ret' to silence this warning
> > >         int ret;
> > >                ^
> > >                 = 0
> > > drivers/mmc/host/sdhci-of-arasan.c:860:9: warning: variable 'ret' is
> > > uninitialized when used here [-Wuninitialized]
> > >         return ret;
> > >                ^~~
> > > drivers/mmc/host/sdhci-of-arasan.c:810:9: note: initialize the variable
> > > 'ret' to silence this warning
> > >         int ret;
> > >                ^
> > >                 = 0
> > > 2 warnings generated.
> > >
> > > This looks like a copy paste error. Neither function has handling that
> > > needs ret so just remove it and return 0 directly.
> >
> > Forgive me for not taking the time to look into this more carefully,
> > but just a thought:
> >
> > Having functions always return a single integer literal as opposed to
> > having a `void` return type in their function signature is a code
> > smell.  Did you consider the call sites of these functions to see if
> > they do anything with the return value?  I understand it may not be
> > worthwhile/possible if these functions fulfil an interface that
> > requires the int return type function signature.  (It's also probably
>
> Which is the case. These functions are passed to 'struct clk_ops', which
> defines the set_phase member as
>
> int     (*set_phase)(struct clk_hw *hw, int degrees);
>
> so we cannot just change the return to void since there are other
> set_phase functions that do set a return value other than zero.
>
> > faster for me to just look rather than type this all out, but I saw no
> > mention of this consideration in the commit message or patch, so
> > wanted to check that it had been performed).
>
> Yeah, I should have probably mentioned that. I can do so if the
> maintainers feel it worthwhile.

No worries, I should hold my comments until I can give a more thorough
review, which I've now done. LGTM and thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


-- 
Thanks,
~Nick Desaulniers
