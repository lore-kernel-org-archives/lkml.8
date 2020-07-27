Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55578C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A62070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595872635;
	bh=b32XTX1XQ+y/l+CgJD+znvZZXn1BHXXUseG7MmRbt+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=136+vaEpRYj+IAl55jF8YH8ndZFkaQ4YFNjdW3O6s6FSx69tLnmFgS+yMfvNP/i1y
	 JYVO2fk4zTtV35e2PaYn+9YbCRxI9tzHhSbxYcd3Oduqq3MDb6QKCZgBZaDvK4a6ak
	 h3Uf9EKPIKxP/An/VRH0u5bC30d3T4K0Qv3N6rS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgG0R5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbgG0R5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:57:13 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EAB2070B;
        Mon, 27 Jul 2020 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595872633;
        bh=b32XTX1XQ+y/l+CgJD+znvZZXn1BHXXUseG7MmRbt+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YfXMo3jdfPbMo2gu2fedR/aEY+rIBrXOPF6ofAi0mfuWnSG+S5P4aptNKTsDdrZP7
         zAloiDNZ/Nz2zdQrWIn+QsHXT4nSs8DlZ7HK1+Br6UDNobUXSXP71li9QfCL3nRkus
         skRGl5Drk7qcAZHD4pBAA1DeplUSoo8+qG5X0fzI=
Received: by mail-oi1-f175.google.com with SMTP id k22so15102322oib.0;
        Mon, 27 Jul 2020 10:57:13 -0700 (PDT)
X-Gm-Message-State: AOAM532W/fHj38l0rm9nzyJLsnHOMjyrFW5Ia4tKt5SbQKWm+qnbQwRW
        jETGT1pYADBFBFVonkPrtHH9oE/5RLOluDRgsw==
X-Google-Smtp-Source: ABdhPJwAcp63yZtFOBxfQhzVkOA6Wmzqkrl7P2Pgr74yZqTy5C39I68LgvhubC4Q4YC4ROg89/rTUj7cPt/fqj0clHA=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr358560oiw.147.1595872632903;
 Mon, 27 Jul 2020 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200727100505.23908-1-ceggers@arri.de>
In-Reply-To: <20200727100505.23908-1-ceggers@arri.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jul 2020 11:56:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jJFNQmxnXeA1HmBhM4aUH-qspdTCSRVvEfh0OVDF+DQ@mail.gmail.com>
Message-ID: <CAL_Jsq+jJFNQmxnXeA1HmBhM4aUH-qspdTCSRVvEfh0OVDF+DQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: at25: fix syntax error in example code
To:     Christian Eggers <ceggers@arri.de>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 4:05 AM Christian Eggers <ceggers@arri.de> wrote:
>
> Add missing semicolon.
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  Documentation/devicetree/bindings/eeprom/at25.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

At this point, I'd prefer to see this converted to schema instead of
trivial fixes. Then the tooling will catch these syntax errors.

Rob
