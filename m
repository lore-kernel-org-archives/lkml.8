Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BEDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5816E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YkGBAuYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCQQvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:51:15 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46799 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgCQQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:51:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id z125so14348339vsb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+4aJa7IpjGZCPI3Fh6cthpiIv4IQ9AsMliiqsg2mts=;
        b=YkGBAuYA3wpjmbt2VnCUIMI0xJVISAM2HQ+4vpw4N5qYFuYvkK/XDLG95zf96seDTj
         JLTzADnRCAjLkajykdhv5TBY+UyCAAt4Fg0/W1SluewltWU9Q42ysjJuhoOH4sDheabF
         gAhRDlrX3PZyU1wGBAo+zTG5FaY2a1pPsQWXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+4aJa7IpjGZCPI3Fh6cthpiIv4IQ9AsMliiqsg2mts=;
        b=B2TbDsAEObz6IiQtMBplE1kstKK5h2Ze4NuPMGc6EuMsTVbcc9p/NTdYuqi6HV7DNu
         8JH0zomoVK6avJfezTVIIdMGe8L5DG6O5Ns3xR8QBu+Qp++UGnbw8o27sc/0I7qV5DcV
         7owHe+ik+sKc2jq4nTz+2W38BoCM9y8clouJGoBz5jIEc1OxFUFrjeV8JAEOJoowF3uK
         +j1LeWWFyD58O1A2Ldas5rzpM4jcP3H5uv66cpISoxDSxDivmQz4ec9t0Mp2lRYXjZH7
         6gc9DsTfTSPqQlLt0ShYHdtMArDb8+2BfBIskaKy8r5F1rXzhpOA9ocxuKSp2sWBTdGg
         vKbA==
X-Gm-Message-State: ANhLgQ0VnEfxSyal4Zub+Y/jcVB7MWExBpsvQC6fbyJS6U2lMTaSA3nX
        V7gefAYuBkSVm+8QQ1ihGy+QxL7bx0M=
X-Google-Smtp-Source: ADFU+vuArJ1kz4XZIHB/khjtglVh8V9C8jKUovxSVqB2TeBCvYgSjwbrMr5+tq2yptWcJQpODK5igA==
X-Received: by 2002:a67:d104:: with SMTP id u4mr4692770vsi.33.1584463873031;
        Tue, 17 Mar 2020 09:51:13 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id m184sm1588885vkb.41.2020.03.17.09.51.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 09:51:12 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id t3so6167721vkm.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:51:12 -0700 (PDT)
X-Received: by 2002:a1f:2305:: with SMTP id j5mr155171vkj.40.1584463871622;
 Tue, 17 Mar 2020 09:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <1584430804-8343-1-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1584430804-8343-1-git-send-email-rkambl@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Mar 2020 09:50:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLZ4RQQuji=1kKE5EnqrpY0M=U_G8XigAWAaZ8mxc=eg@mail.gmail.com>
Message-ID: <CAD=FV=VLZ4RQQuji=1kKE5EnqrpY0M=U_G8XigAWAaZ8mxc=eg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Changed polling-delay in
 Thermal-zones node
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, Sandeep Maheswaram <sanm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 17, 2020 at 12:42 AM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Changed polling-delay and polling-delay-passive to zero as per
> the requirement.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 100 +++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 50 deletions(-)

It probably wouldn't hurt to mention in the commit message that this
is because the thermal sensor interrupts are all hooked up and thus
the polling is not a useful thing to do.  ...but other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
