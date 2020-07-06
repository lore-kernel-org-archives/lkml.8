Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE19C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687902063A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fiT4aMSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgGFOUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGFOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:20:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0BC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:20:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so35088513edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RSLBnnQmv10QnvMK0VJhKxw2dmxExaftUzWSTywjdY=;
        b=fiT4aMSb7vGwMbKdVv3F6xjKsgRlGfjhI3OG5ofb3WLma2odOfR9lu4X+ZYCrXwLV+
         KNldoA3WlWpQRBeQb9hJ6qjDF3X1MAlDxhceFqRQf5BsDIrgWtw7dKBOs7lnuBPxiV7R
         iNt5dXA1almV+pU6qRmx1PYyZS7ajZWvVyFno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RSLBnnQmv10QnvMK0VJhKxw2dmxExaftUzWSTywjdY=;
        b=fqSA+gGdpUSc25TuUhuAky75LvvTxYrDjgN8GvaTtXQ30O2zTutxs8KFNun+j41Mgk
         nXDCbGihVoRfJojybR6Uz86GK3F5zwiyeZv0P50rUR5OC4xtjA9rxRGNolNblFag2kY1
         kaUjzMAh/Gum9kb4WGba1EfUfAV79KuD8qYB+ISFLK5tQbXrgdM0wHS9FSVVgVFusVLK
         uZ1rxV5LP94nDfpIgTYZSUCjIbmzf5RaHVcfDDync5A0dKABhojE48bkMhIC7r7+Z1tq
         wHNsa1wMby8i+msY1+iKz4LNziGpGh8qN95DiuabP5vOi+vIc/2WgNmIfeWa/oVx4UZh
         v4zA==
X-Gm-Message-State: AOAM533vekX7SRd+syu8hUroft3UrJRpjTxgZDYm/iYAem2/j9tpfg42
        sxbij+ekOFq8InHZuDzxtk77toPW6WV7O4c/s7vjHA==
X-Google-Smtp-Source: ABdhPJzNFazFeON3NPnrhfybED/SUs2fZuxYSlU/J+YXh/+hlqeeUCMxNmHzRHLe6EEaKyxJmz2zGES/kOwh6IEh4Jk=
X-Received: by 2002:aa7:c2cf:: with SMTP id m15mr30981175edp.27.1594045221344;
 Mon, 06 Jul 2020 07:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <1582205259-15274-1-git-send-email-sunil@amarulasolutions.com>
In-Reply-To: <1582205259-15274-1-git-send-email-sunil@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 6 Jul 2020 19:50:09 +0530
Message-ID: <CAMty3ZDDCeh29myiX7VC2QVZ-dMVDzW4uNNnTumD699is96pcg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable REGULATOR_MP8859
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Thu, Feb 20, 2020 at 6:57 PM <sunil@amarulasolutions.com> wrote:
>
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
> for 12V supply.
>
> roc-rk3399-pc initially used 12V fixed regulator for this supply,
> but the below commit has switched to use MP8859.
>
> commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
> Enable mp8859 regulator on rk3399-roc-pc"
>
> So, enable bydefault on the defconfig.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
> ---
> Note:
> This change set is applied on top of linux-rockchip, branch v5.7-armsoc/dts64.
> (git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git -b v5.7-armsoc/dts64)
> This change set was tested on ROC-RK3399-PC, an rk3399 based target.
> ---

Any update on this?

Jagan.
