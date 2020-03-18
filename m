Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319FBC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E4620767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="pkpalXpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCRJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:11:07 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35699 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:11:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id m9so15945626vso.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5Zpp1lwuKFsHZwyKtq5kZrgcIvyGzbMByBBkkzuDxo=;
        b=pkpalXpFb+LL0W1iA6cUhuZFLFQQWCdIT3oY0LwzC4hspvtZVvFHSYVcP2yXDKjrKD
         i1BD6uReLlgKC/zyVdUmwvNkjERphnlcbXdkUaIUrK5b3I0dcrrQ1qbIZLCJADdxIZSp
         CtKBzRK6vS+GBJmKAxH7cUSC+IMpZyT9//fFOjqvlLxYJzndi22u6BRM/0rJ0w9jGniO
         c9+RK6axNk/1Crwuh6WrmiTuHFPAUIbVhpZC+m4hGCjVJsLlG4iksQy6vmY1b8tnaQ/8
         cVHLdJQQoDCXM/0mWrDUG8J1hSQadZzpNsvKXO/0TRyAXHBUENBwHVhVtHtKAPPdtyuc
         B/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5Zpp1lwuKFsHZwyKtq5kZrgcIvyGzbMByBBkkzuDxo=;
        b=ndVuceE/trA+IaHtrFB6vqx+Wtqg5UjdbX8M37UwevaWtBHhuLSFIgn26XgdaDuT/M
         8TxalH9lC9PogmXmNrTHmi22Md1juOggQNpviIuVxrp+/5aFnwBnp0dbsCxKxYqsfRQ8
         0kz+iI4ELOXP1RRi1Oy9VS8pMQaa85dW6rMUDiYz5zF6zwNO2ekYv97aiut20APcxhgP
         pEv8LxnI6ngku+33wccE/4qVBB225Kp6YBpHIq9oslHLsHuGhBIaYYZdRjnWs3OV3CIN
         XlXGfN4WMM5xb3Qo30II+X68BwDXu4HWS6B0kXRU1w7e7sQvAzDpP0OGdDl//iheFZjG
         K71Q==
X-Gm-Message-State: ANhLgQ1GXZRN7bRoMowbaXUSrjavXIcAPzaINVfXSpYU9w/n09jS/JRJ
        L+rLV421XBFUbm3ONJFSUNQu0oSlZrizyk5LM0B2Rw==
X-Google-Smtp-Source: ADFU+vt11ShWCw4hpQ84mzHUvKXgXfobrzKPRozN+fntpbNeo4Ni35ZtpB5EIB9Vn3LrVZ0Zn5Iq8e6kqWTCDgf80T8=
X-Received: by 2002:a67:69d5:: with SMTP id e204mr2123868vsc.159.1584522658467;
 Wed, 18 Mar 2020 02:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <1584430804-8343-1-git-send-email-rkambl@codeaurora.org>
 <CAD=FV=VLZ4RQQuji=1kKE5EnqrpY0M=U_G8XigAWAaZ8mxc=eg@mail.gmail.com> <fc7f250e-aa85-0835-8bc4-8274235c74d0@codeaurora.org>
In-Reply-To: <fc7f250e-aa85-0835-8bc4-8274235c74d0@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 18 Mar 2020 14:40:47 +0530
Message-ID: <CAHLCerMCrNdKUmRww4EFctU8cojh6Fqhs7gpux3SNCSwYUBOvQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Changed polling-delay in
 Thermal-zones node
To:     "Rajeshwari Ravindra Kamble (Temp)" <rkambl@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, Sandeep Maheswaram <sanm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:49 AM Rajeshwari Ravindra Kamble (Temp)
<rkambl@codeaurora.org> wrote:
>
>
> On 3/17/2020 10:20 PM, Doug Anderson wrote:
>
> Hi,
>
> On Tue, Mar 17, 2020 at 12:42 AM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Changed polling-delay and polling-delay-passive to zero as per
> the requirement.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 100 +++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 50 deletions(-)
>
> It probably wouldn't hurt to mention in the commit message that this
> is because the thermal sensor interrupts are all hooked up and thus
> the polling is not a useful thing to do.  ...but other than that:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
>
> Hi Douglas
>
> I didn't  get your comment.
>
> Thanks,
> Rajeshwari

I think he means that you haven't mentioned WHY this patch is needed
in the message. The reason you should mention is "to disable polling
mode of the framework since interrupts for tsens are already
configured."

Regards,
Amit
