Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8AEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778821D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PL5ZisVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCBPm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:42:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47181 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:42:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154257euoutp02976c8cbb8c02f340f73efeab567e1e99~4hxFlJCXa1381413814euoutp02e
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:42:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302154257euoutp02976c8cbb8c02f340f73efeab567e1e99~4hxFlJCXa1381413814euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163777;
        bh=UAjKjwooQuhfVtx7iJnUdeI/FwvSg2aaFjTHolZDwT8=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=PL5ZisVSqia940111G4Y98T3gr7pYI/dNMov/GgZ6O9pYTcyYR07xhQKp8g/qhwJ1
         0PI5GMFZMnxwpUtdqhDMBbfQMxE+o2UUz74si4f6F5ENpzjk1MSvL7SjakvG+Xqu9C
         EasXwamjGxPkhhyyj+3MQ18azTlTnsaNR+xUJWb4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302154257eucas1p1a62a2c348deed71d59a025acf0b1ce8a~4hxFRzsb11688016880eucas1p1c;
        Mon,  2 Mar 2020 15:42:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.D3.60698.1892D5E5; Mon,  2
        Mar 2020 15:42:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154256eucas1p1779718103e02d390c115d7c796327a7d~4hxEz8jDz1686416864eucas1p1w;
        Mon,  2 Mar 2020 15:42:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154256eusmtrp1f5907de4ed567dad8164c98f1eb07a1e~4hxEzYXXv2922329223eusmtrp1J;
        Mon,  2 Mar 2020 15:42:56 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c9-5e5d2981575b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3F.20.08375.0892D5E5; Mon,  2
        Mar 2020 15:42:56 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302154256eusmtip17e43339619c3a62f8c4fa9c3cd9962ed~4hxEfuxHR2125721257eusmtip1A;
        Mon,  2 Mar 2020 15:42:56 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: radeon: Remove dead code
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     benh@kernel.crashing.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <4777c389-1e30-f856-f765-0ecfefe0b6a0@samsung.com>
Date:   Mon, 2 Mar 2020 16:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1582042556-21555-1-git-send-email-jrdr.linux@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7qNmrFxBlPOi1l8aGpltrjy9T2b
        xbWrDcwWJ/o+sFpc3jWHzYHVY+esu+wePW9aWD3udx9n8vi8SS6AJYrLJiU1J7MstUjfLoEr
        Y8vnRYwFPbwVJ47KNTAu4epi5OCQEDCRePSgtouRi0NIYAWjxJzbf5kgnC+MEl+bN7J0MXIC
        OZ8ZJb5MLAOxQRpWH7nKCFG0nFHi5dQPbBDOW0aJewdfs4FUsQlYSUxsX8UIYgsLWEvM+DWV
        HcQWEdCWmHv4FzOIzSxQJXH98x+wel4BO4nLsx+AxVkEVCS2zn/ECmKLCkRIfHpwmBWiRlDi
        5MwnYBdxCrhK/Pp0jg1ijrjErSfzmSBseYntb+cwgxwkITCPXeLHjz1MEGe7SDRefcwGYQtL
        vDq+hR3ClpE4PbmHBaJhHaPE344XUN3bGSWWT/4H1WEtcefcLzZQiDELaEqs36UPEXaU6PnU
        zwoJSD6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq5knsCoNAvJa7OQvDMLyTuz
        EPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhiTv87/nUH474/SYcYBTgYlXh4
        A5hj44RYE8uKK3MPMUpwMCuJ8PpyRscJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9
        sSQ1OzW1ILUIJsvEwSnVwFiiO8VHXih0WZ3X3ietusd7b+49JZ588PHLE6/Vn69ojxNettMp
        a0XEzKdbuZ/YOD7/qXjV4nzekdJePTnfMzd7vvV/ZLlypsMolbtfcY1kNuPt3AMaF72SHPSn
        NrTfcXj69G3TmgW14aUpbvcc65ftOtPqqrL5eVl5aQj/n8+bZk9dcHCFjKASS3FGoqEWc1Fx
        IgAjjWkYLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7oNmrFxBm9fWFh8aGpltrjy9T2b
        xbWrDcwWJ/o+sFpc3jWHzYHVY+esu+wePW9aWD3udx9n8vi8SS6AJUrPpii/tCRVISO/uMRW
        KdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY8vnRYwFPbwVJ47KNTAu4epi
        5OSQEDCRWH3kKmMXIxeHkMBSRol359vYuxg5gBIyEsfXl0HUCEv8udbFBlHzmlHiUO96VpAE
        m4CVxMT2VYwgtrCAtcSMX1PZQWwRAW2JuYd/MYPYzAJVEl1Pb7FDNM9glFh98ilYM6+AncTl
        2Q/AilgEVCS2zn8EFhcViJA4vGMWI0SNoMTJmU9YQGxOAVeJX5/OsUEMVZf4M+8S1AJxiVtP
        5jNB2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4m
        RmBUbTv2c/MOxksbgw8xCnAwKvHwBjDHxgmxJpYVV+YeYpTgYFYS4fXljI4T4k1JrKxKLcqP
        LyrNSS0+xGgK9NxEZinR5HxgxOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgt
        gulj4uCUamBUuFcyO7U+pOt+lYCPX7FdplzjL/llS2zyyz7u+5XS+dyDSyVz9amWC82cpj/O
        5QgbhTO1XKtuWPu7sGulzNtpekoqvdO/H/gxMXd3wNp7iiLzzq/sU+7UvMTxh2eBnUJovROX
        ptGH727a3ySyfLM6Vuy4UaK9/UdL0HqlCrlvP5wKVJbatSixFGckGmoxFxUnAgCp/A7gwAIA
        AA==
X-CMS-MailID: 20200302154256eucas1p1779718103e02d390c115d7c796327a7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200218160846eucas1p238fa498fc5fc35f4865f0920c5f7c76f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200218160846eucas1p238fa498fc5fc35f4865f0920c5f7c76f
References: <CGME20200218160846eucas1p238fa498fc5fc35f4865f0920c5f7c76f@eucas1p2.samsung.com>
        <1582042556-21555-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/20 5:15 PM, Souptick Joarder wrote:
> This is dead code since 3.15 and can be removed if not
> going to be useful further.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Patch queued for v5.7, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/aty/radeon_base.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 3af00e3..ccf888e 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -849,12 +849,6 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
>  		case 9 ... 16:
>  			v.bits_per_pixel = 16;
>  			break;
> -		case 17 ... 24:
> -#if 0 /* Doesn't seem to work */
> -			v.bits_per_pixel = 24;
> -			break;
> -#endif			
> -			return -EINVAL;
>  		case 25 ... 32:
>  			v.bits_per_pixel = 32;
>  			break;
> @@ -2548,16 +2542,6 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
>  	if (rinfo->mon2_EDID)
>  		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
>  
> -#if 0
> -	/* restore original state
> -	 * 
> -	 * Doesn't quite work yet, I suspect if we come from a legacy
> -	 * VGA mode (or worse, text mode), we need to do some VGA black
> -	 * magic here that I know nothing about. --BenH
> -	 */
> -        radeon_write_mode (rinfo, &rinfo->init_state, 1);
> - #endif
> -
>  	del_timer_sync(&rinfo->lvds_timer);
>  	arch_phys_wc_del(rinfo->wc_cookie);
>          unregister_framebuffer(info);
> 
