Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B343C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5872076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="P/GCnQ92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgHSNug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:50:36 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:62435 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728562AbgHSNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:49:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597844963; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EEhI7wF8kLbLKbfiPmMz/0RWou71CWdCiWUHBmOFBVU=;
 b=P/GCnQ922uiCIoP6iiSagRgr8NEvv108SMsre2iy0mbMZBRMBgrtfk1StvBqn3oBLzjcB1Li
 pgj5CV2Snx+frXzdF0VE3g8P0SLMXuQIVonh47ABbKwbvqwKmWWqnWFOLTt4UC+v/E5kEboe
 TgftWfPQBitAlrfkMaX/zFQEFuM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f3d2dc97930b01478f55384 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 13:48:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6388BC433CB; Wed, 19 Aug 2020 13:48:56 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 805BFC4339C;
        Wed, 19 Aug 2020 13:48:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 19:18:54 +0530
From:   skakit@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: sc7180: Add sleep pin ctrl for
 BT uart
In-Reply-To: <20200817233341.GE2995789@google.com>
References: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
 <1595563082-2353-3-git-send-email-skakit@codeaurora.org>
 <20200817180158.GD2995789@google.com> <20200817233341.GE2995789@google.com>
Message-ID: <033e17dcf3af000b1c26c4d3d724f272@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thanks for reviewing the patches.

On 2020-08-18 05:03, Matthias Kaehlcke wrote:
> On Mon, Aug 17, 2020 at 11:01:58AM -0700, Matthias Kaehlcke wrote:
>> On Fri, Jul 24, 2020 at 09:28:01AM +0530, satya priya wrote:
>> > Add sleep pin ctrl for BT uart, and also change the bias
>> > configuration to match Bluetooth module.
>> >
>> > Signed-off-by: satya priya <skakit@codeaurora.org>
>> > ---
>> > Changes in V2:
>> >  - This patch adds sleep state for BT UART. Newly added in V2.
>> >
>> >  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 42 ++++++++++++++++++++++++++++-----
>> >  1 file changed, 36 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> > index 26cc491..bc919f2 100644
>> > --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> > +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
>> > @@ -469,20 +469,50 @@
>> >
>> >  &qup_uart3_default {
>> >  	pinconf-cts {
>> > -		/*
>> > -		 * Configure a pull-down on 38 (CTS) to match the pull of
>> > -		 * the Bluetooth module.
>> > -		 */
>> > +		/* Configure no pull on 38 (CTS) to match Bluetooth module */
>> 
>> Has the pull from the Bluetooth module been removed or did the 
>> previous config
>> incorrectly claim that the Bluetooth module has a pull-down?
>> 
>> >  		pins = "gpio38";
>> > +		bias-disable;
>> > +	};
>> > +
>> > +	pinconf-rts {
>> > +		/* We'll drive 39 (RTS), so configure pull-down */
>> > +		pins = "gpio39";
>> > +		drive-strength = <2>;
>> >  		bias-pull-down;
>> > +	};
>> > +
>> > +	pinconf-tx {
>> > +		/* We'll drive 40 (TX), so no pull */
>> 
>> The rationales for RTS and TX contradict each other. According to the 
>> comment
>> the reason to configure a pull-down on RTS is that it is driven by the 
>> host.
>> Then for TX the reason to configure no pull is that it is driven by 
>> the host.
>> 
>> Please make sure the comments *really* describe the rationale, 
>> otherwise they
>> are just confusing.
> 
> Ok, let's try to reason about the configurations.
> 
> I didn't find the datasheet for the WCN3991, but my understanding is 
> that
> it is an evolution of the WCN3998, so probably the states of the UART 
> pins
> are the same (signal names from the BT chip perspective):
> 
>      active   reset
> CTS    NP      PD
> RTS    NP      PD
> RX     NP      PU
> TX     NP      PD
> 
> Since this patch changes the DT let's use the signal names from the 
> host side
> in the following.
> 
>> RTS: NP => PD
> 
> I can see that this could make sense, a floating pin could indicate
> the Bluetooth controller that the host is ready to receive data, when 
> it is
> not.
> 
>> CTS: PD => NP
> 
> From a signalling perspective this should be no problem, since the 
> WCN399x
> has a pull-down on its RTS signal in reset, and otherwise will drive 
> it.
> IIUC there should be no power leakage without a pull, so I think this
> should be ok.
> 

With CTS having no-pull, we are not seeing any power leakages.

>> TX: +output-high
> 
> IIUC this only has an impact when the pin is in GPIO mode, i.e. in the 
> sleep
> config. If that's correct, does it even make sense to specify it in the 
> default
> config?
> 
> Besides that, what is the reason for this change? I was told in another 
> forum
> that Qualcomm found this to fix problems at UART initialization and 
> wakeup,
> without really understanding why. That's not great.
> 

"output-high" was present in IDP dts since Bring-up, we've validated on 
the latest code-base and see that "output-high" is not required, will 
remove it.

> I'm no expert in this area, but my guess is that forcing the TX signal 
> to high
> in certain states is needed to not have it floating (no pull is 
> configured),
> which could generate garbage on the Bluetooth RX side. But is it really
> necessary to actively drive it to high? Wouldn't it be enough to 
> configure a
> pull-up when it isn't actively driven (i.e. in sleep mode)?
> 
> In a quick test wakeup from Bluetooth worked when configuring a pull-up 
> only in
> sleep mode. Could you test this on your side or provide a rationale why 
> TX needs
> to be actively driven to high?
> 

We have tested by keeping pull-up for TX in sleep state(removed 
output-high) and wakeup is working fine with Bluetooth. Will remove the 
output-high from both default and sleep states.

> Thanks
> 
> Matthias

Thanks,
Satya Priya
