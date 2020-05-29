Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFE92075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c+aa2UXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2Ieo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:34:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44985 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2Ien (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:34:43 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200529083439epoutp0454dd0d64088eb6d1e79271d1bdfa8d40~TcsQAwY7V1748917489epoutp04k
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:34:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200529083439epoutp0454dd0d64088eb6d1e79271d1bdfa8d40~TcsQAwY7V1748917489epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590741279;
        bh=UKp7ZJbYEn0AY0z0nMkzE8liDwDd9xM37kJ29ikLW6g=;
        h=To:From:Subject:Cc:Date:References:From;
        b=c+aa2UXLigxAuljKqPrj+lA76JTtJXEi2cj/+Ry18n+FnIgGYCW0yn/M55wOnVMHM
         QqaJ86bgX8fml4+OYFLUcdSz+xZaoXQz9YzL7wQOMqZEBMP678od/FekcCt2PjiTXm
         sgnYsae7UxgDm60IHvVxSAGKxlKxF7o9Us+oogRo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529083439epcas1p2d392274b271f049b5d8248ba0df763ef~TcsPqdnDR0368103681epcas1p24;
        Fri, 29 May 2020 08:34:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49YHtN1BfNzMqYks; Fri, 29 May
        2020 08:34:36 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.18.28578.B19C0DE5; Fri, 29 May 2020 17:34:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200529083435epcas1p437fe64ae869c24adc001eab41dde68f4~TcsMRiegK1985819858epcas1p4p;
        Fri, 29 May 2020 08:34:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200529083435epsmtrp2837240bc32dba14d53951df31bbe1fb8~TcsMQsJAi1040410404epsmtrp2F;
        Fri, 29 May 2020 08:34:35 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-73-5ed0c91b2e1e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.E7.08303.B19C0DE5; Fri, 29 May 2020 17:34:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200529083435epsmtip293514408e91b8046e8c1069c5bd7e3fd~TcsMFiMX51799817998epsmtip2e;
        Fri, 29 May 2020 08:34:35 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL v2] extcon next for v5.8
