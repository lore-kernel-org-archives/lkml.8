Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6620AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3781A24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNK7Q4Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUJEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:04:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59959 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:04:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200121090452euoutp02de15a580a4a3c88ac4934f072f1d9a20~r24zlGvqp0281302813euoutp02T
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:04:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200121090452euoutp02de15a580a4a3c88ac4934f072f1d9a20~r24zlGvqp0281302813euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579597492;
        bh=ceIWUcRTC3WbPS2ZAn6jS028UDFnxpbxzFO6J2f0dt0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vNK7Q4Z+t44twjN2sg21tAfoeUbQWb+NLBFoOAd04sJM733qg6OiwGQOF8e26UrZV
         peSwCqibPeMhC68qjKdelPQNZKBYBJAPCiAlhm6+3lhua8LKuf7C333/4TG3o5TdwP
         Wv9JGfEeviSiAGiy8+Q3MhLnpbkHuEQOHfl7yNm0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200121090451eucas1p145b6d099fbc7ebb9a0bb1e883d5ea16c~r24zFx7Kt1929019290eucas1p1_;
        Tue, 21 Jan 2020 09:04:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 09.04.60698.3BEB62E5; Tue, 21
        Jan 2020 09:04:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200121090451eucas1p1969908f90e0b96d36ffebeeb66130550~r24yq8Mso2047920479eucas1p1o;
        Tue, 21 Jan 2020 09:04:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200121090451eusmtrp1ea79911e616a2f1d6fb2516120c48915~r24yqEVW_2107521075eusmtrp1W;
        Tue, 21 Jan 2020 09:04:51 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-2f-5e26beb31b2a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.25.07950.3BEB62E5; Tue, 21
        Jan 2020 09:04:51 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200121090450eusmtip208148c50eefbb7f28d109cee6aa95206~r24x0cGzj1135211352eusmtip2E;
        Tue, 21 Jan 2020 09:04:50 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] drm: bridge: adv7511: Add support for ADV7535
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, sam@ravnborg.org, alexander.deucher@amd.com,
        matt.redfearn@thinci.com, robdclark@chromium.org,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <7079d373-0a76-7071-50de-13ed828a4d97@samsung.com>
