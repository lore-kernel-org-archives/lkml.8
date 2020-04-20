Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFCC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2139220782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="c5S3+Z5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDTUXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:23:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B3C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:23:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u6so11540891ljl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CuRp/kkTGXEMux5bgsIo3QW+RdRZxdATUglGSRF3hAg=;
        b=c5S3+Z5nEopbu09u5DjyVYMtQfUwx7xcO7OiL/GTmj2QqkZy/KM/OvgBGCCJQugEl7
         s6r/w8EYr8aljdzxYprJ07sXIvRPAgw58EhTUhgUJKIavNbBiScdXVZYCXmlQ+LxxI8B
         8luq4d1ebkxREBHZmWjpTFMo5qLJWzg5A0XYtPkRPIx4OFABhOvacveltjJc5Wdda7mx
         3k5HfOTiJxkyjX2ZJKJi2OCmJGleHmT8Qb2ZggMD2mVFt1y9/00XrOgUhz303UrbHTTn
         RKw3ufXsHZlocyVOTMnJ7bxflOhCfoIqXjfr6b5Qmlu9zXnhzLVXmlsnDgJ56eHRYH6S
         5YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuRp/kkTGXEMux5bgsIo3QW+RdRZxdATUglGSRF3hAg=;
        b=HZhGC2uo0nJJkS7LTUyJTBHCA+iMxZDN3tZP1Bl9k0k9t4o74wwIN0pkHojEH85RmS
         EMYUgciOvOHI65buqyyH4vtpobzM88SjOxMscd9bYJBWkfRrwg4qeoIqIJfIKgjOJ90c
         HzbSI5GuYGJFp//qVbkjaZqWNkGQFKpg77i7aUM3wmooPNfEJZtPm1zCM3kR98uXhRh+
         eKPvoPA84jjxOOBSafDM7gCUjKaY6E5ziV7RImnC3n7gAN55dtqBN0WQm9ZGQewB33zz
         ypYS6W6MqiYoJmMNsaJRVZEDHShj1JOFKGWdVSKFX/TCX9vRiolqgjiFJBi4gkhW7Yce
         uXRA==
X-Gm-Message-State: AGi0PuaO4nIhfAl7H7ZiyMoG/lW7xc5UoDNuVxxjugkK13LOoTN3IJO+
        WBYq3HMM0UZmd5UPOj8vNF4I8Q==
X-Google-Smtp-Source: APiQypIe7ofdBVgkbqdERU9/MDZTLo5v/el4i+71zRDMmRE4Q9LM7F+EC7G8sK2mDnu0mQPPmuMGzg==
X-Received: by 2002:a2e:8805:: with SMTP id x5mr11577593ljh.223.1587414188514;
        Mon, 20 Apr 2020 13:23:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x24sm344419lfc.6.2020.04.20.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:23:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 07398103037; Mon, 20 Apr 2020 23:23:12 +0300 (+03)
Date:   Mon, 20 Apr 2020 23:23:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Colin King <colin.king@canonical.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] selftests: khugepaged: fix several spelling
 mistakes
Message-ID: <20200420202311.srpxl7jrbdjus642@box>
References: <20200420084241.65433-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420084241.65433-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:42:41AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There a are several spelling mistakes in various messages. Fix these.
> 
> There are three spelling mistakes in various messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks a lot.

Andrew, could you fold them in? Or should I resend?

-- 
 Kirill A. Shutemov
