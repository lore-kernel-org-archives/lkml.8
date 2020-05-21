Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A8F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="laAjjfYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgEUORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:17:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62270 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgEUORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:17:37 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200521141733epoutp046b6dc1b5c8e9e4d0cc2bccf317f81202~RENW29Gx52334723347epoutp04C
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:17:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200521141733epoutp046b6dc1b5c8e9e4d0cc2bccf317f81202~RENW29Gx52334723347epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590070653;
        bh=yaoOLNL/YwnMgUGKxYrh4eIUsX8d53qGNJ5vpxP3jDg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=laAjjfYjT+Fl7JL9KEbQGkSuVgsDBtfsW3TjofdC8xxuHghczHhVhHEC3lF9xg2iL
         bhBQFrdleGbJXNchbhwaPOLDnOEVBd5t+/7UfTjugChEpzBT/i8aqOIMF0uTX5YOXm
         jw3VFfGKm2X5K7cbWjuLFG6xPNtCCL1KclPUVLeM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200521141733epcas5p29db77a3345a33b9bfef5a9b128af6022~RENWbjCbd3018830188epcas5p2q;
        Thu, 21 May 2020 14:17:33 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.80.23389.C7D86CE5; Thu, 21 May 2020 23:17:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200521141731epcas5p3970e37a1b1b1986b75814de104e4a857~RENVbBznh1164911649epcas5p38;
        Thu, 21 May 2020 14:17:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200521141731epsmtrp1b904e2decbc2efb1412f81159a003615~RENVZ1AuM1587215872epsmtrp1b;
        Thu, 21 May 2020 14:17:31 +0000 (GMT)
