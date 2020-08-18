Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436D9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE81206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AkaISKol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHRJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:45:20 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25480 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:45:15 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200818094512epoutp0208060699c21c760566edf125e2f765b2~sU5_SRG-e0386903869epoutp02U
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:45:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200818094512epoutp0208060699c21c760566edf125e2f765b2~sU5_SRG-e0386903869epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597743912;
        bh=NsOkvQvkZldczEqoWc3iM/DpfiYCpCE0mDSOoCg/0iU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AkaISKoluwZ6XYRe1HTd/8+1jaQhi6NA0CA2ARIsJqx+l/CCoRD3+++00Xgwch6AL
         ARX2acvYLPtF2EiaPIhJ10lfbPPpMhpeA+vlrEmmTY7a1AvvTICCgrRMIVTN+ipNOY
         3yRDJE699gU2M5OrqF8GJYptNnse7Z0o5yJ6uEFA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200818094511epcas2p474d123ae164af4eb831076642f6ee69a~sU59Ogbj72342323423epcas2p4X;
        Tue, 18 Aug 2020 09:45:11 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BW5cP3FYBzMqYkZ; Tue, 18 Aug
        2020 09:45:09 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.FA.19322.523AB3F5; Tue, 18 Aug 2020 18:45:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200818094508epcas2p418f7d4eb9bb6ca3f41cac4529c6d0942~sU565tFYa2340623406epcas2p4U;
        Tue, 18 Aug 2020 09:45:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200818094508epsmtrp1fc688000405a3e1ef8637970e1e77fa3~sU564_uyd2407924079epsmtrp1A;
        Tue, 18 Aug 2020 09:45:08 +0000 (GMT)
X-AuditID: b6c32a45-797ff70000004b7a-b3-5f3ba32518b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.97.08303.423AB3F5; Tue, 18 Aug 2020 18:45:08 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200818094508epsmtip206c9cca6a2cc76d1706f68fa73ae5f6b~sU56vFHRz2251022510epsmtip2U;
        Tue, 18 Aug 2020 09:45:08 +0000 (GMT)
