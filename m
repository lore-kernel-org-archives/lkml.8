Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4222520760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NxTo1jQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFKMF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgFKMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA0C08C5C1;
        Thu, 11 Jun 2020 05:05:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so6225521ejc.1;
        Thu, 11 Jun 2020 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXfqD7gSvjz6LJbKoi0/E9CrX3G1dDgq7x+YbDEOdME=;
        b=NxTo1jQy5E3dUlcBdualrF+kOZmZ8ehdQqanHWK4t7CQcGWEe2xIGxroxIuHGXUcS0
         5cOIn3TsC9mL6OUHFTtYNN+58fdIhwTgKBpUAtOmnrB/MGuQexWyXk5/PfcXfdzB6ab/
         LyDoRHD/5u1KJ0LMcU8skNIvGrXqEu4sSf9Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXfqD7gSvjz6LJbKoi0/E9CrX3G1dDgq7x+YbDEOdME=;
        b=Ehersb+lndcW5Ajf4kDqCQTCr7PmmwmcIy5osjXfDdlebHaOjtq1tiHaB93KvzKPPJ
         009gSFEtSXcywq/C1yE5g+SZGm8f/fJRd2sMnMokyvjwmpuFqfNl3mfGYORQYxOTkAxl
         QO5fsNQhdL4sua4X+J8CslpQiBGlG6q3W6XLaXF+NH3d+wNmrOIDPwfys1cEC8p8CU+E
         EMVLxfF9OVHWaWVYUjKMcvh6w/2o8Ybqaucuv6sqzP2fxJaPaAR8v1I6+kukOMsaLuru
         6Nx9o/hvT2I8gMbQhx1fOTsP1twLsRtx/AbLTMge33azBeZ2gB5cGz7akJjyZ5WLzQDZ
         oa6w==
X-Gm-Message-State: AOAM533Cn2HqLxVg84KycAGPh2lUWbDw59CI0EIydpeHIUVpe10/aYzk
        suFZJX5Jp1q3djkY2ZF83+BrLMtmWAnDoeqph2FMK90w
X-Google-Smtp-Source: ABdhPJzUsNY6R4Fzc0QWGa0H2nbfLpgV3jjxAFbpDdyM/8hbo0xN8i0rnjvPBa9qfyxJ3vXqnHvTtkwBcmbS2ZBaWY0=
X-Received: by 2002:a17:906:9243:: with SMTP id c3mr7985996ejx.400.1591877124345;
 Thu, 11 Jun 2020 05:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200429113711.13183-1-a.filippov@yadro.com> <20200610081500.GA27959@bbwork.lan>
In-Reply-To: <20200610081500.GA27959@bbwork.lan>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 11 Jun 2020 12:05:12 +0000
Message-ID: <CACPK8XeGPBYcaR-Y2AtGsqfK3P722qWUU+46Op0S600Ohf4H_A@mail.gmail.com>
Subject: Re: [PATCH v7] ARM: DTS: Aspeed: Add YADRO Nicole BMC
To:     "Alexander A. Filippov" <a.filippov@yadro.com>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Geissler <geissonator@yahoo.com>,
        Patrick Williams <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 at 08:15, Alexander A. Filippov
<a.filippov@yadro.com> wrote:
>
> On Wed, Apr 29, 2020 at 02:37:11PM +0300, Alexander Filippov wrote:
> > Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> > by YADRO.
> >
> > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> >
>
> ping

Reviewed-by: Joel Stanley <joel@jms.id.au>

This missed the merge window for 5.8. I will queue it up after -rc1 is
released for 5.9.

Cheers,

Joel
