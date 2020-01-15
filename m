Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9263C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4342467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579100646;
	bh=akWHDw2dp4HMSLYd4jf1ctNTQ9StsTvZ7vOESv0YuV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tj+ixn7w26Tse8qv0sy4MqjsyJWkXLQDE5G4KfoYQ071X8nHi7x9AtsXKuK9NpS7J
	 Iw37g2GPapFz+hUSkY1I2GE4Te/B/aXtfhNY7xw2IKd6/0vyNjvrJpk/nvQgT07x1x
	 pPczFYyB/Dgr4wnEaETSPNZNj1og73vYhgDhnAkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAOPEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:04:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgAOPEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:04:05 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769DF2467A;
        Wed, 15 Jan 2020 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579100644;
        bh=akWHDw2dp4HMSLYd4jf1ctNTQ9StsTvZ7vOESv0YuV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g8eCWlkZqL/jzhSCeIT40O391LHpxlseTdeisKA6ISmouHLCGxYtkunfdbcYe/gq1
         qeuwhwrmIrlubUv8W9g+Lp4d/chlvUSDur7Q5o1XJGfjFLTUpkx/xEj93spqHo1433
         OVsXhHMREYBBTAvyxY1VghmQ6qP6b3ERNrWAl9S0=
Received: by mail-qv1-f49.google.com with SMTP id x1so7486239qvr.8;
        Wed, 15 Jan 2020 07:04:04 -0800 (PST)
X-Gm-Message-State: APjAAAXkOkhUXt9+0dFEHfFl0w8vQl32ReFjbw8Tt+C7P/ijwoPSjrBp
        uftsMHyRN2TJuEwHxqkTfzWyvcZTOfdj6ykOOw==
X-Google-Smtp-Source: APXvYqz6mHF45DAWUWUWDfYEf+gWOnBboSfWtevRnQLUakjB2gyNulzLFf97N1Zxr7ADVDMR2Ywe1q7Xh7UzrSo7WBY=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr22630609qvv.85.1579100643580;
 Wed, 15 Jan 2020 07:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20200114213809.27166-1-jbx6244@gmail.com> <CAL_Jsq+8X0oRykiQOKVyaxis4H0yO=nzUtnFF_BXdwBkuigr7g@mail.gmail.com>
 <12bbbdbc-027e-90de-fd57-291013167b06@gmail.com>
In-Reply-To: <12bbbdbc-027e-90de-fd57-291013167b06@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Jan 2020 09:03:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJD4CY6P+76pM69-4UPpTC+pE5BmyCm+gWhCA-Dd1YB4A@mail.gmail.com>
Message-ID: <CAL_JsqJD4CY6P+76pM69-4UPpTC+pE5BmyCm+gWhCA-Dd1YB4A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: mmc: combine common mmc and
 dw-mshc properties
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 7:02 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi,
>
> Thank you for your explanation.
> I was not aware that was playing.
> So now we go from a 'simple' txt to yaml conversion to a complete
> 'change your node name first' operation.

You only need to update the examples, not all the dts files for now.

> Can you indicate if that common yaml file for dw-mshc and Rockchip
> is still a good idea?

Yes, that's fine.

Rob
