Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBAC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 04:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD582071C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 04:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cCfhKM+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgDWElK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 00:41:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:13736 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgDWElI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:41:08 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200423044105epoutp03afcd8cca07053275efb4ebc2316dd38f~IWSCxrsaI1371813718epoutp035
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:41:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200423044105epoutp03afcd8cca07053275efb4ebc2316dd38f~IWSCxrsaI1371813718epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587616865;
        bh=H1+Rny0qckA74nXf5D0Agzk5GW9B9WAGg0t48WaGf70=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cCfhKM+QUHaBQdVIIIB78gedhvY8tpp2Umm5mvHEyq7F1UcZxnAmYRerBMF/dkiqY
         AQ/xf/fjhoFbUzRsl7Fw4zLj2EYRMfanDHZ4uRV5tnelfv5B6BJqc5loG9RZ8y5PvP
         eb4H2/KSRHLX/Q9VRruUXfIKjN/u9hDMy++XdI9Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200423044105epcas1p12e62ca4523efb8a38bb7c310aed2241c~IWSCWioFA1169911699epcas1p1s;
        Thu, 23 Apr 2020 04:41:05 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4974PX1LrMzMqYkh; Thu, 23 Apr
        2020 04:41:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.76.04544.D5C11AE5; Thu, 23 Apr 2020 13:41:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200423044100epcas1p12ae3c91c4370bae94ce5b33274edec14~IWR_Xd_rT1158011580epcas1p1j;
        Thu, 23 Apr 2020 04:41:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200423044100epsmtrp18c7e70e8d1101d18a6517ce317d76be3~IWR_W0L640722207222epsmtrp18;
        Thu, 23 Apr 2020 04:41:00 +0000 (GMT)
X-AuditID: b6c32a36-7ffff700000011c0-0a-5ea11c5dad97
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.AE.04024.C5C11AE5; Thu, 23 Apr 2020 13:41:00 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200423044100epsmtip125b7766a2e5ba2477ba639633338c16c~IWR_PQqWj0227802278epsmtip1R;
        Thu, 23 Apr 2020 04:41:00 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: 
Subject: [GIT PULL] exfat fixes for 5.7-rc3
Date:   Thu, 23 Apr 2020 13:41:00 +0900
Message-ID: <001c01d61929$6382ac30$2a880490$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdYZDtzqqNcMH+2OR9GFUXpdUIJwkAAA6Xmw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnm6szMI4g9bz3BaXd81hs3jU95bd
        gcnjxIzfLB6fN8kFMEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
        Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al
        6yXn51oZGhgYmQJVJuRkzD0xn6mglb/i04l21gbGPbxdjJwcEgImEs8XvWDvYuTiEBLYwSix
        f/kfFgjnE6PEvK5GVgjnG6PEzZf/WWFaDs9awQJiCwnsZZRo/coIUfSSUeL6lleMIAk2AV2J
        f3/2s3UxcnCICJhJfFviCBJmFtCWuHBoLgtImFOAV2LCP2uQsDBQ+M6JBrBOFgFViRPrtzGB
        2LwClhIzVm1jh7AFJU7OfMICMUZP4sbUKWwwI5ctfM0McZqCxM+ny8DOFBEwkrj77xsrRI2I
        xOzONmaQMyUENrBJbN7xEOoXF4njB1dD2cISr45vYYewpSRe9rexg9wpIVAt8XE/1PwORokX
        320hbGOJm+s3QLUqSuz8PZcRYhefxLuvPawQrbwSHW1CECWqEn2XDjNB2NISXe0f2CcwKs1C
        8tksJJ/NQvLZLCQfLGBkWcUollpQnJueWmxYYIQc15sYwSlPy2wH46JzPocYBTgYlXh4IxQX
        xAmxJpYVV+YeYpTgYFYS4d3wcF6cEG9KYmVValF+fFFpTmrxIUZTYMhPZJYSTc4HpuO8knhD
        UyNjY2MLEzNzM1NjJXHeqddz4oQE0hNLUrNTUwtSi2D6mDg4pRoYizRKty86eicwbX9A62nf
        yQXtWwLNJVTv3nxj7tQ1u/j9wnf73Kbaep812DZ16pnV4SmVpSeDTmsVPDyx4DCr5drjZ/0n
        Tp+btuNEm+hhxoNbb/dal8YIM+xacVRUY2LVb+t/KjuYMxby1hwxq649IXRGaFrW8yMras5y
        svSJ1Dx7pzZja/chISWW4oxEQy3mouJEADq+cPCPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnG6MzMI4g29zDS0u75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrisklJzcksSy3St0vgynjxYT5zwTWeirZ9G1gaGOdzdTFyckgImEgc
        nrWCpYuRi0NIYDejRPu81cwQCWmJYyfOANkcQLawxOHDxRA1zxkl/vxbxwpSwyagK/Hvz342
        kBoRATOJb0scQcLMAtoSFw7NZQGxhQR4JF5t2M8IUsIpwCsx4Z81SFgYqOTOiQZGEJtFQFXi
        xPptTCA2r4ClxIxV29ghbEGJkzOfsECMNJC4f6iDFWb8soWvoa5UkPj5dBlYXETASOLuv29Q
        NSISszvbmCcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT8
        3E2M4MDX0tzBeHlJ/CFGAQ5GJR7eCMUFcUKsiWXFlbmHGCU4mJVEeDc8nBcnxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA+PEcA3RjhpVk2lttwNXH+ZL
        f3Jj6YpSni2vVzTZat2wmJ/YwrCxn/MS12sx1uRTGyb+Up314Z2vTYTwnVu+jItiq+y5subX
        r0xvaVuxRKtUkmOf34XDM1bO5zjeJKbqky1jc0X9pb7lDreO4nT199I/zx86XLDX1676znrN
        t6ve1K5JaucTnKnEUpyRaKjFXFScCAB/aeMdeAIAAA==
