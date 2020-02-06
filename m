Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA1C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC378218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581026417;
	bh=pHFAwz9wfbrc8m+EYW6L4b/ya3IdzTK4JRns6/kZj6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=03IFNzYD5fZVWd67IXjiz3JTNXOCFnxuJjZ/tncOTqcrMdZUDLidOpw7VYShFSIv2
	 MCxNvzyLKEJLNcnt4eKO1gMmMgm17f7g7FHGevFauD1Bh7lBf3z2bG8dz8XaNrdV1V
	 JAJEMwzKD2gJ4TS9ApUxLKd1hofJAClh70Vgqd4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBFWAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:00:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37139 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFWAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:00:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so154372pfn.4;
        Thu, 06 Feb 2020 14:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RE/0U9HMaaH2hc20ud5C4lxm6MqO7eGkAYTEiyXyOb0=;
        b=tz4WFzfjnhDwtr5dsiEOAWxr++A9ejCXtqotSjRAcFV+97fm1TQUlRCeFwebPiPg6X
         Pow+J7rUnivlPmJ3vgiYvFl2kB9gad13RfsQleKKr1tJzH0eRGdEZYshbeB7xamBymXh
         QywVXbTyn2jUk0Pfuqhma87+Q4Svlnw0w3V386qh8AgYhexBWiHkCF1Lgry/U2NcdGKq
         XbNxBG9ANvI+iR9BGxfIb1qcjGboqhWRNIT3u3L5LKG/w1FZePdni5PE2O/qUtE6fzDr
         2CbD0dYYJUkIDGrlazQl34wMCRA7n1gZ7gNB7gFH0+c6XJHgTT6bI2n4djAQaB/TWJWC
         sGiQ==
X-Gm-Message-State: APjAAAW0Y7NC+bOkG1CJCkj97njdWpSPgBnBK0VQZUUXx0UEc1w4IEWO
        paVFYeWfN0hgQ1SWf9aWnRrGD/d8/Q==
X-Google-Smtp-Source: APXvYqzKAZlOtZ6zTxVdNseR3XTrwfkuVpvDHj6Wjm4UEWVA+8HSlBMS//56y3E0jNlK1vsVxbxfCw==
X-Received: by 2002:a05:6a00:5b:: with SMTP id i27mr6395683pfk.112.1581026416197;
        Thu, 06 Feb 2020 14:00:16 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id h62sm287723pfg.95.2020.02.06.14.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:00:15 -0800 (PST)
Received: (nullmailer pid 24167 invoked by uid 1000);
        Thu, 06 Feb 2020 22:00:14 -0000
Date:   Thu, 6 Feb 2020 15:00:14 -0700
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        philippe.cornu@st.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: one file of all simple DSI panels
Message-ID: <20200206220014.GA24061@bogus>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
 <20200206133344.724-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206133344.724-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 14:33:42 +0100, Benjamin Gaignard wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> To complement panel-simple.yaml, create panel-simple-dsi.yaml.
> panel-simple-dsi-yaml are for all simple DSP panels with a single
> power-supply and optional backlight / enable GPIO.
> 
> Migrate panasonic,vvx10f034n00 over to the new file.
> 
> The objectives with one file for all the simple DSI panels are:
>     - Make it simpler to add bindings for simple DSI panels
>     - Keep the number of bindings file lower
>     - Keep the binding documentation for simple DSI panels more consistent
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Yannick Fertre <yannick.fertre@st.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: devicetree@vger.kernel.org
> ---
> version 4:
> - remove orisetech,otm8009a and raydium,rm68200 compatibles
> - remove reset-gpios optional property
> 
> version 3:
> - add orisetech,otm8009a and raydium,rm68200 compatibles
> - add reset-gpios optional property
> - fix indentation on compatible enumeration
> 
>  .../display/panel/panasonic,vvx10f034n00.txt       | 20 -------
>  .../bindings/display/panel/panel-simple-dsi.yaml   | 67 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/panasonic,vvx10f034n00.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
