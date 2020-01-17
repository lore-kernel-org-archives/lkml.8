Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AE7C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4F7222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="vy72WAyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgAQXSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:18:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54964 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgAQXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:18:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so3804387pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VLG8/maPK56SKNLr2yTnp4t8L0TJHtYxqLK8FSBIkjM=;
        b=vy72WAyzSSQasq9HbUjrg3RmYtI0feBoyIRzXbcaqQasdTSoh8bCrZS8wj1qS5OHDb
         ix+JfCHG/FPIkn3ARXwVJ5pihxlwF0EWzuqY8J14IqUpdeFxx7AsAykB2E3xX3mOvNBA
         A5Su205h1jqTioIim81JdQb/+gZXY6nnPxfpDbBB+/MJkk8vCbNpbk31oSxcihMauRs/
         5kUeoF2Pt9b1xQ7bWG9iE12gAjuJhVXC/A1N1wIY93iMdDj6tRVPbPQ/IsUYDqOTklSI
         UgwobEyvB3G2xHgMgOeD8xBSY/lTb79pn1iFqfQpEZdLcZ8P+e2CabEO6lk7YCKaWhAu
         HKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLG8/maPK56SKNLr2yTnp4t8L0TJHtYxqLK8FSBIkjM=;
        b=AirBsqiOtjpp+lS1+dFFKuoHG3M4vCYb9mB4IJOUYyu8X2OA6+g/nVygZcJyUBSpMo
         SWVHRSHBm82sLtwumeqQYjd9vtiE5Ii8pcuqGxNhGyz+DYEnoDE2+j5fDLbVFf+vu60s
         jshvRE8HD1ccRzE7pnZZ2erXvBznY+k0ObApCAjcY6CFblh60ja+9rHjtIOGIYxlxAbx
         QMo4E5kPtrTWi4c8jAFpi6UX2v4tlkytsEHpen2ot7F/im3z3QRC5ASUBvODO8GhUYtu
         8nIPXZljGrURljoTjVL/ILcyZf6FNXR+7AfPHEz8VUi4CH8cTX1vDttnRdlZSVlLa/0V
         Ferg==
X-Gm-Message-State: APjAAAVFj4r4o4zT75ha0yq6EZnIsXGGL21xzCxAxgRBWvy8ZKAz1i4a
        qUGMiBKkRSuOEjONBlfsJ4zE1Q==
X-Google-Smtp-Source: APXvYqyav0hbbsufO88stfLwuT5j7l9xrp4RSPyN0zoqp/A7wZAkTVx0csOHgCvKj9+MAqieRPBHhQ==
X-Received: by 2002:a17:90a:246d:: with SMTP id h100mr8365827pje.127.1579303100597;
        Fri, 17 Jan 2020 15:18:20 -0800 (PST)
Received: from debian ([122.178.20.229])
        by smtp.gmail.com with ESMTPSA id z64sm31598159pfz.23.2020.01.17.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:18:19 -0800 (PST)
Date:   Sat, 18 Jan 2020 04:48:13 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/203] 5.4.13-stable review
Message-ID: <20200117231813.GA2799@debian>
References: <20200116231745.218684830@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:15:17AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.13 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jan 2020 23:16:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 

hello,

compiled and booted 5.4.13-rc1+ . No regressions according to "sudo dmesg -l err"

--
software engineer
rajagiri school of engineering and technology
