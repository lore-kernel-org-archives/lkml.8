Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57ADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 04:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ACC204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 04:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ2PdY14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgESEFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 00:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgESEFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 00:05:16 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B3C061A0C;
        Mon, 18 May 2020 21:05:16 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a14so6733141ilk.2;
        Mon, 18 May 2020 21:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tOm8zzhCxaJy3Xz/20xYyI/RssQ51tXhkdhSGs8XvM=;
        b=PZ2PdY14xr+Ro5d+ddOFHl4D+ksurvlmAHT//qsqdw6SDeJ+Njtcdx18griVnejEdH
         RyRkSXIYdKX/QnNCX73NqkQSMFny0/TLKJVmtHCqogKergXIYgNPnC+sWShWwHid6DgO
         rZChs500Frt8l+dJeR9HN/bKB6DMTCd43fpRBI1StRoTu2ypdjcromQ1EdKQGaF7jUL2
         k1Mo4tt2cZ/sfBEpHouIAjKpsEHx2ZvW/f3+q1ym8GsM6In6VWrj0ykApbU5WXFbKW7n
         XTBb6Te9L3nMOrMTEcdrlWbdIKxPWpZW8GAUT+UEjPomvSFpmSDC9JtXZ3rsk5ZiVxU/
         WhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tOm8zzhCxaJy3Xz/20xYyI/RssQ51tXhkdhSGs8XvM=;
        b=T7hS6eiX9hjyx5uu9VCuWXApHIhBBc0i/O+qN4lA99Jp8DCjqFOltpsmW5Cd0SQ9hF
         nadUTLMoXxurxckuqPhakmaxFlwfvRggmqxT6Wn5tUEoaVNo4paXLIcnUp8ora3NrUAr
         4Zf1Gdph5MiBZV5MJMMrP6MKY8xu5mv1My/20okDHygFKMlgyzEXzSAlPWfhAe2SO1qe
         x0wM+nk+RaKhnJLevJpIUfW1fufK6AWvAfqby/X+N+kPasliDzzE+Mo3tItNtJFDHgiU
         6Y4TPjSkavpO3omAdPnFlaYaHjFCD7JJ+FtPkdfRqkmUGTfZEQ4/HMdpz3N3O9qoE6ZK
         mXMw==
X-Gm-Message-State: AOAM533lBqsfE7e9rNmRB817eN/GIOocKXrEkB8musNRkURf1R3BlJu+
        vTikTDHxiB64bKjIA2mc+AlpTSTBuIkaogY3zSs=
X-Google-Smtp-Source: ABdhPJxNZWuYH/8A7JmkXsS57791uw/AMFZzdoXTYEeXfyUEtNq49rXkuAD3c9lok1aG2vmSkwVYra8Cz/oOSTZ1rpU=
X-Received: by 2002:a92:d40a:: with SMTP id q10mr20463435ilm.87.1589861114283;
 Mon, 18 May 2020 21:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200519012927.GT2165@builder.lan> <20200519034055.hfvifqz442yfduhg@vireshk-i7>
In-Reply-To: <20200519034055.hfvifqz442yfduhg@vireshk-i7>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 18 May 2020 23:05:03 -0500
Message-ID: <CABb+yY30nmbBUzYG62xGEbrr7107h_Edyq3jKPheZAQ0Cvr9Yg@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-05-20, 18:29, Bjorn Andersson wrote:
> > On Thu 14 May 22:17 PDT 2020, Viresh Kumar wrote:
> > > This stuff has been doing rounds on the mailing list since several years
> > > now with no agreed conclusion by all the parties. And here is another
> > > attempt to get some feedback from everyone involved to close this once
> > > and for ever. Your comments will very much be appreciated.
> > >
> > > The ARM MHU is defined here in the TRM [1] for your reference, which
> > > states following:
> > >
> > >     "The MHU drives the signal using a 32-bit register, with all 32
> > >     bits logically ORed together. The MHU provides a set of
> > >     registers to enable software to set, clear, and check the status
> > >     of each of the bits of this register independently.  The use of
> > >     32 bits for each interrupt line enables software to provide more
> > >     information about the source of the interrupt. For example, each
> > >     bit of the register can be associated with a type of event that
> > >     can contribute to raising the interrupt."
> > >
> >
> > Does this mean that there are 32 different signals and they are all ORed
> > into the same interrupt line to trigger software action when something
> > happens?
> >
> > Or does it mean that this register is used to pass multi-bit information
> > and when any such information is passed an interrupt will be triggered?
> > If so, what does that information mean? How is it tied into other Linux
> > drivers/subsystems?
>
> I have started to believe the hardware is written badly at this point
> :)
>
H/W is actually fine :)   Its just that the driver is written to
_also_ support a platform (my original) that doesn't have shmem and
need to pass data via 32bit registers.
Frankly, I am not against the doorbell mode, I am against implementing
two modes in a driver. If it really helped (note the past tense) the
SCMI, we could implement the driver only in doorbell mode but
unfortunately SCMI would still be _broken_ for non-doorbell
controllers.
