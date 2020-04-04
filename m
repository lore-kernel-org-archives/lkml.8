Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706DC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDABB20731
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alUJeSWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDDBHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:07:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39670 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgDDBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 21:07:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id k18so3491830pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6b2gnL33BXhVFyfbJth5+UU7eciSHYX3oxtDKEDuDA=;
        b=alUJeSWDQbazGmCHaD3vGtuEij3VFxX3HTi56q8fbqaiBp7/Y6J7p4a0acMrl7kInW
         X0JbVTtUVvSwa+p2769ApqQW7OcZsWyXCQkuQCxepnyx8UF3+h0nm3E2wSbAjzoh6pmH
         YX5cL9Gly/HX3522R8CBtJKjQTggV2WVU4SLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6b2gnL33BXhVFyfbJth5+UU7eciSHYX3oxtDKEDuDA=;
        b=YLgrMMHSc7KXRy8nDcaOuDuLDsWNN309nU8N1cw2ve97heuxdhuhiKTI1339RqIqx4
         DB09pIKzwzJ98FwIP89H/huihupWzbYvy+bPqA1T8qR3pRD8G4rcO7iL4Dy6BWLy2z5h
         /VpzYA9a9GaGTAJY5cbU5uAGzg9rsBIMGnudjpOvVZYvfF9SouyIaR9QS7Y+YsesDzXr
         jLhTgAt0CC0fY49N8eAzVYHA/+aXoZF366kHP4ClY+19O+LX+AlHvNK0L7liTFFsgxcC
         06Xzp200XxeAynpcm8dDUVnykKM8VxHjlg558gOWVLbQO0pj6SoOETAOj1zAFadIPWzO
         ffzQ==
X-Gm-Message-State: AGi0PuYlZigSO7eCrkXxC5t9PsD/hnFvxEp8hmnbz4UN3ISlXqyvXGhd
        FsFB8kU7t9M/C/EeWyrm4qh/4kI9lJvRtQ==
X-Google-Smtp-Source: APiQypKJ04nJI3wUcRsWYkaBigvP6WO+nKgFIj8ZIaxpW/1JRSLoolr3/h3EKbcG9wWitUZcABQn+Q==
X-Received: by 2002:a17:90b:2397:: with SMTP id mr23mr12731256pjb.88.1585962464936;
        Fri, 03 Apr 2020 18:07:44 -0700 (PDT)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com. [209.85.210.174])
        by smtp.gmail.com with ESMTPSA id y123sm6530404pfb.13.2020.04.03.18.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:07:44 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id a24so4468667pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 18:07:44 -0700 (PDT)
X-Received: by 2002:a1f:e546:: with SMTP id c67mr8715562vkh.38.1585962045690;
 Fri, 03 Apr 2020 18:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200403052900.258855-1-evanbenn@chromium.org>
 <20200403162742.v2.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid> <CAODwPW_iSK_d6EHCk7QUVF7=bHVLuUYHX5mfapf+yeyuHHdNZA@mail.gmail.com>
In-Reply-To: <CAODwPW_iSK_d6EHCk7QUVF7=bHVLuUYHX5mfapf+yeyuHHdNZA@mail.gmail.com>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Sat, 4 Apr 2020 12:00:18 +1100
X-Gmail-Original-Message-ID: <CAKz_xw3W3xWBfspj0DmbR-p8qF9A+sSsuT_euqmYNbx=47HpoQ@mail.gmail.com>
Message-ID: <CAKz_xw3W3xWBfspj0DmbR-p8qF9A+sSsuT_euqmYNbx=47HpoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: Add new arm_smd_wdt watchdog driver
To:     Julius Werner <jwerner@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 9:56 AM Julius Werner <jwerner@chromium.org> wrote:
>
> > +       wdd->info = &smcwd_info;
> > +       /* get_timeleft is optional */
> > +       if (smcwd_call(SMCWD_GET_TIMELEFT, 0, NULL))
>
> How is this supposed to work? A firmware that implements this call
> would return the time left here which may not be 0 (maybe the watchdog
> was already primed by the bootloader or whatever), so smcwd_call()
> would interpret it as an error.
>
> I think the cleanest solution would be to stick to the same return
> codes in a0 and use a1 to report the time left when a0 is
> PSCI_SUCCESS. This is more consistent with SMCWD_INIT too.

Yes you are right, I have the wrong return code in the get_timeleft
implementation. It should use ->a1 for the actual timeleft, a0 is for
the error code.

Here smcwd_call returns the error code, which is NOT_IMPLEMENTED if
the firmware does not implement timeleft. The timeleft itself cannot
return error codes else we would just return that there I guess.
