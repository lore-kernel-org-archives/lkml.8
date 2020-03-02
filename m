Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327C217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DQyJrYAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCBPmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46962 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCBPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154216euoutp02e8f4e16b5240e6e05cfdfd47d0de5050~4hwfRc1hI1346013460euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302154216euoutp02e8f4e16b5240e6e05cfdfd47d0de5050~4hwfRc1hI1346013460euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163736;
        bh=ju1g/QHt4/Lu7DgJ5e4q0GaQjBNKoE5bq5Z7iurWP/k=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=DQyJrYAcx9Q5zqFoTrILuzTHCa+g3ZGx3iTCpxYOmcce5TZc3x1epQMjUJ2lFHOIl
         59FzoND8uUkRl8RlhFmv+UDsw8BVd6bl0wWAUnj6S+oIIvCrZjZv0Zn9Hcuz95I4Bv
         QGT5iXFypEq1WHHEWEQLN5t/DkjcSegUAviozGls=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302154216eucas1p2874d79f9055f0e620c27b0361ff97782~4hwfF4fgT2400924009eucas1p25;
        Mon,  2 Mar 2020 15:42:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.8D.61286.8592D5E5; Mon,  2
        Mar 2020 15:42:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154216eucas1p1bd4c6c0450617d11ffc3136a86f9cbbe~4hwe00ReK0815708157eucas1p1I;
        Mon,  2 Mar 2020 15:42:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154216eusmtrp15ae7fc9811ab1db043978f2c9c2cb1c2~4hwe0LDJL2862728627eusmtrp1c;
        Mon,  2 Mar 2020 15:42:16 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-c6-5e5d29587535
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.FF.07950.8592D5E5; Mon,  2
        Mar 2020 15:42:16 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154215eusmtip21aaf1e0de7a3a4158e7ddc2b0bec5f52~4hweXxq9p2155721557eusmtip2t;
        Mon,  2 Mar 2020 15:42:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/4] video: fbdev: remove set but not used variable
 'hSyncPol'
To:     yu kuai <yukuai3@huawei.com>
Cc:     benh@kernel.crashing.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Message-ID: <f05e964b-2a4c-1fc4-b0f4-16c3e6d1ec34@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119121730.10701-2-yukuai3@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87oRmrFxBvN3SFl8aGpltrjy9T2b
        xYm+D6wWl3fNYbO49u4Mm8WchWwWCx/dYHNg92g58pbVo+dNC6vH/e7jTB6fN8kFsERx2aSk
        5mSWpRbp2yVwZSz684etYApvxYm1N5gbGO9zdTFyckgImEhMvXSPuYuRi0NIYAWjRN+tPywQ
        zhdGiUVblzGBVAkJfGaU6LnDAdPRvv4SVNFyRonHJ25COW8ZJU5te84GUsUmYCUxsX0VI4gt
        LBAi8ap/NwuILSKgIHGr+QU7SAMzyL5lz8+xgiR4BewkDr3aDWazCKhIXG+dAbZaVCBC4tOD
        w1A1ghInZz4BG8QpYCFx7O0dsAXMAuISt57MZ4Kw5SWat84Ge0hCYBO7ROOUs2wQd7tIvDvx
        iwnCFpZ4dXwLO4QtI3F6cg8LRMM6Rom/HS+gurczSiyf/A+q21rizrlfQDYH0ApNifW79CHC
        jhKPDswGC0sI8EnceCsIcQSfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyXzBEalWUhem4Xk
        nVlI3pmFsHcBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwNRz+t/xTzsYv15KOsQo
        wMGoxMMbwBwbJ8SaWFZcmXuIUYKDWUmE15czOk6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gi
        l7FCAumJJanZqakFqUUwWSYOTqkGRh17ljmVNv/N3FT++/E/uDOH2dPE1XTCNKXFJ0LzXi3L
        3Mt7oXPj2xuXXxkk+SRzXj767b7A0qC2gKlh12vKDTXf351z8Nj96ZtYpinNOPJ488TQ0qe/
        uIWvWDk82hKTvoU9p98kaYVfR13AaUbRvewno4Oad77qzLDrkDEP38CTvU/LYImjhxJLcUai
        oRZzUXEiAHyOV4U5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7oRmrFxBrsXsFh8aGpltrjy9T2b
        xYm+D6wWl3fNYbO49u4Mm8WchWwWCx/dYHNg92g58pbVo+dNC6vH/e7jTB6fN8kFsETp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSz684etYApv
        xYm1N5gbGO9zdTFyckgImEi0r7/E0sXIxSEksJRR4tTVBUAOB1BCRuL4+jKIGmGJP9e62CBq
        XjNKfPz5mg0kwSZgJTGxfRUjiC0sECLxqn83C4gtIqAgcav5BTtIA7PACkaJFysus0N072SU
        mLvoJTtIFa+AncShV7tZQWwWARWJ660zmEBsUYEIicM7ZjFC1AhKnJz5BGwqp4CFxLG3d8Di
        zALqEn/mXWKGsMUlbj2ZzwRhy0s0b53NPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9Nxi
        I73ixNzi0rx0veT83E2MwFjbduznlh2MXe+CDzEKcDAq8fD+YIiNE2JNLCuuzD3EKMHBrCTC
        68sZHSfEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cA0kFcSb2hqaG5haWhubG5sZqEkztsh
        cDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTEv5lk0z3mv8MKvEc0aT8+mXdyepJ59dHmnelKvjoTJ
        w9BPxfpzYoK3qMhWvon6d7FRRO6f1utXXEc0t7w+/T1yf2zT5pBLdyp7HzyVWXRhY8OFDq5u
        1puZge9sN/+WWvBSs1hPhCN92bXe7GIri4g9QtbnzV5M2iekveiEQ++alsk9R59mZSixFGck
        GmoxFxUnAgAQyRogywIAAA==
X-CMS-MailID: 20200302154216eucas1p1bd4c6c0450617d11ffc3136a86f9cbbe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200119121831eucas1p2da620aa87a0fdcc73e6a9db46a3e8243
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200119121831eucas1p2da620aa87a0fdcc73e6a9db46a3e8243
References: <20200119121730.10701-1-yukuai3@huawei.com>
        <CGME20200119121831eucas1p2da620aa87a0fdcc73e6a9db46a3e8243@eucas1p2.samsung.com>
        <20200119121730.10701-2-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/20 1:17 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/aty/radeon_base.c: In function
> ‘radeonfb_set_par’:
> drivers/video/fbdev/aty/radeon_base.c:1653:6: warning: variable
> ‘hSyncPol’ set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Patch queued for v5.7, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/aty/radeon_base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 3af00e3b965e..d2e68ec580c2 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -1650,7 +1650,7 @@ static int radeonfb_set_par(struct fb_info *info)
>  	struct fb_var_screeninfo *mode = &info->var;
>  	struct radeon_regs *newmode;
>  	int hTotal, vTotal, hSyncStart, hSyncEnd,
> -	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
> +	    vSyncStart, vSyncEnd, vSyncPol, cSync;
>  	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
>  	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
>  	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
> @@ -1730,7 +1730,6 @@ static int radeonfb_set_par(struct fb_info *info)
>  	else if (vsync_wid > 0x1f)	/* max */
>  		vsync_wid = 0x1f;
>  
> -	hSyncPol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
>  	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
>  
>  	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
> 
