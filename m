Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F49C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7476D205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLOnAciQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgENN5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgENN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:57:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D485C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:57:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so1352216pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqYiH+VZrEFE/4Bke7hJw678bo+ME1oNIhgtpxt66To=;
        b=GLOnAciQbNb0HdK3JXKhpQq3JT9fJe2X9eCvLqzKyG/QiVAnAvlnhQuicAAjKHv8TJ
         S95azhHwl+I2LHx9a+0KbCA/C2DIReQ7HIvy6ghaGru+2EOkh9WN8ap0LRd2rezdzkF1
         KswYo2ef+5oonlA4pE78CdceA8Iml+rbTmTUDJfJHYTm2Qb7UCK/mv44DoF2T6gSyJeL
         6q8OnrUaaPV5Gb8sYykwYOST5ZK+UOfOSFJTPRil/RgTkL5e8TIhIjzuHxct5AkX59fL
         zV65xs1bfu06JmC5yN52tPY3ADCpK61sIvAF+bMxtJukgD6rh3Xttjgv8kLKHLdAENH6
         vM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqYiH+VZrEFE/4Bke7hJw678bo+ME1oNIhgtpxt66To=;
        b=GF4qdnqZ9PUUGd8hEnVejzp821hp82JH9YTuZ8ZALOo2xexSQHoTZdrsuy/+2vcvBa
         MYvFJ1p4t9vJ8+o3SH6C1t2YRDz6XopmTcj4VAzqBLxw00pSdOKqOGCjVD6pAX9qFxYg
         V8Zg9TM5Hf5MLXev5sWolURJaE5eaMmpeYTl2PiifIDi1Zfw23nXHSxOvnPsgtWlZZiK
         KfCSrL0geyoJgPgQ2X12X7mhGGOrI2JZ8nxMeZ56/zP3DXD7SEDrw7LqPtvMIBmWbMva
         xbnINiHg2WjaOtpE219LRqX1rGoUTZaHJGyMwdIBnf7jGEj3qoJnqkRX3u1I4e+oHLVd
         w6bw==
X-Gm-Message-State: AOAM532foXYsEs7YkJ0fddgiP0dSEpDpw5KuXIBpiV30D1mZX0ijYqwz
        pIO0bDW9dSP9i45N+lEtVU8wQA==
X-Google-Smtp-Source: ABdhPJzc+/MZVVljv3fDoixtlxn6rODPGLabMeEYFLm1Mq6UZO49T7Fo/gZ46zRg57ca6oYy4r7G9w==
X-Received: by 2002:a63:7c50:: with SMTP id l16mr4179481pgn.59.1589464652579;
        Thu, 14 May 2020 06:57:32 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v10sm16179337pjy.48.2020.05.14.06.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 06:57:31 -0700 (PDT)
Date:   Thu, 14 May 2020 06:56:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: db820c: fix audio configuration
Message-ID: <20200514135602.GT2165@builder.lan>
References: <20200417092327.7341-1-srinivas.kandagatla@linaro.org>
 <20200514134353.GT14092@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514134353.GT14092@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 May 06:43 PDT 2020, Vinod Koul wrote:

> On 17-04-20, 10:23, Srinivas Kandagatla wrote:
> > After patch f864edff110d ("ASoC: qdsp6: q6routing: remove default routing")
> > and 9b60441692d9 ("ASoC: qdsp6: q6asm-dai: only enable dais from device tree")
> > asm dais and routing needs to be properly specified at device tree level.
> > 
> > This patch fixes this.
> 
> Can we add the Fixes tag here please?
> 

Yes, I added that and picked this patch for 5.7-rc and sent out a pull
request. Unfortunately this does not seem to have been picked up yet.

> Other than that lgtm:
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Thanks

Regards,
Bjorn

> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 22 +++++++++++++++++++-
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi        |  2 ++
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> > index 4692b7ad16b7..cf217b6b2b39 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> > @@ -908,10 +908,30 @@
> >  	status = "okay";
> >  };
> >  
> > +&q6asmdai {
> > +	dai@0 {
> > +		reg = <0>;
> > +		direction = <2>;
> > +	};
> > +
> > +	dai@1 {
> > +		reg = <1>;
> > +		direction = <2>;
> > +	};
> > +
> > +	dai@2 {
> > +		reg = <2>;
> > +		direction = <1>;
> > +	};
> > +};
> > +
> >  &sound {
> >  	compatible = "qcom,apq8096-sndcard";
> >  	model = "DB820c";
> > -	audio-routing =	"RX_BIAS", "MCLK";
> > +	audio-routing =	"RX_BIAS", "MCLK",
> > +		"MM_DL1",  "MultiMedia1 Playback",
> > +		"MM_DL2",  "MultiMedia2 Playback",
> > +		"MultiMedia3 Capture", "MM_UL3";
> >  
> >  	mm1-dai-link {
> >  		link-name = "MultiMedia1";
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 14827adebd94..98634d5c4440 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -2066,6 +2066,8 @@
> >  						reg = <APR_SVC_ASM>;
> >  						q6asmdai: dais {
> >  							compatible = "qcom,q6asm-dais";
> > +							#address-cells = <1>;
> > +							#size-cells = <0>;
> >  							#sound-dai-cells = <1>;
> >  							iommus = <&lpass_q6_smmu 1>;
> >  						};
> > -- 
> > 2.21.0
> 
> -- 
> ~Vinod
