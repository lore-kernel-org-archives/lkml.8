Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD3C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D95B221EC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J63kolCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2NOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:14:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51944 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgD2NOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:14:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200429131442euoutp015e76da6d469663cac182c6c26f4ca971~KTKNS5H0m0760407604euoutp01-
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:14:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200429131442euoutp015e76da6d469663cac182c6c26f4ca971~KTKNS5H0m0760407604euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588166082;
        bh=xbXjOd4CC2fPbn7brWYQ8iiw054MQqQZmXHRzua7a2E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=J63kolCXnR5qEPx54Pukm8CYF+X1LdKV7Xum5udsJejt6tvlXZsbDJW2dOzhjAtFA
         qQKSk+7DymWAfKLBa/e9p7V8TzsK8Fjm1iFZaD5j3sHuS0lZbV+siAhHG7UY4eyGdq
         BFh8Wo/cIkkFcPpB0MQrYqLZXt00wuH+2vDsKLLY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200429131442eucas1p206652f9c013176e156f411626f6a4c9f~KTKM-2WDs0260802608eucas1p2a;
        Wed, 29 Apr 2020 13:14:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5C.B2.61286.2CD79AE5; Wed, 29
        Apr 2020 14:14:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200429131442eucas1p20eb0e32635db17674ba5f52a5eba806a~KTKMsJ9_A0257402574eucas1p2f;
        Wed, 29 Apr 2020 13:14:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200429131442eusmtrp189793fd7b25b9c77ba414491fa3966a2~KTKMrhB2t0351603516eusmtrp1M;
        Wed, 29 Apr 2020 13:14:42 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-a2-5ea97dc2baf5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.EB.07950.2CD79AE5; Wed, 29
        Apr 2020 14:14:42 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200429131441eusmtip259f8d0241dffb4dea348af13384ab709~KTKMSEImI1160211602eusmtip2T;
        Wed, 29 Apr 2020 13:14:41 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: controlfb: fix build for
 COMPILE_TEST=y && PPC_PMAC=y && PPC32=n
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3006e72e-fde0-127c-bd59-3902032a0c18@samsung.com>
Date:   Wed, 29 Apr 2020 15:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200429125101.GA21275@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/XbOzo7i7Dgt31QUBkUKaaLC8YKYFo6E6M8Isk55UGlT2dTU
        CNRMZZlpgtUwMhV1QmbLO5q6wiukVl7y7jB1tnXxEk3JcjtK/vf7vvd5vvd9Xj4SE7Xwncm4
        +CRWHs9IxYQN3tRjGjqpva2OOtX91Z1+vjCD0Z82vxP0YGE5j+4r+MGnP7aVEvTqHR1B15ga
        Ed3YMSoIJSWZExOEpONXGS55XeMpqWjX8yRz93p5ksqSUUKyrnG7ILhkExzNSuNSWLl3yFWb
        2IWubH7iBp76ZiEtA21jSkSSQPnB0qpciWxIEVWDYGxYx+cOGwg6V14Q3GEdQUnDY6RE1hbH
        7IMiwswiqhpBgSGEExkRDGXoeeaCAxUL63k7FpEj5QGT1bmYWYRRJgSL20bLSwQVCEW5tRYW
        UiEwvmHgmxmnjsHdrnHMzIepi7A2/5bPaeyh/8kibmZryhdymhssXoxygsnFZzyO3aHZWGpp
        BtSAAAaGDTg39hl4asjlcewAq70NAo5dYbA4H+cMdQj+5K3suZsRVBdzGYAKgun3W4R5Zdhu
        npdt3tz1aVhr/CngNmkHE0Z7bgg7eNj0aG/BQsjLEXHq41BfVU/st1W2qrFCJFYdiKY6EEd1
        II7qf98yhNciJzZZIYthFT7x7E0vBSNTJMfHeF1PkGnQ7n8a3Olda0GbH65pEUUisa2QZtVR
        Ij6TokiTaRGQmNhRqIutihIJo5m0dFaecEWeLGUVWuRC4mInoW+5/rKIimGS2Bssm8jK96s8
        0to5Ax3ReBAjI5GpZ2XtbsOB8zOVES7hpE7fH/bbs7vw1nndct3i54o+/d932f7BFaulXa73
        RVZzyzGdk1nntrycVd2vQiO1jPRohVU5E/Alv7DXNUvjbu+GB5F9ftXfHA9pIiYy7aLdw6d6
        ToSpTRdXXB38Z+tb0wOmp5RLXdO2Y/5iXBHL+HhicgXzD0XDNclLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7qHalfGGXydz2ex8OFdZosrX9+z
        WZyesIjJ4kTfB1aLy7vmsFm8an7EZrHi51ZGi617r7I7cHg03rjB5rH32wIWj80rtDwW73nJ
        5HG/+ziTx5JpV9k8Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0Mt4eKCFteALS8W+h5UNjL+Zuxg5OSQETCTu9U9k62Lk4hASWMooseTy
        eZYuRg6ghIzE8fVlEDXCEn+udUHVvGaUuLHpDCtIjbBAhsTvd8UgNSICmhK3lrczg9QwC/xk
        lHi8ZAc7RMNuRomG4/dYQKrYBKwkJravYgSxeQXsJK5/ecMKYrMIqEq0HrgOdpGoQITE4R2z
        oGoEJU7OfALWyylgLNG2fQtYnFlAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0WkpZZ
        SFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAetx37uWUHY9e74EOMAhyMSjy8
        E9JXxgmxJpYVV+YeYpTgYFYS4X2UsSxOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBqSKv
        JN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPjxjnu0/emCjsdUetP
        cWKaWHQi2uXoKs+/+Qb7vb8HJDBkeX92sub127PozftePaVzs/5+CT0ie+TfrQm3mK68zPy9
        cOd+w2vvd1xZVSWwu0o1j1VIoPpLnGPw9j9pC8v3b+Fi+Hfxc07BVsZ6C3u/Oz9NPh6/cNCQ
        Z3qj5M30ldL8/ff+r2kyUWIpzkg01GIuKk4EACnAEcvdAgAA
X-CMS-MailID: 20200429131442eucas1p20eb0e32635db17674ba5f52a5eba806a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd
References: <CGME20200429104825eucas1p16bf37b71a3ab3a768d1eff6c48eb61dd@eucas1p1.samsung.com>
        <fe520316-3863-e6c4-9581-5d709f49e906@samsung.com>
        <20200429125101.GA21275@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/20 2:51 PM, Christoph Hellwig wrote:
> Why do we even bother allocing the driver to compile for !ppc32
> given that it clearly needs ppc-specific infrastructure?  The whole
> idea of needing magic stubs for the COMPILE_TEST case seems rather
> counterproduction.
Not a perfect solution but at the cost of 2 ifdefs it allows controlfb
driver to be compile tested on any arch.

Being able to compile test fbdev device drivers is really useful for
me and saves me a lot of time when doing fbdev maintainer duties.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
