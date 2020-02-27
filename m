Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC5C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4D2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J2HlgJvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgB0VxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:53:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44693 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbgB0VxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:53:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id 7so529190lfz.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBxG5p3NtRm8vJZ9SrWGbyvBMMrZfbcd6sEkh872Wpk=;
        b=J2HlgJvotRvArCBanF+nmCfWdRF8pDW66BdmQms7zfNgyS7lRauYT3bDS5OboDi2DM
         ifdOo7gJ8d+ZZyQcHW2Fg38xWkUDpHzNNzVJKJHCx5P3h/fPWvAmbJsxP/jGHk9JHs8h
         efR20upDTYOd5dbP0XxRZK/5y/3u0AYyvc+eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBxG5p3NtRm8vJZ9SrWGbyvBMMrZfbcd6sEkh872Wpk=;
        b=GiVdyTh1zZGyE62bd/cXzL+lvSLyN3RFgl902nI4otZ81j8D+V6B7Pqvgp0nYaNUub
         TVDGxeWw3lkohscn1y1D56i0G34bTU5XZvmshWPwrH/oja9osW7+egMhGa9aTNInmajz
         isZc2xMbKYxtDf46fjT7uWupyshQ04mthcRIkHy+ET4kYhSOt+vuwhnJ69MYVST4WNux
         By1EF0v87i4vEKIUABpj/Pm2N1cj/OB0+cqIhKCRA7yCOwVm1SpjcgMNqwaDBHLvAIvS
         jyydRvbh6Kb9dW3UYy7/Tp9fS2HAoYAFN+iX6Sxz6sUI3Z7q1tumW7zDeiqt0mc98zCe
         pOcA==
X-Gm-Message-State: ANhLgQ1oH6IsRqO/4r/uzic6ip68mqBwMt+6UssKyWo8bfSCWSL03iaq
        HLXTHZPjZ4IvlifJoNopAWMXzh0x/RQ=
X-Google-Smtp-Source: ADFU+vt/ZRbFjJuwrqqNkM8fAOCdCD8xNYrAVM9ucXdffUNV72nm1IknYISwaEslMTdyRWnzedYOvw==
X-Received: by 2002:a19:3f4f:: with SMTP id m76mr792555lfa.63.1582840391185;
        Thu, 27 Feb 2020 13:53:11 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i67sm3586634lfd.38.2020.02.27.13.53.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 13:53:10 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id c23so550603lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:10 -0800 (PST)
X-Received: by 2002:ac2:5226:: with SMTP id i6mr725638lfl.99.1582840389628;
 Thu, 27 Feb 2020 13:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20200209183411.17195-1-sibis@codeaurora.org> <20200209183411.17195-5-sibis@codeaurora.org>
In-Reply-To: <20200209183411.17195-5-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 13:52:33 -0800
X-Gmail-Original-Message-ID: <CAE=gft5OOQVKe9ow2ApbEAjmgqRc05hHVxUi4os+4-gvpMh4Yg@mail.gmail.com>
Message-ID: <CAE=gft5OOQVKe9ow2ApbEAjmgqRc05hHVxUi4os+4-gvpMh4Yg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] interconnect: qcom: Consolidate interconnect RPMh support
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 10:34 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add bcm voter driver and add support for RPMh specific interconnect
> providers which implements the set and aggregate functionalities that
> translates bandwidth requests into RPMh messages. These modules provide
> a common set of functionalities for all Qualcomm RPMh based interconnect
> providers and should help reduce code duplication when adding new
> providers.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Assuming Georgi's comments get addressed:

Reviewed-by: Evan Green <evgreen@chromium.org>
