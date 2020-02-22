Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA807C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD01208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UvU7VmeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBVLuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:50:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35119 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgBVLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 06:50:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id n17so3292546qtv.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 03:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2oHoyb+JnJcDOD/ld8MPLRq6aXjPEqdTgiqvEEYJPd8=;
        b=UvU7VmeTFofcFZ9EDyr5Eo2X0bUAaQkJDkcQZfEv9tc6jLZOG2L8jk/+HM5ka3PuY5
         bEWz/lz7o8O+GDrt4gXzLX26fGcGkWH0d3BmCO5KYZpUstTsFnx9ygugZAujF7AEOsfs
         7GhmB/lVeDzvDgpRDO/TNGmJHsQCQo49hc2GTsHB9QR2M8yWaj84wK/jkhVT6yUVcP5S
         jfLwPzXFxz98EazAK2gSjekGKI6SJTPfjMTxuLG0849z/AzYDbrNjhuwRV23VR4BAVRL
         ENmM5UBKIBW6IQ10avK0/lVPjFXZJ/TcAT5HKCOqsMAZMs02yxWmrihVyG7/bUnXd10j
         abKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2oHoyb+JnJcDOD/ld8MPLRq6aXjPEqdTgiqvEEYJPd8=;
        b=g8LuzfdYoDNg85MZiMBVx4XMklXp3KKpipD9mJjQxLujni9pM0vc3AD6qXZ0sq5g3O
         6rPiRo17uMRch7sCu/jWS4lkaMZuZgwr+Apf/qp+9BjyzjiMbtTFV/W6274zoBCc58F4
         QDEz2axb/Zximo0yYNVMkl0igWzGeL7TCdgnF2A24Kf9lRIrdjpCh/zabb9f1Bx763ea
         3TgalEjqg5uMpGj6qJgdlb/xEWjPUYhb1Vq/N/6xqFc4NjrmbTlVcoUh4FyDNsL95s5A
         GL36qttI4nPlNK2cvfVPd64w08IgPD+JqT189acfWpXpyiadB5Q1bp9Gkn6tD2f+8UWg
         jR6Q==
X-Gm-Message-State: APjAAAVeMzVN9lv3612xIvSjlf2b0RfURhVC/w55p/l8APofw4By5FZH
        K67lS+rVHZF/Gllacp8FHLVjNg==
X-Google-Smtp-Source: APXvYqyPZZBj5jHH9s08zRFxGWurtD5EPWlHOyvqtpdas4/Y/9wlrObBtktabH81aDv065MOxAxg+w==
X-Received: by 2002:aed:2167:: with SMTP id 94mr35462329qtc.318.1582372244475;
        Sat, 22 Feb 2020 03:50:44 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g84sm2962048qke.129.2020.02.22.03.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 03:50:43 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/hugetlb: fix a addressing exception caused by huge_pte_offset()
Date:   Sat, 22 Feb 2020 06:50:42 -0500
Message-Id: <D70C23C6-75CB-4A68-8E7C-23FE8A0CCA68@lca.pw>
References: <f274b368-6fdb-2ae3-160e-fd8b105b9ac4@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, weidong.huang@huawei.com,
        weifuqiang@huawei.com, kvm@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
In-Reply-To: <f274b368-6fdb-2ae3-160e-fd8b105b9ac4@huawei.com>
To:     "Longpeng (Mike)" <longpeng2@huawei.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 22, 2020, at 1:33 AM, Longpeng (Mike) <longpeng2@huawei.com> wrote:=

>=20
> As explained in the commit messages, it's for safe(e.g. avoid the compilie=
r
> mischief). You can also find the same usage in the ARM64's huge_pte_offset=
() in
> arch/arm64/mm/hugetlbpage.c

Rather than blindly copy over there, are those correct here? What kind of ba=
d compiler optimizations exactly do they try to prevent? Until we understand=
 those details, blindly adding READ_ONCE() will only hide other problems.=
