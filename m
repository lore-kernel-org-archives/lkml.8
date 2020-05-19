Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AAAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9E420708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+AEHxuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgESDlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESDlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:41:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE1C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:41:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s69so734566pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CjNWuQJ9v0nVBb91ffdU0D6mxktZAQ032o7BcB0bNE4=;
        b=F+AEHxuCaRGPIloYgy1mhW3Lfe9dOfLHKUZU9PfFM6Q0ED6ra92Z9qv0lsSJKjefzL
         /G445Rt2MS+je7xFwaI3GdAaNppQpjtT9DZtZL1M+OFv4qHAM7NbdDZvrZQpYy476bzA
         qFgVBP+l5L3NYSHQLLu/Kv4IkKI1BZeeHoCwRx11PEdPNVemStjkzdTRV4MbtpajRJQH
         KY/4gQBQfdGL07373QE/k5YwyLOPIzVyqgueoA6pnQwXx8wUe0QKKoI3d8wNLCT+oYQP
         MEDCH36FGnkOJNXu58mqL3PjD+FQbyE+D2IL6UiNHtKkxvzRDycr43draHRKBAdCtxgx
         vfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CjNWuQJ9v0nVBb91ffdU0D6mxktZAQ032o7BcB0bNE4=;
        b=hilaw+22Po2vzwgaKvQCu3XP+TiaYSPcJdsKVoNgnNThCOm2lj0sBdjhUxXEfISIg/
         qkpDnogBgcpcaWQEGVck52WkeTDMlZ8jBG5+j9bP1CJeikotbMWDb6OIyW9rmRQsKB4r
         Dwmdk2npKwstLcQ6kcT6693nWF0QFDlxOn1TBL8yE41ZU+jAc0AWRDWf2lmeIRRbI/lY
         MOcOvOZuK8yNqy/uRgrRax3RxWCFR1oYEcb60XYItzbpxJiMZKSQzuSXpWIjB/YAL4+0
         EQvUzopQILn+90XdEZR2YD8LC/LR21kTFpoHBuNWPh8ickb671m9rZycIimDuak47Dsc
         8IjQ==
X-Gm-Message-State: AOAM532bGrUialcOjwmnt/hNgPle4fjk80W7Q7uX2YkZrAdFP66jUFPV
        AfYkYDGkdIAOO1s/MyYvFQtCnQ==
X-Google-Smtp-Source: ABdhPJy30m1f36llwQe2czJwRgWZ2WYib3wh9j43NkV9xeaRb2PBycPJMqqn/lVk860NFOK6XhPyZQ==
X-Received: by 2002:a17:90a:1b6c:: with SMTP id q99mr2824172pjq.214.1589859659084;
        Mon, 18 May 2020 20:40:59 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id g1sm9573943pfo.142.2020.05.18.20.40.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:40:57 -0700 (PDT)
Date:   Tue, 19 May 2020 09:10:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200519034055.hfvifqz442yfduhg@vireshk-i7>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200519012927.GT2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519012927.GT2165@builder.lan>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-20, 18:29, Bjorn Andersson wrote:
> On Thu 14 May 22:17 PDT 2020, Viresh Kumar wrote:
> > This stuff has been doing rounds on the mailing list since several years
> > now with no agreed conclusion by all the parties. And here is another
> > attempt to get some feedback from everyone involved to close this once
> > and for ever. Your comments will very much be appreciated.
> > 
> > The ARM MHU is defined here in the TRM [1] for your reference, which
> > states following:
> > 
> > 	"The MHU drives the signal using a 32-bit register, with all 32
> > 	bits logically ORed together. The MHU provides a set of
> > 	registers to enable software to set, clear, and check the status
> > 	of each of the bits of this register independently.  The use of
> > 	32 bits for each interrupt line enables software to provide more
> > 	information about the source of the interrupt. For example, each
> > 	bit of the register can be associated with a type of event that
> > 	can contribute to raising the interrupt."
> > 
> 
> Does this mean that there are 32 different signals and they are all ORed
> into the same interrupt line to trigger software action when something
> happens?
> 
> Or does it mean that this register is used to pass multi-bit information
> and when any such information is passed an interrupt will be triggered?
> If so, what does that information mean? How is it tied into other Linux
> drivers/subsystems?

I have started to believe the hardware is written badly at this point
:)

The thing is that the register can be used to send a 32 bit data
(which the driver already provides), or it can be used by writing
different bits to the SET register concurrently, without corrupting
the other bits as writing 0 to a bit has no effect, we have a separate
CLEAR register for that. And so it says that all the bits are ORed
together to generate the interrupt, i.e. any bit set will generate an
interrupt. Which also means that you can't send data 0 with the
register.

-- 
viresh
