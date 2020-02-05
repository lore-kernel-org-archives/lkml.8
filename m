Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D432C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DB1218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUzYU7xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBEUlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:41:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43420 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgBEUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:41:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so3270217oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C80FvtF14u18Q5GuI4vN3cPxQNFCTPS0fGip7F+rzSA=;
        b=tUzYU7xPl+51dvzEMgLEd/cCMubfaL8ywjSse0rY7RFkACLPYA4FOyxZvncSztxGfm
         jFsPLMfKId7jpqzuZVxT2EFmuMLwh+x8Uzd2b6p6oOpYZTrPVrxfRUoUs9SiWeil9MEl
         yg3G0cSD2guGQ453ii26L+O3hPobLCKda6c5k48Srl5Yl0CLV7URwPTuaaKYCo+W82Uw
         zYcfpRpIMGhr7SSz87faIU23uuVkeMhwdM06oNRgj2Hb9/VE/+uxfuAdOGmHUe/euw8X
         cH3J+NDend/xp57RcU74XjqeczV2W7ypldS6fRitxcboaDc5T8+C/X2ZQRo1+uH4ScSX
         IPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C80FvtF14u18Q5GuI4vN3cPxQNFCTPS0fGip7F+rzSA=;
        b=qdBt2/hZa0HdZFkH8intnAOexMul0m/AVQLiWz1j2+NLZ+IHyTfkS5DNtNVI/hgxI7
         qGzFXW7pfIzCy97hW4E55M9HNU9KJ+4DhmxjZki0c09KpRmVPW46BJIQ9MUarsfUK5g7
         rJY5hQs7rIA0sZSwa9AkRiMb3N5xLghCw42nyT10xnnmJWKF4hHNkeNl3DTV4atSE6i2
         r0adNo8SZmLNnksbJNefKZMkRp3JxYy0GgV8Atez27Y2sYXb9AdkfHIWAYvSMGZ5LbFK
         Xk/+Q+ccohfIDeydDaHzs59FQNW3E1nAZb2EYdfQNppaxTDv3JfceDO2wDwtSGz/H1cv
         tFIQ==
X-Gm-Message-State: APjAAAWMzMpvcYCr0B71CiLAATcT54ViOUXrcX79l4owWO0YZoxAruaZ
        vB4GbnvJUl249ApB35PvkhdInpSG3G2dAmOrbpRmoA==
X-Google-Smtp-Source: APXvYqy9KjEBmSX5NkhLfBxg20I2V+XHYQ3xYGJSq4SDwQ1CyKJCQ+J9WrP3E0MhyV/DgPruw7w2Y2qCsPlY5jZD2/4=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr14867146otk.332.1580935303244;
 Wed, 05 Feb 2020 12:41:43 -0800 (PST)
MIME-Version: 1.0
References: <1580838148-2981-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1580838148-2981-1-git-send-email-jcrouse@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 5 Feb 2020 12:41:32 -0800
Message-ID: <CALAqxLX73PWJUFB1g2_nkdanGvCXJJDznwMUwjN2x5AiAJ=Ppg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Remove unneeded GBIF unhalt
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 9:42 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Commit e812744c5f95 ("drm: msm: a6xx: Add support for A618") added a
> universal GBIF un-halt into a6xx_start(). This can cause problems for
> a630 targets which do not use GBIF and might have access protection
> enabled on the region now occupied by the GBIF registers.
>
> But it turns out that we didn't need to unhalt the GBIF in this path
> since the stop function already takes care of that after executing a flush
> but before turning off the headswitch. We should be confident that the
> GBIF is open for business when we restart the hardware.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Sorry, yesterday got busy with other things and I didn't get around to
testing your patch, but I have tested earlier with my own patch which
is identical:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=4e6a2e84dd77fe74faa1a6b797eb0ee7bf11ffd7

So, I think I can safely add:
Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for the quick turnaround on this!
-john
