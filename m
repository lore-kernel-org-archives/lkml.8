Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE3CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D43D217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DZ0Bp9uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCBPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55708 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCBPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:23 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154222euoutp01e0dc0bbcdaeaeaed148991dc23710062~4hwkehrnd1457214572euoutp01G
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302154222euoutp01e0dc0bbcdaeaeaed148991dc23710062~4hwkehrnd1457214572euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163742;
        bh=zjq+EojuhlvuQQNKL6xXqt/j5WgolxzxcUM9XKMd1Hg=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=DZ0Bp9uW+VZqRaztWrHVeRzkUrcM5NHXKtAyNGDb7bf2YJQNVx3j+Bb8y78RORtDX
         MNluOZv9SgAz3RvODzZTaYd0qX3iuikEZ539LabVvtbvYzOB/ZDG+xzTCD8LJb+Oz0
         fhPlT9x4ZkfsbBnat4cMNKQH+02QlQSha4Dmxheg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302154221eucas1p16265e859fb75abb478f8fc388de00a6b~4hwkEe89F1685916859eucas1p1L;
        Mon,  2 Mar 2020 15:42:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.10.60679.D592D5E5; Mon,  2
        Mar 2020 15:42:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154221eucas1p2f32849cc5382209002f735d337ae7878~4hwjmoMck1937719377eucas1p2N;
        Mon,  2 Mar 2020 15:42:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154221eusmtrp1f1520591edeee3b1223016e839a5191e~4hwjmGuwg2862728627eusmtrp1i;
        Mon,  2 Mar 2020 15:42:21 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-04-5e5d295db593
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.FF.07950.D592D5E5; Mon,  2
        Mar 2020 15:42:21 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154220eusmtip25f8537a5f58c70209d5871cb0672a474~4hwjQ1cO42192821928eusmtip2J;
        Mon,  2 Mar 2020 15:42:20 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/4] video: fbdev: remove set but not used variable
 'vSyncPol'
To:     yu kuai <yukuai3@huawei.com>
Cc:     benh@kernel.crashing.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com
Message-ID: <b86b787d-c368-9e1f-d302-1ec0a7af34d1@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200119121730.10701-3-yukuai3@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87qxmrFxBtt7dS0+NLUyW1z5+p7N
        4kTfB1aLy7vmsFlce3eGzWLOQjaLhY9usDmwe7Qcecvq0fOmhdXjfvdxJo/Pm+QCWKK4bFJS
        czLLUov07RK4Mn4cFiv4wlMx4cVOxgbGI1xdjJwcEgImEltOXGfrYuTiEBJYwSixpuUXC4Tz
        hVFi7e9Z7CBVQgKfGSVuXPeB6dhw4zQjRNFyRolVd1cyQzhvGSU6X/1mBaliE7CSmNi+ihHE
        FhYIkbj9/ynYJBEBBYlbzS/YQRqYQfYte34OrIFXwE5i8qFNYA0sAioSy08vZAKxRQUiJD49
        OAxVIyhxcuYTFhCbU8BCYlrfDDCbWUBc4taT+UwQtrxE89bZzBCnrmOXOPJDvouRA8h2kTgw
        rRIiLCzx6vgWdghbRuL05B6wl4HKGSX+drxghnC2M0osn/yPDaLKWuLOuV9sIIOYBTQl1u/S
        hwg7Slzb28AIMZ9P4sZbQYgT+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tgs
        JM/MQvLMLIS9CxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmndP/jn/ZwbjrT9Ih
        RgEORiUe3gDm2Dgh1sSy4srcQ4wSHMxKIry+nNFxQrwpiZVVqUX58UWlOanFhxilOViUxHmN
        F72MFRJITyxJzU5NLUgtgskycXBKNTDGmgrbnj29/FmwVrqAYPnWH00pM68vnK+wQCjpSEvT
        lYrDs4J3ito5hJTI/ljxW3Pjiucaf8XTixK69rtKesz82c+grNSoz9FfP7Ek9J/0Od+N/Qc+
        q3bu9agRZYn6N5257MW7V4+2Wp6QSnnbs/Sfn8j88OZ7BhU1umYL3diuB7llfVycYK/EUpyR
        aKjFXFScCAAmYBLWNgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7qxmrFxBvd+CVh8aGpltrjy9T2b
        xYm+D6wWl3fNYbO49u4Mm8WchWwWCx/dYHNg92g58pbVo+dNC6vH/e7jTB6fN8kFsETp2RTl
        l5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfw4LFbwhadi
        woudjA2MR7i6GDk5JARMJDbcOM3YxcjFISSwlFFiy8lV7F2MHEAJGYnj68sgaoQl/lzrYoOo
        ec0oMfvPHEaQBJuAlcTE9lVgtrBAiMTt/0/ZQWwRAQWJW80v2EEamAVWMEq8WHEZLCEksJNR
        4tombRCbV8BOYvKhTWDNLAIqEstPL2QCsUUFIiQO75jFCFEjKHFy5hMWEJtTwEJiWt8MMJtZ
        QF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yk
        V5yYW1yal66XnJ+7iREYZ9uO/dyyg7HrXfAhRgEORiUe3h8MsXFCrIllxZW5hxglOJiVRHh9
        OaPjhHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmALySuINTQ3NLSwNzY3Njc0slMR5OwQO
        xggJpCeWpGanphakFsH0MXFwSjUw6k2rkFN7tvbrbs7Lm9herviubH7ey7RI8qvP5x+bxJYv
        l1C9Hft9X7Jqw9n/zls6hVyuT3hu52v/k+1sa7q4yb9l094Ir3RcevxSSS7DtaBVXxLdT9sm
        xt+XYr6grTgtqjySxf3DiceprX4znVfPss+84Xdl160o+zL9s+KNeqGKyd8571vNUWIpzkg0
        1GIuKk4EALY7g0rJAgAA
X-CMS-MailID: 20200302154221eucas1p2f32849cc5382209002f735d337ae7878
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200119121831eucas1p1fd9ac9ab84b96d75545e63150c8f8e02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200119121831eucas1p1fd9ac9ab84b96d75545e63150c8f8e02
References: <20200119121730.10701-1-yukuai3@huawei.com>
        <CGME20200119121831eucas1p1fd9ac9ab84b96d75545e63150c8f8e02@eucas1p1.samsung.com>
        <20200119121730.10701-3-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/20 1:17 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/aty/radeon_base.c: In function
> ‘radeonfb_set_par’:
> drivers/video/fbdev/aty/radeon_base.c:1653:38: warning: variable
> ‘vSyncPol’ set but not used [-Wunused-but-set-variable]
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
>  drivers/video/fbdev/aty/radeon_base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index d2e68ec580c2..0666f848bf70 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -1650,7 +1650,7 @@ static int radeonfb_set_par(struct fb_info *info)
>  	struct fb_var_screeninfo *mode = &info->var;
>  	struct radeon_regs *newmode;
>  	int hTotal, vTotal, hSyncStart, hSyncEnd,
> -	    vSyncStart, vSyncEnd, vSyncPol, cSync;
> +	    vSyncStart, vSyncEnd, cSync;
>  	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
>  	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
>  	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
> @@ -1730,8 +1730,6 @@ static int radeonfb_set_par(struct fb_info *info)
>  	else if (vsync_wid > 0x1f)	/* max */
>  		vsync_wid = 0x1f;
>  
> -	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
> -
>  	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
>  
>  	format = radeon_get_dstbpp(depth);
> 
