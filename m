Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D7E206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="z3JHxKcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgBLHfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:35:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39980 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:35:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so801467pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EN24PHoL1c5EckXyWXEkiUAAxQ60wRtO9V7+zWJYg8U=;
        b=z3JHxKcjLvyN8xJNxbH/8bUzaNeB3igBVuUd8FZwqHRKYWItclh6mrpIqT7Q/cvHjX
         3FPSfWsTbozU06H4q+55kUmJAJTxZPfV+r0ULkwpmPFUU6Iz0ERIK/9HQadlqD6e8yNP
         TLuG3NB6l9lwaStIi6sxUFx1OlVNj1miSwyzNol2tYSnYlo0lx/ZHxCe/DaJrZzFbVIz
         r98CmO7655V3G/XYl/ANGupSxIftB6W4elam10HshwfV+nGftxXa9HYbVUiwKgsrqIhG
         f2Os9PAHzMBTMLUSj7vNjAOOlEKKGsWAPkuH/0+W4TRPHyMlCxO/zUuPfQEHUocNSoS/
         THlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EN24PHoL1c5EckXyWXEkiUAAxQ60wRtO9V7+zWJYg8U=;
        b=nfF7BlJpZt+ZaQfEIr+vCslGA9HdGNDeTjyosdPrPYxV86dqwGZmxBTldj6vn6xUfJ
         ENF1tKnDGBhxCF3FTzdKOa8+TC3sCIcOqoO9swFNn30ZWGHDLk98DPiuN3sdsK0B4E75
         d14mJhpoTS1L8RyOIPL4S5x3FGHT0pbMQHPO2Sng9oMhYN9dKjICNdwK7fZRDJMy6g0x
         yAVAZELAR0K8ae0G+UCnrBmowhaSGCGxTSYsGvjJ4cdL5wdlTKihemJy3DuaaLBB8WQa
         MNmPvM8ESSGhzX6+o61ETY5J7wku05skFVBci1h8OXlV6JLzJIwg2+xUmTXKwZFIxG9D
         s2Pg==
X-Gm-Message-State: APjAAAU4JJ+3RmiQlSk3clUZPZlmZEuYwlYpfllpBI7gJajKU/wn3aHy
        3sVRkNU38eGQ/Dg102+2/qcVCA==
X-Google-Smtp-Source: APXvYqxmgt2KZUSfhP0WhnMu4qXXYy171DEbvOTGl4HbZC8mg21wvj7n7mf3SNBTff2ssAoZJs/pOg==
X-Received: by 2002:aa7:9aeb:: with SMTP id y11mr7426959pfp.63.1581492938059;
        Tue, 11 Feb 2020 23:35:38 -0800 (PST)
Received: from debian ([122.183.169.124])
        by smtp.gmail.com with ESMTPSA id b12sm6916795pfr.26.2020.02.11.23.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:35:37 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:05:31 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/309] 5.4.19-stable review
Message-ID: <20200212073531.GA5184@debian>
References: <20200210122406.106356946@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:29:16AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.19 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.

hello ,

compiled and booted 5.4.19-rc1+ . No new error according to "sudo dmesg -l err"

--
software engineer
rajagiri school of engineering and technology
