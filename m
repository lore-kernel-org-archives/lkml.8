Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C7C2D0EE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664692073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4VluhOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgC2RSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:18:02 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39399 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgC2RSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:18:01 -0400
Received: by mail-pj1-f65.google.com with SMTP id z3so5751833pjr.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1VdjSPPRhlOBu7W9s+NexDovrzvWntWGJmIdhHoxZAQ=;
        b=a4VluhObQuJFb8SVMTjUUnyaHON/TeGQbbeStEeHeBcJegBh1n4OVsHdtsIfVjvse5
         IbvBFPybuUVOSQC5Fxd7Qc5iEqcrp89RD74YyUyxSTdpfuKOOp0DVATyIlxcyzQfmBWr
         zEFxYeTsBKcYbSpW7IIWW+VqW4tsstUSA4qE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1VdjSPPRhlOBu7W9s+NexDovrzvWntWGJmIdhHoxZAQ=;
        b=eJTTIcn39fopeVdskzOd2H3W94BKyCMvb6MmbaRDk5Xz5Q0egAXEbva+49kIHiMIHg
         rJKrwNL6m+ISXvWDCYI/tuKJ0OcgcICKfKOAv2IkMh9Vzu2AmNYo/AaNw+F8F0VyeLNq
         bkY7pIAJ/2TSJvvXhykEFtHJg8t+Z6opg4ot9tryvgo17UHUNZnUsLHVO5az94cYLnuC
         FCKXMhPPWNiMMzhkD7pdECiHWM4bszN/REeD6VBcR7yAEvYx+1eByieEKbFOyQjwK9M1
         RDme8/9UzUnLPD6k6L03S6rrOZMQs5iyI3KqT8HND2MFhg1Xj2AYuVV/rhV8t5KYzZcd
         tDzg==
X-Gm-Message-State: ANhLgQ2alG+b1OI5dHwi8mgZWHKxX/GE3Vmcqgq1iEe5K27U2vyoiL28
        u/TGJy1FtJ/a4BM2wLRI7oOVuQ==
X-Google-Smtp-Source: ADFU+vsiB7DX7YoDE8Qsn1o3o8N1nnCf0ZGMiEPaCNY3wHCH2wyiT2nAj/cJUqGyY0agzks/DRDjjA==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr11203973pjr.22.1585502280189;
        Sun, 29 Mar 2020 10:18:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id t2sm4016414pfh.157.2020.03.29.10.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 10:17:59 -0700 (PDT)
Date:   Sun, 29 Mar 2020 10:17:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>
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
Subject: Re: [PATCH v6 2/4] usb: dwc3: qcom: Add interconnect support in dwc3
 driver
Message-ID: <20200329171756.GA199755@google.com>
References: <1585302203-11008-1-git-send-email-sanm@codeaurora.org>
 <1585302203-11008-3-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1585302203-11008-3-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 27, 2020 at 03:13:21PM +0530, Sandeep Maheswaram wrote:
> Add interconnect support in dwc3-qcom driver to vote for bus
> bandwidth.
> 
> This requires for two different paths - from USB master to
> DDR slave. The other is from APPS master to USB slave.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 128 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 1dfd024..7e85fe6 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>
> ...
>
> +/* To disable an interconnect, we just set its bandwidth to 0 */
> +static int dwc3_qcom_interconnect_disable(struct dwc3_qcom *qcom)
> +{
> +	int ret;
> +
> +	ret = icc_set_bw(qcom->usb_ddr_icc_path, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = icc_set_bw(qcom->apps_usb_icc_path, 0, 0);
> +	if (ret)
> +		goto err_reenable_memory_path;
> +
> +	return 0;
> +
> +	/* Re-enable things in the event of an error */
> +err_reenable_memory_path:
> +	ret = dwc3_qcom_interconnect_enable(qcom);

This overwrites the error that led to the execution of this code path.
The function should return original error, not the result of the
_interconnect_enable() call.

I saw Felipe queued the patch for v5.8. I think the main options to fix this
are:

- a v6 of this patch to replace v5 in Felipe's tree (which IIUC will be rebased
  anyway once there is a v5.7-rc)
- send the fix as a separate patch
- Felipe amends the patch in his tree

Felipe, what would work best for you?

Thanks

Matthias