Date:   Tue, 21 Jan 2020 10:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121082719.27972-3-bogdan.togorean@analog.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTURzlvvv29jSXr2XuRx9Eg4KCrNDgRhIGUU8i6Jso+lj5UHFq7LXK
        IFzZyixHtdLSMsuFQxS/muUsSynNVivNTQvDUKm01CSnLbJye0b+d875nd/HuVwWK7OYmWx8
        0iFBl6TRqplAuqrB+2pxZe2CPUvPW1aQTGcTRbI6amTkpPEyJn+qLmLS6hlkSFpBKUNco72Y
        NH110eTsRYucvLFfZ8idtmaK2DvzKVJv2kXc3m5MjA+fyInVa0OksuIKJibnuiglb2wZY/g+
        12q+OK8Y8YPtRjmfa2im+Ycj+TSfm35NxlcUnWX4ZxdaKH7A6ZTz90Y+yPhHN4rlfOe5Roq3
        ZLkY/uOtUpp/nGmmNyp3BkbGCNr4w4Juyap9gXEZD1IOllNH7e96sQH9RBkogAUuAqxuM5WB
        AlklZ0Xg9tZNkGEEBe/PTJDvCEZG08cJ628500BLeiECx/Oncon0I/AayuW+udO5aLC4yxkf
        DuG2gGfI7O/AnAnDcMkJ7Csw3EIYq3zrNym4VfDbVCbzYZqbDw5nF+XDM7gd0NPaLZM806Dp
        Wg/twwFcFIx9fuEPgbm5kGbLxRJWwbuem/6zgXvNQo2jgZaSroGXb34wEp4OfY135RKeDQ7z
        +QlPKnRaT2GpOR2BrawaS4WV0OH8yfjy4/GrS+1LJHk11JVVyKRnmQrt/dOkG6bCpapsLMkK
        SD+tlNzzoPOlbWKgCu689jAXkDpnUrKcSWlyJqXJ+b83H9FFSCXoxcRYQQxPEo6EiZpEUZ8U
        G3YgObECjf9Wx+9Gz31U+2t/PeJYpA5SRGXN36OUaQ6LKYn1CFisDlHknxyXFDGalGOCLnmv
        Tq8VxHo0i6XVKkX47d7dSi5Wc0hIEISDgu5flWIDZhrQzm1TCvKuJkeGjdbmPf0odi9ANv2O
        byUDlxOCWuM9VERjnzF06YbukfXZVTXJm9Z+Lr7iae0aiiuMtdhCQ+ra3Is6ml1zow/oNwex
        wWbz9YTwoC+berWFaTr7cHYcNpi0j4dSrc+On1Md+R6a19Xv2PopZXtwxvLCP3O+fqq+bQ1W
        02KcZtkirBM1fwHJcjYqqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xe7qb96nFGXz6JmvRe+4kk8W0O7tZ
        LZpapzBb/N82kdniytf3bBbNi9ezWVz9/pLZ4uSbqywWnROXsFtc3jWHzWLp9YtMFrvuL2Cy
        ONQXbXHt52Nmi9a9R9gtVvzcymixedNUZou+c+4OQh6tl/6yeby66uixZt4aRo/3N1rZPWY3
        XGTx2PttAYvH7I6ZrB6bVnWyeZyYcInJ4925c+we2789YPXYP3cNu8f97uNMHkumXWXzeLZw
        PYvHgd7JLAFCUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWp
        Rfp2CXoZXXsqCzYyVey69ZK5gfEXYxcjB4eEgIlE+zGWLkYuDiGBpYwSd9b/ZO5i5ASKi0vs
        nv8WyhaW+HOtiw2i6DWjxP+FB9lBEsICnhJLrm1kA7FFBIIlPv69ARZnFuhjljj7SxWi4SSj
        xLO+/UwgCTYBTYm/m2+CNfAK2En869vACmKzCKhKnD73CKxGVCBC4u3vm6wQNYISJ2c+YQGx
        OQUcJP6+OMMIsUBd4s+8S8wQtrxE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUo
        klpanJueW2ykV5yYW1yal66XnJ+7iRGYSrYd+7llB2PXu+BDjAIcjEo8vA7TVOOEWBPLiitz
        DzFKcDArifAuaAIK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wzeWVxBuaGppbWBqaG5sb
        m1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBUK/oQMUVox+QTIkWOnMm3vYI8f/n/2faW
        ravMdf6VjeYv/my9tsNs2eGdTD9kXp4/FxnesMVxT5va051y7Vqz35ytTty4YJFd30KD0Puv
        vdnW2UubutsxPirkXvNSVvqUwoseAW3OB5t7Pr09vn7D0zNun8QFm5tVH3Su8439fWCy5ca7
        2ra1SizFGYmGWsxFxYkAdjyGjDsDAAA=
X-CMS-MailID: 20200121090451eucas1p1969908f90e0b96d36ffebeeb66130550
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121084119eucas1p10ef66cb65ac2a11b1f9da6eba49ee168
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121084119eucas1p10ef66cb65ac2a11b1f9da6eba49ee168
References: <20200121082719.27972-1-bogdan.togorean@analog.com>
        <CGME20200121084119eucas1p10ef66cb65ac2a11b1f9da6eba49ee168@eucas1p1.samsung.com>
        <20200121082719.27972-3-bogdan.togorean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 09:27, Bogdan Togorean wrote:
> ADV7535 is a DSI to HDMI bridge chip like ADV7533 but it allows
> 1080p@60Hz. v1p2 is fixed to 1.8V on ADV7535.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

