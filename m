Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10A6C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD9420731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="t0hKg2rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHCsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:48:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017CC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 19:48:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w2so74473edx.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLZQYSIf7qfSBLr/gKPt/c8GOu7kRmWTRuEn699IMDw=;
        b=t0hKg2rMuJt8UJZCiHk/C/GlwUzYWobqstyxyqfq/FAx5yk6lweJ1xY6Zb13NQyNEE
         SzsJeUAl90c+sKJ3XVhgFTx0VLDTtyUU9D7Ed2leIhcdyCF5nC8WDvfLss+0SvmVg/30
         oGbuu1qaJiiq+Ke0kse/WApWoKnYbpScXlB+J3bN61gd2zMaoKLRUStzo5pnlOE0Z0SE
         AneqS8dOgdm/52ETyLwsixkC0yjJuzmFvllXK8WMZ0nY1FGxuE8jAH+9SoVRZf02XaUd
         Ex/DNK1MqQvqvYTdRyd7VTgMdkg8+05mmsEm0ogq3qmd0A/YleYbScL5RFOFznnmLa7u
         KR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLZQYSIf7qfSBLr/gKPt/c8GOu7kRmWTRuEn699IMDw=;
        b=QGB4Kp6BlxHMEb5xiDt5SUmczx09lRcTs+YyLNeG5dF3YlwKrK6C8QLaJ5KzDbg+Ud
         lEwpahei7BsYB4gUGYmRrRxCARelG62MZla0hhOf3JuOGX6+ykiAk4RXO+mDRLNXQ27P
         VlIZiLMYeL0Ya2ekN60AzayjX652FfggXa9nxzIqTVSFN1wR+JXaGbmCaYaxDXy/HbT4
         er/h58dLIkITheBlePugRD2ERkjF6V7Pn88PNuAr7Qn/hHDFuvbyEg0mJIe23f0yViWc
         FU2L/SZO1tM1yqAZc4EJ1pUZmigCIMj62dnajKll3pHnuM53EebSYjAw4qR1aJqYWuQb
         BKSw==
X-Gm-Message-State: AGi0Pub7cUxug1RXpQgJstO2K4CtMxzRnBEZF3w9bNi9lwHvQ+qe/FPE
        IurqwwsaR1iSpTCCaG96/P7IXUUEetZAJqdy3OHc
X-Google-Smtp-Source: APiQypJ1JZ7IFS3WkxAtuyvG5xE2Yb54OZW8v3tJolFg9OvRJ2M+B/WgLPc4kqcL1KyoJ4XRFiO5YFsRLmz9Y8fXwBg=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr353204edj.196.1588906113921;
 Thu, 07 May 2020 19:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200507185041.GA13930@embeddedor> <20200507215812.ksvwcykfged7ye2a@madcap2.tricolour.ca>
 <20200507224955.GA22343@embeddedor>
In-Reply-To: <20200507224955.GA22343@embeddedor>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 May 2020 22:48:22 -0400
Message-ID: <CAHC9VhQawsT6Z7U7o53XpBbX2Azu4rMMojGgfCJYhppBcsvZKA@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 6:45 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> I wouldn't advise to make any of these conversions in include/uapi/ ...

Yes, let's not make changes like this to anything under include/uapi;
the potential reward doesn't outweigh the risks.

-- 
paul moore
www.paul-moore.com
