Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3E9C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E0720748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z/Ki2IUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgAPOyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:54:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34651 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgAPOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:54:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200116145400euoutp02a9438f6f7520365ecb6224b9d6a78b1e~qZbNPLkJe0280302803euoutp02x
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:54:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200116145400euoutp02a9438f6f7520365ecb6224b9d6a78b1e~qZbNPLkJe0280302803euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579186440;
        bh=XdrI+OO75vRLBbhW+mHu3KAZTISM1ytL0ytmqWyeHDA=;
        h=From:Subject:To:Cc:Date:References:From;
        b=Z/Ki2IUPZZTozg/spYOCqkvBC8CJ9jM8Drl2s7AsjJN6ydBy4jTLrMmt0k53Tlwrc
         +dpfW/zHkbOg/ukBoz5cjxAKriDWa4UqhGLgXZo6K2LzhOFsu+DkjKs0DFUthTOzZk
         fbJIPeK1HBhkaN7ncYEv2V0vnSF7Jmt3JSK3Lfwg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200116145359eucas1p106c0d8b189de26020a2abc90a011abc5~qZbNCHrD41475814758eucas1p1u;
        Thu, 16 Jan 2020 14:53:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DA.64.60679.709702E5; Thu, 16
        Jan 2020 14:53:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200116145359eucas1p1350bf2b827aa7ffa3e6767739e9ba7ad~qZbMmHjku1474814748eucas1p1k;
        Thu, 16 Jan 2020 14:53:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200116145359eusmtrp193f3b8df6875d5ca4056f18d484c2f01~qZbMlkW9b1290712907eusmtrp1b;
        Thu, 16 Jan 2020 14:53:59 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-47-5e2079070f59
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.C5.08375.709702E5; Thu, 16
        Jan 2020 14:53:59 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200116145359eusmtip22712bacbda3ce93bb3ce246f702f9176~qZbMTpyNy0040600406eusmtip2T;
        Thu, 16 Jan 2020 14:53:59 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] video: fbdev: w100fb: add COMPILE_TEST support
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a929db5e-d373-7b09-ae2b-efec227f7e85@samsung.com>
Date:   Thu, 16 Jan 2020 15:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7rslQpxBleeGlvcWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8bqVbfY
        C7ayVqxesIypgfEkSxcjB4eEgInE6w6FLkYuDiGBFYwSq3a+ZoVwvjBKzO57wALhfGaUmNr9
        g7mLkROs4+ibdUwQieWMEt8vrmCGcN4ySjzfv5cRpIpNwEpiYvsqMFtYwFli1q3/YN0iAgkS
        K6bPAIszC8RLbGs+CmbzCthJbD26ng3EZhFQlfh44TdYXFQgQuLTg8OsEDWCEidnPmGB6BWX
        uPVkPhOELS+x/e0csCMkBH6zSUxc+J4N4lQXibkP1rFD2MISr45vgbJlJE5P7mGBaFjHKPG3
        4wVU93ZGieWT/0F1W0vcOfeLDRRMzAKaEut36UOEHSV2bd3LDgk9PokbbwUhjuCTmLRtOjNE
        mFeio00IolpNYsOyDWwwa7t2roSGoofElPmvmSYwKs5C8tosJK/NQvLaLIQbFjCyrGIUTy0t
        zk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMLqf/Hf+yg3HXn6RDjAIcjEo8vDOCFOKEWBPLiitz
        DzFKcDArifCenCEbJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgs
        EwenVANj+oPrATP73ht91zi+vTVtmchf0yn3Cn+aP703YduefyVhj1wNmbgf9bztlTkQ+V/f
        dN1k4fY77klX50zhqo/1umPXuuoHd0gyc6tFb/6ul5qab/7YR0sW+5re328UxhC3luP5yaz3
        NpUdH2O2nlsUoSj18/MxlsVL/WY8zjWM/PdoVvOSxCRrJZbijERDLeai4kQAHTrjICoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7rslQpxBru+SVncWneO1WLjjPWs
        Fle+vmezONH3gdXi8q45bA6sHve7jzN59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbqVbfYC7ayVqxesIypgfEkSxcjJ4eE
        gInE0TfrmLoYuTiEBJYySsxv28bWxcgBlJCROL6+DKJGWOLPtS42iJrXjBIPd69lBEmwCVhJ
        TGxfBWYLCzhLzLr1nxnEFhFIkHj6ej4biM0sEC/Rua0BrIZXwE5i69H1YHEWAVWJjxd+g8VF
        BSIkDu+YBVUjKHFy5hMWiF51iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRYBaSlllIWmYhaZmF
        pGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwNjYduzn5h2MlzYGH2IU4GBU4uGdEaQQ
        J8SaWFZcmXuIUYKDWUmE9+QM2Tgh3pTEyqrUovz4otKc1OJDjKZAD01klhJNzgfGbV5JvKGp
        obmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsYik8aeo8ujNlRsymhb9urS
        V5/X8pPPtd0U2n98/UkTYzvJWHGuy727ek8oJlRM2xV3ojZ1opbUU3vHv1H/7b8V5bC9KBS+
        nysfvvrtjWd8r06aeD01LFk4//GMNd84M4QOvDf6ufzJtRuL7zz7baasxTkrSNx89/6Mo8b8
        sbEf+X3/KjApLxRTYinOSDTUYi4qTgQAUuJ4PqMCAAA=
X-CMS-MailID: 20200116145359eucas1p1350bf2b827aa7ffa3e6767739e9ba7ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116145359eucas1p1350bf2b827aa7ffa3e6767739e9ba7ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116145359eucas1p1350bf2b827aa7ffa3e6767739e9ba7ad
References: <CGME20200116145359eucas1p1350bf2b827aa7ffa3e6767739e9ba7ad@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to w100fb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1827,7 +1827,7 @@ config FB_FSL_DIU
 
 config FB_W100
 	tristate "W100 frame buffer support"
-	depends on FB && ARCH_PXA
+	depends on FB && HAS_IOMEM && (ARCH_PXA || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
