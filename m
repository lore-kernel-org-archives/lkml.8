Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9890C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9601C2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftDR4Ed6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390111AbgEYTev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389904AbgEYTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:34:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6DC061A0E;
        Mon, 25 May 2020 12:34:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q2so21826637ljm.10;
        Mon, 25 May 2020 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A4jmYZdU5ozBMAXAqmyk44sUjgV6hYrwfu6KlXmyOS8=;
        b=ftDR4Ed6/4/UwzMezVOfDErK3teieIpd8y1f/Lb84PRLBTlN2umIzX2SO8oKktyN9e
         JxqTIRfCcwtNJ4LX6lpD5nFObH6vKi8me1zNJN2kX0e/Ds+WWtXr18qRSpTMPB0N3sFB
         G/5DZBl3ODACPw5Kn8rNvy5XQJ+dXJV4nbAAH60KeUSkUsb0/uzkDK1xlRgvrrY5bpxl
         93EZYzGzrqMt273yWJxW3MjIEed6niJeHEs7XgHwqirnTBQ0SbEQkOut+XXIIdb1X09J
         yArmCxgNS8p9Zw4vCLki32tJeRME3xZ9o7Q9tp2OASJD2psnlzoldExpvY3lyJ4ER2pW
         AK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4jmYZdU5ozBMAXAqmyk44sUjgV6hYrwfu6KlXmyOS8=;
        b=YzBy3kTpi7ie1ss5FwXN8H3ZYPyqXguC3KnITa/YWhHGaBBfe+vATuMYNkWKrbLoS6
         bE1quObLmCd1J+dNrREj5lHxHV/fsC51pY2pQoF6A21ueVTIe0o9IfIyb246x+nvmrHC
         bA1FTWdxM3ySy4NDFk3f4OAn0K52RvhLZaiiybdB5HH3Hfz1G9ZahUJGNF3O0eQASYhU
         /ABCzjlq3E2KROFBt/D03tqGMLYxi0YKCNBQzrd3DLxZq9bnKdkFvkVp41XbRJQak7mm
         HxsstD+tN6kHSe+etNnqgZzXQzujZ+DcH08jCGAA+tITWKILaNUAHEmsjK5qHaT18sKU
         d3Aw==
X-Gm-Message-State: AOAM5308A/UBgi2vhd0YIjpbvVufEqH+jvcv1ez26zuPEN7w35rzdMv9
        7iW8FYJKDmD00bg54qogv9XuyGCh
X-Google-Smtp-Source: ABdhPJxMGuM6N/f4LC792sPrhgWYvy5nLWumLbUsFmsrQl5S04rMvyYu8zXeOAyUN4d60W1isrrMrg==
X-Received: by 2002:a2e:701a:: with SMTP id l26mr15350495ljc.50.1590435289168;
        Mon, 25 May 2020 12:34:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.googlemail.com with ESMTPSA id j9sm5339418lfe.24.2020.05.25.12.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:34:48 -0700 (PDT)
Subject: Re: [PATCH v1] iommu/tegra-smmu: Add missing locks around mapping
 operations
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200524183755.3774-1-digetx@gmail.com>
 <20200525083556.GA2382769@ulmo>
 <ffa2f98f-1809-e4f0-009e-d06dcde0ed49@gmail.com>
 <20200525122016.GB2393266@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c6819193-6200-b7a6-57e4-c763d1a7129e@gmail.com>
Date:   Mon, 25 May 2020 22:34:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525122016.GB2393266@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.05.2020 15:20, Thierry Reding пишет:
...
> Do we have a good way to find out how bad exactly the contention would
> be when using a mutex?

I'm now having a second thought about it. We don't need to care about
that scenario at all because it's a software-design defect of the
upstream Host1x driver that it maps gathers dynamically. The defect can
be fixed and then the potential problem won't exist at all.

Neither of the drivers that are using Tegra SMMU need the IOMMU mapping
operations to be performed under spinlock, so mutex will be good a
variant. I'll make a v2 with a mutex, thank you for the suggestion.
