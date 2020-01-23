Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF21EC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F624673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="J6gYOfoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAWDCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 22:02:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34948 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 22:02:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so709464plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 19:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QHwD3xJbxA6Bj+Yx1EYQsUkr/yHSHTopSLaHf+HB1LQ=;
        b=J6gYOfoWW7D94l0Y7ebAoY3D9qsp2ivY4bRoViRNM2t+ygjSQ7c98hfo1U/XlqYySc
         JojfwPv88Mja6A6xQTlrtoPOT36SxrfCvfj3t5/EqQfJCxSo0NcL1czveIgtaa7lDe95
         L+vwHoDMjlgDTN7MvU7EIxsiGv1L9+qITCvUNfrbshL2PKCeiVc7vZB3qVeSzAkQSp+S
         8VGp43i/tm1uGMM+3zQEztlAgfEXgCGnbBuZ/2w1MEV7J62DVCLiS10G//0E58+SgMsx
         w946YabfAyizOwSP6vU1vxY35l/0xrrc1X+/j0QklraJ0iAJO6pkB3c74LgNhr3Brd1z
         5FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QHwD3xJbxA6Bj+Yx1EYQsUkr/yHSHTopSLaHf+HB1LQ=;
        b=hj8kVrnW9jSp4rHCHeBP9dAuLZa4aFUUoUUGZfQ6vrb62YAB9Utc2mpFEY5WXQIY7K
         iU2WKD/Fzk0QKIgbkkjIv5KJwfV0a7dx0Lr2NQGI+awMHMhiuazUTbTMweHsT4fnHeq8
         Ze8x81Z+ZsfNgSnNdTV+znqo2Mva3YRh8BBV4rZiVViHGjazezgsVSuHShgFFrZ5PHXS
         RISZlf+SfJl6E/PU6k2NTwD7IMbY09kJ1IeMAuZZWoWpAQytCcHMv4zb8bBhtE5C3USX
         //4Z56Qcw9xCU3q09dKFjlXDKoQhZdyhTdcZvyN3NbUgRwmxVwltheWJwOIdu0LA7Gte
         8yHQ==
X-Gm-Message-State: APjAAAXzyY9j30ITIVR5kTnbrAoIyri3pX4DyLDlntLzDNzFz+hw1v16
        CCngAa6zLGV3DLsmDBGRZ0yPaQ==
X-Google-Smtp-Source: APXvYqx0ztp78PhfwAEOpZE9YOyLcEj6xDbpjw3B4QFYco9brX2bu9A5MvQuDHkORMpB6ZNtfDJ0aw==
X-Received: by 2002:a17:90a:5215:: with SMTP id v21mr2014316pjh.31.1579748532131;
        Wed, 22 Jan 2020 19:02:12 -0800 (PST)
Received: from ?IPv6:2600:1010:b025:c4e4:c9ce:11e3:9a9e:90f0? ([2600:1010:b025:c4e4:c9ce:11e3:9a9e:90f0])
        by smtp.gmail.com with ESMTPSA id y203sm312460pfb.65.2020.01.22.19.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 19:02:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: Add MREMAP_DONTUNMAP to mremap().
Date:   Wed, 22 Jan 2020 19:02:08 -0800
Message-Id: <CD5EA896-7364-40E2-8709-A014973FFBC8@amacapital.net>
References: <20200123014627.71720-1-bgeffon@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
In-Reply-To: <20200123014627.71720-1-bgeffon@google.com>
To:     Brian Geffon <bgeffon@google.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2020, at 5:46 PM, Brian Geffon <bgeffon@google.com> wrote:
>=20
> =EF=BB=BFMREMAP_DONTUNMAP is an additional flag that can be used with
> MREMAP_FIXED to move a mapping to a new address. Normally, mremap(2)
> would then tear down the old vma so subsequent accesses to the vma
> cause a segfault. However, with this new flag it will keep the old
> vma with zapping PTEs so any access to the old VMA after that point
> will result in a pagefault.

This needs a vastly better description. Perhaps:

When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is set, th=
e source mapping will not be removed. Instead it will be cleared as if a bra=
nd new anonymous, private mapping had been created atomically as part of the=
 mremap() call.  If a userfaultfd was watching the source, it will continue t=
o watch the new mapping.  For a mapping that is shared or not anonymous, MRE=
MAP_DONTUNMAP will cause the mremap() call to fail.

Or is it something else?

>=20
> This feature will find a use in ChromeOS along with userfaultfd.
> Specifically we will want to register a VMA with userfaultfd and then
> pull it out from under a running process. By using MREMAP_DONTUNMAP we
> don't have to worry about mprotecting and then potentially racing with
> VMA permission changes from a running process.

Does this mean you yank it out but you want to replace it simultaneously?

>=20
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical=

> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming=

> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."

Cute.=
