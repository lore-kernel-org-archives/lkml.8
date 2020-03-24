Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B30FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FF020663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STc15kvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCXFfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:35:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38858 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCXFfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:35:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so8469220pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8ny+Tb6gUwQow8aJnk/hTr5U34XF9Z/h6UuVXBqzKw=;
        b=STc15kvLch1+nPQQpq0oMqpfUVpJQP3ccKwQ9QMVbDUOBegBUwBRn8H8WfGFihQCkf
         Tl2yI3NV5tky/QtwL3yEh304JBH8YBOvMnHas8lUaaonXQa2lKyNDsMN70LpDf20SeE2
         idjUjuuWzIcssIlK8B05qOuxM4uNu6lg3ZSSnXCv8yiuYeEYMNOH5Z3/Jbx3tA8D3LgY
         s+U389x5dnUlBCgwKUMqSjmKl1/GFMCeH6G1VQRAoCN7j0g3Bpsb7ye+djmcAaKG8lXG
         xpfhGr7jFRdS5u59M+nxv9Z0exE+ZBuLeufVH1ZJ/5Igh0s/5q1hRKlheXjQTFDDqr18
         NNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8ny+Tb6gUwQow8aJnk/hTr5U34XF9Z/h6UuVXBqzKw=;
        b=bBEflpA+yKP7R68dfAY59X9ICabGUlHQxcCWlfZzM+Ou0UZ3CWVFGQg/WM1qSYYV06
         eRWAJyGFJOzuNnCNnxNu1L+ZbGul+VEOAhdr5X4Bf5f6EtldCoGt1/Dn6HVZT0f6cjIs
         6Q/Kw9ZAMKwwVAyoaGabhjI1ulcX4VosygAln0Txk5VbrF5NMVZSxVNJrVy/GZv6lstW
         j0qzDkayevm/I/yPq82+EYl9lTTc1uJF8i1Bx7NmX/52QpVndQwryuuzcrsQ9HacRlae
         KtJlsBHpEhCtTvT8RoFxRXe7uEYtMg5GCN/24KFS43W9RTDoMxR71r6Rw9JTZo2FitwU
         O3/w==
X-Gm-Message-State: ANhLgQ3rutBMCcLIqjdLHaWeVY47sQhNQnUAwzLhV0FNJPxAHgBlBR9l
        3uSHS11TeVvj8Fkfg6Lm78ko
X-Google-Smtp-Source: ADFU+vvxwYiZucov/b+uqplpddazOvlxd5syVdPfhedXkZA+XcRnVjOSjDjSkBS+a3vNp7EerJn3LA==
X-Received: by 2002:a62:be02:: with SMTP id l2mr24422132pff.106.1585028105850;
        Mon, 23 Mar 2020 22:35:05 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id z20sm13638264pge.62.2020.03.23.22.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 22:35:05 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:04:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] bus: mhi: core: Add support for reading MHI info
 from device
Message-ID: <20200324053458.GB11834@Mani-XPS-13-9360>
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
 <20200323123102.13992-3-manivannan.sadhasivam@linaro.org>
 <c6b696ed-b9cf-98ed-7402-9fb82bcab1c6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b696ed-b9cf-98ed-7402-9fb82bcab1c6@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:14:07AM -0600, Jeffrey Hugo wrote:
> On 3/23/2020 6:30 AM, Manivannan Sadhasivam wrote:
> > The MHI register base has several registers used for getting the MHI
> > specific information such as version, family, major, and minor numbers
> > from the device. This information can be used by the controller drivers
> > for usecases such as applying quirks for a specific revision etc...
> > 
> > While at it, let's also rearrange the local variables
> > in mhi_register_controller().
> > 
> > Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > --- a/include/linux/mhi.h
> > +++ b/include/linux/mhi.h
> > @@ -310,6 +310,10 @@ struct mhi_controller_config {
> >    * @sw_ev_rings: Number of software event rings
> >    * @nr_irqs_req: Number of IRQs required to operate (optional)
> >    * @nr_irqs: Number of IRQ allocated by bus master (required)
> > + * @family_number: MHI controller family number
> > + * @device_number: MHI controller device number
> > + * @major_version: MHI controller major revision number
> > + * @minor_version: MHI controller minor revision number
> 
> Maybe expand the comment to indicate there are valid after register() to
> give controller implementations an idea of when they can use these for
> quirks, etc?
> 

Hmm, Okay. Will add a note in next revision.

Thanks,
Mani

> >    * @mhi_event: MHI event ring configurations table
> >    * @mhi_cmd: MHI command ring configurations table
> >    * @mhi_ctxt: MHI device context, shared memory between host and device
> > @@ -375,6 +379,10 @@ struct mhi_controller {
> >   	u32 sw_ev_rings;
> >   	u32 nr_irqs_req;
> >   	u32 nr_irqs;
> > +	u32 family_number;
> > +	u32 device_number;
> > +	u32 major_version;
> > +	u32 minor_version;
> >   	struct mhi_event *mhi_event;
> >   	struct mhi_cmd *mhi_cmd;
> > 
> 
> 
> -- 
> Jeffrey Hugo
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
