Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ABFC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EBB205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDH6xhpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgC3WTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:19:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33122 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgC3WTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:19:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id g18so7334789plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RR4O6KKUAPvY5CCBrBQ4OejRKZAXWAw54/I6iGcqce0=;
        b=wDH6xhpb0mRK2FvzaT+HqT1+uN5CpoqLit+mjyzbE8kedGfyppG/P9EZuELFWLtjXn
         NpK2SHAAE7dRaRQ23pR9X9dtsH/l1NsbuSTF6xqb09CSBd7vaRmND3xSX0Ao5IowCLU0
         sMRsmA56U8kz1Jg+ISKkMvXF+NapmFB76umwlezvfZl7LFlEGE1TiNuM2XZ6ZqSWgIHY
         Vc3g0ptYlrtbomqLQIcCM4a0kR593wDO+qV0NWVXUIlwOzeb8YF6SYf5WkJ97KgBuy5E
         sLEYjrovZia/52LlBL44id4sbqb66UYYU7YT1GaYh6ZeRAJcYXjbFHM/X8G6/yTT9Pu3
         yAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RR4O6KKUAPvY5CCBrBQ4OejRKZAXWAw54/I6iGcqce0=;
        b=hauRlkWlPFv9JAysvvInvGZI+5KMj8470+7+otJjzcKc8dJOg+Nt6gwDDhpAWqQWsm
         8q1QGrcTPn4klnwMRJtsQYXsubFO+1fap9n82aET/hCAaFWVsD6cGWuc+SPJM+gQbNcM
         zBlz5e5W5tFTnP/doIR5o0CFMuy6h0kg/WZsmWVUOKzxs7Wd9A3qVZz3441cgCXVfY2w
         BDpr8Y1uXCKsZW+8irXgmISqGqHLEXiVnfrEsVjK4P5LFOhudUIHhE/V7S7nXVtPg5Y6
         zSkaadlYr/D/31KQaSa4QeL/dwcB+eLELJc9Ej6gw+Qr/OhGBESTD4W81mb9N6hJ9hs9
         WWMA==
X-Gm-Message-State: AGi0PubAwttDOnD5z91A3GC7M56wU9jC0kEFhb5VtMrEwRGwP86Ef12X
        uIg91lZ+ZdTLkk2OV9Phl7ohGA==
X-Google-Smtp-Source: APiQypKzEYPIoceeNAaANMlUD3ZnvtRmqoGF3UKWvgNefYWug80nmrKS5YtHjcdxJWDBH6vn6JYwKQ==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr1180699plf.42.1585606775041;
        Mon, 30 Mar 2020 15:19:35 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l6sm10684421pff.173.2020.03.30.15.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:19:34 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:19:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Chris Lew <clew@codeaurora.org>, gregkh@linuxfoundation.org,
        davem@davemloft.net, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/7] net: qrtr: Add MHI transport layer
Message-ID: <20200330221932.GB215915@minitux>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
 <20200324061050.14845-7-manivannan.sadhasivam@linaro.org>
 <20200324203952.GC119913@minitux>
 <20200325103758.GA7216@Mani-XPS-13-9360>
 <89f3c60c-70fb-23d3-d50f-98d1982b84b9@codeaurora.org>
 <20200330094913.GA2642@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330094913.GA2642@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Mar 02:49 PDT 2020, Manivannan Sadhasivam wrote:

> Hi Chris,
> 
> On Thu, Mar 26, 2020 at 03:54:42PM -0700, Chris Lew wrote:
> > 
> > 
> > On 3/25/2020 3:37 AM, Manivannan Sadhasivam wrote:
> > > Hi Bjorn,
> > > 
> > > + Chris Lew
> > > 
> > > On Tue, Mar 24, 2020 at 01:39:52PM -0700, Bjorn Andersson wrote:
> > > > On Mon 23 Mar 23:10 PDT 2020, Manivannan Sadhasivam wrote:
[..]
> > > > > +	spin_lock_irqsave(&qdev->ul_lock, flags);
> > > > > +	list_for_each_entry(pkt, &qdev->ul_pkts, node)
> > > > > +		complete_all(&pkt->done);
> > > 
> > > Chris, shouldn't we require list_del(&pkt->node) here?
> > > 
> > 
> > No this isn't a full cleanup, with the "early notifier" we just unblocked
> > any threads waiting for the ul_callback. Those threads will wake, check
> > in_reset, return an error back to the caller. Any list cleanup will be done
> > in the ul_callbacks that the mhi bus will do for each queued packet right
> > before device remove.
> > 
> > Again to simplify the code, we can probable remove the in_reset handling
> > since it's not required with the current feature set.
> > 
> 
> So since we are not getting status_cb for fatal errors, I think we should just
> remove status_cb, in_reset and timeout code.
> 

Looks reasonable.

[..]
> > I thought having the client get an error on timeout and resend the packet
> > would be better than silently dropping it. In practice, we've really only
> > seen the timeout or ul_callback errors on unrecoverable errors so I think
> > the timeout handling can definitely be redone.
> > 
> 
> You mean we can just remove the timeout handling part and return after
> kref_put()?
> 

If all messages are "generated" by qcom_mhi_qrtr_send() and "released"
in qcom_mhi_qrtr_ul_callback() I don't think you need the refcounting at
all.


Presumably though, it would have been nice to not have to carry a
separate list of packets (and hope that it's in sync with the mhi core)
and instead have the ul callback somehow allow us to derive the skb to
be freed.

Regards,
Bjorn
