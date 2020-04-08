Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A8C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 05:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109E120730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 05:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLoEa84O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgDHFkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 01:40:31 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52833 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDHFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 01:40:31 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so723686pjb.2;
        Tue, 07 Apr 2020 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1prhrjKxEZds2TfTdybytV1XN9ZFJTSPhvDxSwKWbE=;
        b=lLoEa84OH4TcHPRT1UimZUdQLc7+R6JFgPXWoCIIRTR2AyiT/OPSoK3ieDWDqzM8qx
         lyCsqh2n5Zq2XflpC4bOHZ8iVDQrslNa1+/DzvMLAIWXtGMWlgcDE9ziykfEik9ddmBi
         tyxXTYOkvFRPwBCL9z5pyp0iPfR1I3wurB47f21uuqJtHxLVwahEtgitfWWN7flMDjOZ
         Safx8k04FtvoZcMhRSmyzx7z3Cwfou//CwYoXYZ07Wi8fW04reFQgw8Y0kGd+M/oglj0
         CPxccDmDXnLlKNcHfvjbisMg0rXq9cG1uOMWcwhtmdlAZqu3MIuoskOTHuqaUL6yiZXb
         664Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1prhrjKxEZds2TfTdybytV1XN9ZFJTSPhvDxSwKWbE=;
        b=dsl/KrW+Cw8tzF+oUPBZAQeSP7UmOI9wKRMXIC85CSCnjliMNYlo4kRSm8PxSGrdGV
         BGSiwkmgPvEeFdjWFBcHQROPE4cxNz4D1p4b7WDzzo9klpUOwkWPK4BI2I7qPrFY4edW
         yrhsR3vyZwHaEoM3oo4kcGg0jEK/oqs5Hl7cRElY00T8wFb9VKwga/r4owlRxlGT6k7z
         7bNFM3DonHzJIs1lRmV60h1juYAjN+5RGf0EsgffGZERGjPHV4QUodW5D9gojs1tm+sL
         yJ9MF9oGG5QvR9Gw0TiiYugF1+M40GMun1he05l1cZbNaoM4SHPffr4QqtczparVrIy8
         El7g==
X-Gm-Message-State: AGi0PuaCKwflXvVHlYqiPS9ONq2xa09XbnUU9J8c99nmneyy8y+1PcT8
        go09WczEOFvOinBYnJUvufQ=
X-Google-Smtp-Source: APiQypJp2wIHnlyEMM+6phi0GLCRMB+cJZqLMeiHhoqYBQwNHDoMx8FFoIJI/HdUYAVagNG142s6pA==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6mr5265576plq.319.1586324430524;
        Tue, 07 Apr 2020 22:40:30 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id d3sm15544077pfq.126.2020.04.07.22.40.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 22:40:30 -0700 (PDT)
Date:   Tue, 7 Apr 2020 22:40:23 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Joel Stanley <joel@jms.id.au>, taoren@fb.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] usb: gadget: aspeed: improve vhub port irq handling
Message-ID: <20200408054022.GA12469@taoren-ubuntu-R90MNF91>
References: <20200315191430.12379-1-rentao.bupt@gmail.com>
 <20200401215826.GA8248@taoren-ubuntu-R90MNF91>
 <512d625e45ea953d722bb7ea73c3619730312284.camel@kernel.crashing.org>
 <20200403064826.GA10866@taoren-ubuntu-R90MNF91>
 <20200407060242.GA15050@taoren-ubuntu-R90MNF91>
 <93ae433317a82de86ff5e9c8485563b78656b615.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ae433317a82de86ff5e9c8485563b78656b615.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:36:16AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2020-04-06 at 23:02 -0700, Tao Ren wrote:
> > I ran some testing on my ast2400 and ast2500 BMC and looks like the
> > for() loop runs faster than for_each_set_bit_from() loop in my
> > environment. I'm not sure if something needs to be revised in my test
> > code, but please kindly share your suggestions:
> > 
> > I use get_cycles() to calculate execution time of 2 different loops, and
> > ast_vhub_dev_irq() is replaced with barrier() to avoid "noise"; below
> > are the results:
> > 
> >   - when downstream port number is 5 and only 1 irq bit is set, it takes
> >     ~30 cycles to finish for_each_set_bit() loop, and 20-25 cycles to
> >     finish the for() loop.
> > 
> >   - if downstream port number is 5 and all 5 bits are set, then
> >     for_each_set_bit() loop takes ~50 cycles and for() loop takes ~25
> >     cycles.
> > 
> >   - when I increase downsteam port number to 16 and set 1 irq bit, the
> >     for_each_set_bit() loop takes ~30 cycles and for() loop takes 25
> >     cycles. It's a little surprise to me because I thought for() loop
> >     would cost 60+ cycles (3 times of the value when port number is 5).
> > 
> >   - if downstream port number is 16 and all irq status bits are set,
> >     then for_each_set_bit() loop takes 60-70 cycles and for() loop takes
> >     30+ cycles.
> 
> I suspect the CPU doesn't have an efficient find-zero-bit primitive,
> check the generated asm. In that case I would go back to the simple for
> loop.
> 
> Cheers,
> Ben.

_find_next_bit_le() function is defined in arch/arm/lib/findbit.S. I'm
looking at the code: will run more tests and send out patch v4 with
simple for loop later.


Cheers,

Tao
