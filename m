Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0A6C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0214B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AgHK/cFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD3BEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3BEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:04:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B5C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:04:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e17so3660138qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nHd4t1dxAGq6mLJOxoRUU+Fay7yLnL9/fA8P7+mfDpQ=;
        b=AgHK/cFgIOfkFmmQJ2HHgpg3mx5clBmVW8MSgmXFicJyCJ7uFPspAVHR0NEiw9NKoI
         gep34agHPjs5RuEmiYWHSn+KyGhnMiDOdm2q0JfUMqqaV/P6rJ0s1LLiTktKWnJPcD7L
         DV2ThlelvfRAnYXjfKYFJIjuY/jQ8d27bN7IBHRgXqNlQedc7yhrytKpevi+SzGJibw/
         7ZqEpkp+LVWoZ3Q+jRu0nFJJT24qXdvadNF23JNoMuP8+aI7uNU1szKkiw33VIDiKPLC
         klezXWYEPlNEOjtem1Ra/HmwgV5jOSGB5Vhp5i2dUuzwwaro53RAyZAesvGtOyahi1ht
         YsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nHd4t1dxAGq6mLJOxoRUU+Fay7yLnL9/fA8P7+mfDpQ=;
        b=T4hF/fNXqwuo1x0Fqd+D5og3GBj/XBFUhw4p+zba2AOcieksu5ubjYiobs6vTv1gvA
         kMFtdHVHeZ7gwFT9oBVnuXkAo7K7MGCu9nTLvHEhFWPznZpR3s5j/IPcKh/R6jG80s6p
         wPQnDtOhPmu8GNDN1Ez2azMgxrOZWirRnquv8i/tYLIZo54lz+UWzsmBaXcDbrW0tGRm
         DLQxhrxY3h630b11AsOgwnNj//9dnYqjNq7pAOZHb4Jp7UYh+kqsTAUeeTtu5eiBjTTf
         2VZXmgJmtT3khLLeHmoy3YXoKxkborObkaVCdVpCGDTq5S+sUFSJkKNqzplBTp3Q1c1W
         SJLw==
X-Gm-Message-State: AGi0PuZMlL3902vAW01byLCUXhPKw/dEuW2u9mfd+eovxMbbrbRzsjwK
        C8Jb0G4TC5qPS/R5BMvLP5HUn4TGjM/dMg==
X-Google-Smtp-Source: APiQypIinv6LGmMaBvcDc2ShRyQ8bG/OhOfqiG0k/1Z4rM4tPxtPlwHvvLLjHt/GZvL/0oAqyQ51KA==
X-Received: by 2002:aed:3aa3:: with SMTP id o32mr1207048qte.364.1588208671328;
        Wed, 29 Apr 2020 18:04:31 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h6sm739542qtd.79.2020.04.29.18.04.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 18:04:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200429112014.GN21900@8bytes.org>
Date:   Wed, 29 Apr 2020 21:04:29 -0400
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B6E0A22-C301-43C9-A8ED-AB473342463C@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
 <20200429112014.GN21900@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 29, 2020, at 7:20 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Mon, Apr 20, 2020 at 09:26:12AM -0400, Qian Cai wrote:
>> No dice. There could be some other races. For example,
>=20
> Can you please test this branch:
>=20
> 	=
https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=3Dam=
d-iommu-fixes
>=20
> It has the previous fix in it and a couple more to make sure the
> device-table is updated and flushed before increase_address_space()
> updates domain->pt_root.

It looks promising as it survives for a day=E2=80=99s stress testing. =
I=E2=80=99ll keep it running for a few days to be sure.=
