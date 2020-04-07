Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88313C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFD52083E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="012GHlOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDGWIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:08:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41008 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgDGWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:08:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id m13so2371231pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uBxvQltL5Nygkvc9R7CLiUS2uaeeOnr3MvEHa8jglnQ=;
        b=012GHlOaJgDjZ2mlQcH2MvQrmUHUv7z5dqGH+4nGa+M3lR1nOksSonlthbiiu3HZCL
         FN/2jjaO4zrzYkPow5NAqRcwkS1hgcXkgtVYzR6dLiIqL4Rtd9Ks1wvlye1Pu3X7S/tz
         DBDnskdn9igLMhMH91n2nupoKW5DqR8wuPRiqTVhDo0bOLJsEv+9QOpX+xwpfOcu3a2O
         3X/VWkaSBS4ISI6oImCmLfLIuUhnFZjZ2l8oHphBfq+r93zICGNGSrhHBHKipneWjanW
         yYvUFCSSE+o1uN6aRD/iAVcyxM3uy2f6xfQlL5h5KF2Xvt30q+LIHheHL/tmN7IsD4mV
         +Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uBxvQltL5Nygkvc9R7CLiUS2uaeeOnr3MvEHa8jglnQ=;
        b=jB85f/bBjXwJwRQFLntigY8HmqgxJ2r8RUm47C5HSQNCgIuFa3lHF2karjoNxN4No1
         S/JusQCdfg1YLsYkzrzKpDqslh4Qx60t868r7WT4X0jSW+MjIBgoMUl7bH9ZE+reD5yG
         xxB0409/Pq6pfs+1aJKoWItx4toJ9ae1SKnoIDcbOuyBpfsdOnY7WQozCS9VvQGhv6kO
         aPvBnCgm+ILna4uM8p269Pp6baHRHwkjAcan5uBE6TZ0b6+OaaMaoTIxc4k4Z2d6qyCQ
         9GlBSvzEkCCOS9QHk788mvYCABIJwZCe0/xu4Iiea8jHfsjPKpY0QSxxoTnkbYYCId+C
         s2pQ==
X-Gm-Message-State: AGi0PuZme7zBNmsHwkzyl1DpEUOZKpitRUiw4wp6RSqxDvopmptFQl5u
        36XOiiifepPPojASu0U0ykgzO+9d9zf3SA==
X-Google-Smtp-Source: APiQypLHOBlYdKaoasCbYYwZKamCeOF7H+N8ijWA6nllKLTV+PsPBOw+PqPGuxhJFqLstthY+g4dHg==
X-Received: by 2002:a63:8c5b:: with SMTP id q27mr3568217pgn.301.1586297278399;
        Tue, 07 Apr 2020 15:07:58 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id e23sm175506pff.192.2020.04.07.15.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:07:57 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: Add sysfs attribute to show remapped NVMe
 device count
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     anthony.wong@canonical.com,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200207100016.32605-1-kai.heng.feng@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5c02b240-a336-8869-1d03-6f5219032e78@kernel.dk>
Date:   Tue, 7 Apr 2020 15:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207100016.32605-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 2:00 AM, Kai-Heng Feng wrote:
> Add a new sysfs attribute to show how many NVMe devices are remapped.
> 
> Userspace like distro installer can use this info to ask user to change
> the BIOS setting.

Sorry for the delay, looks good to me. Applied.

-- 
Jens Axboe

