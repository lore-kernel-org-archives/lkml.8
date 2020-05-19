Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6460C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B249207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4c9syE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgESBaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:30:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F1C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:30:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so648176pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LgMVdXCk9Y4Fkqf44jq13mswdAa1avDRlnZqO0g5o6o=;
        b=T4c9syE2N/TuNooFzWa/GS0n7gi6fof9ZrcCwd6tqzjUOuM4j0VWLLCqT9VlFt7eM8
         QnhCkYnEr/UzmOffONgE0umf1rJLWLpioxFKsjoyPwOCgUF/nA8qopO0/rJxaHqd77N8
         7G5NVL2LxnvgQLAY/YyCGviSXY7lSywSQZr3VeDUiKWYMNy1YMSrWd7sVzuOu1pMhE4G
         49AZTBtM+shipY67LlhyGB8FtDbLBTLrLGp9KbLGuoU+KAGvO0FS/8YE33dpY3FL0rhA
         PWvb6NKeV/5cBb85VRayY9AYTpQhwt7mj1pRyaneizRAmfWsPPy5my1sypTcg3T5BwWw
         0GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LgMVdXCk9Y4Fkqf44jq13mswdAa1avDRlnZqO0g5o6o=;
        b=RQBJgLVcmwu/HwYtl/Xl0VQEI2nxb2f5g5uW546eJI8yJ+TPx5mRCTWGCSX5GiZkPX
         jvYHos/+BUZaOiHhanZYqM0unnHuuKkOwqrRAC4nwAMds8XLxeK977b9XrVJO3bJkzwS
         +8k8+zTDGxA8rT0CEJuMMp9Ay/myK0o7rYm3LmrVF9YvfkaYypDSRXJLvBYINpBlGiTz
         fuJoN2LTtr8fuVtza9zNGxE9F/wUL7GtJDi678L8hm4Y4G+5nNpnTOVmawsXxfHIdZog
         B4quPtc59NKh8vGosgbse5xpFXklnYD/8k4F0drYnmmY4y5SLymoxu6QG9gzL58IL8yr
         dmfA==
X-Gm-Message-State: AOAM531bjYgJUc5RfxMJRCiPxZtIP4AovukqGF4DB4PmqDNsFUVylfSD
        dEOEN65KdoZmZABMiq5qbrvMYA==
X-Google-Smtp-Source: ABdhPJwN5uQ6ZRocOB6ItmMfmFwDisBz5cuvAIkR30rNXA5NEEadjVEZvbK2RsAgxdtE9h7sVXma+w==
X-Received: by 2002:a17:902:b98c:: with SMTP id i12mr4596397pls.41.1589851850376;
        Mon, 18 May 2020 18:30:50 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x10sm8441543pgr.65.2020.05.18.18.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 18:30:49 -0700 (PDT)
Date:   Mon, 18 May 2020 18:29:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200519012927.GT2165@builder.lan>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 May 22:17 PDT 2020, Viresh Kumar wrote:

> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hi Rob, Arnd and Jassi,
> 
> This stuff has been doing rounds on the mailing list since several years
> now with no agreed conclusion by all the parties. And here is another
> attempt to get some feedback from everyone involved to close this once
> and for ever. Your comments will very much be appreciated.
> 
> The ARM MHU is defined here in the TRM [1] for your reference, which
> states following:
> 
> 	"The MHU drives the signal using a 32-bit register, with all 32
> 	bits logically ORed together. The MHU provides a set of
> 	registers to enable software to set, clear, and check the status
> 	of each of the bits of this register independently.  The use of
> 	32 bits for each interrupt line enables software to provide more
> 	information about the source of the interrupt. For example, each
> 	bit of the register can be associated with a type of event that
> 	can contribute to raising the interrupt."
> 

Does this mean that there are 32 different signals and they are all ORed
into the same interrupt line to trigger software action when something
happens?

Or does it mean that this register is used to pass multi-bit information
and when any such information is passed an interrupt will be triggered?
If so, what does that information mean? How is it tied into other Linux
drivers/subsystems?

> On few other platforms, like qcom, similar doorbell mechanism is present
> with separate interrupt for each of the bits (that's how I understood
> it), while in case of ARM MHU, there is a single interrupt line for all
> the 32 bits. Also in case of ARM MHU, these registers and interrupts
> have 3 copies for different priority levels, i.e. low priority
> non-secure, high priority non-secure and secure channels.
> 

In the Qualcomm case we have 32 bits in a register where each bit
written will trigger an interrupt elsewhere in the SoC, as such the
mailbox is purely write only and the "read" side is handled by some
interrupt-controller.

The three copies just sounds like 3 (or 3 * 32) different mailbox
channels.

> For ARM MHU, both the dt bindings and the Linux driver support 3
> channels for the different priorities right now and support sending a 32
> bit data on every transfer in a locked fashion, i.e. only one transfer
> can be done at once and the other have to wait for it to finish first.
> 
> Here are the point of view of the parties involved on this subject:
> 
> Jassi's viewpoint:
> 
> - Virtualization of channels should be discouraged in software based on
>   specific usecases of the application. This may invite other mailbox
>   driver authors to ask for doing virtualization in their drivers.
> 
> - In mailbox's terminology, every channel is equivalent to a signal,
>   since there is only one signal generated here by the MHU, there should
>   be only one channel per priority level.
> 
> - The clients should send data (of just setting 1 bit or many in the 32
>   bit word) using the existing mechanism as the delays due to
>   serialization shouldn't be significant anyway.
> 
> - The driver supports 90% of the users with the current implementation
>   and it shouldn't be extended to support doorbell and implement two
>   different modes by changing value of #mbox-cells field in bindings.

