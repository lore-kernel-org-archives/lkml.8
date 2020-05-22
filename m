Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB16206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM7/kxVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgEVRdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbgEVRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:33:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E444C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:33:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so3152270pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2tZSSQp+Q6NkFkvGgoTM41d8a2brRtjrb60yXEtR4oc=;
        b=xM7/kxVnNd5tkM3aD88kh404nBLGZ0PykMDKj1PajSxvbZKv5gN1DQN4908oXvpFkT
         D5j4s7pQVcv3lluXjL5hsxnA5VxVZtG0VkOtyF+z/kqlbmj4mJwBQsl5vSglfKkcR8nn
         hCubMPJ6ImS9MjzxWO29RgINWtO+wzHImrvVO8bqT+EgexwI4z0GvFjyJSQuvA0RU0kK
         XlRnMSnPgLf+iGmebcMZntq3a8e1GSzPZl1G1vlmX5mofuMANElZbQzYDpVk5myzPSTI
         AGp8GUBRrS5t+JdFrWN109JV1COJz5flF4tptKa4cikXYJEW3rP9B8NjoLN/dHAbj2yd
         l8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2tZSSQp+Q6NkFkvGgoTM41d8a2brRtjrb60yXEtR4oc=;
        b=XXgfA7DyQVycyRE/xN2hBQBiHg1gKbuMd98/uJ/3yIONOLvB3X0YqZTOR46kj95mAp
         rxIazFDAw0Tyc8FpjKxEwtxXR+xLD65D174mS9OSp1oITJwbpS4rwFzNVZVnpuaKNI4k
         UqoYiL9+wPnSWSgHF2aeqc1EoyUmJKu3Yd9+ZwKLszW/Ul/qQs1XXSLeeE1ehZDedAe0
         F2SA7JSUczFb4uip0GAdkY0paiWMxabnandjVleneN57t0OodO1TspFiK4PNgN7a9brI
         pkFADNHGcRoe3k4r72ZTgVAAks+X53sj2jWf0tY6VQeebsVZUhae9PWEeEf1+cueBPab
         LmuA==
X-Gm-Message-State: AOAM531reicFeTkl4SZU771vKyx9kZ+I+Pbk1U/hWABFs05MARp2uaTI
        VrhIzH2dmM8Zn/iSIUC8rz6Ybg==
X-Google-Smtp-Source: ABdhPJxs9ytct9W3l8jqHigChSN52KDjrcdPVZee/8dxkQn+Y6KW9FWnWmyEjZpnERt5Wp6T0UgISg==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr15699226plb.151.1590168829712;
        Fri, 22 May 2020 10:33:49 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t23sm7426330pji.32.2020.05.22.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:33:49 -0700 (PDT)
Date:   Fri, 22 May 2020 10:33:46 -0700
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
Subject: Re: [PATCH 3/4] remoteproc: add support for a new 64-bit trace
 version
Message-ID: <20200522173346.GJ11847@yoga>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-4-s-anna@ti.com>
 <20200521180417.GJ408178@builder.lan>
 <997d6f9a-64ba-7a89-e909-9a5a474120b0@ti.com>
 <f15b0c6d-eee8-b839-0c79-a5316dbbfa7b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f15b0c6d-eee8-b839-0c79-a5316dbbfa7b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 May 09:54 PDT 2020, Suman Anna wrote:

> On 5/21/20 2:42 PM, Suman Anna wrote:
> > Hi Bjorn,
> > 
> > On 5/21/20 1:04 PM, Bjorn Andersson wrote:
> > > On Wed 25 Mar 13:47 PDT 2020, Suman Anna wrote:
[..]
> > > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
[..]
> > > > +struct fw_rsc_trace2 {
> > > 
> > > Sounds more like fw_rsc_trace64 to me - in particular since the version
> > > of trace2 is 1...
> > 
> > Yeah, will rename this.
> > 
> > > 
> > > > +    u32 padding;
> > > > +    u64 da;
> > > > +    u32 len;
> > > > +    u32 reserved;
> > > 
> > > What's the purpose of this reserved field?
> > 
> > Partly to make sure the entire resource is aligned on an 8-byte, and
> > partly copied over from fw_rsc_trace entry. I guess 32-bits is already
> > large enough of a size for trace entries irrespective of 32-bit or
> > 64-bit traces, so I doubt if we want to make the len field also a u64.
> 
> Looking at this again, I can drop both padding and reserved fields, if I
> move the len field before da. Any preferences/comments?
> 

Sounds good to me.

Thanks,
Bjorn
