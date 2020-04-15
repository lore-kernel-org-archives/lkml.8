Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EECC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940DC21556
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586966544;
	bh=9VkA7tg0hn4Ub8bxsko+NpXHvDg8vbTQionDdhYFFoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BkVtBjifZlLpHUyaiIpMcc1M0STuu2rFs2nJ0i+s38+mXRVxGj16esz6+djM0zIa5
	 Bq+0vb3yAioWMHSJaXF2MkXXLEkd3r+LsFzp6sEd2haY4pqGPNoodz/L6FBrz5neFs
	 +tp/vmBEP471ZznyJMG0kOwZe8BqhMXHQJ3KUnsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406296AbgDOQCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:02:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36414 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406231AbgDOQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:02:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id s202so10681966oih.3;
        Wed, 15 Apr 2020 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=423HVimEHq5Dj2Jz8+OlR5o9pwavv3x54hJ0usDWIDw=;
        b=UKETlWzEqDrR4nN1yD5/Sib4ZkE+hcv5iYIdCdiexTMXeBmiDvyoR+wXcNCc6u3lAO
         2ytb2qABEbPIeS8uAvrrpcW1I+3yVZgU3mXiqK/UD0ziJeplLE33kQmKrj4MWoltLud2
         ahKQsZT03b0TeyXrRtztkXi3cs5M5lrlxgta2r/e0qjgh3FCX+1lSZp8RviWXTkUM9lr
         y2YggFzHnf09v6a0Ps4YYaaU2F9wCi2hvnkp6eSKkCNyapRTJdQSyL/geOfoQ87mgT3y
         ZnD6FI8PZkqdMlhpZZHOhoePY/bQbaT0Q820z/kcvQM6ea4BDAsBROy5NAxKXgdqsZBm
         rltQ==
X-Gm-Message-State: AGi0PuYDCjN+1jhZCbCPCPTIKCAVFmF8lx9PebUw57KBw9J8Hlb+lube
        KIQpPA5yQCEFHmb4u5bo1Q==
X-Google-Smtp-Source: APiQypIC6jqygwZFVB7+DVFz/zsP66LHK3iuIMxgJKYN6XMmFSItZFVNAJ6sRzf4dgEWIgvpTYf8+g==
X-Received: by 2002:aca:4843:: with SMTP id v64mr18834734oia.13.1586966524049;
        Wed, 15 Apr 2020 09:02:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j90sm6385763otc.21.2020.04.15.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:02:03 -0700 (PDT)
Received: (nullmailer pid 1964 invoked by uid 1000);
        Wed, 15 Apr 2020 16:02:02 -0000
Date:   Wed, 15 Apr 2020 11:02:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: timer: renesas: cmt: Convert to json-schema
Message-ID: <20200415160202.GA30686@bogus>
References: <20200408091416.25725-1-geert+renesas@glider.be>
 <CAMuHMdWBPS7hZZqPvSyns4OL37Dm21R+eReEAtmH8XUy=qsRqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWBPS7hZZqPvSyns4OL37Dm21R+eReEAtmH8XUy=qsRqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:22:08PM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 8, 2020 at 11:14 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Convert the Renesas Compare Match Timer (CMT) Device Tree binding
> > documentation to json-schema.
> >
> > Document missing properties.
> > Update the example to match reality.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Oops, I forgot the dreaded "additionalProperties: false".

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
