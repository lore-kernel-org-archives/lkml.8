Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C0AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1042076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgHKNol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:44:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53465 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728532AbgHKNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:44:40 -0400
Received: (qmail 331899 invoked by uid 1000); 11 Aug 2020 09:44:39 -0400
Date:   Tue, 11 Aug 2020 09:44:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Wesley Cheng <wcheng@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [RFC v4 1/3] usb: dwc3: Resize TX FIFOs to meet EP bursting
 requirements
Message-ID: <20200811134439.GA331864@rowland.harvard.edu>
References: <20200624022848.7765-1-wcheng@codeaurora.org>
 <20200624022848.7765-2-wcheng@codeaurora.org>
 <87d03yptxi.fsf@kernel.org>
 <b0c8a95b-45e3-0d79-2a7c-14c8936dd551@codeaurora.org>
 <877du5pseu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877du5pseu.fsf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:12:41AM +0300, Felipe Balbi wrote:
> One possibility around this was suggested above, something along the
> lines of:
> 
> 	usb_gadget_ep_enable_bulk(struct usb_gadget *, struct
> 		usb_ep_alloc_desc *alloc_desc)
> 
> (please think of better names, I'm hopeless haha)

How about usb_gadget_enable_endpoints()?

Alan Stern
