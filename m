Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25110C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA5E2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="SDPzTQOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGWIN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:13:57 -0400
Received: from smtp1.axis.com ([195.60.68.17]:31749 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgGWIN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1138; q=dns/txt; s=axis-central1;
  t=1595492036; x=1627028036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50pjpICS47njee1/tY5fnV1hkALwFSNd0R5epRzTCR0=;
  b=SDPzTQOxHV/YddBtBm6wpKdgujWIucifoDoc1PhffUc9MtBYErezabX4
   dYyfS6U2F/9H9zl2+9dhDsfflCQ0825waGQeOFacQyuJEasv2PfcqonJ4
   jYLxaS0uF1u/QsKYKXb9NZdMkNTOsaWdhrM8TddUCrcKFF1+ls1o8VH0z
   kSbMp5hRCYyf7NEvknG3Yz5p0rl5tAMKt/6f+cOniMFM66pPeZelcOdCN
   B0t0vTIgf6yKGnyogXMvYyP7EtbKAvG1NHkxVvX1WomMHWkHh0oun0+/5
   lzDNHDJ6JrX6eTB1ARGabNSpA62eVFBNbTOtkI/4CBKiTlkLUJO1cIRju
   w==;
IronPort-SDR: sm/amTH7eKrS2VnpopBdgkqbHYKu9lvNtBLFc2Y83eWfxs8xxQ36GVgkWrP4gxZHUxjoYSUpf5
 1uyEIKzGqeX/zb0RquOlczAGI4/tSO/XWjC7PKIbsfc09dFKCWTGu2IrsuCfisqFbXN7qk3RLW
 KhuEgvsiA4bUFPyjH9f/OfB1Q2vdqJ2ROuJ23rHNrI0gY4yzwOSez3b5uGkUc4Um+1eoZrSFwC
 qYw7KeaI7tx00clQQ0nox6aK4nlE0vVOEpl3eBwHeX0s8xq+0/H+U8YviachNjcSVk4huaLgaX
 ayc=
X-IronPort-AV: E=Sophos;i="5.75,386,1589234400"; 
   d="scan'208";a="11135659"
Date:   Thu, 23 Jul 2020 10:13:54 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <jackp@codeaurora.org>, <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <mike.looijmans@topic.nl>
Subject: Re: [PATCH 6/7] usb: dwc3: Add support for a role-switch notifier
Message-ID: <20200723081352.hrg6rdpz5zxpp2so@axis.com>
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
 <20200311191501.8165-7-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200311191501.8165-7-bryan.odonoghue@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:15:00PM +0000, Bryan O'Donoghue wrote:
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 2705871ec95e..789e93dd93b4 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -497,6 +497,8 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw, enum usb_role ro
>  	}
>  
>  	dwc3_set_mode(dwc, mode);
> +	raw_notifier_call_chain(&dwc->role_sw_nl, mode, NULL);
> +
>  	return 0;
>  }

dwc3_set_mode() is called from a bunch of other places too, is it
sufficient to call the notifier only from here?  Also, dwc3_set_mode()
performs the mode set asynchronously so the mode switch can race with
this notifier call, is that OK?

Mike Looijmans proposed the control of a vbus regulator from
__dwc3_set_mode(), and that would take care of both the points above.
Perhaps this notifier call can be moved to the same place or perhaps
Mike's patch could even work for you?  The only problem is that your
switching code in dwc3-qcom.c would have to be modelled as a reulator:

 https://lore.kernel.org/linux-usb/20200619142512.19824-1-mike.looijmans@topic.nl/
