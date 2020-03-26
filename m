Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2ABC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8720787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pduojzUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgCZQ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:28:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42157 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:28:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so3121724pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FOCLu4AARJuZ4ixem6J8zMfavgX09kkCrtdGa/hq7aU=;
        b=pduojzUfXYnFTQAEYPYEScZdl3/PD1+lplzovUfNR3/RAZahZS0elhCkWohRbmPIKJ
         y2crZpUW8OiCOhXEgM3l9Jp2rcxrkyWX3Kp6w4Bd+6H7vGqFvmFuUOyQkfpTiRHCyRbq
         aePyoA7++YZNqtL56JN4QaI2053GKgiEF3u+PDprwlQ71zYZBERTXfZ9Aa26Bt2Cq+yR
         B9984tMIeihWA41mj2FNon1rbx9zcXFu63b6TpXdJmLUxSXvyrdAiiThrupMvE5ac1Yl
         +sXxJyG6wEN/jIg7Oj0o0lkSZIkJ+V3T/gsb17ZAs7RvarWYfMucTsis4FFQ6P6qdel3
         i3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOCLu4AARJuZ4ixem6J8zMfavgX09kkCrtdGa/hq7aU=;
        b=kcylFTtintY6/P3YxgJzeQ8Mf0Dmg0iU3SbrxKfPevXudJkMp7iUT0OYjdBxPy2gTk
         K2fiLh1/XErCH2Hnd2Gioec/tViSoN3LspaG1LWvSATYS5aEQjfFmLX/cK1z8DwcP8Vz
         R4+YlhELwh8tYLMG+0sbQv522fsM+XusNDmlzN/Ya7FhixwXGZIjNlDhzBkafr3jDKlg
         y2pY8s+Sz8g7Vno4HQ34bbYNF2es6+W98GPuuLYKIftWK1ayn95/2sltEmB2tppsLuAC
         hZIcxpG8ZaBv2jU92Y8cEkayazho4okoacwIzHQfI5cC9gA696SseQPcQr0IDgujUYtD
         rAfA==
X-Gm-Message-State: ANhLgQ0riFBUib/dg9DnspoYf0jS7ayjI7Ke8SOUb9/sJbzpq7coTeC4
        RIztWeyuLAiGFMMCPk21xBv3tiaWYD9S+g==
X-Google-Smtp-Source: ADFU+vvt6R7XeparInw83y2Wuxrc+y+PgkmfWrAG01DKaEv7PxF19icMldUkVrEvls4dAkWG6R889w==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr9939531pfn.168.1585240136843;
        Thu, 26 Mar 2020 09:28:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id k20sm1932086pgn.62.2020.03.26.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 09:28:56 -0700 (PDT)
Subject: Re: [PATCH v5 00/27] ata: optimize core code size on PATA only setups
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <CGME20200326155838eucas1p2a1c1f5c08832410d1e2b5a5ea8226151@eucas1p2.samsung.com>
 <20200326155822.19400-1-b.zolnierkie@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f6f4944-5e3b-3a78-718a-c7faafab85fa@kernel.dk>
Date:   Thu, 26 Mar 2020 10:28:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 9:57 AM, Bartlomiej Zolnierkiewicz wrote:
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

Thanks, applied.

-- 
Jens Axboe

