Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB4C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2732469B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxyIrW6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgB1CR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:17:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38088 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgB1CR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:17:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so870873pfc.5;
        Thu, 27 Feb 2020 18:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2EGIDOcwSkQzmyztRJT0eD0yvIAqM5S1zi6e6PNVyBE=;
        b=hxyIrW6h6Ksa8bvLFVo5YgU+CvO5X/olU27A6pYYW76LeZfR4jZ8f8GVTuclvQdm35
         7Xivx1a7iFUjwdrTMQD+wjxC9C8mg/36mvjEzV69PG7apCteWxANtJfQmjescKO4nzb4
         +GIjeyT9KxhNLjNOAmEPh7PIWiuDeD/Sgu8a/8B49qQLPHhdse0LWldQ4B3+kNuozhDl
         LNVwypVwSM2iN89h1gz8E2KXgEBxQCRfnV+D7wv1tta50ly6Pwepl8eN8n7ZkV5Tzfd+
         FsNfc6qDHLBk7OH2XsYWwvyJ5634BgdBxfLMMcTH8GBjeViZpmiZX601BMpnDEHWOGfm
         GGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2EGIDOcwSkQzmyztRJT0eD0yvIAqM5S1zi6e6PNVyBE=;
        b=fxSw0FR+uYDy5zRFbcJ5hIcIspoqKjKE4Fmnu5+XmL2D2a7S+q9jorPyZjZG9o2lp3
         7ds6PEuWxIm2xB3VftbG9FSvqGirVECv+8/I74dqajwLhJjxZhKdWWAB4Xlg6980JMbC
         zuet14nO2TSiwZbaUeEK3gTODTJEQYamAVlDNEX+KwWFQyjOd1trET0Bmo/R4/ucM0SK
         NUPeNpgxROUi+Vn8/iwuPa8kbpLVme7v8m0CaoFxVke2RFx7BaKVSdnEGHQJAcDn7qUe
         jK3JvC1K7J1BFYGtlSQWJtiNYxqAsShg3vyJFFfWVoHp0BTs6+OccAyCtVhbPZM+UUZw
         ohOA==
X-Gm-Message-State: APjAAAVaIHrXEsLYNf9ucDAAIuTgN/h2JN/COBWo9se0Fi4a11vE77FD
        T0mIZ7bDG7+gNpjg8zOxzf8=
X-Google-Smtp-Source: APXvYqyUgHXDdMtyN5qf7cF9j3WUfPh16bn//Fez+Zv6OmxeEF/n0f8zXq5msQ21fZp6elwSchs83Q==
X-Received: by 2002:a63:6ec7:: with SMTP id j190mr2177647pgc.356.1582856247969;
        Thu, 27 Feb 2020 18:17:27 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id h185sm8824175pfg.135.2020.02.27.18.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 18:17:27 -0800 (PST)
Date:   Thu, 27 Feb 2020 18:17:19 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200228021718.GA10827@taoren-ubuntu-R90MNF91>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-8-rentao.bupt@gmail.com>
 <20200227165504.GA26955@bogus>
 <20200227224250.GC29420@taoren-ubuntu-R90MNF91>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227224250.GC29420@taoren-ubuntu-R90MNF91>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 27, 2020 at 02:42:51PM -0800, Tao Ren wrote:
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub@1e6a0000: 'aspeed,vhub-downstream-ports' is a required property
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub@1e6a0000: 'aspeed,vhub-generic-endpoints' is a required property
> > 
> > See https://patchwork.ozlabs.org/patch/1245388
> > Please check and re-submit.
> 
> I ran "make dt_binding_check" in my local environment and don't see the
> failures. The 2 properties are introduced in this patch set and I add
> the properties in aspeed-g4/5/6 dtsi files (patch #4, #5 and #6): am I
> missing something?

I think I missed "libyaml-dev" package. I've reproduced the error in my
environment and added the 2 required properties in patch v6.


Cheers,

Tao
