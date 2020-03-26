Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758F22073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z2wYiDyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgCZPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:16:49 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54576 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgCZPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:16:49 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so2590464pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wYPpm/roqn+t+5JwnWeUfdJW3sGbPaRDzYCBTuCQby4=;
        b=Z2wYiDyFq+4kYFEy1ZL0i6gxvSpUpfAJmOXyCbqhKg+PdPvlSUr3ali/GljgK/Y/ZO
         r1lE/mqPo5Lh3fepBdj1tRSHRumc5SJSeaGHIQ56MIMlijSzSdT+IHejkr8PEGyu1fMC
         8ELfNIDF/fbI5SEeMO0/SDbx/7Q+0xS2AbvSXseYolyb5kZOhWi20hUwBKONH5YJk3L0
         EcFNsSrEYhwMVeqyM2Pkl0IMon2MeA4R9F6OxqbgesIBzlOZTzqedR9li1D0qUa4vV0Z
         f0FJOSYZ6XY1EwH1AZh5KO5QOZQ8+Xt/IKb11SPCZDhUgxzDDM5IDautzEdEILRygdmx
         eoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYPpm/roqn+t+5JwnWeUfdJW3sGbPaRDzYCBTuCQby4=;
        b=nA3Uy1dURcFNdrbz99WtZbiLTOKHtJhUyZew3OB4yRDkTSYjRKGws3kNUCeQUOkHHL
         cGrKZuz4ZdUScvLUckiLV1zqO5kMfdLKw2Ru1szD+H3C/3Q5Gwz0/TzqNbE7qCMRCYNl
         9BjJ8Hbj20QztVMZmEy5sEvXvELHIPzP2F43jCzvsYEztgb4qJ2Z2AWPnsdhrGhV/MTB
         4d2rtTx0BCQFot3kLqk8EJA86daclkUu9KMLYl8dfhKrCJwoNHMXJRTlbrVOUeZuak4+
         Ng5BDMJO+0j7ORCJK+9ONjMPu5RwrIl6WLMprnyRpwnWijmLuIq6E5I3+Upb1SzV4lSe
         6oZw==
X-Gm-Message-State: ANhLgQ29l3atWgB1Sk7Y67wOaCHdAjgelCYrQfkBhsKVN30c3Pte7fXY
        zP8duichVnDF2BCLSmgu2DAAcPwAZa2AUg==
X-Google-Smtp-Source: ADFU+vvSwDGZ3vi5MYUbHEhhi1yLLSyC9+GawkQSsKQc/4RZYnNcX1X8a7E9gp+ST4kC/Xk11Sw3Gw==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id m10mr466536pjq.173.1585235805719;
        Thu, 26 Mar 2020 08:16:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b3sm1878746pgs.69.2020.03.26.08.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 08:16:44 -0700 (PDT)
Subject: Re: [PATCH v4 00/27] ata: optimize core code size on PATA only setups
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <CGME20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836@eucas1p1.samsung.com>
 <20200317144333.2904-1-b.zolnierkie@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3ec639bd-f307-df95-857c-d613a375c7fc@kernel.dk>
Date:   Thu, 26 Mar 2020 09:16:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 8:43 AM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> There have been reports in the past of libata core code size
> being a problem in migration from deprecated IDE subsystem on
> legacy PATA only systems, i.e.:
> 
> https://lore.kernel.org/linux-ide/db2838b7-4862-785b-3a1d-3bf09811340a@gmail.com/
> 
> This patchset re-organizes libata core code to exclude SATA
> specific code from being built for PATA only setups.
> 
> The end result is up to 24% (by 23949 bytes, from 101769 bytes to
> 77820 bytes) smaller libata core code size (as measured for m68k
> arch using modified atari_defconfig) on affected setups.
> 
> I've tested this patchset using pata_falcon driver under ARAnyM
> emulator.

Bart, I'd like to get this into 5.7, can you rebase on current
for-5.7/libata? As you know, I dropped the dprintk series, and it's
now throwing rejects.

-- 
Jens Axboe

