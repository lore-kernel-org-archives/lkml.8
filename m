Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB03C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6562E246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFlUCv7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgB1BFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:05:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41471 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1BFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:05:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so774076pfa.8;
        Thu, 27 Feb 2020 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vYKIHHhVn7nSPH52/lrlIOtB7hqwWnXUydbXUcnZWnI=;
        b=QFlUCv7nCT2v8zoOhV2qa4uo6mlR9+Nsq7/xVvJLjsHIYBg9P4ixu6A7b7qhQfX8Qe
         vM2r2IJLVY9WzSAiDaGRlFnxtMv0848tL6yTTWdVjghb2Xv7E37AEUDJvaVREmp1BNIY
         940Ae6Ut8CrQrOp26oJlS2RyZXS+vfTFD/yZ9tb3CLTw9R9hPaFCY9Tmvvtv3wtrpMv2
         wsbFKm7PATc4wfRkkFxv4OB6EejtTBAuwkvi2tchL/GS8lh0brgPhwBQKAmHXetqk/pd
         Fczf/Ob3g8Rk03buXNFyaS8jPj0aEMjWjAAnatVfiDQsw3OFVl9MCsiJrbJCHh/etzdq
         Iy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vYKIHHhVn7nSPH52/lrlIOtB7hqwWnXUydbXUcnZWnI=;
        b=JerhwD9443k8HApuhfBm61aTPYo+k30gThB+pmjj2CXFdU/d+DqWBv2qstT5VcUObz
         o7nXLNr0yHwA9G3HEnnnFq2iEu3AxX8GK2UFxfSx1imYwCLVNqRYvFvRxN73K5IquErw
         RIqb2ELrDceZD37Yopsa5wl5lN9nwqQG8uhPMJoSg+VwMnfwYzzl8j9pj+1/XUgbPeF/
         hipobu1tl1+udva6qXUvqNcm7DclOAqYYb9qbVlBgJRVKXeioWOQDdzsW6S8mRW6duJs
         s8ZNs/v/GvOG5ICGeL5jyHuYnxbcwOpLVrqy7YdAywe0bSkS9/eTlHxPygxdEMWkG7lj
         XoOg==
X-Gm-Message-State: APjAAAWxSuNwF6CwwyMTThpyCYBMlWk+N+86G34azwiIeyOPHVzJeQii
        bgc45RRA7gmE8YEdTTMbiKc=
X-Google-Smtp-Source: APXvYqyTntILByeXSll2nrJCqdigFZSVhDQGQyd6dWT/1lZozrCoBY86BHFMbLTiHaa612sjWifBGQ==
X-Received: by 2002:a62:3343:: with SMTP id z64mr1754059pfz.150.1582851928639;
        Thu, 27 Feb 2020 17:05:28 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id 136sm7975604pgh.26.2020.02.27.17.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 17:05:28 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:05:20 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v5 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200228010444.GA19910@taoren-ubuntu-R90MNF91>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
 <20200227230507.8682-8-rentao.bupt@gmail.com>
 <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:30:02AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2020-02-27 at 15:05 -0800, rentao.bupt@gmail.com wrote:
> 
>  .../...
> 
> You haven't fixed the problem spotted by Rob which is that the example
> is now out of sync, it's missing the required properties.

Ahhh, now I know where my problem is..
Let me see why I cannot reproduce the error on my side; otherwise I may
create more noise in my next patch set (customize device IDs/strings)..

> Also long run I think best is going to have a child node per downstream
> port, so we create a matching linux struct device. This will make it
> easier to deal with the other device-controller in the ast2600 which is
> basically one of these without a vhub above it.

Maybe a dumb question: what would be the proper place to parse the child
node/properties when they are added? For example, in some usb_gadget_ops
callback?


Cheers,

Tao
