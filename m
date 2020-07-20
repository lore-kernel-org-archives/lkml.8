Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34914C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D8521775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595239030;
	bh=bYF8x8T+NOYxWZCxmZtD7bG4+5sVpYYxLLih0BIYenY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZDJR2HcvFnUK1m7ceTP0FVpdQiVN2Asip94u1IT1SNc7tOFGeFtfteHrIvU+IsiG/
	 N0oQKL14uVhxmKXTJ+gY977UGJK8xASYDVsCE+jrsIv9+vHb+RtC4CPLoOS5O7d+Cm
	 ts45f4dXMMvk/XxTPPkGvF0DzXj+p21A1stYSCas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGTJ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgGTJ5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:57:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B2820734;
        Mon, 20 Jul 2020 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595239027;
        bh=bYF8x8T+NOYxWZCxmZtD7bG4+5sVpYYxLLih0BIYenY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lYwLi/CkaFlBla38GLo8xOn6xBYHfq2cODfLE0754tTPPi8nTeeGutBGl4n7LIoCU
         +LgKvxr5h18LO7rNGeTeT9rDnDUVACHr2/s2Fzc/PUb0H2CLQdqW6HgXn7cm56/uM1
         dLMacy+FasIVm20WsOpUUBYSkW5ZP2h6Ck+grryE=
Date:   Mon, 20 Jul 2020 10:57:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] input: ADC joystick driver & DT bindings
Message-ID: <20200720105703.53b5e0b7@archlinux>
In-Reply-To: <20200719221103.91644-1-contact@artur-rojek.eu>
References: <20200719221103.91644-1-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 00:11:01 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Hi all,
> 
> this series is a continuation of adc-joystick changes split from:
> https://lore.kernel.org/linux-iio/20200709152200.10039-1-contact@artur-rojek.eu/
> 
> Rob, the bindings example in patch 1/2 depends on changes introduced
> in another patchset, still to be merged:
> https://lore.kernel.org/linux-iio/20200719205307.87385-4-contact@artur-rojek.eu/  
> Your scripts will most likely fail to validate this. You have already
> reviewed this patch when it was still part of the aforementioned series.

I've just taken v9 of the dependency into iio.git as an immutable branch based on 5.8

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git ib-5.8-jz47xx-ts

Thanks,

Jonathan

> 
> Cheers,
> Artur
> 
> Artur Rojek (2):
>   dt-bindings: input: Add docs for ADC driven joystick.
>   input: joystick: Add ADC attached joystick driver.
> 
>  .../bindings/input/adc-joystick.yaml          | 121 +++++++++
>  drivers/input/joystick/Kconfig                |  10 +
>  drivers/input/joystick/Makefile               |   1 +
>  drivers/input/joystick/adc-joystick.c         | 253 ++++++++++++++++++
>  4 files changed, 385 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
>  create mode 100644 drivers/input/joystick/adc-joystick.c
> 

