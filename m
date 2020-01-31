Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE9C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8328020707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="TAzJij5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAaWeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:34:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52311 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgAaWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:34:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so3497290pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qHwLMgyQPf9S7w4WbZP4aPjIld/v+Drkd6KsGVLfTRk=;
        b=TAzJij5TvX03n0DX+NG7XH8i+sI9pZ5N3cXiDbwWpQN0KAIoQKoDfOqjP/lUnVQkTW
         xyP9jjonEDwIUj5xUdb8w33Qn/qATITZjS/erX7IBRakn+r1SEx/lOfGaZR/8xb5NsVi
         U+7jafWA8Vw8Gdnx/9BJBmhXAFmofAxb0eUXgwRZ0yA+2qwXVhaKnLOzpTcQTEGRxYU/
         jd8Mc0Cb97k7fCvyLmIYqK6K/TUdleaEKd6TfKTruf6dY5qSJzfswtLDLtJLOJcT08lD
         MRziTjzvffZ3FMMFeCFIe03nLiv//XNNCvZdKn+Znpmoax4jOdUbJG7PUM5XgOyyCRgJ
         156Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qHwLMgyQPf9S7w4WbZP4aPjIld/v+Drkd6KsGVLfTRk=;
        b=EIK4qsu63WZuGrUvmNk2RYkKyT4KkJeG+bFwdmHzQAd3FdS2B0CRTlKnItR/IA9YSC
         l1FI/AQOrQJQOM5dmY8FKRUQt2spOIWrRunV1E+iV5QLEycTSh/dWVnkq9HWIFGy18Nq
         iNba6UYk45JRekgTO5JDYrYPgs02O97AeZPbrWrBo+Ryt+yZkktliZ7oW/wwumAVPJ3E
         mig4bpQM0c1su1/X9PYfHbGixlYANdCLjk8eeSlbWjErBc8TSiaXZIQWVTzv190T4pXQ
         HVdT8NsrynRqEg8wlvIVFX8PG9bUIhu4932K+iy4TWoUjtNHRmQxLqlFNlqNVIhUN5ch
         kPvg==
X-Gm-Message-State: APjAAAXPx/Bc5mFrRoJ2WuQrT1A6qwK9o8a+VqLWaI6xLKRBXLLKv+X5
        jcbLAupn5yf0awwa4ptqetWl4A==
X-Google-Smtp-Source: APXvYqwuiYxLCHCh6fjR7LbWTgMTBUD3gm41x8xDrAAiRlQK/Jb+gxFiQLu/RXpqE0A+WwwyLvb0ZQ==
X-Received: by 2002:a17:902:5a0c:: with SMTP id q12mr12362460pli.301.1580510051986;
        Fri, 31 Jan 2020 14:34:11 -0800 (PST)
Received: from debian ([122.174.183.46])
        by smtp.gmail.com with ESMTPSA id q8sm11260417pfs.161.2020.01.31.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:34:11 -0800 (PST)
Date:   Sat, 1 Feb 2020 04:03:59 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.5 00/56] 5.5.1-stable review
Message-ID: <20200131223359.GA2670@debian>
References: <20200130183608.849023566@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:38:17PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.1 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.

hello ,

compiled and booted 5.5.1-rc1+ . No new errors according to "sudo dmesg -l err"

--
software engineer
rajagiri school of engineering and technology

