Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AF1C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A020772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmejOzvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgCaLXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:23:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgCaLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:23:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id a24so3365170pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXxdjqfqKsI367q8g3+EJ/v0hXOY5Q6mELpkQJCd7wk=;
        b=cmejOzvwxWsAKsSDIXk6EJoFXbWVfi1jjPgaxvRqVm37ksv/8dHWnJd7OFc9fHcCdj
         Ly8QIKPqZvBgj8i5qgQZQHj1fIFL0+vuLzq5wXxn4WGbs4Z16J4k7hmf9Xx6t6vtoiyu
         iTdJ3gqKOcq/WFlXjreQNLgLQAlQ1TSEo404PBkG1Pw5dRerooiFmTTbRR+SQVC7Sacz
         H7VNtsQgFmo8SvrYmoswPnuXD9wOWBGORwHhyx0MT7ByTGjLcvmOteA5TgEE4rbXKqGE
         fWkXSnR4TPGDrm0CtwxzEcnT+gcj20xIHioZ78D30FUbqbUfp1LhXXedGi/oLbLt1Xvp
         Fr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXxdjqfqKsI367q8g3+EJ/v0hXOY5Q6mELpkQJCd7wk=;
        b=PYw7qnRst4gt9tzgKuEY1hieL64Fcef4QLd6o7Pj6kv5j+Dc8Bv2VERZ7N7WWYAO+/
         QclNMpfgwNduHgrxXHf/wRCSFOGYvqY3JCQ5SGYq05+qlhPH/gYUddlwVFQzeSkaoYpV
         HObHcfwvNTjGQbKYRRaKspQoBffvo2umBV1NIxG3jjjDdaeLe74PqZIaAsL3UCYS5BFs
         QNJIGIusQo+DNxwr4SnFzzu1t4oOab7jafJ/YLj4D81PHDyqnTSK3hUQEZgqohN4aT/l
         sMlroTeVjIlFb58siHhawrmhmrxOTqCQPuC8xoMK0iT7BYm1Re/+92ihanfX9wAcDQuQ
         npqg==
X-Gm-Message-State: ANhLgQ2EzBOauJGLlQ9S88pr+3iYSGeZzcqPiNtHWTmLKyXRTMGKIt8k
        auaao7eyOgejR1np6mNyUx66
X-Google-Smtp-Source: ADFU+vua2WWw22BJNgir87I4Bn/FSDg8vWUO/X+nkfFs5lP44LsMIG180Kn7igbKPzREsGKTyjW1iw==
X-Received: by 2002:a65:5383:: with SMTP id x3mr17166618pgq.279.1585653814612;
        Tue, 31 Mar 2020 04:23:34 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:630f:1337:c28:2530:7bf4:e941])
        by smtp.gmail.com with ESMTPSA id q71sm12347339pfc.92.2020.03.31.04.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 04:23:33 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:53:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Chris Lew <clew@codeaurora.org>, gregkh@linuxfoundation.org,
        davem@davemloft.net, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/7] net: qrtr: Add MHI transport layer
Message-ID: <20200331112326.GB21688@Mani-XPS-13-9360>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
 <20200324061050.14845-7-manivannan.sadhasivam@linaro.org>
 <20200324203952.GC119913@minitux>
 <20200325103758.GA7216@Mani-XPS-13-9360>
 <89f3c60c-70fb-23d3-d50f-98d1982b84b9@codeaurora.org>
 <20200330094913.GA2642@Mani-XPS-13-9360>
 <20200330221932.GB215915@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330221932.GB215915@minitux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mon, Mar 30, 2020 at 03:19:32PM -0700, Bjorn Andersson wrote:
> On Mon 30 Mar 02:49 PDT 2020, Manivannan Sadhasivam wrote:
> 
> > Hi Chris,
> > 
> > On Thu, Mar 26, 2020 at 03:54:42PM -0700, Chris Lew wrote:
> > > 
> > > 
> > > On 3/25/2020 3:37 AM, Manivannan Sadhasivam wrote:
> > > > Hi Bjorn,
> > > > 
> > > > + Chris Lew
> > > > 
> > > > On Tue, Mar 24, 2020 at 01:39:52PM -0700, Bjorn Andersson wrote:
> > > > > On Mon 23 Mar 23:10 PDT 2020, Manivannan Sadhasivam wrote:
> [..]
> > > > > > +	spin_lock_irqsave(&qdev->ul_lock, flags);
> > > > > > +	list_for_each_entry(pkt, &qdev->ul_pkts, node)
> > > > > > +		complete_all(&pkt->done);
> > > > 
> > > > Chris, shouldn't we require list_del(&pkt->node) here?
> > > > 
> > > 
> > > No this isn't a full cleanup, with the "early notifier" we just unblocked
> > > any threads waiting for the ul_callback. Those threads will wake, check
> > > in_reset, return an error back to the caller. Any list cleanup will be done
> > > in the ul_callbacks that the mhi bus will do for each queued packet right
> > > before device remove.
> > > 
> > > Again to simplify the code, we can probable remove the in_reset handling
> > > since it's not required with the current feature set.
> > > 
> > 
> > So since we are not getting status_cb for fatal errors, I think we should just
> > remove status_cb, in_reset and timeout code.
> > 
> 
> Looks reasonable.
> 
> [..]
> > > I thought having the client get an error on timeout and resend the packet
> > > would be better than silently dropping it. In practice, we've really only
> > > seen the timeout or ul_callback errors on unrecoverable errors so I think
> > > the timeout handling can definitely be redone.
> > > 
> > 
> > You mean we can just remove the timeout handling part and return after
> > kref_put()?
> > 
> 
> If all messages are "generated" by qcom_mhi_qrtr_send() and "released"
> in qcom_mhi_qrtr_ul_callback() I don't think you need the refcounting at
> all.
> 

Hmm, you're right. We can move the packet releasing part to ul_callback now.

> 
> Presumably though, it would have been nice to not have to carry a
> separate list of packets (and hope that it's in sync with the mhi core)
> and instead have the ul callback somehow allow us to derive the skb to
> be freed.
> 

Yep, MHI stack holds the skb in buf_addr member of mhi_result. So, we can just
use below to get the skb in ul_callback:

struct sk_buff *skb = (struct sk_buff *)mhi_res->buf_addr;

This will help us to avoid the use of pkt, ul_pkts list and use the skb directly
everywhere. At the same time I think we can also remove the ul_lock which
was added to protect the ul_pkts list.

Let me know your opinion, I'll just send a series with this modified QRTR MHI
client driver and MHI suspend/resume patches.

Thanks,
Mani

> Regards,
> Bjorn