X-AuditID: b6c32a4b-797ff70000005b5d-6a-5ec68d7c6ce6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.BB.18461.B7D86CE5; Thu, 21 May 2020 23:17:31 +0900 (KST)
Received: from mshams01 (unknown [107.122.43.244]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200521141728epsmtip2175afe050debcb26c6df5c9eee7767df~RENR51xpw0089300893epsmtip2d;
        Thu, 21 May 2020 14:17:27 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Inki Dae'" <inki.dae@samsung.com>, <jy0922.shim@samsung.com>,
        <sw0312.kim@samsung.com>, <kyungmin.park@samsung.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
Cc:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shaik.ameer@samsung.com>,
        <krzk@kernel.org>, <alim.akhtar@samsung.com>
In-Reply-To: <fa372f07-abba-a296-c315-e9769fb43623@samsung.com>
Subject: RE: [PATCH v2] drm/exynos: Remove dev_err() on platform_get_irq()
 failure
Date:   Thu, 21 May 2020 19:47:25 +0530
Message-ID: <000001d62f7a$90a004d0$b1e00e70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH7RT4aJkRNX9fY1F1/HBHlZPyRGwGjzbRFAXV3RIKoT5+4wA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7bCmlm5t77E4g09iFr3nTjJZPJi3jc3i
        /7aJzBZXvr5ns5h0fwKLxYt7F1kszp/fwG5xtukNu8Wmx9dYLS7vmsNmMeP8PiaLIw93s1vM
        mPySzYHXY++3BSwem1Z1snls//aA1eN+93Emj81L6j36tqxi9Pi8SS6APYrLJiU1J7MstUjf
        LoErY8XhXsaC7ewVG5YvZmlgXMLWxcjBISFgInF+p1wXIxeHkMBuRonbM9+yQzifGCWm971h
        hXC+MUo8mvKYuYuRE6zj25lfbBCJvYwSTZ82QFU9Z5S4sPYrC0gVm4CuxKSDbcwgCRGBJYwS
        f9f+YAJxmAUeMkp0rJwLNotTwF7i0v57rCC2sECIRMu3D2BxFgFViavXF4FdyCtgKXGvIQYk
        zCsgKHFy5hOwBcwC2hLLFr6GOklB4ufTZWBjRAScJG49fM8MUSMu8fLoEbCHJASucEhMn/mB
        FaLBRWL+rD4WCFtY4tXxLewQtpTEy/42KDtfYv68VVALKiRWXngDZdtLHLgyhwXkNmYBTYn1
        u/QhdvFJ9P5+wgQJVF6JjjYhiGpFif+7+6Emiku8WzEF6gIPia+3l7FNYFScheSzWUg+m4Xk
        g1kIyxYwsqxilEwtKM5NTy02LTDOSy3XK07MLS7NS9dLzs/dxAhOalreOxgfPfigd4iRiYPx
        EKMEB7OSCO9C/qNxQrwpiZVVqUX58UWlOanFhxilOViUxHkfN26JExJITyxJzU5NLUgtgsky
        cXBKNTBtVVlo80OHYYrT1+gpbc9frP6kldQgIaRddzg+eeefg72VLxdWxQZr8dlx6zwXv6r0
        +cqLmEJbm0Va017UhHiyXOZV7e9o8i3gTS6exfHk3iXnn79lPkj5TQx8fUNwx5qK93HzXnQG
        zU848/GPyMEC25QO1p/B6/dE2VWfyufWKTrgf+RSm/Gt8zPuOBdb2tuXegTUbGEvkilcPTti
        zW1Jgd23Ik7lbGn8qtV7mZmV59wtV+63G1YEakx4xvS17Xpm84aCRQ5sL6oD0v1cNjZpmet+
        2KVy+k+UZlLzlr0zNe7uCZM3d2Uwc7tzS6uoQJ412f3pxZQ53Tf+b2M1OC9+uvtYqv21aees
        E5QmByqxFGckGmoxFxUnAgCSFEUL2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvG5177E4g+cTjS16z51ksngwbxub
        xf9tE5ktrnx9z2Yx6f4EFosX9y6yWJw/v4Hd4mzTG3aLTY+vsVpc3jWHzWLG+X1MFkce7ma3
        mDH5JZsDr8febwtYPDat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAHsUl01Kak5mWWqR
        vl0CV8a3G8+YCiawV3w7sIGpgfE/axcjJ4eEgInEtzO/2LoYuTiEBHYzSuz5epodIiEuMe3X
        fkYIW1hi5b/n7BBFTxkl7i7bzAySYBPQlZh0sI0ZJCEisIpR4mznfTCHWeA5o0T/jnksEC17
        GSV6Xh9kA2nhFLCXuLT/HthyYYEgiWVP5jCB2CwCqhJXry8CquHg4BWwlLjXEAMS5hUQlDg5
        8wkLiM0soC3x9OZTOHvZwtfMEOcpSPx8ugxspIiAk8Sth++ZIWrEJV4ePcI+gVF4FpJRs5CM
        moVk1CwkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHqJbmDsbtqz7oHWJk
        4mA8xCjBwawkwruQ/2icEG9KYmVValF+fFFpTmrxIUZpDhYlcd4bhQvjhATSE0tSs1NTC1KL
        YLJMHJxSDUz5enWazDe0vookt/+JKVec/rMxReXYVFl2/qri9y0C1asNGe42ZkyIe7Ho5ASr
        VdMvuqsLhL2V2h/7VOOH/Llme5M/D2PrjX1vlwk68N/p+lyzIqD6ok3C/6glOdI7L7zmLCvb
        KH/3mt+DmrpmIb8f37Rz79+3L26I1Z1fkuZx6YPQndwYBv1PU5O2bdky+WyIOAfvj9TAaZKz
        tJ5lylVJfPjlGbfZT++Vm9nURfcYhW2amRgk7sutVSit0Z7ou+hfh4J7QeokpQuL5nzlaJnw
        XcHP3XdHTV33kwe7Hx8+Z+H32Me5fk62b3iF6P/J62ZfEJ0ULH6ghWOhUaIi3w2fxi/+060X
        e06++10tTomlOCPRUIu5qDgRANdX/eI/AwAA
X-CMS-MailID: 20200521141731epcas5p3970e37a1b1b1986b75814de104e4a857
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200519110323epcas5p23b9472d505f5ba58d033fa468cb9969d
References: <CGME20200519110323epcas5p23b9472d505f5ba58d033fa468cb9969d@epcas5p2.samsung.com>
        <20200519104904.59246-1-m.shams@samsung.com>
        <fa372f07-abba-a296-c315-e9769fb43623@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Inki Dae <inki.dae=40samsung.com>
> Sent: Wednesday, May 20, 2020 11:08 AM
> To: Tamseel Shams <m.shams=40samsung.com>; jy0922.shim=40samsung.com;
> sw0312.kim=40samsung.com; kyungmin.park=40samsung.com; airlied=40linux.ie=
;
> daniel=40ffwll.ch
> Cc: dri-devel=40lists.freedesktop.org; linux-arm-kernel=40lists.infradead=
.org; linux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> shaik.ameer=40samsung.com; krzk=40kernel.org; alim.akhtar=40samsung.com
> Subject: Re: =5BPATCH v2=5D drm/exynos: Remove dev_err() on platform_get_=
irq()
> failure
>=20
> Hi Tamseel,
>=20
> Same patch=5B1=5D has been merged. So could you re-post this patch after =
rebasing
> it on top of exynos-drm-next branch?
> After rebase, only g2d part would be valid.
>=20

Hi Inki Dae,
Thanks for letting me know, I will send updated patch for G2D file.

Thanks & Regards
Tamseel Shams


