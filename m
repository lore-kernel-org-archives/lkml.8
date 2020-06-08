Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6052C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DD02074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEEjtcL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgFHPRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbgFHPRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:17:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B7C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 08:17:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b5so8674133pfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWmFg/FpOXpC8fC4p5EowACnCJsVRXBo99Iac+1RUe4=;
        b=BEEjtcL9BiUhCC2pxnlGAkadTKNs4w++y/f3l+KLZu0KfEVRUYhdHhfTSjiwJBuSNF
         aEbVyF4z44sFB9n5JV8Cl2s7WnDE2WViyJbgP0a0VkWgXG7T4CEbIh1guLuHAJi+fHkD
         grJvKw1Bbp28FedBNkTUbE/VbdS3nz04+ortAK5BdrR+K+jv/weK5D/LYbuTsHbaR6Ug
         Sp5lI/Tu6gYx3g2e4DiGKtUCBKE/m09Bs1ED3hwEK5d7rDxitnBfgt0qqlk2C+2NdApu
         x7yqu2F2CMXYIsCE3HQBCfXO2eYdz+Q2xY18G1vb6Jx8WOOm0T5QBo7O0xLJ1652y9ku
         eAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWmFg/FpOXpC8fC4p5EowACnCJsVRXBo99Iac+1RUe4=;
        b=JsClVApG3ez39UwDA9jBpIZ8CuPgke8/GpPt+w97xRNjdk6jXfvCEjDpncLi8aq8kv
         Teu4xuhlxjS16ghCRRh3g0XtAgerTg+DBiz5SVjfE2iZrBFGIocem/dzVksQIevhtLc4
         WTH3cxPxXZm9yQOX30O+lA0pODzEsTRbpZQRCeFhdWAPruAAKIkiTT30cy27raemLb45
         U/FtePF72t9Bw4o8s+xfIIvQnRyG6lJIsYZ9sDrgr75Q5coGcDCV4YJjTVRgQ8cGL1eA
         O8lCEOaKvYoMZIWoHcatbs/JtQVG9EHGEb1KkOatNMxRYYd5L99oeps/PUXEJNBI6uBd
         ma8A==
X-Gm-Message-State: AOAM532Og1zFsn+Ja1QT6G3IkM24uqh9Bf/70o47lEslHtHKqQME4BQM
        4nBu4F2rruMkzU95frCIn9U=
X-Google-Smtp-Source: ABdhPJwyn3PPSJoUHGmcph7d+thdSZ03s3peWqRUfw2HhvMN43yq/Jf6zUbQlYGJTBjo1wIZbXB4PQ==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr20731564pga.57.1591629450583;
        Mon, 08 Jun 2020 08:17:30 -0700 (PDT)
Received: from localhost ([49.207.54.212])
        by smtp.gmail.com with ESMTPSA id h20sm7391252pfo.105.2020.06.08.08.17.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 08:17:29 -0700 (PDT)
Date:   Mon, 8 Jun 2020 20:47:27 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200608151727.GA5017@afzalpc>
References: <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
 <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
 <20200608111834.GB5736@afzalpc>
 <CAK8P3a1q51=_DUS1A8k67c3TyQ+7LTpeo98LmzoFK=qg+8Fktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1q51=_DUS1A8k67c3TyQ+7LTpeo98LmzoFK=qg+8Fktw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 08, 2020 at 04:43:57PM +0200, Arnd Bergmann wrote:

> There is another difference: get_user_pages_fast() does not return
> a  vm_area_struct pointer, which is where you would check the access
> permissions. I suppose those pointers could not be returned to callers
> that don't already hold the mmap_sem.

Ok, thanks for the details, i need to familiarize better with mm.

Regards
afzal
