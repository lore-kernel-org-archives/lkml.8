Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF13C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69BA20723
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnNHdo+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGDQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGDQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 12:37:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941FC061794;
        Sat,  4 Jul 2020 09:37:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z13so35936068wrw.5;
        Sat, 04 Jul 2020 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGM5We0s6d91iAHT6ccX0Y+8JiIRTw5ExhXAZd/KucE=;
        b=DnNHdo+tr+7acCeB3NZNGPinQRrKbRX81uLIAqtL5Hkt/3NH6jV4gGOIFxZUdhPXJ3
         VPaI3R/0RsZ7/M9+bOEWBDmBixytA1fLy5NFct3WKqZfjVzWaWOXA7fuKI3qWCRUU8te
         urDZtriR2Xff+nOwTMemCtle3CH2b/MRLP2OHXjPLdKcqfZWpbUWezB3y5Q9k/azKuFC
         TJWcfJNHW1DTRx/rjXUcxD23vts4lMFHuaLDd3T/7MOPIFWcxft2CQHL4+ymm0neAX5M
         CmM5LCfw392tt+EEnwsm0wiNQsP/u7Mb0AEudQgZFrKnqVpT7YisWpBYRnmdqxK7ieze
         z2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGM5We0s6d91iAHT6ccX0Y+8JiIRTw5ExhXAZd/KucE=;
        b=iLraqFrha4TeGfgiJ73PveAwF5TT3SxtL5kUA0NvpSpzrrELJEyr1JFU3d/QI680V8
         EDI4T1QnAhZ5+KlWvOmtAFFvykhkO/JYUoPhkvLlzQ42dK4zXBdg/+Ybk1/4xC/uQ6IW
         SYOUU44eVbuG585XP72D8LX6iYNkdB7BKx66VfkEAt7FCYF125HPnY0g5HKyTXRs/OoF
         CBSjPngyTue9pAe4JH3M3KKNd2bggCBBe2XajE1ZxRmwLtqszIJJVjAFRVlootQMVxc0
         S+soh0Qz4tVAmz0f9eri0B5EUPM9FjsdaAfl/+6OuAbpYveMIWEd5za32Yq4TlWjL9N8
         7zXg==
X-Gm-Message-State: AOAM532ToqLM/s1PrFQ1qthBc0/0V6f+SUw3cp4tjlDhi7izfPHkmG3J
        xcafwTQgq2RPzNb3EpLZV45CLI82EYL1q+A7jVSKjw==
X-Google-Smtp-Source: ABdhPJxCG5R263EDYCqlklp/8pFwN2e0CRcdTF3YD9+FvcUrMqsic+O84r6XvCvWiGvxyIUtusxMqbrPX6uf876EGvY=
X-Received: by 2002:adf:ee0b:: with SMTP id y11mr18837573wrn.360.1593880636134;
 Sat, 04 Jul 2020 09:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200703182010.1867-1-bruceshenzk@gmail.com> <CAKgT0Uc0sxRmADBozs3BvK2HFsDAcgzwUKWHyu91npQvyFRM1w@mail.gmail.com>
In-Reply-To: <CAKgT0Uc0sxRmADBozs3BvK2HFsDAcgzwUKWHyu91npQvyFRM1w@mail.gmail.com>
From:   Zekun Shen <bruceshenzk@gmail.com>
Date:   Sat, 4 Jul 2020 12:37:04 -0400
Message-ID: <CAHE_cOvFC4sjVvVuC-7A8Zqw6=uJP5AAUmZOk5sQ=7bD+ePpgA@mail.gmail.com>
Subject: Re: [PATCH] net: fm10k: check size from dma region
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 09:05:48AM -0700, Alexander Duyck wrote:
> The upper limitation for the size should be 2K or FM10K_RX_BUFSZ, not
> PAGE_SIZE. Otherwise you are still capable of going out of bounds
> because the offset is used within the page to push the start of the
> region up by 2K.
PAGE_SIZE can drop the warning, as the dma allocated size is PAGE_SIZE.

> If this is actually fixing the warning it makes me wonder if the code
> performing the check is broken itself since we would still be
> accessing outside of the accessible DMA range.
The unbounded size is only passed to fm10k_add_rx_frag, which expects
and checks size to be less than FM10K_RX_HDR_LEN which is 256.

In this way, any boundary between 256 and 4K should work. I could address
that with a second version.
