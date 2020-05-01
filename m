Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C05C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A64C21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588364047;
	bh=TevFkjb5rNexzQ+5edWV1jKKHFVOqDomhs7zDWXFj/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L/lT7MsA3+oErFxexW5xRIJdIUXkx7hsRZVgfrhFvDbdMiEMYg4OnNna+iqUXMO/I
	 5ySRjxlKc66LsGQB9Ze9gNLvBEHwl3dnPCFLeKpacFaXQNrRpA2Kpu0INZZN3swNZe
	 C/19r2oZ51+M5sFpriHXFLwKp2u+MhOMFY5Bw6FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgEAUOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:14:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33810 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgEAUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:14:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id 72so3524749otu.1;
        Fri, 01 May 2020 13:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2xG6LfTRRj7zxxC5OOjRbiExVAKfImflfttUoxbE6Wk=;
        b=E6A04inRYx8OfDNO0GjxnjC2PKh3Zq54wZ1FBdpvpec+0380jrtgCyBhZxocPbRbYF
         cc/hFmOss6Ylv/TeM8DV095zf2yGoom6lxi6GgAcFB16oU05O27p8jdaisB2qeetGVOp
         uMlS7Zuc4f/QU15TlVYOLY9Ifj98T4BmjCOYOraMXyES/iJTdiIU2XMlN8BzbqMuc5cE
         nkbc80J4o76gYC7YwFKZ/G4oa7q+HrEXaqbTbHZ47X+YhTy6S3/zWc3AG6B2mWRHMA7N
         KFTPondo1pV8bM6+DJ5v/W3NGdL1MBP+u7jEXVnvtvTAsv5bAedypqV2vd7cawwSv19F
         Qp6g==
X-Gm-Message-State: AGi0PuafzeL+DpN0HFLeJOTpVMjcbsQicrwhP9hf1gk7CgGM6DCdtiyD
        sePtHs8SSO2S4u04EJGu4g==
X-Google-Smtp-Source: APiQypK5652+F+YPF+Qn5GQulTJDVC1+CGSNJ8JQC4ySwrNbIYJVtWlnY9BlUtvjDv0XE2FcIET1+g==
X-Received: by 2002:a9d:6e3:: with SMTP id 90mr5124784otx.261.1588364044458;
        Fri, 01 May 2020 13:14:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d61sm1065978otb.58.2020.05.01.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:14:03 -0700 (PDT)
Received: (nullmailer pid 26942 invoked by uid 1000);
        Fri, 01 May 2020 20:14:02 -0000
Date:   Fri, 1 May 2020 15:14:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: audio-graph-card: switch to yaml base
 Documentation
Message-ID: <20200501201402.GA8603@bogus>
References: <87ftcxv2lk.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftcxv2lk.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:18:15PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/audio-graph-card.txt       | 337 --------------
>  .../bindings/sound/audio-graph-card.yaml      | 416 ++++++++++++++++++
>  2 files changed, 416 insertions(+), 337 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/audio-graph-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-card.yaml

This needs to be a series, so they are applied together and don't break 
the tools if only the ak4613 patch is applied.

As mentioned in the other patch, I think this needs to be broken up to 
multiple schemas and avoid definitions.

I'd really like to see either simple-card deprecated to use the 
graph-card or drop the 'simple-card,' prefix to align the property 
names.

Rob
