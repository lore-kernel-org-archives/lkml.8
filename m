Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C2C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D5A20678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BjiJV3Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbgDBUPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:15:49 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43507 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:15:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id g24so1828248uan.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msGUQVJku9LyJfG6SdcO2M9YOo532jnVn5mu5AdgG5w=;
        b=BjiJV3KtRqlmVSMawM+CqNHpoUrOgtBwK5VFs4XMeLmwOXb1GpsZNIfq69lrKDlvg+
         NbUxXEluca5cHHziGQIlaCpa2ZBtJT9Q5DOkwBbD6kNFvX+ortLEryXUdjOrMunBACvj
         F25sgO1iXEMdXmOo7CdjbevYpEvDlLYwJpfL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msGUQVJku9LyJfG6SdcO2M9YOo532jnVn5mu5AdgG5w=;
        b=MHFIQ1sg6BRc9Iq9uGz5Zg2wG5TstRrfAfEFtX6cuAVtaYQf6YLUzU/vcE+0Kfo2sH
         M7Anjv1HXETWbsboBBiytvCWwSPGybG+eRWnd4xo/sU2ECWXuQIsei+R836m+vF55m0v
         5PNiqg9i/QzvQBgO/+UJetIMKtyWeHDQFmXMwF04p0U4jFwXROTMVJ2+pkGtRQHbj4FL
         31ie7ccw6Jdmfmt3kx6Mfa+oi7wKvrIwXR0CYPYR2A8egB6+xclyINQ0J5enowBHkN+L
         7Jfg+GEAvZS7YKhl5jebG29SeU4qwZZs95ain7JzeKaB3ag+40cxxfPKFxy5oZ/lAtYS
         99bw==
X-Gm-Message-State: AGi0PuYXrqc4j9RcL+lq/JLUgZ+b6zftenyn+gDKhgEKuhCkSeCMW4E3
        FN+TINCfHSaPsUhO6PIFpmMCEGjS8Jg=
X-Google-Smtp-Source: APiQypKD+Y61bttwtKgHKb4jG56uwSwA6YXxvKcSEkdyMRjizOPSvgIceed21Aha/mz+IL8Nm6nUdw==
X-Received: by 2002:ab0:1158:: with SMTP id g24mr3904067uac.55.1585858546124;
        Thu, 02 Apr 2020 13:15:46 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id h6sm1544890vsl.12.2020.04.02.13.15.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:15:45 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id x206so3429483vsx.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:15:45 -0700 (PDT)
X-Received: by 2002:a67:1e46:: with SMTP id e67mr3977870vse.106.1585858544905;
 Thu, 02 Apr 2020 13:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200311231348.129254-1-dianders@chromium.org>
 <20200311161104.RFT.v2.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid> <1fd57a5e-067c-5b2e-c9d5-5a1836e55273@codeaurora.org>
In-Reply-To: <1fd57a5e-067c-5b2e-c9d5-5a1836e55273@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 13:15:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfLsvFbhAb4iEnb4zj8U_LK7zzerAz-NH6R1TQNig_tw@mail.gmail.com>
Message-ID: <CAD=FV=XfLsvFbhAb4iEnb4zj8U_LK7zzerAz-NH6R1TQNig_tw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 02/10] drivers: qcom: rpmh-rsc: Document the
 register layout better
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 1, 2020 at 1:14 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> > + * - The first TCS block is special in that it has registers to control
> > + *   interrupts (RSC_DRV_IRQ_XXX).  Space for these registers is reserved
> > + *   in all TCS blocks to make the math easier, but only the first one
> > + *   matters.
>
> First TCS block is not special, the RSC_DRV_IRQ_XXX registers are common
> for all

Ah.  I think I see it now.  It's much easier to talk about this with
my old struct definition.  Right now I have it documented as:

/* 0x2a0 = 672 bytes big (see RSC_DRV_TCS_OFFSET) */
struct tcs_hw {
  u32 irq_enable;
  u32 irq_status;
  u32 irq_clear;
  char opaque_00c[0x4];
  u32 cmd_wait_for_cmpl;
  u32 control;
  u32 status;
  u32 cmd_enable;
  char opaque_020[0x10];
  struct tcs_cmd_hw tcs_cmd_hw[MAX_CMDS_PER_TCS];
  char opaque_170[0x130];
};

...but you're saying that it's actually:

/* 0x2a0 = 672 bytes big (see RSC_DRV_TCS_OFFSET) */
struct tcs_hw {
  u32 cmd_wait_for_cmpl;
  u32 control;
  u32 status;
  u32 cmd_enable;
  char opaque_010[0x10];
  struct tcs_cmd_hw tcs_cmd_hw[MAX_CMDS_PER_TCS];
  char opaque_160[0x140];
};

So it's still 672 bytes big but the extra "opaque" at the end is where
those bytes go.  Then, before the first TCS, there's actually 0x10
bytes of IRQ stuff.  OK, I will adjust the diagrams.

-Doug
