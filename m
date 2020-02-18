Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EEBC3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A72070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582059611;
	bh=9VFLIpvHCUonzusOwJLnA08GCA8JcwJBbhUKZiS6Fh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=apD6ENg9Du0l6nQd1Ff+e36Sz2hRaUqlB4L3cL9X7iV3gFwMjtQDI3KvbQs8An+CI
	 wvbZLjlCutLWxHJNahM09zMRBk1ZVIQd/5nrwxU2wDwPxZHOwqTDK4klqAdSy97I3l
	 hOpaxvMtrH3tn5U0xmV+Bui+tpEL4OhCOoOjZvQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgBRVAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:00:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37227 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:00:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id w23so4526571otj.4;
        Tue, 18 Feb 2020 13:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZdSZVnFTTL60ilak2TTEP7SdA1gf6hbeTUpnAC0fEY=;
        b=JW1TMgw+oqDThRlFbFkU1CVTMhfET0pQbiW4h8wYztN3sItpNF4FQ6hmdizDlZsW7V
         t2nJ/qFWLvwqtC+Ms4Q5dqHCeq8q4wHnyN8bXm1ihzArowyFsAPj8KI8PzJKEBTP+5hA
         207c90e/vzZfpgODMIORR55+49DzGt17LCEeRnkxDLhhmVN0ylO+OeI35kmE2gAQ3OXZ
         MJIk0AmR3A3lr1AH/t2UW1N4jhxgjQP1UZbscxUbfjXTaqafSQ94OUeggTRZzOIm2JTw
         iHOBBPmZSIS1kEvqLH1eAovzE9DHNktc+YuOAe8JsF4CaZjpE7WWoNBqQC7OGMqYH4B2
         TauQ==
X-Gm-Message-State: APjAAAVDym2nM5OUdhgCD7XqbGMl2uQvUIkmDxt8KjCfDZJP/P14Z08N
        Khk+J5LePQbc8VAr1Wq5Kw==
X-Google-Smtp-Source: APXvYqxBQJgcoPbaU7PhwEXKClf1mLX8ROp0uTfC2VI4ZU5HWY5HM3BpMCCje1myXwydUl1kHDMoZQ==
X-Received: by 2002:a9d:6c01:: with SMTP id f1mr16594053otq.133.1582059608989;
        Tue, 18 Feb 2020 13:00:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3sm1731641oto.57.2020.02.18.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:00:08 -0800 (PST)
Received: (nullmailer pid 27504 invoked by uid 1000);
        Tue, 18 Feb 2020 21:00:07 -0000
Date:   Tue, 18 Feb 2020 15:00:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>, arnaud.pouliquen@st.com,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 3/3] dt-bindings: remoteproc: stm32: add syscon
 bindings preloaded fw support
Message-ID: <20200218210007.GA27448@bogus>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-4-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174205.22247-4-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 18:42:05 +0100, Arnaud Pouliquen wrote:
> Add the optional syscon property that points to the resource table
> address and the state of the Cortex-M4 firmware loaded by the bootloader.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
