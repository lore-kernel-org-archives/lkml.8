Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88948C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686312075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wTKtd1Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgEYEcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgEYEcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:32:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC30C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:32:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so19314566ljj.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WrUFOLt9W4X7+7Hr4QrlHwXipVvqxmvlL120XbBbrhs=;
        b=wTKtd1Vjv/ulJ2FRNbEj/4hKXpRQgfTgnSQqG0fgNLk2kydwySZbE6RNq14Nz3V7mT
         DRaLDFml1j37ovPWa4B0sMa7yINjDPda6OfVIj/IZN+DNBcp/rVx6TOlCRv64xmYWumE
         M7NHUOVeEsTkw27kZokfduHNoW6jHGHHX08aczLzJiJv60S0E6ph+pMu7+jor0Y59A4H
         Ix8vOh6ni0QJnJ69+/JY+ySU/SPP0tPNwyJtqxQuK/GB08xYdHAS/fPsuT2da1gGUumf
         d6cRP7OtTKN4zBS3Zuh9USel6xHpJ51z8oxXrQmZtqP4gmY9X/RhMRI6KB2U7nKovb5Y
         OCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WrUFOLt9W4X7+7Hr4QrlHwXipVvqxmvlL120XbBbrhs=;
        b=G3/KqgWu7820HTk+uZUbE0uug0bYFKPq5B5QQncHvOMToNof5n2I4FHBAcqZ6qH11a
         638f/TzXRqgh8Gs5HfPsr55VfDmGjh13pnn38GUS3XXd4+18hBwaNKjkg/UMKO1AMb+x
         XuNwaFgcucTZmjPK/YoROTERqj9GZmfO82rom3QN8bFm/lyYZ4Gd4YHU9Oei7RKJsXUD
         UznJE5biqDFvM8ETep3F5AcxuI2Ic8pej0p2zFcdjdITkY/GPGNpCwD58LpJIO5o8CBy
         ZhnZRJium3eJa3SCHYAv8Q/Tb/ZBdLu7W5d9hPlMkMGzZ7ogqOReRueuiUDdo8jcLuWw
         13ZA==
X-Gm-Message-State: AOAM531Ue7vsZmYmo49tc1gX2AMM5lYFZzHM6tH89aMnsmSvhnrmXXe7
        1XimJ/Njn/J06Q56cB47U1M6Tg==
X-Google-Smtp-Source: ABdhPJzZGWVnx2Ety9OdD8HfgyBX70TKROgXrdT6USIyGUjVgUaa7nqQ2ypUdkRt0MksjSbVn1uqnA==
X-Received: by 2002:a2e:a586:: with SMTP id m6mr6713031ljp.318.1590381162883;
        Sun, 24 May 2020 21:32:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f12sm4446255lfp.8.2020.05.24.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:32:42 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D146B1012E6; Mon, 25 May 2020 07:32:42 +0300 (+03)
Date:   Mon, 25 May 2020 07:32:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
Message-ID: <20200525043242.ef2uhn2a4w7xazcx@box>
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 06:50:15PM -0700, Hugh Dickins wrote:
> When collapse_file() calls try_to_release_page(), it has already
> isolated the page: so if releasing buffers happens to fail (as it
> sometimes does), remember to putback_lru_page(): otherwise that page is
> left unreclaimable and unfreeable, and the file extent uncollapsible.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Cc: stable@vger.kernel.org # v5.4+

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
