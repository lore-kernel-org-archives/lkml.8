Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B28C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAAEE20814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="se3vu6er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEUTmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUTmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:42:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9414AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:42:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so2193838pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BXYPauGkNWtPwKYwGGvUTVu/KGcI14RapTxg+fHwXY4=;
        b=se3vu6erp2PBFC3GeiZK3pujHsPbv1+Tub7hi+r+f1Cu3Y6qod1+7C7rJZAl2ylOrO
         xe7x3AdAvBRwQZ+ViBf3KRKqKxm5/pfNZdBUCB+/cZixrse5Nrq3v5eAScYCzQNG0wzd
         bXws+6xkLfsjR+OPSM1Tezns0jGTj/TOo5PXDTpWjhjk72I2AHEzDy4zLLAQRg0+QW+d
         mWWYanxQ9LMvTj1CgdOsvNvsfhKpKSWJR4cuW1nWvYDuqsA5AQAaaRqI3ucSL53IB6V+
         x3ZOhZYpuxq0n4GGBJrYgVWsiorHx0X17eXWKyYOZtnXT4u7BGIxnD5cbxsAHeNBchtF
         OXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXYPauGkNWtPwKYwGGvUTVu/KGcI14RapTxg+fHwXY4=;
        b=BCyQfsA96Uu3tacMkO/MV6wkjQxetk6f8x5KXkAcw1MYFOX7JFE3TvkHrlexo2dcdk
         VqCpb6juYprUWZUGxr22sYLCxFUvRNyUi7miM7zDnu5cYn6noXJyMTk2G2e5GrQqs5v7
         GcGHUS8hprBoJ7BjmwOWNYGL0+LdS5wYjoTL4l1KZNale2xhN+K2LTudvExJ3bATF4xO
         vXk5ZrGSUaXyPkRGBl3QqOPqL8tY1NMnE+d+yWYjBXhgMr2yW82o9BeLnmvc9LxPI0uj
         iNqWLVv/x3oWllwPfpoCleDaTjTsIYwJE4knMv7ooXTEicEv0FFDIZajlcykZkpdjFEk
         TMEA==
X-Gm-Message-State: AOAM531eDUvvaStOY+p2XHrxr9xHChSTMNcm7K0dNnqvJm6XhvZjBnhr
        zVIGXereCTdWKB+BFV2zzXc/TA==
X-Google-Smtp-Source: ABdhPJxk6/AaRmSF7oCKZdzRq5JtighkgWW5LdhwQ4PD4zRb+L/JtxeyuIelMKGLsyYWPBn0ErhdvA==
X-Received: by 2002:a17:90a:248a:: with SMTP id i10mr157777pje.174.1590090155010;
        Thu, 21 May 2020 12:42:35 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n21sm5065359pjo.25.2020.05.21.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:42:34 -0700 (PDT)
Date:   Thu, 21 May 2020 12:41:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] remoteproc: introduce version element into resource
 type field
Message-ID: <20200521194116.GP408178@builder.lan>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-3-s-anna@ti.com>
 <20200521175421.GI408178@builder.lan>
 <b338480e-c586-f988-f5b6-784551b7beb6@ti.com>
 <20200521192146.GO408178@builder.lan>
 <57ae5678-fd0a-07a8-6165-a2cf7ccdef88@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ae5678-fd0a-07a8-6165-a2cf7ccdef88@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 May 12:29 PDT 2020, Suman Anna wrote:

> On 5/21/20 2:21 PM, Bjorn Andersson wrote:
> > On Thu 21 May 12:06 PDT 2020, Suman Anna wrote:
> > 
> > > Hi Bjorn,
> > > 
> > > On 5/21/20 12:54 PM, Bjorn Andersson wrote:
> > > > On Wed 25 Mar 13:46 PDT 2020, Suman Anna wrote:
> > > > 
> > > > > The current remoteproc core has supported only 32-bit remote
> > > > > processors and as such some of the current resource structures
> > > > > may not scale well for 64-bit remote processors, and would
> > > > > require new versions of resource types. Each resource is currently
> > > > > identified by a 32-bit type field. Introduce the concept of version
> > > > > for these resource types by overloading this 32-bit type field
> > > > > into two 16-bit version and type fields with the existing resources
> > > > > behaving as version 0 thereby providing backward compatibility.
> > > > > 
> > > > > The version field is passed as an additional argument to each of
> > > > > the handler functions, and all the existing handlers are updated
> > > > > accordingly. Each specific handler will be updated on a need basis
> > > > > when a new version of the resource type is added.
> > > > > 
> > > > 
> > > > I really would prefer that we add additional types for the new
> > > > structures, neither side will be compatible with new versions without
> > > > enhancements to their respective implementations anyways.
> > > 
> > > OK.
> > > 
> > > > 
> > > > > An alternate way would be to introduce the new types as completely
> > > > > new resource types which would require additional customization of
> > > > > the resource handlers based on the 32-bit or 64-bit mode of a remote
> > > > > processor, and introduction of an additional mode flag to the rproc
> > > > > structure.
> > > > > 
> > > > 
> > > > What would this "mode" indicate? If it's version 0 or 1?
> > > 
> > > No, for indicating if the remoteproc is 32-bit or 64-bit and adjust the
> > > loading handlers if the resource types need to be segregated accordingly.
> > > 
> > 
> > Sorry, I think I'm misunderstanding something. Wouldn't your 64-bit
> > remote processor need different firmware from your 32-bit processor
> > anyways, if you want to support the wider resource? And you would pack
> > your firmware with the appropriate resource types?
> 
> Yes, that's correct.
> 
> > 
> > Afaict the bit width of your remote processor, busses or memory is
> > unrelated to the choice of number of bits used to express things in the
> > resource table.
> 
> I would have to add the new resource type to the loading_handlers right, so
> it is a question of whether we want to impose any restrictions in remoteproc
> core or not from supporting a certain resource type (eg: I don't expect
> RSC_TRACE entries on 64-bit processors).
> 

Right, but either you add support for new resource types to the
loading_handlers, or you add the version checks within each handler,
either way you will have to do some work to be compatible with new
versions.

Regarding what resources would be fit for a 64-bit processor probably
relates to many things, in particular the question of what we actually
mean when we say that a coprocessor is 64-bit. So I don't really see a
need for the remoteproc core to prevent someone to design their
system/firmware to have a 64-bit CPU being passed 32-bit addresses.

Regards,
Bjorn
