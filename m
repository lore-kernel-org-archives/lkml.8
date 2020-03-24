Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A4C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E320722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oINxRp6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCXXPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:15:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22123 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCXXPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:15:53 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200324231551epoutp04ccb889bdec7b38290d621eebfc1deb4a~-YIyrJLJc0202802028epoutp04S
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 23:15:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200324231551epoutp04ccb889bdec7b38290d621eebfc1deb4a~-YIyrJLJc0202802028epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585091751;
        bh=qsqwQPSUgktw5Td+D+Lx1dbqnLEYotbbr0lFDeOk+Gc=;
        h=To:Cc:From:Subject:Date:References:From;
        b=oINxRp6NMJM/Fe/swDHSXxyBKAHVetvcRRcDcQiellCHv1slHteaIcyiDVHGiCAXb
         MH0nB80ofbx74lAwPLAuBPKkh8/E5wYRH20+BI5VaJ7J6Tq99GFGWksvUFBfeSmaM6
         I9dSQiRwcBv8Kz9eaUvNmiRECWvuR3rS2jnt3Izg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200324231550epcas1p299b22da309d1743b25d4a68682b8740b~-YIyPRsfh0061500615epcas1p23;
        Tue, 24 Mar 2020 23:15:50 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48n6YX1ysnzMqYkc; Tue, 24 Mar
        2020 23:15:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.7E.04074.0A49A7E5; Wed, 25 Mar 2020 08:15:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324231543epcas1p2302f5fe248059301b6ea67cb9dafb8f2~-YIrw6f6d2969629696epcas1p2r;
        Tue, 24 Mar 2020 23:15:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324231543epsmtrp161bc2cbdff579d33fcb1b873905fbff5~-YIrwM4jz2482024820epsmtrp1S;
        Tue, 24 Mar 2020 23:15:43 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-75-5e7a94a0b2f3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.3F.04024.F949A7E5; Wed, 25 Mar 2020 08:15:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200324231543epsmtip2a7055527fb15f2fca95659a0acab0b7e~-YIrlxY422435024350epsmtip2o;
        Tue, 24 Mar 2020 23:15:43 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.7
Organization: Samsung Electronics
Message-ID: <60060403-c2ee-2794-ff44-319e8e5272b5@samsung.com>
Date:   Wed, 25 Mar 2020 08:24:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmvu6CKVVxBve38VlMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RkNC9+zFvzgrzh79T97
        A+NDni5GTg4JAROJGev2M3YxcnEICexglJh7dyE7hPOJUWLBr15WCOcbo8Tz1rlsMC2/nu5i
        gkjsZZTYeaOTBSQhJPCeUeLwHSYQW0RAQ+Ll0VssIEXMAo8ZJX7+3Q3WzSagJbH/xQ0wWxio
        6N7Ra6wgNr+AosTVH48ZQWxeATuJvf2NYINYBFQl3ny4ww5iiwqESZzc1gJVIyhxcuYTsMXM
        AuISt57MZ4Kw5SW2v53DDLJYQmAPm8SZ1eeAijiAHBeJ6euhnhaWeHV8CzuELSXxsr8Nyq6W
        WHnyCBtEbwejxJb9F1ghEsYS+5dOZgKZwyygKbF+lz5EWFFi5++5jBB7+STefe1hhVjFK9HR
        JgRRoixx+cFdJghbUmJxeyc0ED0k/ky/yziBUXEWkm9mIflmFpJvZiEsXsDIsopRLLWgODc9
        tdiwwBQ5tjcxgtOkluUOxmPnfA4xCnAwKvHwNjyujBNiTSwrrsw9xCjBwawkwrs5tSJOiDcl
        sbIqtSg/vqg0J7X4EKMpMLAnMkuJJucDU3heSbyhqZGxsbGFiaGZqaGhkjjv1Os5cUIC6Ykl
        qdmpqQWpRTB9TBycUg2ME8S2LnWwyKhbv2JD6KMvz9+aVv7Mfz7bcKLk8TiBqIwVxxuCtso9
        T7++/u47ttT48odCn1wOJC+x1pszs/M487WOzB0C7icfvGO4OtPu2uO+mr1TFm6OMtul8bfE
        wFdk/nnWt6vUdv7wa3mUZvrqfXTz34BEs8iTLPdtHVpUqi4XpSy78lN8khJLcUaioRZzUXEi
        AIx987epAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvO78KVVxBrv2qVlMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GQ0L37MW/OCvOHv1P3sD40OeLkZODgkBE4lfT3cxdTFycQgJ7GaUmLFuMTNEQlJi2sWjQDYH
        kC0scfhwMUTNW0aJngU3WUBqRAQ0JF4evQVmMws8ZZSY1GwNYrMJaEnsf3GDDcQWBqq5d/Qa
        K4jNL6AocfXHY0YQm1fATmJvfyMTiM0ioCrx5sMddhBbVCBMYueSx0wQNYISJ2c+gZqvLvFn
        3iVmCFtc4taT+UwQtrzE9rdzmCcwCs5C0jILScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHP5amjsYLy+JP8QowMGoxMOr9bAyTog1say4MvcQowQHs5II7+bU
        ijgh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGGP6Tunx
        v2V47d/k7DsjbB734cyYRbplnEwO3zbtENp3/sbdH1dnVASkrvn1/WVL8wtRjjaFiKi4kHc2
        z+b5LhF42eUuurT22fGGNQsXFas+WP9icXbWG6sgmX/zvBQjZhrUx4l6JGRzl+/Xv31Uptz6
        4q6L/q2hnI8s1vhJVi2QrHqkeN/fRImlOCPRUIu5qDgRAAYWRON7AgAA
X-CMS-MailID: 20200324231543epcas1p2302f5fe248059301b6ea67cb9dafb8f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324231543epcas1p2302f5fe248059301b6ea67cb9dafb8f2
References: <CGME20200324231543epcas1p2302f5fe248059301b6ea67cb9dafb8f2@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.7. I add detailed description of
this pull request on below. Please pull extcon with following updates.

est Regards,
Chanwoo Choi

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.7


for you to fetch changes up to 9c94553099efb2ba873cbdddfd416a8a09d0e5f1:

  extcon: axp288: Add wakeup support (2020-03-25 08:16:14 +0900)

----------------------------------------------------------------

Detailed description for this pull request:
1. Update the extcon provider driver as following:
- Add wakeup support for extcon-axp288.c
- Clean-up code of -EPROBE_DEFER error case for extcon-palmas.c
- Covert extcon-usbc-cros-ec.txt to yaml format
2. Export symbol of extcon_get_edev_name()

----------------------------------------------------------------
Dafna Hirschfeld (1):
      dt-bindings: extcon: usbc-cros-ec: convert extcon-usbc-cros-ec.txt to yaml format

H. Nikolaus Schaller (1):
      extcon: palmas: Hide error messages if gpio returns -EPROBE_DEFER

Hans de Goede (1):
      extcon: axp288: Add wakeup support

Mayank Rana (1):
      extcon: Mark extcon_get_edev_name() function as exported symbol

 .../bindings/extcon/extcon-usbc-cros-ec.txt        | 24 ----------
 .../bindings/extcon/extcon-usbc-cros-ec.yaml       | 56 ++++++++++++++++++++++
 drivers/extcon/extcon-axp288.c                     | 32 +++++++++++++
 drivers/extcon/extcon-palmas.c                     |  8 +++-
 drivers/extcon/extcon.c                            |  1 +
 include/linux/extcon.h                             |  5 ++
 6 files changed, 100 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
