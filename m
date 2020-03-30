Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9245C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFCE205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbD3U0SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgC3Puq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:50:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34503 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgC3Pup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:50:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so6892783plm.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZsn4EW/SyaRsmueE+/vYE2vemazchjXW/dbHmCRlUs=;
        b=cbD3U0SWemqC1mmtbV87ewilvyfjJ6wvBrx1Zv9z50jgAf9m1zNNdUG66wXMgyvK6w
         ZZdtz3wzvXNip6aIDfmUPWqG85OQxDWzLAzKrN9IJ2NIzLYVNAO6ke9IydE4kwJIysFp
         5v+XWRKX9MnKGNCQeTmnSp3izMpZzXfKXtPtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZsn4EW/SyaRsmueE+/vYE2vemazchjXW/dbHmCRlUs=;
        b=qsUxydzWOjLRaAFTlDiA8VJjsFgUKQbbT3ibQXOOSuXlqruYMzae2kH3n91NOe5Z4H
         j9ncN6b4CTz+L19dqmweni2hVMUkmkDPcH45dwt1ed9fb6DugQOCP8Ws/iprDe6B/GWn
         waeT0QYs4bV39HwLLzoWyX7KrIeJSdw452EUsvAt+QL0XLpqqi3ULgysukJNfOGkElxh
         wbDyNoaqLcJFZpWWqrHa6Gg7vQyXuBgcK2vqKjYYdHQxioZpAONjlU2ZODg6QTRsMz0x
         VjgAlCQOjBAQKGxNABkSUdV/f5ytJS2afDEwwZ1aqewd/wadnvf3TUb9KywfpJENNNhE
         BHkw==
X-Gm-Message-State: ANhLgQ1aHH06SJ0fKZA0EdUH7eka+O4pcYYrb4sIAW4xRrxsrmzSzBge
        g1EM2yze6IjSge5IFmtM9gtykA==
X-Google-Smtp-Source: ADFU+vs3bQbui32mwgN4d69WBgcOI3D/G3nH3HTL6g28UawRkGYTx1Gv6AOqnTJmut2iCUcqWB559A==
X-Received: by 2002:a17:90a:3249:: with SMTP id k67mr16585418pjb.167.1585583442859;
        Mon, 30 Mar 2020 08:50:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id r7sm10438837pfg.38.2020.03.30.08.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 08:50:41 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:50:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Subject: Re: [PATCH v6 2/4] usb: dwc3: qcom: Add interconnect support in dwc3
 driver
Message-ID: <20200330155038.GC199755@google.com>
References: <1585302203-11008-1-git-send-email-sanm@codeaurora.org>
 <1585302203-11008-3-git-send-email-sanm@codeaurora.org>
 <20200329171756.GA199755@google.com>
 <87h7y62r28.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7y62r28.fsf@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:19:11AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Matthias Kaehlcke <mka@chromium.org> writes:
> >> Add interconnect support in dwc3-qcom driver to vote for bus
> >> bandwidth.
> >> 
> >> This requires for two different paths - from USB master to
> >> DDR slave. The other is from APPS master to USB slave.
> >> 
> >> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> >> Signed-off-by: Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
> >> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>  drivers/usb/dwc3/dwc3-qcom.c | 128 ++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 126 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> >> index 1dfd024..7e85fe6 100644
> >> --- a/drivers/usb/dwc3/dwc3-qcom.c
> >> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> >>
> >> ...
> >>
> >> +/* To disable an interconnect, we just set its bandwidth to 0 */
> >> +static int dwc3_qcom_interconnect_disable(struct dwc3_qcom *qcom)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = icc_set_bw(qcom->usb_ddr_icc_path, 0, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = icc_set_bw(qcom->apps_usb_icc_path, 0, 0);
> >> +	if (ret)
> >> +		goto err_reenable_memory_path;
> >> +
> >> +	return 0;
> >> +
> >> +	/* Re-enable things in the event of an error */
> >> +err_reenable_memory_path:
> >> +	ret = dwc3_qcom_interconnect_enable(qcom);
> >
> > This overwrites the error that led to the execution of this code path.
> > The function should return original error, not the result of the
> > _interconnect_enable() call.
> >
> > I saw Felipe queued the patch for v5.8. I think the main options to fix this
> > are:
> >
> > - a v6 of this patch to replace v5 in Felipe's tree (which IIUC will be rebased
> >   anyway once there is a v5.7-rc)
> > - send the fix as a separate patch
> > - Felipe amends the patch in his tree
> >
> > Felipe, what would work best for you?
> 
> Let's go for a v6, which commits should I drop? I can't find anything
> related to $subject in my queue:
> 
> $ git --no-pager log --oneline HEAD ^linus/master -- drivers/usb/dwc3/dwc3-qcom.c
> 201c26c08db4 usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>

I thought I saw a "queued for v5.8" message from you, but can't find that back.
I guess I saw the "queued" message for the "Add USB DWC3 support for SC7180"
series and thought it was for this one. Sorry for the confusion.
