Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE3C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636C02072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVE56PpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD1MUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726645AbgD1MUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:20:54 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F5C03C1A9;
        Tue, 28 Apr 2020 05:20:54 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so32132220otq.13;
        Tue, 28 Apr 2020 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEakP3BtxjrtzgVk40jbRNVCPopEEl2PBz5jMBYZCac=;
        b=oVE56PpMDFxR0zO4k9lfsaLvi7hqxAlke11voP7oMZjEXpSI1birbRwawrQK9QtMSD
         xquQX6QebCLp/DbhCYXc62xYd/CXcJ3fXZreM8uDTMozSPXYWNkpmfqLuLuzWI8zIkIQ
         XX3d10p1u/7iCDhqpEbbs0MjczLLwvj8HkfAXzp0KNmFE3drSAhFbicpOwud2F6Fqpc4
         oB+vScljfSnnn7++OKsyTE9zUp0V7XEMwKZq132YDCiCMH+de5hAFoB3Al6c/8412b+j
         sSuUVLpHY8pdLjyCaYE+VzC7zzOeRf/kaFBDRfrsMR7QCDkGLq61u/tqzf7nesjOMbv2
         6KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEakP3BtxjrtzgVk40jbRNVCPopEEl2PBz5jMBYZCac=;
        b=aGpDFYe+Ct7I4oWwpi2MlYmTv/TqloTLLDp38vl3ISP5TilPD5XpiSmNfP4sETqPbs
         /PW3iOQk9UXBnSEUL+HFE4Lb7iZj2slBmJ4Nr+VDpfpCvGZ6OCt5Q4Ek34VtgVdNRdeD
         Rm7+aYEFZbhhxsYsg7mDWtlFRQf8647yc5NXybYAgCGaZJmcWvTRuPnFhvToAl/ii921
         bOj9MJI5Oc9q71OpRvg4c6NNUJu+NGmdcS3AhMHx24lEgZoMSp50i+rApcJpE1ooYoks
         vk+k5qRvVx0s6+jR4YBZHNR2vW291+in+e17lBEZKrSnUvMQ6LoOj/ZRhpyFyqaJhX4T
         EPQA==
X-Gm-Message-State: AGi0PuYZ9LPsJdic/BMyR7pKCYJN12ww5kzfn5DEfEYamiYxB2G0gmpn
        lr3aDl6IGkcvMIgjyCKsN/zu4h8y3Nx9zExTlY4=
X-Google-Smtp-Source: APiQypK5pXVXyGbHlFz3rzAt9zBWxyAstAXK+xYvkVxekeAXou+WcJ2uJpsQfGYUqBHQrNUECrJU86hNRYQ9QGL2zFU=
X-Received: by 2002:aca:fc0a:: with SMTP id a10mr2749752oii.77.1588076453793;
 Tue, 28 Apr 2020 05:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
 <e5f05ee3-515b-7b13-5125-b6d7a03ac031@gmail.com>
In-Reply-To: <e5f05ee3-515b-7b13-5125-b6d7a03ac031@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 28 Apr 2020 08:20:42 -0400
Message-ID: <CAGngYiU_gDceVw9G7id6PmpdJt1iegoNVA3-ozkQzDFN9hUR5g@mail.gmail.com>
Subject: Re: [Q] devicetree overlays
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frank, thank you for sharing your expertise. Much appreciated !

On Mon, Apr 27, 2020 at 4:26 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 4/16/20 9:46 AM, Sven Van Asbroeck wrote:
> > My situation is this: I have hardware which consists of several modules.
> > Knowledge about the type and location of these modules is located in an
> > on-board eeprom.
> >
> > So now I need to assemble a devicetree, by puzzling various 'blobs' together.
> > This could be done in the bootloader,
>
> Do this, if at all reasonably possible.
>
> > - is there perhaps a more canonical / idiomatic way to solve this?
>
> Yes, apply the overlays before booting.
