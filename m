Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252CC2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8A520787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="RWI+XKWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgDAAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:43:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39931 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbgDAAnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 20:43:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so20259699qtq.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=29l1Cx3EQRTg+9C3FuFocy47P0Q9W5pPReVeNSwur6o=;
        b=RWI+XKWfSaDXusY29+11maE3rke9eaax5k1NXL5V9s98nlLQhJPNZ2LnX2kCDNSbFK
         GGEqZ3xA9w34hAVSlAySVBdYgSLzJPzitgoYCw2moesOic+Frdo4IM1fs2gszhJyJllw
         dCGmFewutA47Tm/igpqUDGnir/3efzX6vIkAX6O4zsQbbrXLLquizZDKw6Uk76Boe3zU
         vKuNi0JYie6zKdtWajostEv0sbOV3Ny/W+WOzH5GXP51U3bAEZ8kbGfPPLJyQmkX4+j8
         9EXLT2JSRXvuw/cvedQKJK8Gd8Hr/lkohg8/CyqTajxurMpQKGLWx0qorUnnEoKNr1DS
         C8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=29l1Cx3EQRTg+9C3FuFocy47P0Q9W5pPReVeNSwur6o=;
        b=V8X2cLvFzFJZStzOYYY0vUQxzkeLUeXuZTp8x4CCqCwEga9f8fwFQK3cizGWs0dQZP
         D/4IX5X+OeQvSOtH29qn3WHZnUnpDSMyUpgQ++3+2HaQEQImPVe3YJMNeXptTpmudaZF
         Fw9pHB3drzhDtfGMmEIy6i3I90XcyPH9hrKKgSFSieEMdsa7WZknoPQglaatxNPvyz0h
         h92R+82F79zHPYfLrtZQPlq2vuIShTOg/jQjXOTuPD5mMKFlVteibJBauwG9HhwkLj9R
         wAOs1LHchI2PcnFS3roQpn/tFL4X8WICA9DQHs0FM6NBJFWyfZ81Krnv8KBJuiAirIUC
         aOPg==
X-Gm-Message-State: ANhLgQ2DdAkjN+ZAo6EbctUenK09CofS61BC9C9+JY/J2jA/1AcLazQN
        V8qkgpeX8Jpmidt+yBBzZG6qgA==
X-Google-Smtp-Source: ADFU+vsa9O48OZ0BTiH0JIAZqbnWZeB9KY6uad99GDtbM5YxMPs8wVGAqMTdKHx3aP9ZXRMIqGiC3g==
X-Received: by 2002:ac8:2d88:: with SMTP id p8mr8191570qta.346.1585701789565;
        Tue, 31 Mar 2020 17:43:09 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id t6sm430247qkd.60.2020.03.31.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 17:43:08 -0700 (PDT)
Message-ID: <5ccaf0509d415643338abdd04493a4c6f4a77c9f.camel@massaru.org>
Subject: Re: [PATCH 5.5 000/171] 5.5.14-rc2 review
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Date:   Tue, 31 Mar 2020 21:43:04 -0300
In-Reply-To: <20200331141450.035873853@linuxfoundation.org>
References: <20200331141450.035873853@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 17:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.14 release.
> There are 171 patches in this series, all will be posted as a
> response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2020 14:12:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.14-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled, booted, and no regressions on my machine.

BR,
Vitor


