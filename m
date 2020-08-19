Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A073C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185BA207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP7wxaQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgHSPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHSPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:36:17 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11105C061757;
        Wed, 19 Aug 2020 08:36:17 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id y134so13570679yby.2;
        Wed, 19 Aug 2020 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yu6MjuffUqrvzTmREMwpNVUQPpNzcjiZEpk7Hkf/UU=;
        b=GP7wxaQER+oRSpSmzu5Ej5ID1gIBkNWhvwX/NQjTv/WWlTjd8P0PhKTqDV3D8pmrFJ
         zo5qjtzYtMPRsyz7gCfdmKgZ+j53mdIbfOv/wneKIk6xjspYrFNhStJJ13tYwiC4gBQv
         iQQs5n5rZ3xzptqbzjJxnNf6tq5Y2RzS282lHG9bi4QOXFQ0tJZWxfssYSYR8pgUDVG9
         SfvMXrZS0kxt3xkjd1QKSWfFTNJ6j7SjOfCfTsIl1EpMNXbzkR0XqXWNbQ13Y1QcyXIj
         LY3lo5GfccJDnhyG9MXIeIK3V71KMtEdiQfbg0gfHIiSbEF/msbKiQxwN9lQMPHKoGpr
         tBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yu6MjuffUqrvzTmREMwpNVUQPpNzcjiZEpk7Hkf/UU=;
        b=KerVGtyxUxrQ0DRuBF3ELfR+ZFdrgUXw3mGvynJFo03uQfP1Ep4OuaQp7LajVFJELS
         7BCRuLm47IJmUL6npKYetx57tkF8eW0nGxR+wQ17QErF1rc8moQfyn0YeXY9OFTXc3Xy
         C3CxFxBmuwWu7DWLf9xLHS/3zMVv/e3ImHmHC6qJM3k3syIDq06XXIF2lhRsEaR2v+rE
         REdgVVvYbZRRDOp7YcbvFEypQcM3pMk66GHzwJY8A84kbxZ9KhRhLtNT+nfN5cPSG8Dh
         Nb9kYUtbDe2UaBXfGY/pKUmVBTIZrFX0yffw86sRuDCIaVf3qWc26qk/6iH0T9inU4bB
         qnuw==
X-Gm-Message-State: AOAM530vBlqU0/nNHu3w8DPR+31YHJnjRsz8pJPYjZd/GOA4fP8qgRL1
        gAQgAmDV/GJ1i99oGdLz2IMBBdAjkAXo8dhNljU=
X-Google-Smtp-Source: ABdhPJxb1DHiB8WAkFW02UkIh45i4Q5xPvVRp8zLw6H3cwZGV9k61E76rhWzFNWAtFFGW6oMEoSYH+521YpPZKnH+Mw=
X-Received: by 2002:a5b:f4e:: with SMTP id y14mr37390161ybr.71.1597851375269;
 Wed, 19 Aug 2020 08:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200819042308.19043-1-f.fainelli@gmail.com>
In-Reply-To: <20200819042308.19043-1-f.fainelli@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Wed, 19 Aug 2020 17:36:03 +0200
Message-ID: <CACna6ryhQ=pY0LgpgwbBo5WGXSSfserc3V1ELzD3WLgnTv3n+g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 at 06:23, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The pin controller resources start at 0xc0 from the CRU base which is at
> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
> are currently off by 0x100. The resource size of the CRU is also
> incorrect and should end at 0x248 bytes from 0x100 which is the start
> address. Finally, the compatibility strings defined for the
> pin-controller node should reflect the SoC being used.
>
> Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux controller")

Let me verify that fix. I'm confused as I believe I got pinctrl
working for uart1 :|
