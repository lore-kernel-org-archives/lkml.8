Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7BB21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599680123;
	bh=FmS+Mv6vcINTmrnnqIDU3Kws7cA+nxloDJR5zK7sEXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R5OXX2jYXRedf9/4+k5aURbVbwlL9KJdDtclnjENdCYDqszZ1fzj9Gn+Bi49umN/E
	 R4iTeYlwT7io+hseqkEma4Z6q3+CFr681V1V8Lub/4dj87fyuisIoPw+hqz/LsdIYX
	 kzX8PYeqgYnJP3/v4tNQrKqAleDvfOxwpEwZGMis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIITfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIITfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:35:20 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AD921D90;
        Wed,  9 Sep 2020 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599680119;
        bh=FmS+Mv6vcINTmrnnqIDU3Kws7cA+nxloDJR5zK7sEXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r7qAUmg2QIRvIL3999aTY5BQxI3zZUF0G59WZWClia4lwuEyLefIa0N7Px7nixXMz
         iPgcgEOBHlS5FMNfDhvR4Xohayt+ImWmLBeNDk25ZVf31fyC8SPkE1rrbkGLd1ykrZ
         030IaQd5RMO7tYiTZKgZjQPf09Z9W7d+DecWkIMo=
Received: by mail-ot1-f46.google.com with SMTP id h17so3348315otr.1;
        Wed, 09 Sep 2020 12:35:19 -0700 (PDT)
X-Gm-Message-State: AOAM533LfyCmP8DZdmop+uPxXYOWEhA4PCR9tpLXDLr9NQzG7SONkDC6
        Ea/34hi3LN7zmvCVBKTajxv73vPfYuCVkB5b+A==
X-Google-Smtp-Source: ABdhPJznHG+uQgUJEl4IEka4J1X8lmxaSNKo+q+Y2KEZrtoPPgNb0ghaBsjXA/g4VSMP2vkJC6ZO1mqPNi0+QJRCUAM=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1741993otp.129.1599680118260;
 Wed, 09 Sep 2020 12:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <ee7439aea0c2076aab5dab26d8266d5faab01b6b.1599632119.git.viresh.kumar@linaro.org>
In-Reply-To: <ee7439aea0c2076aab5dab26d8266d5faab01b6b.1599632119.git.viresh.kumar@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Sep 2020 13:35:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJadbhUSiVQWAL5uDzqpkDPWT+M7nGDVJ7Wyf4zHkPvEg@mail.gmail.com>
Message-ID: <CAL_JsqJadbhUSiVQWAL5uDzqpkDPWT+M7nGDVJ7Wyf4zHkPvEg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 12:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> From: Sudeep Holla <sudeep.holla@arm.com>
>
> The ARM MHU's reference manual states following:
>
> "The MHU drives the signal using a 32-bit register, with all 32 bits
> logically ORed together. The MHU provides a set of registers to enable
> software to set, clear, and check the status of each of the bits of this
> register independently.  The use of 32 bits for each interrupt line
> enables software to provide more information about the source of the
> interrupt. For example, each bit of the register can be associated with
> a type of event that can contribute to raising the interrupt."
>
> This patch thus extends the MHU controller's DT binding to add support
> for doorbell mode.
>
> Though the same MHU hardware controller is used in the two modes, A new
> compatible string is added here to represent the combination of the MHU
> hardware and the firmware sitting on the other side (which expects each
> bit to represent a different signal now).
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - New compatible string and minor reformatting.

Fine with me despite whatever I may have said in the past. Whatever
puts this to rest finally.

> - Not sending as RFC anymore.
>
>  .../devicetree/bindings/mailbox/arm-mhu.txt   | 44 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)

I'd really like this converted to schema first given it's more than a
minor change, but I don't want to hold things up. (Though, where's the
new driver?)

> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> index 4971f03f0b33..1adc441a2c63 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> @@ -10,21 +10,41 @@ STAT register and the remote clears it after having read the data.
>  The last channel is specified to be a 'Secure' resource, hence can't be
>  used by Linux running NS.
>
> +Doorbell mode: The MHU drives the interrupt signal using a 32-bit
> +register, with all 32-bits logically ORed together. It provides a set of
> +registers to enable software to set, clear and check the status of each
> +of the bits of this register independently. The use of 32 bits per
> +interrupt line enables software to provide more information about the
> +source of the interrupt. For example, each bit of the register can be
> +associated with a type of event that can contribute to raising the
> +interrupt. Each of the 32-bits can be used as "doorbell" to alert the
> +remote processor.
> +
>  Mailbox Device Node:
>  ====================
>
>  Required properties:
>  --------------------
> -- compatible:          Shall be "arm,mhu" & "arm,primecell"
> +- compatible:          Shall be "arm,mhu" (in data transfer mode) or
> +                       "arm,mhu-doorbell" (in doorbell mode) and
> +                       "arm,primecell".
>  - reg:                 Contains the mailbox register address range (base
>                         address and length)
> -- #mbox-cells          Shall be 1 - the index of the channel needed.
> +- #mbox-cells          Shall be 1 - the index of the channel needed,
> +                       when used in data transfer mode.
> +                       Shall be 2 - the index of the channel needed, and
> +                       the index of the doorbell bit within the
> +                       channel, when used in doorbell mode.
>  - interrupts:          Contains the interrupt information corresponding to
> -                       each of the 3 links of MHU.
> +                       each of the 3 physical channels of MHU namely low
> +                       priority non-secure, high priority non-secure and
> +                       secure channels.
>
>  Example:
>  --------
>
> +1. In data transfer mode
> +
>         mhu: mailbox@2b1f0000 {
>                 #mbox-cells = <1>;
>                 compatible = "arm,mhu", "arm,primecell";
> @@ -41,3 +61,21 @@ used by Linux running NS.
>                 reg = <0 0x2e000000 0x4000>;
>                 mboxes = <&mhu 1>; /* HP-NonSecure */
>         };
> +
> +2. In doorbell mode
> +
> +       mhu: mailbox@2b1f0000 {
> +               #mbox-cells = <2>;
> +               compatible = "arm,mhu-doorbell", "arm,primecell";
> +               reg = <0 0x2b1f0000 0x1000>;
> +               interrupts = <0 36 4>, /* LP-NonSecure */
> +                            <0 35 4>; /* HP-NonSecure */

The binding says there are 3 interrupts.

> +               clocks = <&clock 0 2 1>;
> +               clock-names = "apb_pclk";
> +       };
> +
> +       mhu_client: scb@2e000000 {
> +               compatible = "arm,scpi";
> +               reg = <0 0x2e000000 0x200>;
> +               mboxes = <&mhu 1 4>; /* HP-NonSecure 5th doorbell bit */
> +       };
> --
> 2.25.0.rc1.19.g042ed3e048af
>
