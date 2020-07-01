Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9450C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CC52067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YWuMKAR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgGAAXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgGAAXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 20:23:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65014C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:23:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m25so12301831vsp.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdlMKhUIKqBn4942Twt7faFKPF5NMn0jtO6zIzl5bWo=;
        b=YWuMKAR+NdZjoNqc21fwUzKbGR2W0tPVMxpKtpZrOKr3GXGnYkWzC8jYjtI7q+KLJm
         AMVP//lGkH183E7F9X39r/rfkU0M+tqYwxtL84uz4euS+Fvxv/+zAEMzAEd0mWE6jc0S
         gGh0doMKy/r7SCj2J/HyRI7NCqI/1zm9w6GdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdlMKhUIKqBn4942Twt7faFKPF5NMn0jtO6zIzl5bWo=;
        b=pluaHaoOAPtVf2IipDp6y3gYQKa0LIEUHFy3eGBrOitHI+bWzvrBM/Gtu8FJ9kx5fR
         7zdSuEWYsVpX5WcaBO8KKXb1tcVdIPC2pzZC0L2qmnnQR0ZWups7bpoKRszklOGQGQab
         npSo7PeRQaUssXrLm+0jQBNtOcF3PT0Gqy03mk+RtxFEZRM3qIJGhdVgpbi2S+fACZkx
         tb87VzBOi4tNNOJ7lPr8gdaCIiojk8ArHHHq0iASJAumjCsEk7+aiOjMAbImpYMm8ju9
         ABX1gO9MWajOdRA0twdNi6/GwdEcLA2FjefEWM7652PapQK6MgM100srQ7xdE85FR+Ir
         aPCA==
X-Gm-Message-State: AOAM531WR5zbu5H3i4MfOi/rTo0WJoHozRcMu66HzO0iaC+JMGXwnbK2
        5aqsFPrXFeJR8y7usKkFL/7DPcKgtvLLIKBgBe4+Bg==
X-Google-Smtp-Source: ABdhPJwklNYbaSTpl0qNpkykSJzbSKFMsew3YVzuD2Q01wlFVEKt0KhkSj6Nj/9ghRA7Bl1UMUPvHF5hEHtwpUsHUmg=
X-Received: by 2002:a67:7241:: with SMTP id n62mr11743925vsc.170.1593562988363;
 Tue, 30 Jun 2020 17:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
 <20200407082923.2001556-2-patrick.rudolph@9elements.com> <159306873839.62212.9311861115757727633@swboyd.mtv.corp.google.com>
 <CAODwPW9Gp+sjt7hdTrDmU-KnfpbXNkuQL52+v_FxwSzSSTH_yg@mail.gmail.com> <159315642733.62212.13203844825360378214@swboyd.mtv.corp.google.com>
In-Reply-To: <159315642733.62212.13203844825360378214@swboyd.mtv.corp.google.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 30 Jun 2020 17:22:57 -0700
Message-ID: <CAODwPW98o4dN1BffFrM0ZaUcjFyqmE3V9djEdJkO8Vrkc+nv4w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] firmware: google: Expose CBMEM over sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Coreboot <coreboot@coreboot.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. Regardless of the concern of the physical address is there any usage
> of this attribute by userspace? The description makes it sound like it's
> a pure debug feature, which implies that it should be in debugfs and not
> in sysfs.

I'll leave that up to Patrick. I doubt we'd want to create a whole
separate debugfs hierarchy just for this. Like I said you can just
read it out of the log too, this would just make it a little bit more
convenient. It's not like it would be the only informational attribute
in sysfs...
