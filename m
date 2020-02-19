Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFBC7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B176324670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582150466;
	bh=N211GYwBeBK341ThgMDhwyjOl9k3AX/2zhp0K27AEWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bS/Qo2S8nbiVnj0R+S0wbrcq4c89+Pv7qVz8Ez4qog7VxwZYKBRlKsJ6QRZz/zjGV
	 BTkfzndEROQldAO4Cb6afwZ/AxkiOG+W5/5KVaLj1sCabrJI0wcE0pVanAb5J+ACcY
	 3lCKk/nTFfkeOte5klopuKThfh7svb574LdpXwrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBSWOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:14:25 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:32980 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgBSWOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:14:25 -0500
Received: by mail-ot1-f44.google.com with SMTP id w6so1778266otk.0;
        Wed, 19 Feb 2020 14:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PCB28ZHMHLDxZ8UN0t28z/W7i0m8dXBxggY1wp5teCo=;
        b=LocM/Y7b0RfVgs2EiT087MB4fF0EKI68woCpFn2kakVu1VP/K2jHx6/fsUp/SHs7vL
         sXZDZn9h2rhe70OyHO4fHjCxOLVgzqyWOljhn32j7KZ7tz44G6xujU4AvmIvvb2WmKIa
         8570dTnozpTmTYEWDSQag4qMA2pTUU2hf3G29ghDlo0+/5o0nozuTSqXe1qMVc6WN1PP
         48P77bZiVZVlQExunH5uZFE4Z/xqdx7Owpdv+16xijmluhzVgMHBBdCz1z5EyAQcOpxd
         EbsoUGO1OyTEcuip5D8JyPUyXDbFNLjOU31QtmoN/7EX9cCbaZu8MdpYWz7EC6ZqOvog
         l/zQ==
X-Gm-Message-State: APjAAAUEhnPFUus/91XFhpWKOO+1UsnA5bi5ceoNbdUP5YjkBt7laaDf
        AdO68SW11E2v4epsRNLPyg==
X-Google-Smtp-Source: APXvYqyobv41FyF6JR9Ye576ZoF0o/UE945k9arGF5Dektgk3qpqgQezDg6xv8alvXICKnJMdOqE9g==
X-Received: by 2002:a9d:7851:: with SMTP id c17mr21733875otm.58.1582150464028;
        Wed, 19 Feb 2020 14:14:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm376115oty.48.2020.02.19.14.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:14:23 -0800 (PST)
Received: (nullmailer pid 32442 invoked by uid 1000);
        Wed, 19 Feb 2020 22:14:22 -0000
Date:   Wed, 19 Feb 2020 16:14:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [RESEND 4/4] dt-bindings: dsp: fsl: Add fsl,imx8qm-dsp entry
Message-ID: <20200219221422.GA32379@bogus>
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
 <20200210095817.13226-5-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210095817.13226-5-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 11:58:17 +0200, Daniel Baluta wrote:
> From: Paul Olaru <paul.olaru@nxp.com>
> 
> This is the same DSP from the hardware point of view, but it gets a
> different compatible string due to usage in a separate platform.
> 
> Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
