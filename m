Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C784C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9C120771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TXEWF0PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgHKR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:26:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50909 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbgHKR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:26:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200811172609euoutp02847654398e86864cd8550acff7ad3ebb~qRrb-84hz1390613906euoutp02O
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200811172609euoutp02847654398e86864cd8550acff7ad3ebb~qRrb-84hz1390613906euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597166769;
        bh=DWSq51BVqD/cJXFaRO9qdwmVLjQYWLiMKoZTS3OxLlo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TXEWF0PR3a7MjDGUBYFIjGOEZ1NGlXcNmIUXoNH1tr+JsOh+6FI3pT7T19hf7GYh5
         VCRu7/hbSDpMxDYg6QXYCO7lYQOosWxu8WBkdH1dh0F+KDy2eXk88hKNrkXbn9ywQJ
         mENeRn7XerNHmlCyKbmcMGr8EEi7YHQuvl3sIsPM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200811172609eucas1p2836ca6b88971ab73d32f2dc6999c53bf~qRrbZn8Ea0784407844eucas1p2H;
        Tue, 11 Aug 2020 17:26:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 99.46.06456.0B4D23F5; Tue, 11
        Aug 2020 18:26:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200811172608eucas1p139ea646735cd81a8c5fe76cc701c7b05~qRra4uTjq1061710617eucas1p1T;
        Tue, 11 Aug 2020 17:26:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200811172608eusmtrp12364ad39b2bd51504b1a7643e3cf4898~qRra4DzuI2746427464eusmtrp19;
        Tue, 11 Aug 2020 17:26:08 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-56-5f32d4b0daf3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.99.06314.0B4D23F5; Tue, 11
        Aug 2020 18:26:08 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200811172607eusmtip2d0f1f37c2f15c6ede57d77d2107da6c0~qRraEcG_D0617706177eusmtip2e;
        Tue, 11 Aug 2020 17:26:07 +0000 (GMT)
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <774ad8b4-2d6f-fd09-1582-edd674385aa9@samsung.com>
Date:   Tue, 11 Aug 2020 19:26:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+Ln22E4FPexE1R2dmV=u9U5UFWsAz=8kXgqBntEBgabnUEF+Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjlt3u33Y0m17nY15KCmz1M0tTCS5mUKewfwyBKgrRrXqbmVDZ1
        WoGGaPlILQ1tGZp/pIxEHb6lguUzU9FKl6VlrEzFfAuVaF6vkv+dc77zPQ58BCavE6qIiOg4
        VhfNRFEiKV7f/rv3SPV7j5CjJbNedE1RlZAeWhwX0nPZo0L6XXOxiC7qeymgK1tHxHT/G396
        dbAGp03NK+i0RD1jTROrm4wjYrXZlCFS59SakHrBvCdQeFnqHcZGRSSwOjefq9LwuvRnKHYI
        T8ysrsBSkA3LRBICyGMwOPdUmImkhJysQLD2uAvxZBHBbE+TiCcLCGy9VuFWy9T85GahHIHx
        RTPOkzkE375Xbgx2IIOhtvGjgMMK8iAsF+SKORNGPsbgR2OnmCuISHe415azvpAgZKQPLI/F
        czJO7ofx4eINy871OXUdHzbmyEh76HpkwzksIc/DWG66iMMYqYRhW4mAx3uhYboY43YB2S6G
        ifLKzaR+cOd5mYjHDjDZUSvmsSN052fjfEMqguyWT2Ke5CH40lGKeNdJ+Nz7R8RdipHOUNXs
        xstnoGZqCONkIO3AOm3PH2EHD+oLN2UZ3E2X824n+GsqFPBYBVm2NTwPUcZt0Yzb4hi3xTH+
        31uKcBNSsvF6rYbVu0ezBlc9o9XHR2tcr8VozWj9mbpXO+Yb0dJAqAWRBKJ2yErve4TIhUyC
        PklrQUBglELm29MdLJeFMUk3WF1MiC4+itVb0G4Cp5Qyz7KJK3JSw8Sx11k2ltVtVQWERJWC
        nC88cVY0MDcNAtNYRpf1oovvT8uJ5DzfwoAllcutzkBzovI1dtbUVzyWW+aUxUgvtfoVmD2/
        pif3Fwb+yjiEhi2J/pqHQbERaZq40JpureE2VarY9zZ49PiM4ZS9oS2SEuyqHVBRtnyv1BXH
        ANRSgilfHTB5Wyt9IuvPBVkoXB/OuB/GdHrmH460u0BIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7obrhjFG9zeLWaxccZ6VovrX56z
        WnzsucdqcXnXHDaLGef3MVmsPXKX3eLiKVeLf9c2slis2vWH0YHT4/2NVnaPnbPusntsWtXJ
        5tG3ZRWjx+dNcgGsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
        mWWpRfp2CXoZW9uWMRZcZ6no2rCCuYHxCXMXIyeHhICJxOtPr9i6GLk4hASWMkqc6VjE1MXI
        AZSQkpjfogRRIyzx51oXVM17RonZh94wgSSEBeIktuy4CWaLCKhLfJvSzw5SxCwwn1li+fs9
        7BAdl5gkDrRPBFvHJmAo0Xu0jxFkA6+AncS3h6UgYRYBVYnnt+awg9iiQEMf9/4HK+cVEJQ4
        OfMJC4jNKRAo8bC/jQ3EZgZa9mfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKzULSPgtJyywkLbOQ
        tCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGIfbjv3cvIPx0sbgQ4wCHIxKPLwLJhrF
        C7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84EpIq8k3tDU
        0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUAyNDdddfqbm/y62FXx28dTn+
        +OPrVzm/NnxxfxZ43OyUVdfh8DCHvAiWR4VX9ofPvLxttT2rYHqG3O2XaeouQc8XFkW+Lbp3
        XvezpmfGr+tWKSo53/52zntT4Kazm8sw3eLi2Z4oJhODD4LMN1SCk17neTud7rQ3PhQoyr80
        ju/VT0NH/j93NyixFGckGmoxFxUnAgBUVANB2QIAAA==
X-CMS-MailID: 20200811172608eucas1p139ea646735cd81a8c5fe76cc701c7b05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
        <20200811112507.24418-1-s.nawrocki@samsung.com>
        <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
        <66c7330e-507e-d81f-1cb1-b509bf54d050@samsung.com>
        <CA+Ln22E4FPexE1R2dmV=u9U5UFWsAz=8kXgqBntEBgabnUEF+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2020 18:53, Tomasz Figa wrote:
> Yeah... I should've thought about this. Interestingly enough, some of
> the existing implementations in drivers/clk/samsung/clk-pll.c use the
> ktime API. I guess they are lucky enough not to be called too early,
> i.e. are not needed for the initialization of timers.

In normal conditions nothing bad really happens, the loop exits as soon
as the lock bit is asserted. Just the timeout condition will never be
detected - if there is something wrong with the PLL's setup and it never
locks we will never stop polling.

-- 
Regards,
Sylwester