I interpret Jassi's view as this is a channel that passes 32 bit
"messages".

> 
> Sudeep (ARM) and myself as well to some extent:
> 
> - The hardware gives us the capability to write the register in
>   parallel, i.e. we can write 0x800 and 0x400 together without any
>   software locks, and so these 32 bits should be considered as separate
>   channel even if only one interrupt is issued by the hardware finally.
>   This shouldn't be called as virtualization of the channels, as the
>   hardware supports this (as clearly mentioned in the TRM) and it takes
>   care of handling the signal properly.
> 

But if writes to the register is ORed together than it seems like the
hardware isn't supposed to pass multi-bit messages, but instead is
supposed to carry 32 individual signals - somewhat similar to the
Qualcomm block.

I don't see a problem with having a cascaded IRQ handler for incoming
notifications.

> - With serialization, if we use only one channel as today at every
>   priority, if there are 5 requests to send signal to the receiver and
>   the dvfs request is the last one in queue (which may be called from
>   scheduler's hot path with fast switching), it unnecessarily needs to
>   wait for the first four transfers to finish due to the software
>   locking imposed by the mailbox framework. This adds additional delay,
>   maybe of few ms only, which isn't required by the hardware but just by
>   the software and few ms can be important in scheduler's hotpath.
> 

So these 5 requests, are they conveyed by the signals [1,2,3,4,5] or
[BIT(0), BIT(1), BIT(2), BIT(3), BIT(4)]?

In the first case you have to serialize things given that e.g. signal 1
immediately followed by 2 is indistinguishable from 3.

If you signals are single-bit notifications then you don't need any
serialization.

Regards,
Bjorn

> - With the current approach it isn't possible to assign different bits
>   (or doorbell numbers) to clients from DT and the only way of doing
>   that without adding new bindings is by extending #mbox-cells to accept
>   a value of 2 as done in this patch.
> 
> Jassi and Sudeep, I hope I was able to represent both the view points
> properly here. Please correct me if I have made a mistake here.
> 
> This is it. It would be nice to get the views of everyone now on this
> and how should this be handled.
> 
> Thanks.
> 
> [1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515f/DDI0515F_juno_arm_development_platform_soc_trm.pdf , section 3.4.4, page 3-38.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/mailbox/arm-mhu.txt   | 39 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> index 4971f03f0b33..ba659bcc7109 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> @@ -10,6 +10,15 @@ STAT register and the remote clears it after having read the data.
>  The last channel is specified to be a 'Secure' resource, hence can't be
>  used by Linux running NS.
>  
> +The MHU drives the interrupt signal using a 32-bit register, with all
> +32-bits logically ORed together. It provides a set of registers to
> +enable software to set, clear and check the status of each of the bits
> +of this register independently. The use of 32 bits per interrupt line
> +enables software to provide more information about the source of the
> +interrupt. For example, each bit of the register can be associated with
> +a type of event that can contribute to raising the interrupt. Each of
> +the 32-bits can be used as "doorbell" to alert the remote processor.
> +
>  Mailbox Device Node:
>  ====================
>  
> @@ -18,13 +27,21 @@ used by Linux running NS.
>  - compatible:		Shall be "arm,mhu" & "arm,primecell"
>  - reg:			Contains the mailbox register address range (base
>  			address and length)
> -- #mbox-cells		Shall be 1 - the index of the channel needed.
> +- #mbox-cells		Shall be 1 - the index of the channel needed when
> +			not used as set of doorbell bits.
> +			Shall be 2 - the index of the channel needed, and
> +			the index of the doorbell bit within the channel
> +			when used in doorbell mode.
>  - interrupts:		Contains the interrupt information corresponding to
> -			each of the 3 links of MHU.
> +			each of the 3 physical channels of MHU namely low
> +			priority non-secure, high priority non-secure and
> +			secure channels.
>  
>  Example:
>  --------
>  
> +1. Controller which doesn't support doorbells
> +
>  	mhu: mailbox@2b1f0000 {
>  		#mbox-cells = <1>;
>  		compatible = "arm,mhu", "arm,primecell";
> @@ -41,3 +58,21 @@ used by Linux running NS.
>  		reg = <0 0x2e000000 0x4000>;
>  		mboxes = <&mhu 1>; /* HP-NonSecure */
>  	};
> +
> +2. Controller which supports doorbells
> +
> +	mhu: mailbox@2b1f0000 {
> +		#mbox-cells = <2>;
> +		compatible = "arm,mhu", "arm,primecell";
> +		reg = <0 0x2b1f0000 0x1000>;
> +		interrupts = <0 36 4>, /* LP-NonSecure */
> +			     <0 35 4>; /* HP-NonSecure */
> +		clocks = <&clock 0 2 1>;
> +		clock-names = "apb_pclk";
> +	};
> +
> +	mhu_client: scb@2e000000 {
> +		compatible = "arm,scpi";
> +		reg = <0 0x2e000000 0x200>;
> +		mboxes = <&mhu 1 4>; /* HP-NonSecure 5th doorbell bit */
> +	};
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
