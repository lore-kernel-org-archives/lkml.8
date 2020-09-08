Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6504D2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="kMpihx1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIHIfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:35:20 -0400
Received: from mail.alarsen.net ([144.76.18.233]:57426 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgIHIfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:35:19 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 04:35:18 EDT
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:b440:f8d3:1c0c:d20c])
        by joe.alarsen.net (Postfix) with ESMTPS id C72DC2B80B87;
        Tue,  8 Sep 2020 10:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1599553730; bh=vAMC3BpR+mvYVqZXlzgmRJWrQUKXzqY7hp9gqzLPC+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMpihx1Mn0lZF+E26HcrGXm3wEl1wM3kQy9vMh0OgkdaWmym0/RAttcriMqnUNx+Q
         onTCxRAk4kQFdU4k5nSd+5wUEG3XWrGMOplq2HqO9QooG+jtDochhQkAddnZU6i3BM
         A7l1QtSqSgTV0VKpPpD0wi38Cf+6S8QGZy0DmSts=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 98F8327C02A7;
        Tue,  8 Sep 2020 10:28:50 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add Shanghai Top Display Optolelectronics vendor prefix
Date:   Tue, 08 Sep 2020 10:28:50 +0200
Message-ID: <14178277.p4ol7qMFiq@alarsen.net>
In-Reply-To: <20200908075421.17344-2-narmstrong@baylibre.com>
References: <20200908075421.17344-1-narmstrong@baylibre.com> <20200908075421.17344-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2020-09-08 09:54 Neil Armstrong wrote:
> Shanghai Top Display Optolelectronics Co., Ltd  is a display manufacturer
> from Shanghai.
> Web site of the company: http://www.shtdo.com/
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index a1e4356cf522..4e9dfb352c68 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1078,6 +1078,8 @@ patternProperties:
>      description: TPK U.S.A. LLC
>    "^tplink,.*":
>      description: TP-LINK Technologies Co., Ltd.
> +  "^tdo,.*":
> +    description: Shangai Top Display Optoelectronics Co., Ltd

Please keep the list sorted alphabetically as requested in line 25 of the file.

>    "^tpo,.*":
>      description: TPO
>    "^tq,.*":

Cheers
Anders


