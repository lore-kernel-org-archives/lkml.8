Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D45C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82255214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jsIVEzjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBJCr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:47:57 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37464 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBJCr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:47:56 -0500
Received: by mail-qv1-f66.google.com with SMTP id m5so2531154qvv.4;
        Sun, 09 Feb 2020 18:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDCSxWhDLuTd8LJ5aB5xbWhS/YdWKP+avSFo/NepTNM=;
        b=jsIVEzjDdAnlls3W4DAXr0MB0WaQ+CAtxK394yiKvBLynQtiF4FPxwfE0fjOCufrzh
         /iuq2MoMKcrvuSqKRDRRpUU8o1TdlTl0/niKb8x65PC4QaRJTJDffH39jgiNXZaaE5nh
         pyIztvtIvTxamrLvVqxCw518aIwrgHzeVAgVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDCSxWhDLuTd8LJ5aB5xbWhS/YdWKP+avSFo/NepTNM=;
        b=OAf0PFlevMdj56YEqGYLHb9Er5NzUvvB/+PSHbUsfZsjHbYYqcZUZxubKfnUeDafLE
         9DkwZQMr7OKpcvMZ7A3JVNdDW8zckZcFQjFoj9fgwLLujzXOdpC3r8+IDHctyGy3LdNI
         f8jfDCohRakgWFkoPYJ6rK/1McXAUgabqnRO28UmEfmzWUtXD+WqXUSCgqBSsHyZxqzD
         BPvfrxdl1gnyQ6Xzo6ntgHs7BDpHGFoQwqF45uq9wou/tQA55KhiQz/jWQrT/ovn9Vwd
         kK0BXIz9QYp6XGAkV0ji4OI5diTWxUEruDSXNd3vRWpcDBQUy2kEYVvdFhlVXlB+Op2W
         0qqw==
X-Gm-Message-State: APjAAAVr8lGKwOwiFksssGzTMLLpmiXSA3YJM/oQTM3JbwCHiR5k3Kg4
        eTG0GN7UvHUFl4o4xlxOHN3iSnZfW/YUxZCYCLA=
X-Google-Smtp-Source: APXvYqwuGj9cqaQI7ihHFaiQ5EXNe1MT7fdGI525zSMynjA/wwaIBfxWOGb0gwg6UBAtGbBtysYAvGRljf8gLEaT+Wc=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr8172390qvo.20.1581302875467;
 Sun, 09 Feb 2020 18:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20200131222157.20849-1-rentao.bupt@gmail.com> <20200131222157.20849-4-rentao.bupt@gmail.com>
In-Reply-To: <20200131222157.20849-4-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 10 Feb 2020 02:47:44 +0000
Message-ID: <CACPK8Xe=szrpcY_3Gk5g6KqZ3UFBE03wH5MPx-BFOjKN39-EZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed-g6: add usb functions
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 at 22:22, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add USB components and according pin groups in aspeed-g6 dtsi.
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

I've applied this to the aspeed tree for 5.7.

Cheers,

Joel
