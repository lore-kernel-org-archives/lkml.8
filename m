Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CF1C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829C420857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587138274;
	bh=hnf2A8V4qBNWsT2wZc5TYR/5N45Rb/xIL/GsDn1Hfpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SbHc/lhkiLBjPDhl8mLcL7lIkqSC6UDKQqLiVPoxcPXv1U4U88R2mVPzlP2eFBsZ3
	 j69ULazHpx17UDHeS+Ps7cz3jYuNE9YpYPJJ+6JyiU5s2I+aJpravg1463/cOdf5OE
	 TYSpkCgVxq5kltMHALYWM5eIprLQ1FdpxpPSiEG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgDQPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:44:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44537 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgDQPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:44:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id j4so1750846otr.11;
        Fri, 17 Apr 2020 08:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0hSg8h89PKnJqverNNE6/RmqgqRpENkMCA9/HM0Hqk=;
        b=FPKI5j9bN47ImjahmQoMx2u1slRN5D8MSzjXgL1MhblyKU1bvUt2qQC0Bs4IJrqqNB
         N6/pdDGJQvor5WbokCP5gSG7UUyNkOsJE7MsN/5rC7VQ9Tz8tkOJQ+mvFd/durXHeYcq
         WH8z25H9v5k5C+zVAq+L9Tbpp2d/8FVK68l5u4w9Of+WGnOVXoCEr5mvyKrMocHlXOpV
         FEEn4h2+Ihnepsh4MgiVggs7w8AP+yTKACbHNdfesnbpWGq7EECtnFHE8BuodkBx1Zo/
         z8+hE5E3DkE2M6dEkzQHrsuWRs7HALwuJE7mDsj0Ui3e8/FY6815WJVbKqnMV1v9UIpI
         4p8w==
X-Gm-Message-State: AGi0PuaDetdWnjjpWJxvQuEy5GJUFfyH7uAYACxdyqOEFVO97bP9IBsU
        9T+pa9qVGqNj7E0/LGqw8Q==
X-Google-Smtp-Source: APiQypIX59vHMIu6rkiJIVlneGwxYf3SsQrvwf/zImYtEcVKZu3FrSWZd2Jnj46N9DVJS/55PFPT+A==
X-Received: by 2002:a9d:7590:: with SMTP id s16mr3027305otk.250.1587138272409;
        Fri, 17 Apr 2020 08:44:32 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c15sm8840799oot.23.2020.04.17.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:44:31 -0700 (PDT)
Received: (nullmailer pid 12338 invoked by uid 1000);
        Fri, 17 Apr 2020 15:44:31 -0000
Date:   Fri, 17 Apr 2020 10:44:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: check libyaml installation for 'make
 dt_binding_check'
Message-ID: <20200417154431.GA12021@bogus>
References: <20200417040455.763892-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417040455.763892-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:04:55PM +0900, Masahiro Yamada wrote:
> If you run 'make dtbs_check' without installing the libyaml package,
> the error message "dtc needs libyaml ..." is shown.
> 
> This should be checked also for 'make dt_binding_check' because dtc
> needs to validate *.example.dts extracted from *.yaml files.
> 
> It is missing since commit 4f0e3a57d6eb ("kbuild: Add support for DT
> binding schema checks"), but this fix-up is applicable only after commit
> e10c4321dc1e ("kbuild: allow to run dt_binding_check and dtbs_check
> in a single command").
> 
> I gave the Fixes tag to the latter in case somebody is interested in
> back-porting this.
> 
> Fixes: e10c4321dc1e ("kbuild: allow to run dt_binding_check and dtbs_check in a single command")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/dtc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
