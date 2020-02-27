Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC39C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839CB2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMG5VflR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgB0VxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:53:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43348 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgB0VxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:53:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id s23so534473lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akb/fqWb9RAKIbbLYDDh8qkuoGYS5G+iOCImBrzoF9o=;
        b=TMG5VflR3I+CGPW+mSXF7fJBlkIgbvu1pHHgkcCLliyNx/65WX4EateAFJ+aYYIZTw
         c3laEpZS9R7qXtce7smYE4n1H0nZi18snVj03jIXMRsHgoFOyMPcwQBWb+g9rcCNCD28
         PdCGEoz3ivKvIuWNhKqTW1465oIKHlXJl+83w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akb/fqWb9RAKIbbLYDDh8qkuoGYS5G+iOCImBrzoF9o=;
        b=H1miuGhb79Gw1B+gG/IjKqaRLEqUW1O9hgnypac0suyv6Z6iuAX6lINGF4lZB2qSN1
         MSO8zwT170y5D04a7V8Vm80PFw/SsS0QJDwfs+hh6lJKpvCN1cDhQAFlEXaPzi+ymy20
         FHRm4jnIYAw6TSVfHmYV1gGlPlIusIKYLSaRfSANO6x/Vwrm5dSYX/6fOGbtzISgF7ka
         DgeCUmes7MBGr0+qeVve8+UFe/1NDCZoNpdltqqd1g/zvx5pjhU7pLXsoDg1sQCQUP8W
         ooKV9PkXtwwqZoI8uWrMnGvY9d2cA6PszYqMClncrw79uSW7gNQcSE2LmYagRGJHoTkP
         xiBA==
X-Gm-Message-State: ANhLgQ1rsOb9Racm/ct+vPJB9dKJuo20g8CfNeiAjhHXJ55oecV3AsmR
        mdewix3xl+uUPmpKYOFeQZkLVu9E0Zw=
X-Google-Smtp-Source: ADFU+vvcxzbnnv+nss5sxjExLYNTx1fGB96CL8JJjUQfS+NTDVsULEeLVjrP4eLdKsyxuVOLOPENVQ==
X-Received: by 2002:ac2:59c7:: with SMTP id x7mr747962lfn.148.1582840399602;
        Thu, 27 Feb 2020 13:53:19 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w24sm2795491ljh.26.2020.02.27.13.53.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 13:53:18 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id w1so971657ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:18 -0800 (PST)
X-Received: by 2002:a05:651c:1a2:: with SMTP id c2mr734150ljn.79.1582840398185;
 Thu, 27 Feb 2020 13:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20200209183411.17195-1-sibis@codeaurora.org> <20200209183411.17195-6-sibis@codeaurora.org>
In-Reply-To: <20200209183411.17195-6-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 13:52:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft755hYH7ue=fv2jvofejoWHZaguji6D-M1qHup-3SJTwQ@mail.gmail.com>
Message-ID: <CAE=gft755hYH7ue=fv2jvofejoWHZaguji6D-M1qHup-3SJTwQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
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

On Sun, Feb 9, 2020 at 10:35 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
