Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D51C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2120BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAxPDHZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCaRkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:40:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45354 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCaRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:40:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id r14so8165068pfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4l5ETOgQ0imWwnT/8ipOuClDORxJCjuXyVXWv0vRdoI=;
        b=iAxPDHZi6j5XJDdwzsv0gC4hIkVTp64vobCnjhVmnUmhWcTudGJ0DxkmaAcflR3Tzk
         qfmOb+xfqmzYhtVa4SEUkfXVw835Lf7flpWypgLk96zZmJC8Xr2gV2XAvHuqisPiFp8R
         qUcZdqicxs+h69FdXEIhkQoBsPMr4JyCssTZz9Tk49dv7ReiplqU618mGAtYCZcAdih+
         q9f1aGerdw1UxcTeN921BXCG7KdLdJZn+0XjBqwoZePxKmWuGFD5qd90dpB475khGY71
         T2yecrpkGRyBI+6IqqTPfjcAYbLkf1lCQyKsundJ28kLDjjbigtSGI7LSJTxZZ1Nvi16
         8cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4l5ETOgQ0imWwnT/8ipOuClDORxJCjuXyVXWv0vRdoI=;
        b=JANLlV4k02tobZ633vzguIIJkfYjzS/eQCQCOT3if680OYe9lR8hG6i2/90gdGutUm
         zdYi5WqFNbmEqtuDMW3YrQ9pID2tuTXF4T0ITrZzHJJacybew50tHYZOSAlW3oFGL3T5
         gAsZT0CmUmCg+PZDPDZDyFe6f1ReNlpVa3lHBawFYtqHiUGXIgycSQdqI+tzWBNHmIHt
         k2iGQbOQmV9R2Sc6OwgTXx/8ye61ZoIHc7bupYUQenUPvPNXdYVAx2vSHdrkXuaM8bis
         1Odw3JeiC4HQI+7wEvMvXqVZMsgPLrX/IJAb/F15om9BzQpUi9uuY4oRWYxyWdGnOpoG
         XBNg==
X-Gm-Message-State: ANhLgQ3xmEVou9u0TdfK5guxtD8GDjI4BfdZAojTYU6HzSewxZmNI0B4
        m5kBkEDW4/UWdXkrSClPSMyRHQ==
X-Google-Smtp-Source: ADFU+vtxoE33/QBXRkl1qEOqS7lVO2SAFrcJR/z+5URP14AMuRSyqNIjgdaD0jMgwjNXzGVQSp5kUQ==
X-Received: by 2002:aa7:880c:: with SMTP id c12mr18142763pfo.77.1585676419418;
        Tue, 31 Mar 2020 10:40:19 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id nh14sm2439979pjb.17.2020.03.31.10.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:40:18 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:40:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Chris Lew <clew@codeaurora.org>, gregkh@linuxfoundation.org,
        davem@davemloft.net, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/7] net: qrtr: Add MHI transport layer
Message-ID: <20200331174016.GA254911@minitux>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
 <20200324061050.14845-7-manivannan.sadhasivam@linaro.org>
 <20200324203952.GC119913@minitux>
 <20200325103758.GA7216@Mani-XPS-13-9360>
 <89f3c60c-70fb-23d3-d50f-98d1982b84b9@codeaurora.org>
 <20200330094913.GA2642@Mani-XPS-13-9360>
 <20200330221932.GB215915@minitux>
 <20200331112326.GB21688@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331112326.GB21688@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Mar 04:23 PDT 2020, Manivannan Sadhasivam wrote:

> Hi Bjorn,
> 
> On Mon, Mar 30, 2020 at 03:19:32PM -0700, Bjorn Andersson wrote:
> > On Mon 30 Mar 02:49 PDT 2020, Manivannan Sadhasivam wrote:
> > 
> > > Hi Chris,
> > > 
> > > On Thu, Mar 26, 2020 at 03:54:42PM -0700, Chris Lew wrote:
> > > > 
> > > > 
> > > > On 3/25/2020 3:37 AM, Manivannan Sadhasivam wrote:
> > > > > Hi Bjorn,
> > > > > 
> > > > > + Chris Lew
> > > > > 
> > > > > On Tue, Mar 24, 2020 at 01:39:52PM -0700, Bjorn Andersson wrote:
> > > > > > On Mon 23 Mar 23:10 PDT 2020, Manivannan Sadhasivam wrote:
> > [..]
> > > > > > > +	spin_lock_irqsave(&qdev->ul_lock, flags);
> > > > > > > +	list_for_each_entry(pkt, &qdev->ul_pkts, node)
> > > > > > > +		complete_all(&pkt->done);
> > > > > 
> > > > > Chris, shouldn't we require list_del(&pkt->node) here?
> > > > > 
> > > > 
> > > > No this isn't a full cleanup, with the "early notifier" we just unblocked
> > > > any threads waiting for the ul_callback. Those threads will wake, check
> > > > in_reset, return an error back to the caller. Any list cleanup will be done
> > > > in the ul_callbacks that the mhi bus will do for each queued packet right
> > > > before device remove.
> > > > 
> > > > Again to simplify the code, we can probable remove the in_reset handling
> > > > since it's not required with the current feature set.
> > > > 
> > > 
> > > So since we are not getting status_cb for fatal errors, I think we should just
> > > remove status_cb, in_reset and timeout code.
> > > 
> > 
> > Looks reasonable.
> > 
> > [..]
> > > > I thought having the client get an error on timeout and resend the packet
> > > > would be better than silently dropping it. In practice, we've really only
> > > > seen the timeout or ul_callback errors on unrecoverable errors so I think
> > > > the timeout handling can definitely be redone.
> > > > 
> > > 
> > > You mean we can just remove the timeout handling part and return after
> > > kref_put()?
> > > 
> > 
> > If all messages are "generated" by qcom_mhi_qrtr_send() and "released"
> > in qcom_mhi_qrtr_ul_callback() I don't think you need the refcounting at
> > all.
> > 
> 
> Hmm, you're right. We can move the packet releasing part to ul_callback now.
> 
> > 
> > Presumably though, it would have been nice to not have to carry a
> > separate list of packets (and hope that it's in sync with the mhi core)
> > and instead have the ul callback somehow allow us to derive the skb to
> > be freed.
> > 
> 
> Yep, MHI stack holds the skb in buf_addr member of mhi_result. So, we can just
> use below to get the skb in ul_callback:
> 
> struct sk_buff *skb = (struct sk_buff *)mhi_res->buf_addr;
> 
> This will help us to avoid the use of pkt, ul_pkts list and use the skb directly
> everywhere. At the same time I think we can also remove the ul_lock which
> was added to protect the ul_pkts list.
> 
> Let me know your opinion, I'll just send a series with this modified QRTR MHI
> client driver and MHI suspend/resume patches.
> 

This looks more robust than having the separate list shadowing the
internal state of the MHI core.

+1

Thanks,
Bjorn
