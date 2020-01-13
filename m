Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F21C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A58C21744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="EQ//Ej4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgAMG2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:28:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43667 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbgAMG2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:28:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so4358043pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I5C3nwrlmpAyk+QkEXs7euA2p6whJngz7gNkLGAB+Ws=;
        b=EQ//Ej4CuJIOHENKsDe7JOHI8zjDbtFhhHsj5YCGU3PB1YX04S4W8Bw2pFN6S9QmmZ
         QLXumgM5mJyIFQdCT1oxH5p4P7SbWmgmYf1P9QHzPDiMmWLNII38CmGqffYb3QhkrZvW
         Lil4iTXVDD/Ux4IJJIRGvNag3acWc0Ta6cMZlfG/NkPVZnRHz2BLhfDS3iTuK7H8k7nx
         4wrxfJiHYssbimlmf2G7cqAbjsF4zpo15Y2FGFD7A3v/I8e7QOMduSabuVjXegZWmKyh
         fD64SbbGcM8ScqwhOGEJbtBg6tCk9OL8IiGZd2kNqRGDNarP+mp3T1RTEddLDgxVFrue
         d2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I5C3nwrlmpAyk+QkEXs7euA2p6whJngz7gNkLGAB+Ws=;
        b=RDa0rM4sxXLLw42Radacidrq9+wP3+AS4Tx/T+dCoz+N4DPFSJqY9cE88I2KTNuFXt
         e6AAQawJ34wrDPESwcSWuVF1vvggQ2BTkSkA+CyM/4wtCY7kUUtLqFD5et+xhmr5Ozb+
         w7pYLgHAB/REEW87fivPnBX3dNTszlVq/7jlXuyVA7To8nSmKkVymfj3Z/UVWAGrft+d
         2FKuspGIlJ+b64VeYzmj92wrEvbH2jV9smEIyFxtCwn4kQJsTr3YY6zmgIezxDw2G0I4
         doP1ClokDaMREmzpjHOrboDFcdbKjjfkhwimeX0fOxOHGDGd10r2/ngVDggKuwG6M9SZ
         nRuw==
X-Gm-Message-State: APjAAAUAs8lqg6g7RvAytfjp+Sh01KT/iSGSTJdfi+tgKXFE/tV1MsB6
        Oiq3NEdIKerHWrZygmvD+z4/Ng==
X-Google-Smtp-Source: APXvYqwu4X6ngOi3zIhRdvZ4Miog4ASVHjmWUWWXs8oWzKVUD+5CfBDHp8WBVT0IF5H4FzeXFlcpIw==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr17955039pff.135.1578896909830;
        Sun, 12 Jan 2020 22:28:29 -0800 (PST)
Received: from debian ([122.164.106.111])
        by smtp.gmail.com with ESMTPSA id q10sm12867346pfn.5.2020.01.12.22.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 22:28:29 -0800 (PST)
Date:   Mon, 13 Jan 2020 11:58:22 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/165] 5.4.11-stable review
Message-ID: <20200113062822.GA2706@debian>
References: <20200111094921.347491861@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 10:48:39AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.11 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 13 Jan 2020 09:46:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 

compiled and booted 5.4.11-rc1+ . no regression according to "sudo dmesg -l err"


--
software engineer
rajagiri school of engineering and technology

