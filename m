Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D8C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6046124688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RSDI340P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBZLuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:50:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44556 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBZLuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:50:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id j23so1979208qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=1Nj3WLo9cRZxIPEHv9qflBuNtujnV4srBAYaoC6re2w=;
        b=RSDI340PiBSVFYUkud1M9U3Lq657NRydFYs10bE04Em1x6PIG4aT2xeeWPZAu73fnB
         0NhbmR0qdEntI8a1Uo/YEsjcfi3wGUzdDrrOE4QQO2BksjlIA5H7qy3fYwHsULvhpcWn
         /DoS9rrLodMtGsZ8m7Nf4Zl6tRZoewkcWowjJOY5yhaW+uQg8F/GVpOPjmUHCxPaJnI6
         k0AXbwsdEDg+BVlvO2pw1iEltPtkAV0HKQcJm8j2eNDgAjKK8oDJqm8HRnz7ntW2kayv
         xR9zNiIy3yFLn4PSQnxr9cqIUq0ZvZXeaAgL9ex1bspckmygM8bJr6AffKTm+9AZT2Cr
         wcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1Nj3WLo9cRZxIPEHv9qflBuNtujnV4srBAYaoC6re2w=;
        b=WfzvO4+l/ePcBoTX/PEXECW0Bv0vC0NPri6V9zpI9gmvMBY12GWfKLdoB6Vkj2LRx0
         ApIYBtp+/aluSw6vzDBZHVqR5GXwsqB+s9F9sPvgMrO83CIALpzrVKeoVRjsfvCwh9eO
         ufnRHqDfb1N+rQq/DA9toH/+1M+OIBpnacTYTHPDj4eRTJyl+AorLMvMeL06v7uEetb0
         AUBFOt1wiZmkpXk14HJ+WI1ixSGx6HeQG6ry1/dCLz0CY+06/BpLZapxitFCjiu1IeUO
         QTtsf9abIN7Gy82aaHJRAWtzqcqhBjJDxy6+OKnqP+KATkRri4t9bUB28DdL6cP6gdBB
         mvog==
X-Gm-Message-State: APjAAAUmXNJdSudc4ID1Pchb3UGoluLOSDG5VUkDAe+r1GPP346hjdnX
        WUE1XRYMN86o8OGwsiEvMypkCQ==
X-Google-Smtp-Source: APXvYqzyF/W4n0zBHBIcKiHA29O0HxreUGdQ9llSh06xLq9nPJRJamNnrSzZ+WKBW2YMksk/7XLWBg==
X-Received: by 2002:ac8:6999:: with SMTP id o25mr4093185qtq.342.1582717803449;
        Wed, 26 Feb 2020 03:50:03 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x24sm977024qkn.48.2020.02.26.03.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 03:50:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/vmscan: fix data races at kswapd_classzone_idx
Date:   Wed, 26 Feb 2020 06:50:01 -0500
Message-Id: <8C6CE0C4-7B15-41D5-A1B2-F48F6241200F@lca.pw>
References: <20200226040612.GW24185@bombadil.infradead.org>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200226040612.GW24185@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 25, 2020, at 11:06 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> I don't understand why the usages of kswapd_classzone_idx in kswapd() and
> kswapd_try_to_sleep() don't need changing too?  kswapd_classzone_idx()
> looks safe to me, but I'm prone to missing stupid things that compilers
> are allowed to do.

I am not sure. Although it looks possible on paper, I am wondering why KCSAN=
 did not trigger it yet which seems rather common. I did stress testing thos=
e areas with KCSAN for a few months now, but it might just be that I missed t=
he report at the first place.

I=E2=80=99ll keep running some testing to confirm it, but until that happens=
 or someone else could confirm it could happen, I=E2=80=99ll leave it out fo=
r this version. We can always submit an incremental patch later if necessary=
.=
