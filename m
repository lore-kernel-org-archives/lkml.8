Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88D8C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D042465A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byikFvWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAWCj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:39:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38281 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:39:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so680088plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 18:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bTqNrmZc4XwB7mbH5XKk8hIXReWiy2o/x14mzISIa8Y=;
        b=byikFvWWlkqO1f5z4PSmmOvGSP4X745Zi5Zxzm8EBh0qZ8UWn56+B0yzEt6K61kzgH
         UIH4OHaJLtDSr4LI+pVWG+YieX7Ut4IOOluIanj5iVpOVFuSMZjaB2ma+d15j1F5z671
         LH3wlYrHF15Xms+98W2VTz1Q68Lk1JKy3zffRSylF7hbM1lQGXsrNljDC7N/y8OwPr8L
         1pXPyvW9a+MC72GbEGM1+4t45D36jbtqH1BA195w/YehECEagnR8xW4NbY8HOGsp2jgF
         x2VyyxV7PoqCGSv4p6vcZGJ1Pyat9mZznroY9sX+kV3dv0/aqNm9j3DPzxic1emFqhPv
         05/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bTqNrmZc4XwB7mbH5XKk8hIXReWiy2o/x14mzISIa8Y=;
        b=Rpote3q1Ir5L62dqXE9RyVwEnXOz/6v/qdKPCASRDPiYnb18I6JUDuwdAqml9lXfqD
         wZkOVGB5cJAh2zczBvZgBeBSlwv2FlUuXQBfo9yiu+qNtYYl9xawMLuzW7fb+emNMbHP
         eogZsVbs0dbLbn/aOyhWZj/H9lPDxY9bEnRijvcOYk68YUDJBIbAeAhtucDAKhyLr0Ey
         Uwtwm2sp7P23ySCq0KjF0br9dLvHgkWQ+Gw23BHGc80V50l5qyDzmvuyFFG+D1XZsInj
         stnroW05GW507iLz8xH4Rfb3kdfrOA5SYYpRMzrqSbvuSzKgijn0RYSIt59nGdAOxXWn
         zU8A==
X-Gm-Message-State: APjAAAVFpacNnZZHxuFAGyC6odAAVNmHw3H80Y6RrzcL4CilE45iUaLE
        7ClIYFL5WLEeUckxXNZPjONY0Q==
X-Google-Smtp-Source: APXvYqy7I+trccw5AXOWtnefRTubn87fuxIQql4VUIPbEhXpw2iqsLDrMfyucFrbZ7GI1P996ynOSA==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr1870273pjt.88.1579747167904;
        Wed, 22 Jan 2020 18:39:27 -0800 (PST)
Received: from localhost ([122.167.18.14])
        by smtp.gmail.com with ESMTPSA id w11sm386820pgs.60.2020.01.22.18.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 18:39:26 -0800 (PST)
Date:   Thu, 23 Jan 2020 08:09:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     arnd@arndb.de, Sudeep Holla <sudeep.holla@arm.com>,
        jassisinghbrar@gmail.com, peng.fan@nxp.com,
        peter.hilber@opensynergy.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200123023924.roqc2iyx4wmukk4p@vireshk-i7>
References: <4b74f1b6c1f9653241a1b5754525e230b3d76a3f.1579595093.git.viresh.kumar@linaro.org>
 <3a8836dd-99d3-faff-af05-2032d609f594@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8836dd-99d3-faff-af05-2032d609f594@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-20, 12:44, Cristian Marussi wrote:
> On 21/01/2020 08:27, Viresh Kumar wrote:
> commment is obsolete

Right, they need to be checked everywhere again. Sorry for missing
that earlier.

> > +struct scmi_chan_info {
> > +	struct scmi_info *info;
> > +	struct device *dev;
> > +	struct scmi_handle *handle;
> > +	void *transport_info;
> > +};
> > +
> > +/**
> > + * struct scmi_transport_ops - Structure representing a SCMI transport ops
> > + *
> > + * @send_message: Callback to send a message
> > + * @mark_txdone: Callback to mark tx as done
> > + * @chan_setup: Callback to allocate and setup a channel
> > + * @chan_free: Callback to free a channel
> > + */
> commment is obsolete but I would also ask: are all of these operations supposed to be mandatory supported
> on any possible foreseeable transport ? (beside the obviously needed like send_message)
> 
> I'm asking because they are all called straight away from the driver core without any NULL check
> so that if a new transport should not need one of them it will be forced to anyway implement a dummy one
> to comply, which it will be needlessly invoked every time.

They are kept as mandatory for now as we don't really know how it
will look for other transport types. Lets make them optional only when
someone don't need to define them. It would be a simple change anyway.

> >  /* Each compatible listed below must have descriptor associated with it */
> >  static const struct of_device_id scmi_of_match[] = {
> > -	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
> > +	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
> >  	{ /* Sentinel */ },
> >  };
> 
> minor thing: shouldn't the chosen transport being configurable at compile time with some
> option like CONFIG_SCMI_TRANSPORT_MBOX ? or via DT ?

It is configurable via DT. The compatible should look different in
that case, something like: "arm,scmi-<newtranport>".

-- 
viresh
