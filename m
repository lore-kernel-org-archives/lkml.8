Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB4C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0DB206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vcZe2via"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQAF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:05:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40209 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgAQAF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:05:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so24566790ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 16:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Z14qpCzwdc58TA6O2eX1AbdOS4ytGE4JBPiLVxwA6Y=;
        b=vcZe2viaZHiKyvdg3wQxdz/ommSVOelob2WDBHYa/AQC1Hfl2KqqyQqny2UyHegmVq
         mINM47GJy/DgdyXTWgYUPb1O//Oa+CtHJ8PEvay29pdv7CnrD+l0hB5quh2xOgd5NOQT
         sKP04CXne9+PViFooxQiTZV/ibEpuHIzvzmIrqo0sGOGwvbvwmFCkLRu3zitNLO2L9sF
         FxfCNppfBbuetF5zgmkneM60ilQt10uKFyq7Pm3y30CC0Tfv17wWeOloEkPa/6mKBVjf
         fUNivDiZEBCBxxXKLxEXwWCZZyy8mlg/ppDylFGecxypsUXCvxuhTfJWXNmmz8Qy3BlS
         rMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Z14qpCzwdc58TA6O2eX1AbdOS4ytGE4JBPiLVxwA6Y=;
        b=s5GOq7OfRGLZ1IpCf1IhZLsKQBYiVulkvYYaMibLlOgKFlCGTRx0KtqnynH4Z0WIjB
         KaCfctZXIIkCzWSCnNt/otP0WnSdOBjD/kRNFmOsvd0+A8NRfl1NyGFfth7ku80ZqX+6
         y/CWPNI3wC54Itu54rcqFjLR8puN+adVq5t7/TrbjshjENL4l/gInsAZiNlOC+uJdQOe
         28rCg0i2c2KHgFB30RfLudT2PMDUIoV8Xe7/1Ve24oPBfmANkxkfRpKWH6HgZdL3Fxte
         QUxqZCSkW0hc8Bf/Z73ZqW+Bh+hUokXziBIzKrsJroo6w63fPa4ckiEiQvvrEMO3Hh0j
         kJCA==
X-Gm-Message-State: APjAAAU2EA+E0pNwxUEtcU5ZapfctxuRlSVW9iRyrQF4fNo2A0k2toI8
        MY0jLsaX16b4ZULEVhFT3Q/ndA==
X-Google-Smtp-Source: APXvYqxO3c0bMRGbhnWaS+stTD6UIXHu0Ory2JDP23i6h0g4Lrlf0oLkL+1F+9hbTsjI/WSgTSv7rQ==
X-Received: by 2002:a2e:9716:: with SMTP id r22mr4041961lji.224.1579219527323;
        Thu, 16 Jan 2020 16:05:27 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 144sm11386025lfi.67.2020.01.16.16.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 16:05:26 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:03:58 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     soc@kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, khilman@kernel.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: [GIT_PULL] SOC: TI Keystone Ring Accelerator driver for v5.6
Message-ID: <20200117000358.fe7ew4vvnz4yxbzj@localhost>
References: <1579205259-4845-1-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579205259-4845-1-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 16, 2020 at 12:07:39PM -0800, Santosh Shilimkar wrote:
> Its bit late for pull request, but if possible, please pull it to
> soc drivers tree.
> 
> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> 
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.6
> 
> for you to fetch changes up to 3277e8aa2504d97e022ecb9777d784ac1a439d36:
> 
>   soc: ti: k3: add navss ringacc driver (2020-01-15 10:07:27 -0800)
> 
> ----------------------------------------------------------------
> SOC: TI Keystone Ring Accelerator driver
> 
> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> enable straightforward passing of work between a producer and a consumer.
> There is one RINGACC module per NAVSS on TI AM65x SoCs.

This driver doesn't seem to have exported symbols, and no in-kernel
users. So how will it be used?

Usually we ask to hold off until the consuming side/drivers are also ready.

Also, is there a reason this is under drivers/soc/ instead of somewhere more
suitable in the drivers subsystem? It's not "soc glue code" in the same way as
drivers/soc was intended originally.


-Olof