Organization: Samsung Electronics
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Message-ID: <169a5d0a-6e64-d2f6-99db-4c1c9090e004@samsung.com>
Date:   Fri, 29 May 2020 17:44:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTQFf65IU4g8XzDS0m3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Ix7fTOYC05wVbyfUdHA
        eJaji5GTQ0LAROLTijssXYxcHEICOxgl1r6ZwgrhfGKUWDTzJzOE85lR4uayl0xdjBxgLe/X
        JYF0CwnsYpRYfIMRouY9o8TE2Q/ZQBIiAhoSL4/eYgGx2QS0JPa/uAEWFxbQlph7aAYTiM0v
        oChx9cdjsGZmgTeMEvs+d7KCJHgF7CRuN6wHa2ARUJU4s/4dO4gtKhAmcXJbCyNEjaDEyZlP
        wBYwC4hL3HoynwnClpfY/nYOM8Rvb9kldn5Xh7BdJN60TWOBsIUlXh3fwg5hS0l8freXDcKu
        llh58ggbyEESAh2MElv2X2CFSBhL7F86Gex7ZgFNifW79CHCihI7f89lhNjLJ/Huaw8rJIB4
        JTrahCBKlCUuP7jLBGFLSixu74Ra5SHxtmMz6wRGxVlIvpmF5JtZSL6ZhbB4ASPLKkax1ILi
        3PTUYsMCU+S43sQITpFaljsYp7/9oHeIkYmD8RCjBAezkgjvmrPn44R4UxIrq1KL8uOLSnNS
        iw8xmgLDdyKzlGhyPjBJ55XEG5oaGRsbW5gYmpkaGiqJ8zpZX4gTEkhPLEnNTk0tSC2C6WPi
        4JRqYPJW2ymjWeJ3sWDqyzCn4C0XPvl8nhzbcfTsx1yD2Tab1wk5zKn4umOPa475vTuL2L24
        ZZ6lNH1s5zDTd74v9fX28iORqaE/d0m/PH55r966P0LfJ3iYnxdu5L1QcuzbZLs0Fss9r5fd
        M/r5OO3ZS9M1D1+sPlwhass3Q7X22pffjJs3/XnD+7xqkeo+Nuud85iZjGLnL/uTrTI92yGu
        3D//ZYyu45E/cwsf9x05cW6jVhjvmTPv2NYdcZo8jf/O+7VOVhE/uL9wmBS5rhTR9j/vtWrt
        ltB1us2v4iRL7tXzfctKF4jsi/MS7S/ofqkurKymr31y+er0JUwttR3uYucK1/A7Zs63MBQr
        mpcX3qjEUpyRaKjFXFScCAAU79guGgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvK70yQtxBrO6pS0m3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jHt9M5gLTnBVvJ9R0cB4lqOLkYNDQsBE4v26pC5GLg4hgR2MEhO3TWLtYuQEiktKTLt4lBmi
        Rlji8OFiiJq3jBIfJjUzgdSICGhIvDx6iwXEZhPQktj/4gYbiC0soC0x99AMsBp+AUWJqz8e
        M4I0Mwu8YZToX7OFHSTBK2AncbthPVgDi4CqxJn178DiogJhEjuXPGaCqBGUODnzCdgCZgF1
        iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRcBaSlllIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKj
        vNRyveLE3OLSvHS95PzcTYzg4NfS2sG4Z9UHvUOMTByMhxglOJiVRHjXnD0fJ8SbklhZlVqU
        H19UmpNafIhRmoNFSZz366yFcUIC6YklqdmpqQWpRTBZJg5OqQYmswW/LLf9+bBaQN5ssaiO
        QND0CU1JNi+X7xZb/T+Jl2/ukubwhfqqXwx+7c00eWAvsoUrRz5y+3F/s1Pim6+ox6nEX9vv
        9slrSvGxwMMmeleajsjur9ixdJO/7ttVzpqlc6MCzibcuBRx1q+dMyyqvJdPVX3Cmb4ffoY6
        K5TLY1anngw0kve67/nuZNA5daZni7YlTuJQXLZ1a0qybwRL4Itpz746feiUdw39aPBi08Fq
        20jm4KjbglbL86NKU82euBq1R+6ZYa57qXPNiraA4Ac7p23fs2iLja181Bs5jWaJvHlXJFp2
        q6irKf1jZtxvvFTJYc0ZqQP7kg9cZ/vFdj1z4puyXN7+afOD+a8osRRnJBpqMRcVJwIABBRO
        w+0CAAA=
X-CMS-MailID: 20200529083435epcas1p437fe64ae869c24adc001eab41dde68f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529083435epcas1p437fe64ae869c24adc001eab41dde68f4
References: <CGME20200529083435epcas1p437fe64ae869c24adc001eab41dde68f4@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.8. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Changes from v1:
- Change the base commit from v5.7-rc7 to v5.7-rc5.

Best Regards,
Chanwoo Choi


The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.8

for you to fetch changes up to b2e5575a8d04028d17f6c914eea31036589bc79a:

  extcon: arizona: Fix runtime PM imbalance on error (2020-05-29 17:36:02 +0900)

----------------------------------------------------------------
Christophe JAILLET (1):
      extcon: adc-jack: Fix an error handling path in 'adc_jack_probe()'

Colin Ian King (1):
      extcon: remove redundant assignment to variable idx

Dinghao Liu (1):
      extcon: arizona: Fix runtime PM imbalance on error

Marek Szyprowski (1):
      extcon: max14577: Add proper dt-compatible strings

 drivers/extcon/extcon-adc-jack.c |  3 +--
 drivers/extcon/extcon-arizona.c  | 17 +++++++++--------
 drivers/extcon/extcon-max14577.c | 10 ++++++++++
 drivers/extcon/extcon.c          |  2 +-
 4 files changed, 21 insertions(+), 11 deletions(-)
