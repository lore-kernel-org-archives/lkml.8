Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81441C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BDC206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gso9pMxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHSKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHSKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:52:11 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:52:10 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id k63so4785555oob.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVVSOWbVhc+1jDHdFns3ZSzRukenY167RTrEndwbU+M=;
        b=Gso9pMxrOQWdMFS4oUDFDQopnA2DpTpiZCJFqq/B2ZEoa859lMA5DG1q5AfyFRQC2K
         0BbOOMsaxojyLaYamQN/hpqRKPyyNI6tYgVnrQEOZwypkcXjeXNYOcmggJBzwWOAPH2t
         uDby8ZfkUfgPuCVQ1hjydyCXloT/GD+ySll0NBJQxEcqa5ZYkvWZC8QcBYu6LNGB6qmy
         BNwFxRP4pWhEXUL9/E4VkRndasu5/0pLNTSDu1EbLLgbuQ4nsZFmlQPPbC5atEOXRxVR
         X7KawI1aJh0oYRDXgKsXSAYl9gDpUeMspxL/faww8IWo5Ubp2AZ/wAk+H184A02WZfBJ
         /6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVVSOWbVhc+1jDHdFns3ZSzRukenY167RTrEndwbU+M=;
        b=RvNzHDwysQ3fpv0fHfUcRAiYYtdtpbG3i+oJ8IR14U5UKgF79SXU+/3SBiGt//cNXk
         QHu6v5Qhmx8GABnf9ZgGviMQmaOl5O/rrJNMObvuOwRrjhDcIxWHCzGGcGJ2cZWUxkxI
         iN33w9UoQtThhKpr48WcFHz7R0RK/hqdPgncBPqK+VWvM30isZuCzMweZhPAkyeVdnXo
         w2UpuDq39qa7N7UaKdpEI7PglgsPtP+iiZ15gjJsxeA3/Us+B0EvM92wfx5vT8I3kYPJ
         4s131ixHedc64jcO2k+y8sqr4fZN2zuMrcMTX8oG58gIELhPjXZHQsFTmCfk6AlFXywC
         Grmg==
X-Gm-Message-State: AOAM530gae4gksRXv0zSIXWUQpflNDLa7sNRF+as2mJaoA5BiwiEe5Mo
        xxt/Y4c2jJtQGq0A+ux5TuyvQPWwlg9EYcSZORk=
X-Google-Smtp-Source: ABdhPJza8N+paiL7BVopPlHy+EmjenRyRlSSITcfsn9ivsKXVK0GX/mlG+WzET1CjkKeuuz0KvlkntNnGGj9jJ4neCo=
X-Received: by 2002:a4a:d62c:: with SMTP id n12mr18112364oon.38.1597834329556;
 Wed, 19 Aug 2020 03:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de> <20200818104432.GB5337@sirena.org.uk>
In-Reply-To: <20200818104432.GB5337@sirena.org.uk>
From:   Allen <allen.lkml@gmail.com>
Date:   Wed, 19 Aug 2020 16:21:58 +0530
Message-ID: <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Allen Pais <allen.cryptic@gmail.com>,
        perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, Kees Cook <keescook@chromium.org>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Mark, may I apply those ASoC patches through my tree together with
> > others?  Those seem targeting to 5.9, and I have a patch set to
> > convert to tasklet for 5.10, which would be better manageable when
> > based on top of those changes.
>
> These patches which I wasn't CCed on and which need their subject lines
> fixing :( .  With the subject lines fixed I guess so so

Extremely sorry. I thought I had it covered. How would you like it
worded?

> Acked-by: Mark Brown <broonie@kernel.org>
>
> but judging from some of the other threads about similar patches that I
> was randomly CCed on I'm not sure people like from_tasklet() so perhaps
> there might be issues.

Yes, there is a new macro by name cast_out() is suggested in place of
from_tasklet(). Hopefully it will go in soon. Will spin out V2 with the change
and also re-word subject line.

> Allen, as documented in submitting-patches.rst please send patches to
> the maintainers for the code you would like to change.  The normal
> kernel workflow is that people apply patches from their inboxes, if they
> aren't copied they are likely to not see the patch at all and it is much
> more difficult to apply patches.

I understand, I'll take care of it in the future. Thank you.

-- 
       - Allen
