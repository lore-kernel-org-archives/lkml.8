Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0412C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F2120663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OVlESagn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCLOJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:09:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44901 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgCLOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:09:26 -0400
Received: by mail-io1-f67.google.com with SMTP id t26so5797331ios.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3m1ZZ5KE4cBxywTfMXaeVKmgrv47iIDbm51HIwX8Uw=;
        b=OVlESagnp4ojIJRJriwYXrPnVIsWAOoYHX/CrkD/VjcZYBrFeXHS5XRYzyC1tV6gPQ
         CDFqQsGk0ekObOVIDy/Ot5fw3IananZAmnm9APvjqSumZvd4vcHbH834bL+TtV50PAxT
         nMun4kBwXRAu/9emKRjXJTZ49bYpkEMENM4hWPg73KfCIgSYLvKy5QwKtT2ZGeurp65d
         QnZFipFM1volevqcXv3LWKtORSUn7daQEdd1FQlu52RGFxSuosBYH0p+DM2Sf2/bp1FA
         RA9WnsnZa8DDNcHlrLKVBM0W9Kp8qZ7l99Nk8dhK1yIVPHmMbV6O88mRFxFD6POfo7Nq
         xA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3m1ZZ5KE4cBxywTfMXaeVKmgrv47iIDbm51HIwX8Uw=;
        b=BqlzRBH3ozJza0v8ntOmc9BAolkfEtuu9eJxNxAKK4pWV34RI5QImavCG4QpT5l8vr
         o/Dg2nGQHf9gdqhh1x37wzmvMtdmBctiE7BZZ6PFgiKhx40PM9q1VC91qlLDqYzYZ1+4
         T9m3pp1cLCz64Ifr32uj77qs1lethbzc+Ma7clB2G1/vy92E9oTOfbzNp0KwaeIuVMDI
         ueGpn/2r8cQMRanGXOSvoaC/9FJbdVlVcjkwRYYiE3BtF+V1w2v4WjL92d9CyRRn6/EW
         f+kYxFi4y3V1UCTareOfiqu7rrcFyv48sRc5QTz02OPxSp+fYVoNOzqndKgqPKUEuzQ5
         raDw==
X-Gm-Message-State: ANhLgQ1IVHXlPfeAgnuUSOhZMFOtPhAeJyPxmd+lBHtNc8BTiPRpNiAJ
        UZEfSg7ayKXS1+vS9S/FHaP5IHTg9he1rQ==
X-Google-Smtp-Source: ADFU+vu8mIZ3dryskTJJJ+eUV8Cy1B45VJpNeJP6fVYvi0bdzYaLtASGIj33VlCxs310Srt1uDk9hg==
X-Received: by 2002:a05:6602:1217:: with SMTP id y23mr8104806iot.34.1584022164604;
        Thu, 12 Mar 2020 07:09:24 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f12sm15073840iog.46.2020.03.12.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:09:23 -0700 (PDT)
Subject: Re: [PATCH v3 00/27] ata: optimize core code size on PATA only setups
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <CGME20200227182238eucas1p1a4a5546e46b2385057f41528bd759aea@eucas1p1.samsung.com>
 <20200227182226.19188-1-b.zolnierkie@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15a1618d-a2fe-8911-764f-0d7204895ddb@kernel.dk>
Date:   Thu, 12 Mar 2020 08:09:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 11:21 AM, Bartlomiej Zolnierkiewicz wrote:
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
> 
> 
> patches #1-11 are general fixes/cleanups done in the process of
> making the patchset (there should be no inter-dependencies between
> them except patch #10 which depends on patch #9)
> 
> patch #12 separates PATA timings code to libata-pata-timings.c file
> 
> patches #13-15 let compiler optimize out SATA specific code on
> non-SATA hosts by adding !IS_ENABLED(CONFIG_SATA_HOST) instances
> 
> patches #16-22 separate SATA only code from libata-core.c file to
> libata-sata.c one
> 
> patches #23-24 separate SATA only code from libata-scsi.c file to
> libata-sata.c one
> 
> patches #25-26 separate SATA only code from libata-eh.c file to
> libata-sata.c one
> 
> patch #27 makes "libata.force" kernel parameter optional

Bart, patch #2 seemed to have an issue, are you going to resend
this patchset?

-- 
Jens Axboe

