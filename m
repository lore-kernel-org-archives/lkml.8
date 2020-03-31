Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B1C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DC220578
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585673381;
	bh=yHAS29L5m0Tj17+jqpkqcxGQISwvDIxvJMm/vfNg7QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VliCdtGIl4iCVGbq+fsEwRQIcCdzN0ikNF4+1wXWpvRyNIlhmmGjl3eVZtCle0Ac8
	 F6e+yb1x8hCTyI8GWomrXU/x/tM9+npiD/aUvn0QqMy+Lqxfnu0zIpNOLdyo9OxlEY
	 pMjHJcktVMy0bbMWQSwS588WUVaRv4C9iv5YXPSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgCaQtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:49:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38442 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:49:40 -0400
Received: by mail-io1-f65.google.com with SMTP id m15so22495993iob.5;
        Tue, 31 Mar 2020 09:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QwrQutvISOdwRt5xFRlvMoy4S4i7e5APKKFlmWfPlI=;
        b=PvlCBlOVhWpiEE5vOlhHcqN26W3aL5DkkchPoDew3CcASddiAUT2tm3rbub6g58/U6
         y6UbJDsXPEaMQ86yFvefEQAT7/skAvRU9KmpQ/3mM47im7p/rHF275Ag59VllBgo+GD9
         E1SR6I77dXgOqvAKi1V4abV2UCa/2u7GkfDWbsuuKmoB+EqqGQvfeOTOnYpZR2UKmapI
         08Q49ocMaabZMLSOhasoLTIFhj+cGGDVJ3qHuDZB4G2wCHZ8e7crL1Z3PB/qQXde7rwd
         os5C1S4d494Yx2zyTPWrO0F5gyrYH9L8Ffri8zKw6qtC5vo354BuHsi91KdK4UJs9Q/9
         AwsA==
X-Gm-Message-State: ANhLgQ33odvHo52AVS4GKqggNVwT126y0KI4yq6Ivt3emb+8Dy0WFKbJ
        oiIKz8uniI6isEqG1lcvjg==
X-Google-Smtp-Source: ADFU+vu0uvJu27akUkqWds8x0YrvgBWePU3mk/Nwbnw0BEYSzZyw5fX/kIW3WxqJWs3yGGKUbPvnEA==
X-Received: by 2002:a02:5a82:: with SMTP id v124mr8013603jaa.132.1585673378445;
        Tue, 31 Mar 2020 09:49:38 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l17sm6133742ilf.28.2020.03.31.09.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:49:37 -0700 (PDT)
Received: (nullmailer pid 20383 invoked by uid 1000);
        Tue, 31 Mar 2020 16:49:36 -0000
Date:   Tue, 31 Mar 2020 10:49:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     fabrice.gasnier@st.com, lee.jones@linaro.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: mfd: Document STM32 low power timer
 bindings
Message-ID: <20200331164936.GA18783@bogus>
References: <20200331083146.10462-1-benjamin.gaignard@st.com>
 <20200331083146.10462-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331083146.10462-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:31:41AM +0200, Benjamin Gaignard wrote:
> Add a subnode to STM low power timer bindings to support timer driver
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 5:
> - the previous has been acked-by Rob but since I have docummented
>   interrupts and interrupt-names properties I haven't applied it here.
> 
> version 4:
> - change compatible and subnode names
> - document wakeup-source property
> 
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
