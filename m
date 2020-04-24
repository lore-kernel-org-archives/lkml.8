Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F6C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC7220767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PanBHZdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgDXD7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbgDXD7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:59:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C6C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:59:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so3262461pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=OUVxQF+oC0mlk6FQJe7RPNH97fg6Os38vM17nA7u2v4=;
        b=PanBHZdvJgcCE2sQEDbfNptEXd2LoewP/cdztrIQJ8zsMm7qBCJ4rb14rKRxckCuIi
         AkWLmrJwNMNwrrgknZ0p7Pe1Iet4XcWd5s2P1CYKGT9f/LtHoWlNU46SiDWtTAuxOwAC
         3ggB+LyQNWc3vrRj14PUJVKS6IJJRgvGdtr2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=OUVxQF+oC0mlk6FQJe7RPNH97fg6Os38vM17nA7u2v4=;
        b=o5REcCDNrbNln2qM04/6Rit2IbJM+tNZQWPtnlL3YDjbQiQPeiWgIb4y53wpAmjtfk
         rSdGhXBtwQtkRoL79b+DvwQ3t9HCnZ11C4EYyYpUhFWiPk4VFSvEY/de4k2O8uwXtXND
         uwkOt1iWQdAR8EBLKOxcEbSbpLHso47fvrFCaf5KpnnAk19KDYX7Fhb7oLZ9WthwSlmV
         p9f+C+v+d2yJJEG8j6D8Cee707sXbWPxSLUBn12CJUV8/mST7I/JtCyQWT8Rta+Zztu6
         bXkrIwp1nZ1kkOr7ZbVHcA21hfYKBsX5b4eCU5TzifB1mjsUnZYxC5Zan+am1taT9VqG
         UiKw==
X-Gm-Message-State: AGi0PuarU4VD44hRRNkdiVTDV9XdB5GMj/2QizOjXfdzLFgJ7i3RNQZJ
        GtRrerFaBEo4Hh2LHW3P/qCevg==
X-Google-Smtp-Source: APiQypIfk8zyw99IbqgvbDJNXYALRVLhuXlRSJ7PIl3u+1588Xj4XFdbySV/wfLt2qod8HEst3vl+g==
X-Received: by 2002:a17:90a:25cb:: with SMTP id k69mr4076138pje.93.1587700794708;
        Thu, 23 Apr 2020 20:59:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c3sm3662204pjc.43.2020.04.23.20.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 20:59:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200422145408.v4.5.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid> <20200422145408.v4.5.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
Subject: Re: [PATCH v4 5/5] soc: qcom: rpmh-rsc: Remove the pm_lock
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, mkshah@codeaurora.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com
Date:   Thu, 23 Apr 2020 20:59:52 -0700
Message-ID: <158770079266.135303.7831640949542355577@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-22 14:55:03)
> It has been postulated that the pm_lock is bad for performance because
> a CPU currently running rpmh_flush() could block other CPUs from
> coming out of idle.  Similarly CPUs coming out of / going into idle
> all need to contend with each other for the spinlock just to update
> the variable tracking who's in PM.
>=20
> Let's optimize this a bit.  Specifically:
>=20
> - Use a count rather than a bitmask.  This is faster to access and
>   also means we can use the atomic_inc_return() function to really
>   detect who the last one to enter PM was.
> - Accept that it's OK if we race and are doing the flush (because we
>   think we're last) while another CPU is coming out of idle.  As long
>   as we block that CPU if/when it tries to do an active-only transfer
>   we're OK.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
