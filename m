Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37736C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C30A2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581473217;
	bh=umrSbJk39wy9eXeneTcJHzJq4oJofSkULgg//8oRT/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vEstKOknY9axobE/JMtp58ymwtDlVpi6lZsO4PreQ9wJrL4iUi0Fzs+ACWB0jwZ/V
	 KElGeI1QSK2ObOezqfU4wIxz9JDEB7VN/BG8S9n+Xrlet9ZObj2+0VFo9jRHIb4YLu
	 u9dksoEbboaWLWqYpAl/4FYQrnJe6unkGgIWt3io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBLCG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:06:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41704 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:06:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so520014oie.8;
        Tue, 11 Feb 2020 18:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tVXjPjxR9wTAQLJNH5T7mUhjsaEtPI+g7h5Obb2jWnE=;
        b=VGUefA5ms/wVUzLX4GqnQMVWPuyhylNRL6MVibCxlT4tFErgfTxL/tz5R4JbM/kPLN
         cXPI0n7RfeeQYxepmLSCTjLk5Psz0W4uJmHmDd+PJ0tG5l/6aU6HgfbUQM4J8uzas34L
         C8fFLI1Y39dFWkcUv3Z8Fb7GhoKpGCJ2v4T67g/OvLqASETPLPrx546wOC2ohAp6yhGv
         GIwG5Opav0fykrguET1zRIVNLwb7W+dakf7peIRETuiACmid/49mfl0hMqtOFeBi4pws
         o6FWFW5eUZmmf9sh81IZUfhSTSFvgVeBNld9IpTK7tHVvjXx3o9tjor0+yS+xrsmwBPX
         oo4w==
X-Gm-Message-State: APjAAAX0uvash15Amd4YfusYR21RmVstVLOdvLv57hTQqb6dNnWFjqsC
        GPRMH0fWCC42ngP19XEhYhUhY1c=
X-Google-Smtp-Source: APXvYqybQ/XV/KhEd/2JUE85p1PXN4bVy5ZMAraDqMTKCuVg5SpphZnA98DtlRuWcuJmCzIfBzRiMQ==
X-Received: by 2002:aca:1708:: with SMTP id j8mr4794797oii.166.1581473214862;
        Tue, 11 Feb 2020 18:06:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 32sm1871958ott.38.2020.02.11.18.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 18:06:54 -0800 (PST)
Received: (nullmailer pid 29491 invoked by uid 1000);
        Wed, 12 Feb 2020 02:06:53 -0000
Date:   Tue, 11 Feb 2020 20:06:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, afd@ti.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv6 RESEND 01/14] dt-bindings: remoteproc: Add OMAP
 remoteproc bindings
Message-ID: <20200212020653.GA27019@bogus>
References: <20200211152125.23819-2-t-kristo@ti.com>
 <20200211153313.24072-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211153313.24072-1-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:33:13PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add the device tree bindings document for the IPU and DSP
> remote processor devices on OMAP4+ SoCs.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [t-kristo@ti.com: converted to schema]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> Quick resend. Missed adding Rob+DT list in CC, git is too clever to get rid of
> CC fields automatically...
> 
> v6: made memory-regions property optional

Small enough change to keep my R-by.

Reviewed-by: Rob Herring <robh@kernel.org>

> 
>  .../remoteproc/ti,omap-remoteproc.yaml        | 321 ++++++++++++++++++
>  1 file changed, 321 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
