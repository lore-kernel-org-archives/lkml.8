Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E783C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81D207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TIGiUoR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGVE54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:57:56 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:51368 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGVE54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:57:56 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200722045752epoutp03db48dcd38b6f0e490c66c4653b690f68~j_kYujU_11910119101epoutp039
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:57:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200722045752epoutp03db48dcd38b6f0e490c66c4653b690f68~j_kYujU_11910119101epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595393872;
        bh=uLPSwVzWO2UHVL+bhwXgdI0sUE3gDT5kG6rjvtdvufk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TIGiUoR1Up0uJFIp0x26yO1lMDOEVuD+GVb/OQtnNnwU3OL8+tY2dAj+wE0QatiRg
         r4WWwTJDOLNj59e3RDX06rG/JAO3RphDvdAIju3dh9iT26tqv9yulpUDwZm241kzHi
         q2BkLC1DmywvTSqBYeFsucjcp8cvzfI8eNWd8AVo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200722045752epcas1p4fe117359e574bd7ed4a0fe2e4a43432e~j_kYeOfFv1766217662epcas1p4Y;
        Wed, 22 Jul 2020 04:57:52 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BBNWM0tpzzMqYmB; Wed, 22 Jul
        2020 04:57:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.9C.18978.C47C71F5; Wed, 22 Jul 2020 13:57:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200722045747epcas1p3304644dafc49b5cc877454e51c6ec00a~j_kURTdFO0261302613epcas1p31;
        Wed, 22 Jul 2020 04:57:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200722045747epsmtrp2ebb3b04571bfdc096edce9fbc1d38a74~j_kUQoWXe2805128051epsmtrp21;
        Wed, 22 Jul 2020 04:57:47 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-c3-5f17c74c6db3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.85.08382.B47C71F5; Wed, 22 Jul 2020 13:57:47 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200722045747epsmtip2f5eeab1b2d21899c4d8ac80db4c5e980~j_kUJ2CmK0700107001epsmtip2d;
        Wed, 22 Jul 2020 04:57:47 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] exfat fixes for 5.8-rc7
