Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96152C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333A206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5cCE+a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCXRH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:07:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40442 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgCXRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:07:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so9328022pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z5FlNvobQwsE4JjWwpB9xpnt659VvIIkODecw7v6xFU=;
        b=g5cCE+a9rK7Ol3/MxK290vxkbvYcslScmw4Nr9qn3XZwu0ijTMP1z+PmlO2i4DUDuh
         odbIuC0CQyRRX7C5AXGljZt1f+6k0bOrmGL9+BeEH/y85DaCvC5iPR+d4fFkjOYlrAip
         6l7sYzFlH0UWA+QzlWXS29QFzJq98TXQ3GR0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z5FlNvobQwsE4JjWwpB9xpnt659VvIIkODecw7v6xFU=;
        b=XEI7cCmstjtsrSdwh9xDiSy2iD+Ex2tAFFr5Ikb5ivy5sAhv+W9ktAMnrZkReqbtU3
         +HYyWb0V+HR/fVhXtmW1O7eiGMEQZyUXj3bCz9tXg+Bbv9SPOvqPBUjfqkTu6pAwklq4
         7kBKvyvwg8MWhVCJ2GtdADNGu6OlhNRddK+gaX/Ejljvaswjx9dhepIhFOZhcsDVREh1
         VYAEbA09TlSvHGvbTs+PGHVclLcGurNwp/tlvPoDFuGvSl1RibG6Q/Fl/7vP20huzThy
         6p6JASKKiuGP4brqBw++Rez6LKY7hnF15VYboolKAruUlIpNtVjB1E0Ir+iAqJBzS5YG
         TrMw==
X-Gm-Message-State: ANhLgQ2ru11DhF7fRLtMCBsyK1JHXBeKuDVzK0D+MOQtj4k8Gi2snhaw
        t9tjb92fdkLmo2ob3pCsCYqm8Q==
X-Google-Smtp-Source: ADFU+vtvr3BmpQ0r7UliDraOCB+NrvbJdWBUhpXYn1ZRKokM7FeOB5RH8ZUN3z/vSykcaXGb+X2LTQ==
X-Received: by 2002:a62:3786:: with SMTP id e128mr31547438pfa.124.1585069645419;
        Tue, 24 Mar 2020 10:07:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x15sm16047493pfq.107.2020.03.24.10.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 10:07:24 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:07:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Sandeep Maheswaram (Temp)" <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Subject: Re: [PATCH v5 2/3] usb: dwc3: qcom: Add interconnect support in dwc3
 driver
Message-ID: <20200324170722.GD204494@google.com>
References: <1581668684-4182-1-git-send-email-sanm@codeaurora.org>
 <1581668684-4182-3-git-send-email-sanm@codeaurora.org>
 <20200214201154.GB15781@google.com>
 <d381164d-b749-4c93-de6d-72eca3e51341@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d381164d-b749-4c93-de6d-72eca3e51341@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:11:32PM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Matthias
