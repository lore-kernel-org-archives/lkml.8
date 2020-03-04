Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C654207FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="J+9ttkkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgCDHrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:47:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37316 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgCDHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:47:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so888577ljm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90yR+U0yyx88muPof9ELq5RmjD8lTcfReEz4WNGCuAs=;
        b=J+9ttkkL3U2tfSixpLp40ZevGJY6w7+oKgo008s4LmmMoFaX+aoXETJoaT3XHhKDxJ
         O99zq+b1QV2fGPwaPM77i9ENNzpQtrCIRt5R21GLOLzITiMTWACJMz8qhybe6oOkE8up
         TbA8azSnt3BipfJBXIH3cuIX5SlSCjH2aCtokjd4WKtCcXzp4Lp7lexqYWRUTZ9T3syY
         lVJ7kMvEepib4Y7C55YIt9sc7BcTRMqQnwgBEkyT+HQIBDXBZj427rqWevhU/LgSowOt
         P4Ou049Cmky7WSmt5pj8TZP7cNAKUECUqOKtPEPKf8f1NgZn3PuZsvxevrcgxVbZGCJ/
         cTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90yR+U0yyx88muPof9ELq5RmjD8lTcfReEz4WNGCuAs=;
        b=lD4kUdrnDmzFF1eJBYobNqyXSk3qfKRi6bJKqV+kgWrmqeun+/5En7M3/cSt3IOdxl
         fTMe4D9fafV5hQEDVzgbbJvmyiZVo9MqgEohUnc3R3Yt7lS+O+T+d7guKbW/DS/mNtKa
         U3TYH8dcmQMOko9c7tWDUzZ7/y4i3kIA2iQSm8H5+SQ18GwKLxVVc0SaHr5lax6TB7Lt
         lwb9eQjaMXukz2d1aNgMNKxCn/deIRtRSTKj819D1QkEUHHY40i1ZH7yT+r+LiAjtxtC
         iefPycZYBvNYnX2vuteaJuXGezQsq6VYCg2pL1eKw7SLj1PtDmMXPWDvZ7gk91pBJBZN
         RhBA==
X-Gm-Message-State: ANhLgQ1rT0RjFJb/pWUQT2CcHC/spyktW73vqAy3J6ksKetRv+F+p1K4
        Xa/Ux0lArX93bMY9QpVEKVCm0g==
X-Google-Smtp-Source: ADFU+vvthg21d+IvRKw0r2uGiQyTdS6vwB709S/BjS55tayWxFK8wV01Tvm9aaXShoVjxV5AGPZO8A==
X-Received: by 2002:a2e:8754:: with SMTP id q20mr832943ljj.158.1583308041359;
        Tue, 03 Mar 2020 23:47:21 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t3sm232731lfp.81.2020.03.03.23.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:47:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A5062100EAB; Wed,  4 Mar 2020 10:47:19 +0300 (+03)
Date:   Wed, 4 Mar 2020 10:47:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v9 04/20] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20200304074719.e6unbgdop2r3jhk2@box>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-5-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583146830-169516-5-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 07:00:14PM +0800, Alex Shi wrote:
> The func is only used in huge_memory.c, defining it in other file with a
> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
> 
> Let's move it close user.

I don't think it's strong enough justification. I would rather keep all
lru helpers in one place.

-- 
 Kirill A. Shutemov
