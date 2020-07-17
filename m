Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27508C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDD42076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595012552;
	bh=hY/IiQZ62oMR2cm1BWXEte+UuNUso2tLkvY01Z3Z7so=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=URp9aNcBFvnpV3xLPe5/iNVWxWSGIOsnjw1Vbr/1xAuKNntaMBUUmO3bO0lYJ5Phx
	 DVce09XjFg2r0q00IweDnCZth+2sLfvTj+JYFfYUnUGVb9Q3wAiQNmLxyWvaPsecAh
	 Mz4HiFSmWYh1N55dF5uQv6aw+7uJyzJfp5jMGBCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgGQTCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgGQTCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:02:30 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66DDE20775;
        Fri, 17 Jul 2020 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595012549;
        bh=hY/IiQZ62oMR2cm1BWXEte+UuNUso2tLkvY01Z3Z7so=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QNwhBCWxtuvTLRSbhixHCBlp73msYY5d2rOsE+qi+9d+WJgBkiDpqBUsQNPg4hTr+
         mHTMZHwMy/c1hncyNQVipPgFrbmRlFfqK0GiZOCEybSU6XSQTum/kgvhljsXbv0/Im
         hvjLnb9qvM6T3djT7shhwgAP2Pq0/27HXSUi0QtM=
Received: by mail-oi1-f170.google.com with SMTP id t4so8832941oij.9;
        Fri, 17 Jul 2020 12:02:29 -0700 (PDT)
X-Gm-Message-State: AOAM530Z1EQqa2V5907KbvYFF6G0rAuklBX5F7MqFlTWRnrQBWWFhgAv
        +G9kaKZhfFvr892kNK9g9IbGw0YJ2P0ru/p6MA==
X-Google-Smtp-Source: ABdhPJzZY8yy3yKxPk7vB1ABc8/WFSudqSAMcFCsEUF38xcGMuBxhU8wPz3U67XIH6o54FVkR0PRKLPNGbkhbV3VBOE=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr8975582oiw.147.1595012548740;
 Fri, 17 Jul 2020 12:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
 <20200716191318.GA2683551@bogus> <3995892c-340c-3419-3c2d-934a3067f51b@collabora.com>
In-Reply-To: <3995892c-340c-3419-3c2d-934a3067f51b@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Jul 2020 13:02:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Xr5m4pxqbeEt+Zwb1GCWPKN1KBmdVtyKAmVFiLf=r1A@mail.gmail.com>
Message-ID: <CAL_Jsq+Xr5m4pxqbeEt+Zwb1GCWPKN1KBmdVtyKAmVFiLf=r1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 3:53 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Rob,
>
> On 16/7/20 21:13, Rob Herring wrote:
> > On Wed, Jul 15, 2020 at 10:16:04PM -0700, Bhanu Prakash Maiya wrote:
> >> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> >>
> >> Add DT compatible string in
> >> Documentation/devicetree/bindings/mfd/cros_ec.txt
> >
> > Need to update this.
> >
> > With that,
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
>
> So this is an ACPI-only driver that is instantiated by using the Device Tree
> namespace link in ACPI. I am not sure how to deal with this, but I suspect we
> need a proper OF binding definition before accept it.

In that case, NAK because I have no bandwidth or desire for ACPI
stuff. The DT bindings in ACPI concept is flawed.

> The driver gets at least the baudrate and the flowcontrol from ACPI resources,
> so I'm wondering if we should also add the properties in the device-tree
> description (although we're not able to really test because there is not OF
> hardware that supports it yet). Or is fine to just accept the compatible for now
> and we can do this later when we have the possibility to test with OF-based
> hardware.

That's all defined by the serial device binding already, so it doesn't
really matter here.

You can keep my R-by, but don't send me more ACPI crap.

Rob