> 
> On 2/15/2020 1:41 AM, Matthias Kaehlcke wrote:
> > Hi Sandeep,
> > 
> > On Fri, Feb 14, 2020 at 01:54:43PM +0530, Sandeep Maheswaram wrote:
> > > Add interconnect support in dwc3-qcom driver to vote for bus
> > > bandwidth.
> > > 
> > > This requires for two different paths - from USB master to
> > > DDR slave. The other is from APPS master to USB slave.
> > > 
> > > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > > Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
> > > ---
> > >   drivers/usb/dwc3/dwc3-qcom.c | 135 ++++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 133 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > index 261af9e..2ed6c20 100644
> > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > @@ -13,6 +13,7 @@
> > >   #include <linux/module.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/extcon.h>
> > > +#include <linux/interconnect.h>
> > >   #include <linux/of_platform.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/phy/phy.h>
> > > @@ -43,6 +44,14 @@
> > >   #define SDM845_QSCRATCH_SIZE			0x400
> > >   #define SDM845_DWC3_CORE_SIZE			0xcd00
> > > +/* Interconnect path bandwidths in MBps */
> > > +#define USB_MEMORY_AVG_HS_BW MBps_to_icc(240)
> > > +#define USB_MEMORY_PEAK_HS_BW MBps_to_icc(700)
> > > +#define USB_MEMORY_AVG_SS_BW  MBps_to_icc(1000)
> > > +#define USB_MEMORY_PEAK_SS_BW MBps_to_icc(2500)
> > > +#define APPS_USB_AVG_BW 0
> > > +#define APPS_USB_PEAK_BW MBps_to_icc(40)
> > > +
> > >   struct dwc3_acpi_pdata {
> > >   	u32			qscratch_base_offset;
> > >   	u32			qscratch_base_size;
> > > @@ -76,8 +85,13 @@ struct dwc3_qcom {
> > >   	enum usb_dr_mode	mode;
> > >   	bool			is_suspended;
> > >   	bool			pm_suspended;
> > > +	struct icc_path		*usb_ddr_icc_path;
> > > +	struct icc_path		*apps_usb_icc_path;
> > >   };
> > > +static int dwc3_qcom_interconnect_enable(struct dwc3_qcom *qcom);
> > > +static int dwc3_qcom_interconnect_disable(struct dwc3_qcom *qcom);
> > > +
> > >   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
> > >   {
> > >   	u32 reg;
> > > @@ -239,7 +253,7 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
> > >   static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
> > >   {
> > >   	u32 val;
> > > -	int i;
> > > +	int i, ret;
> > >   	if (qcom->is_suspended)
> > >   		return 0;
> > > @@ -251,6 +265,10 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
> > >   	for (i = qcom->num_clocks - 1; i >= 0; i--)
> > >   		clk_disable_unprepare(qcom->clks[i]);
> > > +	ret = dwc3_qcom_interconnect_disable(qcom);
> > > +	if (ret)
> > > +		dev_warn(qcom->dev, "failed to disable interconnect %d\n", ret);
> > > +
> > This assumes that all QCA systems with a DWC3 have an interconnect
> > configuration, however after applying this series SDM845 is the only
> > platform. You need to track somewhere if the controller in question has
> > an ICC config for not.
> 
> This is handled in drivers <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/>/interconnect <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/interconnect/>/core.c <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/interconnect/core.c> 
> icc_set_bw function.

Thanks for the clarification!

> > 
> > >   	qcom->is_suspended = true;
> > >   	dwc3_qcom_enable_interrupts(qcom);
> > > @@ -276,6 +294,10 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
> > >   		}
> > >   	}
> > > +	ret = dwc3_qcom_interconnect_enable(qcom);
> > > +	if (ret)
> > > +		dev_warn(qcom->dev, "failed to enable interconnect %d\n", ret);
> > > +
> > same as above
> This is handled in drivers <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/>/interconnect <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/interconnect/>/core.c <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/interconnect/core.c> 
> icc_set_bw function

ok

> > >   	/* Clear existing events from PHY related to L2 in/out */
> > >   	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
> > >   			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
> > > @@ -285,6 +307,108 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
> > >   	return 0;
> > >   }
> > > +
> > > +/**
> > > + * dwc3_qcom_interconnect_init() - Get interconnect path handles
> > > + * @qcom:			Pointer to the concerned usb core.
> > > + *
> > > + */
> > > +static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
> > > +{
> > > +	struct device *dev = qcom->dev;
> > > +	int ret;
> > > +
> > > +	if (!device_is_bound(&qcom->dwc3->dev))
> > > +		return -EPROBE_DEFER;
> > > +
> > > +	qcom->usb_ddr_icc_path = of_icc_get(dev, "usb-ddr");
> > > +	if (IS_ERR(qcom->usb_ddr_icc_path)) {
> > > +		dev_err(dev, "Error: (%ld) failed getting usb-ddr path\n",
> > > +			PTR_ERR(qcom->usb_ddr_icc_path));
> > > +		return PTR_ERR(qcom->usb_ddr_icc_path);
> > > +	}
> > This will break all QCA platforms with DWC3, except SDM845. Instead of
> > failing you could interpret the basence of the 'usb-ddr' patch in the DT
> > as signal that the controller has no ICC configuration, and continue without
> > it (i.e. return 0 from here, don't print an error, at most a dev_info() log),
> > and track somewhere that the controller has no ICC config.
> > 
> > Alternatively you could check above with of_find_property() whether the
> > controller has an 'interconnects' property at all. If it doesn't exist
> > return zero, otherwise return an error if any of the paths doesn't exist,
> > as you do now.
> This is handled in drivers <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/>/interconnect <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/interconnect/>/core.c <https://opengrok.qualcomm.com/source/xref/LC.UM.3.0/src/third_party/kernel/v5.4/drivers/interconnect/core.c> 
> of_icc_get function.

You are right, of_icc_get() returns NULL if the property doesn't exist, and this
is handled gracefully by the other ICC functions.

> > > +
> > > +	qcom->apps_usb_icc_path = of_icc_get(dev, "apps-usb");
> > > +	if (IS_ERR(qcom->apps_usb_icc_path)) {
> > > +		dev_err(dev, "Error: (%ld) failed getting apps-usb path\n",
> > > +				PTR_ERR(qcom->apps_usb_icc_path));
> > > +		return PTR_ERR(qcom->apps_usb_icc_path);
> > > +	}
> > Failing here is ok, if 'usb-ddr' exists, we expect the rest of the config
> > to be in place.
> This may be required for error handling

Agreed, my comment meant to say the above handling seems correct.

> > > +
> > > +	ret = dwc3_qcom_interconnect_enable(qcom);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable interconnect %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * dwc3_qcom_interconnect_exit() - Release interconnect path handles
> > > + * @qcom:			Pointer to the concerned usb core.
> > > + *
> > > + * This function is used to release interconnect path handle.
> > > + */
> > > +static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
> > > +{
> > > +	icc_put(qcom->usb_ddr_icc_path);
> > > +	icc_put(qcom->apps_usb_icc_path);
> > > +}
> > > +
> > > +/* Currently we only use bandwidth level, so just "enable" interconnects */
> > > +static int dwc3_qcom_interconnect_enable(struct dwc3_qcom *qcom)
> > > +{
> > > +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> > > +	int ret;
> > > +
> > > +	if (dwc->maximum_speed == USB_SPEED_SUPER) {
> > > +		ret = icc_set_bw(qcom->usb_ddr_icc_path,
> > > +			USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
> > > +	} else {
> > > +		ret = icc_set_bw(qcom->usb_ddr_icc_path,
> > > +			USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
> > > +	}
> > nit: curly braces are not needed here
> Will remove in next version.
> > 
> > > +
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = icc_set_bw(qcom->apps_usb_icc_path,
> > > +		APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
> > > +	if (ret)
> > > +		icc_set_bw(qcom->usb_ddr_icc_path, 0, 0);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/* To disable an interconnect, we just set its bandwidth to 0 */
> > > +static int dwc3_qcom_interconnect_disable(struct dwc3_qcom *qcom)
> > > +{
> > > +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> > > +	int ret;
> > > +
> > > +	ret = icc_set_bw(qcom->usb_ddr_icc_path, 0, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = icc_set_bw(qcom->apps_usb_icc_path, 0, 0);
> > > +	if (ret)
> > > +		goto err_reenable_memory_path;
> > > +
> > > +	return 0;
> > > +
> > > +	/* Re-enable things in the event of an error */
> > > +err_reenable_memory_path:
> > > +	if (dwc->maximum_speed == USB_SPEED_SUPER)
> > > +		icc_set_bw(qcom->usb_ddr_icc_path,
> > > +			USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
> > > +	else
> > > +		icc_set_bw(qcom->usb_ddr_icc_path,
> > > +			USB_MEMORY_AVG_HS_BW, USB_MEMORY_PEAK_HS_BW);
> > instead of the above:
> > 
> > 	dwc3_qcom_interconnect_enable(qcom);
> Will change in next version.

With that changed:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
