Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A287C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4D220747
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy8tnJGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDTMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729543AbgDTMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:50:59 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97463C061A0F;
        Mon, 20 Apr 2020 05:50:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d7so8599266oif.9;
        Mon, 20 Apr 2020 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35aqzVMMcIlOOYhLALGKxscQPUJo+RlR+stQptgOImc=;
        b=Xy8tnJGNE6IPz8WZ/6FO3Q1inVAJSdTpoIxxV8Ux3JOU6jzoZgSo2z7XMgnEPW46N9
         P6QxEiWKXe/FZpYWdIedsYvkjV7dQVVb4YBZX1wagT0BAfcG8106E9ivHOW67/4Y9LTA
         LO5V8Ofjd4lLcW7yirW8B48dF5Mf+o7nZdYWcxYn8triKYf6kU5NJc8DECDek6B/dOBP
         fc0CE8kIyjAbZoyRZNZrVd9CPs1RC5VirmUNeSnxLxzHV/OG+rFCAiXYxHfKJKl/CPIV
         L+TFufhxIn3IQVFRYmHE3GRcMP5TuEJuUDWRIuwAjNdfkhX4sAulJvl7fFVD8R4o6b6m
         cIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35aqzVMMcIlOOYhLALGKxscQPUJo+RlR+stQptgOImc=;
        b=DGJ7UIN1yCI9flJwcZOZS+FQ8LNqgkUteNVB0vnNpHr0SAKIXupjbQP9A3LvRtNFit
         T6SUy4dDRR1JTjECyuE3OMv26jlSZprRcBj56TcMKQVvNveqevP3+zFoLWlSWPPC+58T
         JNYUfoQrVGdbBmFa41qplSp3M01OrYW3Rg1RyHS9jrCABgB/iE2YzT7MlnL6QEKddj/4
         L42Te7uK6h5TrAeORhtmB8u7vJlrnM6gn1WU76sI32Fe0JoIp4ooB8QypwVY6F23rxvJ
         MvKQDyeAMLBfpOK83pe4k6zrX4cdWxQMJyVXtalj9bJsu8Ae3Fcv/xLmiPJmpUEBgNo3
         Q0ow==
X-Gm-Message-State: AGi0Pubaj5KjhIvgncNKqPHR5iYLIg+ffJjww+l6pZ7PH0RYlLnM6tOr
        S0cSGL7YxpgCjxPi/pDMMd9DJRC7pvGDTQpnZXU=
X-Google-Smtp-Source: APiQypJQOv9Ww+7hoK/CdulOK2O+mlEVZi3+qaYbfvCToGcp+X800VBJy2czYU/s9k9AzL8Q0DF1MbReNmebyiXuhYg=
X-Received: by 2002:aca:fc0a:: with SMTP id a10mr10490437oii.77.1587387056332;
 Mon, 20 Apr 2020 05:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200417221341.31428-1-TheSven73@gmail.com> <20200420121542.GB6507@sirena.org.uk>
 <CAGngYiWauBTnXDcP9UC1S7U5Ogy0B=bUZSdGs1Z9aKZ2+sB=Qw@mail.gmail.com> <20200420122534.GC6507@sirena.org.uk>
In-Reply-To: <20200420122534.GC6507@sirena.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 20 Apr 2020 08:50:45 -0400
Message-ID: <CAGngYiV9MxeLrERkgU2+rucCiJ5StCXN7GXxKLMfaJ-bqSpAAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 8:25 AM Mark Brown <broonie@kernel.org> wrote:
>
> I'd expect someone with knowledge of the hardware such as yourself.

I claim no expertise - I was just getting tired of dragging the
out-of-tree vendor
driver for this chip from kernel to kernel. AFAIK, most people using this chip
have forked the vendor driver and adapted it to their specific needs.

If my name has to be there, I'd be keen to hand it over once someone more
familiar with this chip comes along.

Hopefully someone from Microsemi will be monitoring this discussion.
