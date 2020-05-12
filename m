Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9720FCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77863206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crUTI9DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgELQ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:57:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9449C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:57:04 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so11154666lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soB2T7jMfJPtP5H3MNhiTe8IwYHJSi7NbmavIdokrOw=;
        b=crUTI9DBwo1cPu+KhFehaihTnypYtCw55ruTD7lVh8znQdy9XZk/8FGzr8uT3FK2iV
         hRIiPsNa753rxUMiEk5p3b5zJ6y4SQ9lMrHEh4BNB0f0LNwzwPRwYUux8eaG4K48fgZE
         QLAuHslKPqD8iz0uGuPmhKPpNIIpnqwyweDz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soB2T7jMfJPtP5H3MNhiTe8IwYHJSi7NbmavIdokrOw=;
        b=jMtqd6XfA5wCYFuaK/KCAXzrii8f+TmgqZ2HKzh9a9pFrGT6fA2BLHSqIujGRAxGaK
         2s9cyKkI+elb7eV4qudY38mLYNIu6e7sO+nJIOoV1rZsdc56DJ88AZngIY2+kXDLg1fy
         7L43e2rBDylf2XYHNyH8oVHsuUiJmBsi5tyqeDsfNAXHoct5YEhRqcZc5X8qJ78/bf9G
         TnrPB39c0QU5El/wm2iNitddg9rhnKQzRDI7noLK+RAc0XapnDDuVteDIHo6Yp8Ght/P
         ExDbvgtUzYWb0uIHOJ1EbTMMqi2orv0dRdQ+aCqahSkotwHfCuEeJh0ur5ylSnsOX5nb
         8TNQ==
X-Gm-Message-State: AOAM533nN87VdhNDr8IvAOsZjphGJm5rVpiJC+Ysmy/5Oe4JdGz85Yvp
        DDTO3pgaG6W/qNHnnjNDW6foGIqA9aE=
X-Google-Smtp-Source: ABdhPJxCQW/hoNzOsJ1uSjWUply7W3tVXkjKKFnNgOrXS7KgGirrpMilYgvIuhrMpw8/nIAIoKqMSQ==
X-Received: by 2002:a19:4285:: with SMTP id p127mr14921755lfa.46.1589302622576;
        Tue, 12 May 2020 09:57:02 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k24sm277732ljg.92.2020.05.12.09.56.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 09:56:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id b26so11175604lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:56:59 -0700 (PDT)
X-Received: by 2002:a19:5518:: with SMTP id n24mr15139341lfe.61.1589302618801;
 Tue, 12 May 2020 09:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185931.19288-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190906185931.19288-1-navid.emamdoost@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 12 May 2020 09:56:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com>
Message-ID: <CA+ASDXMnp-GTkrT7B5O+dtopJUmGBay=Tn=-nf1LW1MtaVOr+w@mail.gmail.com>
Subject: Re: [PATCH] ath9k: release allocated buffer if timed out
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, Kangjie Lu <kjlu@umn.edu>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:59 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In ath9k_wmi_cmd, the allocated network buffer needs to be released
> if timeout happens. Otherwise memory will be leaked.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

I wonder, did you actually test your patches? I ask, because it seems
that all your patches are of the same mechanical variety (produced by
some sort of research project?), and if I look around a bit, I see
several mistakes and regressions noted on your other patches. And
recently, I see someone reporting a 5.4 kernel regression, which looks
a lot like it was caused by this patch:

https://bugzilla.kernel.org/show_bug.cgi?id=207703#c1

I'll propose a revert, if there's no evidence this was actually tested
or otherwise confirmed to fix a real bug.

Brian