Date:   Tue, 18 Aug 2020 18:37:39 +0900
From:   Cho KyongHo <pullip.cho@samsung.com>
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, catalin.marinas@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, janghyuck.kim@samsung.com,
        hyesoo.yu@samsung.com
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818093739.GB191752@KEI>
MIME-Version: 1.0
In-Reply-To: <20200818082852.GA15145@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmma7qYut4g/8HxCzeL+thtPjbeYHV
        YsF+a4vNc4otOmdvYLfY9Pgaq8XlXXPYLNYeuctucfDDE1aLljumDlweTw7OY/JYM28No8em
        VZ1sHpuX1HtMvrGc0aNvyypGj8+b5ALYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoW6BUn5haX5qXrJefnWhkaGBiZAlUm5GTMX3aNtaBZsGLBu83MDYzveLsYOTkkBEwkFu/f
        wt7FyMUhJLCDUeLI8x5mCOcTo8S0bXOhMp8ZJXbdvczSxcgB1tJ9KBOkW0hgF6PEoZW2EDUP
        GSV+3fjKCJJgEVCVWHq8kxnEZhPQklg99zhYXERAUWLH9j9gG5gFfjFK3Fj4mwUkISzgLbFm
        RTMTiM0roClxeEMbG4QtKHFy5hOwGk4BM4mT7d1MIEeICqhIvDpYDzJHQmAuh8S0ubeZIP5x
        keh5uYYFwhaWeHUc5DcQW0riZX8bO0TDdEaJd/MPsUEkNjNKfNstCGEbS8x61g52KbNAhsTT
        Z7ugPlaWOHKLBSLMJ9Fx+C87RJhXoqNNCKJTRWLn1GssMKv69t6A6vSQ+DtRCBJWxxglXi1N
        nsAoPwvJY7OQ7IKwdSQW7P7ENguom1lAWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40KDJGj
        ehMjONVque5gnPz2g94hRiYOxkOMEhzMSiK8SSfM44V4UxIrq1KL8uOLSnNSiw8xmgKjaSKz
        lGhyPjDZ55XEG5oamZkZWJpamJoZWSiJ8+YqXogTEkhPLEnNTk0tSC2C6WPi4JRqYMotOWxj
        LvEmxeXZh+xlHltCH2fbrLhs7jat+OpGKY6vASYce1Zovz/cMT31m8F1u2tlu6Uyu81+KpzU
        N7V4PvH+K42c5h2npPt0FpoWHd0X0TIxQK3v8eUaxs8l7PMYTsy+tW5eo/iV2GPl+gUiDRPV
        8+LjMnOLxTWePPWLeNnCah3ZI8+x5JbPjD96Z6beXeJSdrJGNvcKm8O1TN9HVyfLsTvlbLZ9
        tvn2t8JrXfFz3/39ZXe+KsndcGsDR9m6utP70i6erPwkt5sjs4Hz+YYtHUU/T6qqG8o8Vvcv
        UohMeGMcKtunEjKjmuM9i/KMddXq20zeZ5i/de1jFlRZMHVJ1ZcSC/bGiMURdjt3KLEUZyQa
        ajEXFScCALBJtCg+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK7KYut4g73fzS3eL+thtPjbeYHV
        YsF+a4vNc4otOmdvYLfY9Pgaq8XlXXPYLNYeuctucfDDE1aLljumDlweTw7OY/JYM28No8em
        VZ1sHpuX1HtMvrGc0aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyDr+vLDjMV3FmQk4D43Hu
        LkYODgkBE4nuQ5ldjJwcQgI7GCW2TJIDsSUEpCTmda9lgrCFJe63HGHtYuQCqrnPKDGxZRU7
        SIJFQFVi6fFOZhCbTUBLYvXc44wgtoiAosSO7X+YQRqYBf4wSjw8eh+sQVjAW2LNimawqbwC
        mhKHN7SxQUw9xihx9e5/doiEoMTJmU9YQGxmoKk3/r1kArmUWUBaYvk/DpAwp4CZxMn2brCw
        qICKxKuD9RMYBWchaZ6FpHkWQvMCRuZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjB
        caKltYNxz6oPeocYmTgYDzFKcDArifAmnTCPF+JNSaysSi3Kjy8qzUktPsQozcGiJM77ddbC
        OCGB9MSS1OzU1ILUIpgsEwenVAOThE2UCsexQt3iVy2vw2d+7oj0vNy1poP12T8/PQVW62hb
        i9t11cFesh+FrNxydx3tudxib7Pe8YcaU/wOsfmHTl+5mL/a5cZHv5lGk11Wh3Smqr10YhXh
        vLVqitbb9eKO1w3jb6peZzxZcuPWeblXpTrLZqV4TcqRf2jNEHBzL7t+4KKouUfPrNQq7ZH8
        vfDw24hHN3/F9iza8+XfBh77JC028YAnZzd3v94TZru+yMJ2/pxT/fqqq59ohL3i2BW6PYp/
        xXk/YeZyv9srs3Nj6o4v0+q1midqd86H0+hoZfQsnnm/zMOs77KF/Iion3TduudbjZHK2y9+
        1iqbRAXK2D9t3bpI4VnnchexA4xKLMUZiYZazEXFiQCwYQjgAgMAAA==
X-CMS-MailID: 20200818094508epcas2p418f7d4eb9bb6ca3f41cac4529c6d0942
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
        <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
        <20200818082852.GA15145@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > Cache maintenance operations in the most of CPU architectures needs
> > memory barrier after the cache maintenance for the DMAs to view the
> > region of the memory correctly. The problem is that memory barrier is
> > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > involves the memory barrier per every single cache sg entry. In some
> > CPU micro-architecture, a single memory barrier consumes more time than
> > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > are larger.
> 
> Have you got higher-level performance data for this change? It's more likely
> that the DSB is what actually forces the prior cache maintenance to
> complete,

This patch does not skip necessary DSB after cache maintenance. It just
remove repeated dsb per every single sg entry and call dsb just once
after cache maintenance on all sg entries is completed.

> so it's important to look at the bigger picture, not just the
> apparent relative cost of these instructions.
> 
If you mean bigger picture is the performance impact of this patch to a
complete user scenario, we are evaluating it in some latency sensitve
scenario. But I wonder if a performance gain in a platform/SoC specific
scenario is also persuasive.

> Also, it's a miracle that non-coherent DMA even works,

I am sorry, Will. I don't understand this. Can you let me know what do
you mena with the above sentence?

> so I'm not sure
> that we should be complicating the implementation like this to try to
> make it "fast".
> 
I agree that this patch makes the implementation of dma API a bit more
but I don't think this does not impact its complication seriously.

> Will
> 

Thank you.

------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_
Content-Type: text/plain; charset="utf-8"


------6Tv-RL.wkjEGwkeNQieDfELFd5He6k7dbFa.nbvKv8n_uDOi=_29efc_--