X-CMS-MailID: 20200423044100epcas1p12ae3c91c4370bae94ce5b33274edec14
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200423044100epcas1p12ae3c91c4370bae94ce5b33274edec14
References: <CGME20200423044100epcas1p12ae3c91c4370bae94ce5b33274edec14@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v5.7-rc3. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks=21

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936=
:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/f=
or-5.7-rc3

for you to fetch changes up to 81df1ad40644b706a1cdbd28a1471f9f0c0ea3e8:

  exfat: truncate atimes to 2s granularity (2020-04-22 20:14:06 +0900)

----------------------------------------------------------------
Description for this pull request:
- several bug fixes(broken discard mount option, remount failure, memory le=
ak)
- add missing MODULE_ALIAS_FS for automatically loading exfat module.
- set s_time_gran and truncate atime with exfat timestamp granularity.

----------------------------------------------------------------
Eric Sandeen (2):
      exfat: properly set s_time_gran
      exfat: truncate atimes to 2s granularity

Pali Roh=E1r=20(1):=0D=0A=20=20=20=20=20=20exfat:=20Fix=20discard=20support=
=0D=0A=0D=0ATetsuhiro=20Kohada=20(2):=0D=0A=20=20=20=20=20=20exfat:=20Unify=
=20access=20to=20the=20boot=20sector=0D=0A=20=20=20=20=20=20exfat:=20remove=
=20'bps'=20mount-option=0D=0A=0D=0AThomas=20Backlund=20(1):=0D=0A=20=20=20=
=20=20=20exfat:=20add=20missing=20MODULE_ALIAS_FS()=0D=0A=0D=0Afs/exfat/bal=
loc.c=20=20=20=7C=20=203=20---=0D=0A=20fs/exfat/exfat_fs.h=20=7C=20=201=20+=
=0D=0A=20fs/exfat/file.c=20=20=20=20=20=7C=20=202=20++=0D=0A=20fs/exfat/mis=
c.c=20=20=20=20=20=7C=2014=20+++++++++++++-=0D=0A=20fs/exfat/namei.c=20=20=
=20=20=7C=20=207=20+++++++=0D=0A=20fs/exfat/super.c=20=20=20=20=7C=2053=20+=
+++++++++++++++++++++-------------------------------=0D=0A=206=20files=20ch=
anged,=2045=20insertions(+),=2035=20deletions(-)=0D=0A=0D=0A