Date:   Wed, 22 Jul 2020 13:57:47 +0900
Message-ID: <003601d65fe4$a4d20da0$ee7628e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZfGnm5ek10PffcR5K6mTRqyoxPkQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmrq7PcfF4g8d3+Swu75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBGq+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L
        10vOz7UyNDAwMgWqTMjJuN3vWbCau2Li+vOMDYzTOLsYOTkkBEwkzi05wtbFyMUhJLCDUeL0
        kxZWCOcTo8SvDdsZIZxvjBJvjsxhg2lZtXsLVGIvo8SzuTPYIZyXjBI7/25lB6liE9CV+Pdn
        P1AHB4eIgJnEtyWOICazgJLE1VNyIBXCAtoSaxYfBpvJIqAq8bOxgRXE5hWwlPiz8C6ULShx
        cuYTFhCbWUBeYvvbOcwQNyhI/Hy6DKxGREBP4sq6zcwQNSISszvbmEHOkRDYxS7R1/sLqsFF
        4uGZJSwQtrDEq+Nb2CFsKYnP7/aCnSkhUC3xcT9UeQejxIvvthC2scTN9RtYIc7XlFi/Sx8i
        rCix8/dcRoi1fBLvvvawQkzhlehoE4IoUZXou3SYCcKWluhq/wC11EPidm87+wRGxVlInpyF
        5MlZSJ6ZhbB4ASPLKkax1ILi3PTUYsMCQ+SY3sQITndapjsYJ779oHeIkYmD8RCjBAezkgiv
        DqN4vBBvSmJlVWpRfnxRaU5q8SFGU2CwT2SWEk3OBybcvJJ4Q1MjY2NjCxMzczNTYyVx3n9n
        2eOFBNITS1KzU1MLUotg+pg4OKUamDT1epsO3wnoEbPWdxOoFpYTCd57/01ZYVjGY781O+yF
        dz+t/eTAEnjbaOuksriXTSEid62NWHaEv1/7Lf3iPm7nx/aMpwOVX0kW/1ilO82ya+sup8uG
        zvmlPkLVZgun5y2SnsDgqDDffZLBy1XSt6+qaCRM8nvQl/q2u6Qz6dAsLc+vZZU7vla1nTwt
        9KJpxwTJ13vzbh8VVv7LVtT/vvXP35I8OVv9BUqNkjNWchcKOum9uj/t+oSeeZ8ECxZHFc/b
        +G2x9QMW0RUHq3bcbCjfdPaM5PJLqtWz+Z03dO7qaBbJDHx3Y67xp4+8Fufn7503afe+8Pde
        ifPtxI6tM125aknl/5MHH3NJGBwr7lZiKc5INNRiLipOBAB1SxCYAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSvK73cfF4g9PTFCwu75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrisklJzcksSy3St0vgyrjd71mwmrti4vrzjA2M0zi7GDk5JARMJFbt
        3sLYxcjFISSwm1Fi788GZoiEtMSxE2eAbA4gW1ji8OFiiJrnjBLtq+eC1bAJ6Er8+7OfDaRG
        RMBM4tsSRxCTWUBJ4uopOZAKYQFtiTWLD7OB2CwCqhI/GxtYQWxeAUuJPwvvQtmCEidnPmGB
        aNWTaNvICBJmFpCX2P52DtQxChI/ny4DKxcBKrmybjMzRI2IxOzONuYJjIKzkEyahTBpFpJJ
        s5B0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzCWpo7GLev+qB3iJGJg/EQ
        owQHs5IIrw6jeLwQb0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNITS1KzU1MLUotgskwc
        nFINTFaTFGI8bu4tcHJ8niN4mvek2JeFbgnHZJP+bnt7+vyFjOOdSh89AuatSUupYd4yYeOZ
        qtSpX/36uP81TZt9b9kmZzE3ObWzcjJMfx9PMS5cJjs1d5ahelrmTxP9Y/N/L1/1pPNcO5NV
        Z4D+Zu45gevVX+1k7wn5vaFv3ly39IPK13+tuiMj+/H238QbVzicrJWZWvJW8P2Rrgwr+bS2
        aNHTedHTo4Qid24XPhpR+r7xpMvaz7biDFc1nNRv3fgh1n6Re3u8yLuqx+dcJS9z2KjOU75Y
        1efhm+p38oT9SklGm53hBozSNWKPNvmnr4q5/c9SYhXvzKBmgY7ZV5696079vNNJ//GRJKX7
        irsCmpRYijMSDbWYi4oTAbZaFgDQAgAA
X-CMS-MailID: 20200722045747epcas1p3304644dafc49b5cc877454e51c6ec00a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200722045747epcas1p3304644dafc49b5cc877454e51c6ec00a
References: <CGME20200722045747epcas1p3304644dafc49b5cc877454e51c6ec00a@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v5.8-rc7. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.8-rc7

for you to fetch changes up to db415f7aae07cadcabd5d2a659f8ad825c905299:

  exfat: fix name_hash computation on big endian systems (2020-07-21 10:44:19 +0900)

----------------------------------------------------------------
Description for this pull request:
  - fix overflow issue at sector calculation.
  - fix wrong hint_stat initialization.
  - fix wrong size update of stream entry.
  - fix endianness of upname in name_hash computation.

----------------------------------------------------------------
Hyeongseok Kim (1):
      exfat: fix wrong size update of stream entry by typo

Ilya Ponetayev (1):
      exfat: fix name_hash computation on big endian systems

Namjae Jeon (2):
      exfat: fix overflow issue in exfat_cluster_to_sector()
      exfat: fix wrong hint_stat initialization in exfat_find_dir_entry()

 fs/exfat/dir.c      | 2 +-
 fs/exfat/exfat_fs.h | 2 +-
 fs/exfat/file.c     | 2 +-
 fs/exfat/nls.c      | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

