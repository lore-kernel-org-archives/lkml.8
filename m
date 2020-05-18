Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACEA207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OgcPYse3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgERE6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:58:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38378 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERE6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:58:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200518045813epoutp022e5407262dd3b0244c32149a937a94d7~QBpJLKPDQ1897918979epoutp02d
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:58:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200518045813epoutp022e5407262dd3b0244c32149a937a94d7~QBpJLKPDQ1897918979epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589777893;
        bh=BUfspEEvnMC1VJXrI+6oHzX38ZBpJHXGPWrIkFHl+rw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OgcPYse3Yawd7agZaJfjdEb7Wary6qk3Q/6BKWFhL+OKkXYpJIyw78cL8VOBdPGaa
         RZYJZXLKZvgNF0HT3sPm6BRUEpLuvXmEissu+/zyxN14Hk3pAbWv+aT9qeNPabiyyt
         0UlbCqis5g99FWKv4A0BLfsiJ3J6aQEgBwS/AQYY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200518045813epcas1p2ce0a5afbc8f6c017bcf60dd5e77ddd4c~QBpI-p9ff2079220792epcas1p2s;
        Mon, 18 May 2020 04:58:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49QRbm4qzXzMqYlp; Mon, 18 May
        2020 04:58:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.EF.04648.2E512CE5; Mon, 18 May 2020 13:58:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200518045810epcas1p1aa279ded0971de7d07e600a85f242459~QBpFp1XiJ0458704587epcas1p1k;
        Mon, 18 May 2020 04:58:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200518045810epsmtrp16fe9eae5e0ec6f0f00c69c423d02da0d~QBpFpMwhP1821118211epsmtrp1E;
        Mon, 18 May 2020 04:58:10 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-79-5ec215e2558c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.34.18461.1E512CE5; Mon, 18 May 2020 13:58:09 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200518045809epsmtip1be5b2b898fd17b4e4a2b0a4f33fe7f7f~QBpFfEO4a1165611656epsmtip1R;
        Mon, 18 May 2020 04:58:09 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] exfat fixes for 5.7-rc7
Date:   Mon, 18 May 2020 13:58:09 +0900
Message-ID: <000801d62cd0$ed42b540$c7c81fc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYszl7+CgDhKJF2QSqS6da65y3rUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmge4j0UNxBt33RS0u75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBGq+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L
        10vOz7UyNDAwMgWqTMjJWP39IWtBI2fFnbWfGBsY97B3MXJySAiYSLyZd5i1i5GLQ0hgB6NE
        05s9bBDOJ0aJk0cOQmW+MUrs3rmMCaZl08KFLBCJvYwS3+ddAEsICbxklPj42RzEZhPQlfj3
        Zz/QKA4OEQEziW9LHEHCzALaEhcOzWUBCQsD2We+yYKEWQRUJd5O7WIFsXkFLCXWbd3JBmEL
        Spyc+YQFolVeYvvbOcwQJyhI/Hy6DKxeREBPYuHnq+wQNSISszvbmEFOkxA4xC7x/W8TG0SD
        i8Slvf8YIWxhiVfHt0C9LyXxsr+NHeQeCYFqiY/7oeZ3MEq8+G4LYRtL3Fy/gRWkhFlAU2L9
        Ln2IsKLEzt9zGSHW8km8+9rDCjGFV6KjTQiiRFWi79JhaKBJS3S1f4Ba6iHx89RcpgmMirOQ
        PDkLyZOzkDwzC2HxAkaWVYxiqQXFuempxYYFxsgxvYkRnO60zHcwbjjnc4hRgINRiYf3QtTB
        OCHWxLLiytxDjBIczEoivJGf98UJ8aYkVlalFuXHF5XmpBYfYjQFxsFEZinR5HxgKs4riTc0
        NTI2NrYwMTM3MzVWEuedej0nTkggPbEkNTs1tSC1CKaPiYNTqoFRxHuD1rKvUzY1W9zdV31h
        Ye37NULFbcEmh8IvcPZOWPqKf9mmg4U7H/d8N01I4ZnkLaavZOaiUTDF2fd5EXvgXG2O/klS
        a1oM7K+93i/S88v/y5b0h+7a0b5sl74/rm1vT10sc1NkwTT7t3PS1k5WvlR07lMFCzt/vrZv
        rIjZ/B+am5Qrd7UpsRRnJBpqMRcVJwIANOgRMY0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO5D0UNxBpdeWFtc3jWHzeJR31t2
        ByaPEzN+s3h83iQXwBTFZZOSmpNZllqkb5fAlbH6+0PWgkbOijtrPzE2MO5h72Lk5JAQMJHY
        tHAhSxcjF4eQwG5GiZ2dfWwQCWmJYyfOMHcxcgDZwhKHDxeDhIUEnjNKbH0uAWKzCehK/Puz
        nw2kRETATOLbEkeQMLOAtsSFQ3NZQMLCQPaZb7IgYRYBVYm3U7tYQWxeAUuJdVt3skHYghIn
        Zz4BK2cW0JNo28gIMUVeYvvbOcwQtyhI/Hy6DKxVBKhk4eer7BA1IhKzO9uYJzAKzkIyaRbC
        pFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwCGtp7mDcvuqD3iFG
        Jg7GQ4wSHMxKIryRn/fFCfGmJFZWpRblxxeV5qQWH2KU5mBREue9UbgwTkggPbEkNTs1tSC1
        CCbLxMEp1cB0+eHadyI++1/stWnP+lXlVODXML/JVPdpkMmE7i1vHh3aV6vnVJQZ9HF+j8MB
        jzOymyI97knar+4/lV+Vf/6Dp2a9j3ZCiOWrBU7/T2l+6vjfertPWtBcIvf7docXJr97l5yo
        uVfTHfF72xLx7r7fOnp7u+51r9SYkd6QcnLK8c/LO+2DpL0zGQ/33M1/qynGMD0y7GW3rz7T
        7l3bvRyi55sv4JjGeLd4eUYsN/O8d6/m7tsW8GGzYP2qEzJ+u9hs9v5lEpVWK9t75+ZGZenn
        7frxD3vvp7H7THf7L8ag+f1mcsrJOnMuBpGWiH0ps5l7dG+Uv2NdKXNoxdmrv7nVWQrmxB9k
        P1i1LpZZyVGJpTgj0VCLuag4EQAY2NO50AIAAA==
X-CMS-MailID: 20200518045810epcas1p1aa279ded0971de7d07e600a85f242459
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200518045810epcas1p1aa279ded0971de7d07e600a85f242459
References: <CGME20200518045810epcas1p1aa279ded0971de7d07e600a85f242459@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v5.7-rc7. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/for-5.7-rc7

for you to fetch changes up to 94182167ec730dadcaea5fbc6bb8f1136966ef66:

  exfat: fix possible memory leak in exfat_find() (2020-05-18 11:51:44 +0900)

----------------------------------------------------------------
Description for this pull request:
- Fix potential memory leak in exfat_find.
- Set exfat's splice_write to iter_file_splice_write to fix the splice
  failure on direct-opened file

----------------------------------------------------------------
Eric Sandeen (1):
      exfat: use iter_file_splice_write

Wei Yongjun (1):
      exfat: fix possible memory leak in exfat_find()

 fs/exfat/file.c  | 13 +++++++------
 fs/exfat/namei.c |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

