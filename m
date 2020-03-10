Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2645C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9432120873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583866128;
	bh=n+cyrf7lfGTbCHVUgVgAurLOC6uO4AK85qBrh6PLbJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bvb8F1J01/kdiN7y5S+AdPzrx0SylSCVMgDp7g8isFtcJkMPzA9y3h5+6TMRoNmfW
	 mlqPCwCmPMiGiYYdyEoqZo4J8kS/J0nDvpTIDS6sp5dhZuqboKReuafVvr1DCDsdxL
	 qV0PpwZxOW9h83AsGg4D/kY/qgdhzQBpsuy/j8ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCJSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:48:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34964 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:48:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id k26so6971149otr.2;
        Tue, 10 Mar 2020 11:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzS4Ory16y/BLSb6no87Sernjs2m/cGxUWkwz4EtDSw=;
        b=bHrrbkEe93tofoi9fXugjJHRTbU1TMEPmLwDmEpz8kIbcp0BZ0uzFY8CIz2TJE4QcA
         H65GMIhzduUY5GGOIMKxjYW5G3WonEnC9qKqbKjzWdsQRBAc4XAL/1eoLfx8BEn04W/j
         ZSyofGpHSCT2mSnIwTFyM/26ltBHBROy8hLn4gGlZ1nbCI1RoL3V/uV9pIzgqZ5jzH99
         h/rYMYXJseNhVRsU+jZ7eaVF15w0BBvNe8DADxmBi8Ji5M0mhnQB9ciLrFG3Tz/5TmUp
         lgDc37Rm4v7ABAPQjaFOVcyWfL4tLjzYqBi7etHKbbCSgKd9Q6BLr9lQgMjSh1AoMi2R
         emzQ==
X-Gm-Message-State: ANhLgQ0dMupVGjiZ9/kzLLm6Wuk24FFRFTOHdi4y65/YpP2rEAwiaFsm
        O9r+uJ+LLmv2bhyjOtZ1dw==
X-Google-Smtp-Source: ADFU+vsMU183YY5TJ9IDWm2qf6EIOH/EKHLHafJAiNQIT7jZ1BNW3xQAYT9kBEXnBN09EB1NU0f2WQ==
X-Received: by 2002:a9d:750d:: with SMTP id r13mr7271522otk.321.1583866126181;
        Tue, 10 Mar 2020 11:48:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a73sm2633320oib.16.2020.03.10.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:48:45 -0700 (PDT)
Received: (nullmailer pid 15229 invoked by uid 1000);
        Tue, 10 Mar 2020 18:48:44 -0000
Date:   Tue, 10 Mar 2020 13:48:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        olivier.moysan@st.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] dt-bindings: sound: Convert cirrus,cs42l51 to json-schema
Message-ID: <20200310184844.GA15190@bogus>
References: <20200228152706.29749-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228152706.29749-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 16:27:06 +0100, Benjamin Gaignard wrote:
> Convert cirrus,cs42l51 to yaml format.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/sound/cirrus,cs42l51.yaml  | 69 ++++++++++++++++++++++
>  .../devicetree/bindings/sound/cs42l51.txt          | 33 -----------
>  2 files changed, 69 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
