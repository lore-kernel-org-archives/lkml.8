Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A6C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698FC2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lTex8KY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDJBJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:09:01 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44918 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:09:00 -0400
Received: by mail-pg1-f180.google.com with SMTP id n13so307864pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KfeRNbGADcVsLhmDY1KvOUg8WlCqSZouokcF6WhZTMU=;
        b=lTex8KY33AjDWXhOXsO1vslYWVZ+gPbYc6N+1/ZjxiGto1ITyd0UzcDpLuXrvxPMdn
         rFLiuRH0wvDfNTKzWnMW6W0/hRlTkrp62O0FS8QUrKy9m/bLJrQdiP0vLBLh31jaur8w
         W8vhcdvN9MYR/iGEPB79IBuAvRIgLfIaKfz3r55KlnzUUUH7+YcbEG9JSOJwdi9OzrB1
         7ZBw6pE+vXtGjWjzIl+++2n5h+BDP5IWVTdIMjIe8uF2PNtvrN6AQdOHvzc/qz0u8LgO
         2qfKJXnuej6IEHlmRwUPPgigVW4fd9YmYv5lkX+o3xglNpvHoAiqvPN39YedZQYbc35Y
         A0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KfeRNbGADcVsLhmDY1KvOUg8WlCqSZouokcF6WhZTMU=;
        b=giW/pLMpM+C2g3wwOj4JLgVfXzDnbKsQotxQYPMruqB4vah1hxGFTao9sqw8wtkktS
         ZdtapVW05qEWHlfFv+BvLGk/eD8ZewOH5/jfSV1xn9toBNAIaXuFKwC97X3E7tABVB7N
         3akS+I+/0DGYxZVTJ5wXaVWIUSx2KAvMs6S721Wh4UWuz+oHPLvJRqeN/kVMnVOSYEWE
         JXqyMZSWDTD345pONVJrhOnyH/54tP/r+mqRR/TBi2GGa3DewlXxqWpikSC0OvoNs5uG
         iCmSkCEzYvpuM1Uh92uhRteKJU9lYruGBAOzviSw+Lv7PrYRqROGOXcWfVCyGKP2YwFG
         R2Uw==
X-Gm-Message-State: AGi0PubezAYYdrA+U4qIISEeaAN290sSYj1vbqUEhWfPvAWAFfUFeSNx
        wAgXNLbLsHJUD691qYRXVeMARV7e7hmfdA==
X-Google-Smtp-Source: APiQypLVulUqW1wgrq3Mj+B5fZrkY1FyQ4M65TayaKEINqqBPlMJL64hWNTU6RppcYiLk9VlviRtTA==
X-Received: by 2002:a63:5955:: with SMTP id j21mr2098029pgm.16.1586480938383;
        Thu, 09 Apr 2020 18:08:58 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:70f8:a8e1:daca:d677? ([2605:e000:100e:8c61:70f8:a8e1:daca:d677])
        by smtp.gmail.com with ESMTPSA id t63sm281645pgc.85.2020.04.09.18.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 18:08:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <9069bb0a-c338-4516-52d7-99d85aca5297@kernel.dk>
Date:   Thu, 9 Apr 2020 18:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few followup changes/fixes for libata for this merge window.

- PMP removal fix (Kai-Heng)

- Add remapped NVMe device attribute to sysfs (Kai-Heng)

- Remove redundant assignment (Colin)

- Add yet another Comet Lake ID (Jian-Hong)

Please pull!


  git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-09


----------------------------------------------------------------
Colin Ian King (1):
      ata: ahci-imx: remove redundant assignment to ret

Jian-Hong Pan (1):
      ahci: Add Intel Comet Lake PCH RAID PCI ID

Kai-Heng Feng (2):
      libata: Return correct status in sata_pmp_eh_recover_pm() when ATA_DFLAG_DETACH is set
      ata: ahci: Add sysfs attribute to show remapped NVMe device count

 drivers/ata/ahci.c       | 29 +++++++++++++++++++++++++----
 drivers/ata/ahci.h       |  1 +
 drivers/ata/ahci_imx.c   |  2 +-
 drivers/ata/libata-pmp.c |  1 +
 4 files changed, 28 insertions(+), 5 deletions(-)

-- 
Jens Axboe

