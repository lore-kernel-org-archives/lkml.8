Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABBCC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E74206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJPxmASU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409693AbgDPP1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410294AbgDPP1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:27:01 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E3C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:27:01 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u10so2957263ual.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5jNCJ+HTEfYq0vmDWY4nGVZs4XHihE5XqwhXEt7AJ8=;
        b=tJPxmASU7XIeA0JQhgsePcYmiH9byUljlJ7sXQg3Zbrci8tbFlq0pJ8j3buqYxbBS8
         tx/SnwCQNJgKqW0j7B3jWV+VbDWnaHa5VrRhAtb/B2z2JyzGkR4onH/k6OPH2u+N/e+E
         jKJA2BKgHWc0JlRqbUU18SSO9D12VEbZs40RbGqnvfSnVBHtA6nmQJQPDctGwL+pj8bO
         86Gtxvfp9wGt8K3g1anybFVBVyeA3XQRYWqYSvRonzJk01c0jG5TUfczKmaG4USF6hUF
         ut0chu1TX/jvBhEKiJHeDi3d3J5dfgsHSZi7EYDc3xWDlLFRz0Ge5dNSwOV0kkFhjQZV
         knYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5jNCJ+HTEfYq0vmDWY4nGVZs4XHihE5XqwhXEt7AJ8=;
        b=taoguzOvgQBakT/8BnSwtZUBhKqU0Rvu6Ch7XB8JlNmOGcooPu0FbWqcwGC9Sqw30F
         N+nxHHzmZdF3Lo0v3g20FQ636rb/gO1xTENHEGtd+Ay7ajsTDVh7nhz3RihfKVTkyVc4
         1NFuzyCD3pS79WSs/FTj1Gt3Nps50ztNXPFWEwbK3dvxwLpT9W1vP7mwB7tZORbyrNWD
         K/1nibcp6aQ20gS0CLbkvjLssQ++3tH+hICsXb41w05NDC8INMbz5HJCDyRYXDyben9e
         vO7kNp+8ZQo2zLS9FuqwPEeBzeEATVnHK6js8bAXIINih9sfcQvkboa9moJEO8naOp+Z
         VxKg==
X-Gm-Message-State: AGi0PuZDBTUS3B5SXDkf2QDIv9Isvq/fcFsf20GJ4jKNhFLu59dg8lVp
        0nGH/Am7II91X5pWIda8JwUCMcbwxZt0UURSpjo3nw==
X-Google-Smtp-Source: APiQypIdHzCCVnGwXbE+1fn376c80PaYgJJ94kmCBTdhFbUdb3aFSclxX08a2sZN6B7MhFXdI0SRLbc67BCe3fqu4xA=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr9324947uap.19.1587050820198;
 Thu, 16 Apr 2020 08:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <1586706808-27337-1-git-send-email-vbadigan@codeaurora.org>
 <1586706808-27337-3-git-send-email-vbadigan@codeaurora.org>
 <CAPDyKFobBGDYMGmkpTcmKVrnT7MywM5=xaOx86f91ay6c7DUWw@mail.gmail.com> <abe9cee2-dce4-c887-cece-5a321e4852bd@codeaurora.org>
In-Reply-To: <abe9cee2-dce4-c887-cece-5a321e4852bd@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 17:26:24 +0200
Message-ID: <CAPDyKFrBEoJdJuh9KyBf8MNuAXTy9HCr4GfKPRZpa61FaZHYHA@mail.gmail.com>
Subject: Re: [PATCH V1 2/4] mmc: sdhci-msm: Enable MMC_CAP_NEED_RSP_BUSY host capability
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 16:49, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Hi Ulf,
>
> On 4/16/2020 5:46 PM, Ulf Hansson wrote:
> > On Sun, 12 Apr 2020 at 17:54, Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> >> sdhci-msm controller requires the R1B response for commands that
> >> has this response associated with them.
> >>
> >> So enable MMC_CAP_NEED_RSP_BUSY capability.
> > I assume this potentially should be considered as fix and tagged for stable?
> Yes Stable flag can be applied to this.
>
> Patch with MMC_CAP_WAIT_WHILE_BUSY cap also needed besides this.
> Shall I push V2 with stable flag?

Ah, so maybe squash both into one patch to simplify for stable?

Yes, please add a stable tag in v2.

>
> > Another question, if there is there an upper limit of the busy timeout
> > in the HW (cmd->busy_timeout) or does the driver use a software
> > timeout that is adjustable?
>
> The max supported h.w busy timeout value on qcom h/w 21sec.

Alright, that sounds like it should be sufficient for most cases. But
perhaps not for eMMC sanitize.

How do you cope with the situation when the R1B response is passed to
the driver and the cmd->busy_timeout exceeds the 21s?

[...]

Kind regards
Uffe
