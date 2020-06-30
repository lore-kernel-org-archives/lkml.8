Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7449C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B162720722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqGvK2P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgF3CXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgF3CXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:23:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550ADC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:23:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so7847529plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D7EQW6LVu/0LCQVaLjrZlygqrUoX4J/4WhIdq95ups4=;
        b=eqGvK2P0KbEv7YNVWM3sX4gdSuUS22MEImdYUCitDNbLwwQhlXEWVMN+sfnQfxSI7s
         X3ZIBVg76VMnPRXZLDlylOoDN2aMsPdl82fJrcCwBMALeO9TkTUu4vmMLyek91DGMJKb
         b5KkT4yWgiJNfABUQSLhbMG+6l8qMZK7pv24h3ZS18gqVw5Kq1LmRqmgHfUnSrdtbjfb
         bSMaxciVuXntSrLmo3XqJ4Td/FraZqYIPvwoEXdWHAV/LeSKTk+BRhZOU2ypdssfZ/le
         crp20QShS7XdaU+N1xz+B+0AbQA4L0rm24yak5coOERB5bK9q1uVAn7wadqkY1rG1c13
         CMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7EQW6LVu/0LCQVaLjrZlygqrUoX4J/4WhIdq95ups4=;
        b=JCfgcaxZUeMThSRNvKEKMx1wvgavJyOMF0pkwDTqRMsNIQSRgOSwN6LLvjqSOLAWPJ
         5zIq8wMHc1L6L4j/P4BzSk33q1YXCcrLVmLgZBjjXiDRTW5sX5ahhRPVKfM6UExBgKnb
         TFQZfOb8b2egz3nxhIUycX/BbP2TquWJ3g4Dw2kIwgv9SgNCe3cpWkwMo3u2ux2YaDYu
         snP2TqJypIu0xRcmlkBJ/5n1WANR6iIQwvewKHl9i+csC5KSteIrHD62mBiOyDmIzmPa
         YuJH5TD2zv1hVT/KoMPytB6sWfuzKURAzqGdo6f3BiKszvxqLNOL3748EPhqd0c9kdu8
         0ZNw==
X-Gm-Message-State: AOAM531IVlg7F4nthJzaI0UaUtEi2Y78ISuSFEYkgBejfHH1v+qmIQ2o
        aLP58DWVR5azRFQ89b4/a8ugBw==
X-Google-Smtp-Source: ABdhPJzrYacdOd5DIB52tslC3wsLFea6Uoc0i4RCCBB1Jf0xYsnX6xU+fppqQC3njjiitgbGDm3/BQ==
X-Received: by 2002:a17:90a:20e9:: with SMTP id f96mr20462600pjg.13.1593483781624;
        Mon, 29 Jun 2020 19:23:01 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j19sm819933pfn.109.2020.06.29.19.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:23:00 -0700 (PDT)
Date:   Mon, 29 Jun 2020 19:20:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stefano Stabellini <stefano.stabellini@xilinx.com>
Cc:     Rob Herring <robh@kernel.org>, Ben Levinsky <BLEVINSK@xilinx.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Message-ID: <20200630022029.GC407764@builder.lan>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
 <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com>
 <20200511221755.GA13585@bogus>
 <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
 <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
 <alpine.DEB.2.21.2006291734370.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006291734370.8121@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29 Jun 17:37 PDT 2020, Stefano Stabellini wrote:

> On Wed, 10 Jun 2020, Rob Herring wrote:
> > On Tue, May 26, 2020 at 11:40 AM Ben Levinsky <BLEVINSK@xilinx.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > The Xilinx R5 Remoteproc driver has been around for a long time -- admittedly we should have upstreamed it long ago. The driver in the current form is using an "classic" remoteproc device tree node as described here.
> > 
> > I would rather not have 2 possible bindings to maintain. If there's
> > been no rush to upstream this til now, then it can wait longer.
> > 
> > >
> > > I am working with Stefano to come up with an appropriate System Device Tree representation but it is not going to be ready right away. Our preference would be to upstream the remoteproc node and driver in their current forms while system device tree is maturing.
> > 
> > There's obviously going to still need to be some sort of description
> > of the interface between cores, but this has parts that obviously
> > conflict with what's getting defined for system DT. The TCMs are the
> > most obvious. If you can remove (or hardcode in the driver) what
> > conflicts, then perhaps this can be upstreamed now.
> 
> 
> Hi Rob,
> 
> Sorry it took a while to answer back but we wanted to do some research
> to make sure the reply is correct.
> 
> 
> The System Device Tree version of the OpenAMP remoteproc bindings aims
> at being simpler and vendor-neutral. As anything else System Device
> Tree, Lopper will read it and generate a "traditional" device tree with
> the existing remoteproc bindings. In that sense, it might not affect
> Linux directly.
> 

Can you give some examples of how you will be able to describe the
hardware involved in powering/clocking resources surrounding your
remoteproc and the necessary resources in a "simpler and vendor neutral"
way that then can be further lopped(?) into something that Linux can use
to control any remoteproc?

> However, given the fragmentation of the remoteproc bindings across
> multiple vendors (they are all different), I think it is a good idea for
> Linux, for System Device Tree, and in general to come up with simpler
> remoteproc bindings, more aligned between the vendors. If nothing else,
> it is going to make Lopper's development easier.
> 

In my view the big reason for the fragmentation between bindings is
because they all describe different hardware. There has been common
properties of remoteprocs discussed, but apart from the firmware-name
property I don't think we have agreed on any.

> 
> So I think it is a good idea to take this opportunity to simplify the
> Xilinx remoteproc bindings as you suggested. The idea of to removing the
> TCM nodes is a good one. In addition I asked Ben to have a look at
> whether the mboxes and mbox-names properties can be removed too.
> 

If your remoteproc uses a mailbox for signaling, then this should be
described in devicetree. This will allow you to reuse components in
other designs where either part is replaced or reused.

Regards,
Bjorn

> Ben will reply with a simplified bindings proposal.
