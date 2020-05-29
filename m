Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F67C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19602071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MkeuGMA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbgE2DB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:01:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30345 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391785AbgE2DA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:00:57 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200529030053epoutp021858d98fc89e477865dd890429393397~TYI1PTFuw0660306603epoutp02k
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 03:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200529030053epoutp021858d98fc89e477865dd890429393397~TYI1PTFuw0660306603epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590721253;
        bh=rSVo7ud+9TszCLiyewFEvOoTOG9lXMM1SQDasks6Ths=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MkeuGMA3DZ9eyhsUEzuzfCpyPkbAHwHfKhDjkGDmJlEbpOyD04Pnp5o8AuCZxLDTf
         YVqR7V/NW47rTGLW0A7XS40ptMFK8h0OQxdv/prjuphzmP8PyEtSJjO7VGpBPGMcQU
         bgjbHrUJhOHs6JlDNqHzBpa5yvuO0m0XswPNAIdE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529030052epcas1p2403069f73d1d61282f1488e0a72cd81a~TYI0yKqh-0334803348epcas1p2f;
        Fri, 29 May 2020 03:00:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49Y8TF3B33zMqYkp; Fri, 29 May
        2020 03:00:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.F3.29173.CDA70DE5; Fri, 29 May 2020 12:00:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529030043epcas1p2a41f6271b91e086a2e730a488ce53015~TYIsSdkSP1023810238epcas1p2K;
        Fri, 29 May 2020 03:00:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200529030043epsmtrp2016b1b89e4aac5ef2a4a97a3096a89f5~TYIsR4iGf0654606546epsmtrp2R;
        Fri, 29 May 2020 03:00:43 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-7c-5ed07adc0972
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.DB.08303.BDA70DE5; Fri, 29 May 2020 12:00:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529030043epsmtip1e9be7ed341d230145d48b218584cf3e0~TYIsFxk__0604606046epsmtip1f;
        Fri, 29 May 2020 03:00:43 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for v5.8
Message-ID: <a7f317f3-5499-d1d5-cabd-b53d7e8d9977@samsung.com>
Date:   Fri, 29 May 2020 12:11:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTV/dO1YU4gxV3FSwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iw5D66yFTTwVWx62Mbc
        wHicu4uRk0NCwERiS+cppi5GLg4hgR2MEp3rPjFDOJ8YJU5sOskK4XxmlNj2oJ8ZpuXqjoWM
        EIldjBIvN3dBtbxnlFjwZAU7SBWbgJbE/hc32EBsfgFFias/HjOC2CICGhIvj95iAWlgFnjD
        KLHvcycrSEIYKDFz0QkWEJtXwE7iQ9NGsGYWAVWJe7dvgdmiAmESJ7e1MELUCEqcnPkErJ5Z
        QFzi1pP5TBC2vMT2t3PALpIQeMsu8a/9ICPE3S4S8+90s0HYwhKvjm9hh7ClJD6/2wsVr5ZY
        efIIG0RzB6PElv0XWCESxhL7l04G2sABtEFTYv0ufYiwosTO33MZIRbzSbz72sMKUiIhwCvR
        0SYEUaIscfnBXSYIW1JicXsn1CoPib8PtrJNYFScheSdWUjemYXknVkIixcwsqxiFEstKM5N
        Ty02LDBGju9NjOBUqWW+g3Ha2w96hxiZOBgPMUpwMCuJ8K45ez5OiDclsbIqtSg/vqg0J7X4
        EKMpMIAnMkuJJucDk3VeSbyhqZGxsbGFiaGZqaGhkjivr9WFOCGB9MSS1OzU1ILUIpg+Jg5O
        qQam68dX+kw1/nKlgeOjcJXwrR9VOtu/S6d033yk8bwwPuRs68Hqmq4CN+emFTvU/h03/ee3
        s7pTX6/ixEXdj/KZc3ta7zGuK3l27W0Dt5Lyvc4z/QU/tbjN3j2pm7V37qIXPsvf9SvPyIqv
        l9dhy+pR6H3O/3ymR3t1v4Xh+v2JmUkqLYxJWX+5PkZLH5X/wLTEeJMjeyDXuvXhbIvcJjiJ
        JL9pDuC6f/zo1TMdpf+9asX3PTZ5yBbYd89UINPO8NoJszlHRflO1iSFsxfvzhNawf1AvGfd
        vqOOb3I299qdt1WOYDpUO8FyjtueZNYU2Qnzbhg4rfdL/SLd862/b9eCGStTnSXnTt3d5CE2
        yUeJpTgj0VCLuag4EQCjR9yDHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO7tqgtxBrunaFtMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GXMeXGUraOCr2PSwjbmB8Th3FyMnh4SAicTVHQsZuxi5OIQEdjBK7GnYxwyRkJSYdvEokM0B
        ZAtLHD5cDFHzllHi6NsPrCA1bAJaEvtf3GADsfkFFCWu/njMCGKLCGhIvDx6iwWkgVngDaNE
        /5ot7CAJYaDEzEUnWEBsXgE7iQ9NG8GaWQRUJe7dvgVmiwqESexc8pgJokZQ4uTMJ2D1zALq
        En/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj4CwkLbOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjBEaCltYNxz6oPeocYmTgYDzFKcDArifCuOXs+Tog3JbGyKrUo
        P76oNCe1+BCjNAeLkjjv11kL44QE0hNLUrNTUwtSi2CyTBycUg1MR7Mz4/58W76o4OEHpyWc
        jO0XvO+/3LPJcelUCabbEXtjN0StFljTvlZIdUW8IAd3bsREtda6yXsvzq65LJE2UWf67Vkf
        2+VXLHO5Fi8aFrpKanH6nm9Zr8++ij5TuWj5vf9WmtOOMLwsDdPYWqVun9WYs9r3zFZJW4+t
        n98fmWjjx/nHOK3CSLw53FN2x68Dry96PH1ldfRVYpDBpqZ4+2yWaUfbOYtM3+8sfS44s8Ak
        p/Fgv69h9BqO0m9O/SaMvCElgi2t1/ZvVW7aGCLQ4Hqg3eD1UaGXheduXtD48SZbLXL5qwxB
        p58ujUuNes9zqD87FvGWafa/mquabmdXiZ25m/Jn7bUHf5clVsoLKLEUZyQaajEXFScCANiw
        awzvAgAA
X-CMS-MailID: 20200529030043epcas1p2a41f6271b91e086a2e730a488ce53015
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200529030043epcas1p2a41f6271b91e086a2e730a488ce53015
References: <CGME20200529030043epcas1p2a41f6271b91e086a2e730a488ce53015@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.8. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.8

for you to fetch changes up to bef91b5ad53981b6cb4db7f6253d1808cfef593d:

  extcon: arizona: Fix runtime PM imbalance on error (2020-05-28 18:02:29 +0900)

----------------------------------------------------------------

Update extcon for v5.8

Detailed description for this pull request:
1. Update extcon provider driver
- Fix an error handling code by using devm_iio_channel_get() for extcon-adc-jac.c
- Fix the usage counter imbalance of runtime PM for extcon-arizona.c.
- Add proper dt-compatible string for extcon-max14577.c.

2. Update extcon core with minor updates:
- Remove unneeded initialization of local variable in extcon_register_notifier.

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
