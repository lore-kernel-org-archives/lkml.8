Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F28C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E6A2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596207802;
	bh=TNjMlzoPQHI0wlsBaAWoHVjP1u1LqhZUC7mLkm8h7j4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fwScZHAnLnQMGWf+w96bpXAMmBJOnBfTzbLNiAekdbiyL2KiO/arX3vSqhGsmFw9i
	 +29LHtVt9p1KIR9KdUOQd95SyJCwliY7dG1dv4GRlI9xhc7I7sRKCxZpFotwMmKnpN
	 iqaIeOAZ12Av0EWxfAsm/vBqo+CwMAjiOKEaMGGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgGaPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgGaPDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:03:20 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E55D2072A;
        Fri, 31 Jul 2020 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596207800;
        bh=TNjMlzoPQHI0wlsBaAWoHVjP1u1LqhZUC7mLkm8h7j4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ywQhW6fnNH9l9UqFqmDlhRihtA66/7sZB9rTjxXhYSEhRyYnbNV4d+sZF3wYrCVLt
         PoirDb2IpzabVzoOUEjeswROZIrolZNJUh516Cj6N3q0p+OdUEmhVaAqQQLroI3BY+
         2mLY3aIQKj75Caych/w5V1+n4nbBP7Z/DbXxMN6I=
Received: by mail-oi1-f170.google.com with SMTP id o21so6225849oie.12;
        Fri, 31 Jul 2020 08:03:20 -0700 (PDT)
X-Gm-Message-State: AOAM532FA/4DEKlPgg+YIaqMjXP2CgzaTIpXoPHxJBhmPgylIBTb/IxC
        Dk6+BFIQYSpQwWMRfMz/H7COAV62VXbecrjlKQ==
X-Google-Smtp-Source: ABdhPJzvvV++26sSwIjQIfjsQli2HfwsMKAC2xOcaSjeoED3m/ygScfsO5zkopsW6Gep4+d91WmvZ1nkXie0+pxAxNc=
X-Received: by 2002:aca:4844:: with SMTP id v65mr3343472oia.152.1596207799530;
 Fri, 31 Jul 2020 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200731100248.26982-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200731100248.26982-1-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 31 Jul 2020 09:03:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKu4CB7-b_hRvu63c9jQ_S91epWMr=P__9Fu-h_WFR-_Q@mail.gmail.com>
Message-ID: <CAL_JsqKu4CB7-b_hRvu63c9jQ_S91epWMr=P__9Fu-h_WFR-_Q@mail.gmail.com>
Subject: Re: [PATCH] of: address: Fix parser address/size cells initialization
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 4:02 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> bus->count_cells() parses cells starting from the node's parent. This is
> not good enough for parser_init() which is generally parsing a bus node.
>
> Revert to previous behavior using of_bus_n_*_cells().
>
> Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/address.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

We have a unit test for this code, does it fail? If not, adjusting it
to fail or adding a test case would be nice. Either way:

Acked-by: Rob Herring <robh@kernel.org>
