Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278E0C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8A3217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VJuV14bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCBPlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:41:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55512 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCBPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:41:50 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302154149euoutp01a3160e874e39c184f3615ad45f6efc63~4hwGRrvmw1219112191euoutp01R
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 15:41:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302154149euoutp01a3160e874e39c184f3615ad45f6efc63~4hwGRrvmw1219112191euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583163709;
        bh=4axK78g/nrDsBa+2KEV1lk3bOVjQm/EHI8h3F1+etvY=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=VJuV14bqSo0kLYPCxQFpI7FUc1rShpdbkfrbPxh/WbM04kX6jATaD2K95aLmB+bhL
         z1Y6E7pBRStc7YDHHun2deueDmrIvMeppejsgHyiJt+Bd30uIRpZHkvyCiH2mqxBd2
         0+n5uTFUMQpVZ2elSB2m/BfKku0mePXLeLJ4+ZWM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302154149eucas1p11a8529e523c802e7ca76dad12fd30d89~4hwF_x2dS1686416864eucas1p1o;
        Mon,  2 Mar 2020 15:41:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 31.B3.60698.D392D5E5; Mon,  2
        Mar 2020 15:41:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154149eucas1p2ef15ea86f8183f5d7985cb158ef23831~4hwFpEuM72401024010eucas1p2g;
        Mon,  2 Mar 2020 15:41:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302154149eusmtrp16fb691095183e81e4f4de56f47bf4e4c~4hwFojvFV2862728627eusmtrp1W;
        Mon,  2 Mar 2020 15:41:49 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-00-5e5d293d668b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.00.08375.C392D5E5; Mon,  2
        Mar 2020 15:41:49 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302154148eusmtip29e3f309216e3f495ce9d913856ad2ff5~4hwFUDpsp2174521745eusmtip2V;
        Mon,  2 Mar 2020 15:41:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] video: fbdev: arcfb: add COMPILE_TEST support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <cb48242a-1125-ab99-2c94-6ea6037d9ac4@samsung.com>
Date:   Mon, 2 Mar 2020 16:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200117185722.GA24508@ravnborg.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87q2mrFxBtt2yFlc+fqezeJE3wdW
        i8u75rBZrPi5ldGBxeN+93EmjyXTrrJ5fN4kF8AcxWWTkpqTWZZapG+XwJXxp3sLY8Fp5opn
        06YyNzD+Z+pi5OCQEDCRmLvEuYuRi0NIYAWjxJIvp9ghnC+MEjsvL2KBcD4zSjQ83cLaxcgJ
        1nHo61ImiMRyoJbnDWwQzltGibsvHrOBVLEJWElMbF/FCGILCzhJXF/YxgRiiwgoSxw/fw1s
        ErNAgsSXm5+ZQWxeATuJM/9WgfWyCKhIrDvZC1YvKhAh8enBYVaIGkGJkzOfsIDYnAJGEtOm
        PGCGmCMucevJfCYIW15i+9s5zBCXdrNLLHsvBWG7SHT13WaEsIUlXh3fwg5hy0icntwD9qaE
        wDpGib8dL5ghnO2MEssn/2ODqLKWuHPuFxsoxJgFNCXW79KHCDtKTLy6CBqQfBI33gpC3MAn
        MWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLPZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3
        PbXYOC+1XK84Mbe4NC9dLzk/dxMjMKGc/nf86w7GfX+SDjEKcDAq8fAGMMfGCbEmlhVX5h5i
        lOBgVhLh9eWMjhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomD
        U6qBsanfsGXuRuuNr26+T/arKwu0Sbr6Y0b9EQszXi9Hj5Pf5/vqZjivOvQ0W6/2iHQyG++6
        lx++rI98eqP1tH/6Vm9WtQnpnWtjFf2WbJx3Z8K/WS51ya7/0ljm/pjl+un9eh7+jtqLW82M
        9rk2tl+dpbJ2lt2ccAOPu7YzNBKer+YK4Fikor/IVomlOCPRUIu5qDgRAC6uY2okAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7q2mrFxBs+uMFlc+fqezeJE3wdW
        i8u75rBZrPi5ldGBxeN+93EmjyXTrrJ5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxp3sLY8Fp5opn06YyNzD+Z+pi5OSQEDCROPR1
        KZDNxSEksJRR4nrrDJYuRg6ghIzE8fVlEDXCEn+udbFB1LxmlOjt3MYKkmATsJKY2L6KEcQW
        FnCSuL6wDWyoiICyxPHz18BqmAUSJDbdn8oGYgsJ7GKU2L/REcTmFbCTOPNvFVicRUBFYt3J
        XrBeUYEIicM7ZjFC1AhKnJz5hAXE5hQwkpg25QEzxEx1iT/zLkHZ4hK3nsxngrDlJba/ncM8
        gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzACNp27OfmHYyX
        NgYfYhTgYFTi4Q1gjo0TYk0sK67MPcQowcGsJMLryxkdJ8SbklhZlVqUH19UmpNafIjRFOi5
        icxSosn5wOjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAKCZ8
        1PVyDodU6O/Gb29quqf86yq78bSLT/qkl3xs2pZtRbxS66snmfvv5mC5GjCTaZdzzA0+oSln
        Nfu+R3Km256pmcEeHizLw3DTrLLB6tXUaWJv2Sd9ZFGasFnj9OEoBpGj6x5vqWuPPxW0uciR
        63pw0roznFWsiRbm0lFTrjukP607oLJYiaU4I9FQi7moOBEAV6Xp0bYCAAA=
X-CMS-MailID: 20200302154149eucas1p2ef15ea86f8183f5d7985cb158ef23831
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200116144909eucas1p1b247368aded82dad3ca8da852deaca1a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200116144909eucas1p1b247368aded82dad3ca8da852deaca1a
References: <CGME20200116144909eucas1p1b247368aded82dad3ca8da852deaca1a@eucas1p1.samsung.com>
        <acf2cc2e-614d-f0fb-ce40-cee62bfcde4c@samsung.com>
        <20200117185722.GA24508@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/17/20 7:57 PM, Sam Ravnborg wrote:
> On Thu, Jan 16, 2020 at 03:49:07PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> Add COMPILE_TEST support to arcfb driver for better compile
>> testing coverage.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks, patch queued for v5.7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
