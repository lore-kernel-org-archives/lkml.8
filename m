Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC8A2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YtWEPImM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgFIIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:45:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:45574 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgFIIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:45:49 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200609084546epoutp03f964e4cdfbc27d4a73c606685deacf6a~W08GGAmlH3157931579epoutp031
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:45:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200609084546epoutp03f964e4cdfbc27d4a73c606685deacf6a~W08GGAmlH3157931579epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591692346;
        bh=bI3oqIDWZ4rt+bmTVjAEn2Ya7lnsCa/ld4oq8kRKOhc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YtWEPImM6ZEztWNVIYRPqCZjVFkKHz0f1m5QcNrPdqLcSgYI4vxvGzXNXkRm1WqlD
         MUCeGOUAJ6V3d/glqnwwTit1s3dJ6ytEclNf5MxDkTJAeXn/3WDEao1LqadegHCsJm
         X/NEFi6B5V1rIzEW0L5XKXh70dL7MgwmrmHiITO8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200609084546epcas1p13ddc7c81c902c05a86399d30fd94574e~W08Fxuyot2599825998epcas1p1q;
        Tue,  9 Jun 2020 08:45:46 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49h3c90Z6jzMqYkj; Tue,  9 Jun
        2020 08:45:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.25.19033.63C4FDE5; Tue,  9 Jun 2020 17:45:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200609084542epcas1p35b5e76b8b99735e2f48921b5aaf7d4c3~W08CcLPPB1165411654epcas1p32;
        Tue,  9 Jun 2020 08:45:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200609084542epsmtrp1448500c4b92a05664368a242a3eaf22f~W08Cbm7vT0604806048epsmtrp1T;
        Tue,  9 Jun 2020 08:45:42 +0000 (GMT)
X-AuditID: b6c32a36-159ff70000004a59-73-5edf4c367f81
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.9B.08382.63C4FDE5; Tue,  9 Jun 2020 17:45:42 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200609084542epsmtip13aa25c6447fecc273e7419cb6f064e6a~W08CRmiI50989009890epsmtip1W;
        Tue,  9 Jun 2020 08:45:42 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] exfat update for 5.8-rc1
Date:   Tue, 9 Jun 2020 17:45:42 +0900
Message-ID: <001301d63e3a$5bdb43d0$1391cb70$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdY+LrMzOcJwC6u8TI6E/skAjA+lag==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmvq6Zz/04g623LS0u75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBGq+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L
        10vOz7UyNDAwMgWqTMjJeLvrL2PBCdmKX+sWMzYwLpPqYuTkkBAwkVhyeTs7iC0ksINRYneD
        TxcjF5D9iVHi1Ol2dgjnG6PE9m2XWWA6vq/qZIHo2Mso0fqIG6LoJaPEwuO3mUASbAK6Ev/+
        7GfrYuTgEBEwk/i2xBEkzCygLXHh0FywXmEBHYn1zR/YQGwWARWJ+RPuMYLYvAKWEnd2PGWH
        sAUlTs58wgLRqydxY+oUNpg5yxa+Zoa4R0Hi59NlrCC2CFBN17PV7BA1IhKzO9uYQW6TENjH
        LtG18TvUAy4S2z9vh7KFJV4d38IOYUtJvOxvYwe5WUKgWuLjfqj5HYwSL77bQtjGEjfXb2CF
        sBUldv6eywixi0/i3dceVohWXomONiGIElWJvkuHmSBsaYmu9g9QmzwkHj5+xT6BUXEWki9n
        IflyFpIvZyH5ZgEjyypGsdSC4tz01GLDAiPkuN7ECE55WmY7GCe9/aB3iJGJg/EQowQHs5II
        b/WDO3FCvCmJlVWpRfnxRaU5qcWHGE2BAT+RWUo0OR+YdPNK4g1NjYyNjS1MzMzNTI2VxHnV
        ZC7ECQmkJ5akZqemFqQWwfQxcXBKNTDFhnVVrdfNktiQf+XZ65TTi1SXbbnB+6wirTHrp3TS
        vMyl+w9vn3t7/56u6DUFx6cnGjzlmrrd8XqJjewD1bt7j9h/dPVNCsma9LqxP9dnrtLC2U/0
        FbQtTFZw3zE4KVTm8T897fjxzxmHZlpG5ktGuK+P/yJ+gc0y0LZijcTZpWZBb37U8C2qnnRL
        /Wdg+7elR1/5i1aY/w6/mCOuvn9Dxm3JQ06/s04y/a27+nPafDanZBbN1inJHQJ7S5pamc6Z
        XIqsmCqRmXJCzpOl7cTj/dLLT17mfPnYi+v5uV/v5UrYjFYYzqzeLPzUcZLlg/1KfDvZd3gp
        Vh068GgO68bPKT0rJOts70RNabqX//mZEktxRqKhFnNRcSIAo3NoqQIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnK6Zz/04g913pCwu75rDZvGo7y27
        A5PHiRm/WTw+b5ILYIrisklJzcksSy3St0vgyujb5ViwRqLiZsc15gbGmcJdjJwcEgImEt9X
        dbJ0MXJxCAnsZpSY9e8gI0RCWuLYiTPMXYwcQLawxOHDxRA1zxklLv39wwZSwyagK/Hvz342
        kBoRATOJb0scQcLMAtoSFw7NZQGxhQV0JNY3fwArZxFQkZg/4R7YeF4BS4k7O56yQ9iCEidn
        PmGB6DWQuH+ogxVmzrKFr5khzlGQ+Pl0GVhcREBPouvZanaIGhGJ2Z1tzBMYBWchGTULyahZ
        SEbNQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcCBrae5g3L7qg94hRiYO
        xkOMEhzMSiK81Q/uxAnxpiRWVqUW5ccXleakFh9ilOZgURLnvVG4ME5IID2xJDU7NbUgtQgm
        y8TBKdXAtLH/l9VVz+1mcd7PvbonfXv482lpmQvr/L2XYhi/PpRU7YzUMCph1dC2rHxz3HmS
        64EuMf+f3hOvxJz0XlWaemGHU4LvsRfaWvl2pl5xUa89veOD9WT3Lcq3vnxx6Yd0zrwdord0
        jmiovz2RxGHbeF51ne5jQTUJkc1HZCenJ2mfcHz1QsH7rcwK3vDqBjmulGvht1Y5r9iaU3LH
        UiBNakJ27bH7y47/tV3O0r8s1O3cpk2bP8/MNjVTcv81s+9om5iEHlv6hB3t79Zr/z6ef2Bx
        5+qwJ3/1U0sm731w8Zr53yVX2WXkrl7eV8DYeex887cfk52Uvb+sbGyc4ex05WFJ/ikF0Zpt
        dlopNd29SizFGYmGWsxFxYkA0JV7VNMCAAA=
X-CMS-MailID: 20200609084542epcas1p35b5e76b8b99735e2f48921b5aaf7d4c3
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609084542epcas1p35b5e76b8b99735e2f48921b5aaf7d4c3
References: <CGME20200609084542epcas1p35b5e76b8b99735e2f48921b5aaf7d4c3@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.8-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks=21

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162=
:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/e=
xfat-for-5.8-rc1

for you to fetch changes up to fc961522ddbdf00254dd03b677627139cc1f68bc:

  exfat: Fix potential use after free in exfat_load_upcase_table() (2020-06=
-09 16:50:18 +0900)

----------------------------------------------------------------
Description for this pull request:
* Bug fixes
  - Fix memory leak on mount failure with iocharset=3D option.
  - Fix Incorrect update of stream entry.
  - Fix cluster range validation error.

* Clean-up codes
  - Remove unused code and unneeded assignment.
  - Rename variables in exfat structure as specification.
  - Reorganize boot sector analysis code.
  - Simplify exfat_utf8_d_hash and exfat_utf8_d_cmp().
  - Optimize exfat entry cache functions.
  - Improve wording of EXFAT_DEFAULT_IOCHARSET config option.

* New Feature
  - Add boot region verification.

----------------------------------------------------------------
Al Viro (1):
      exfat: fix memory leak in exfat_parse_param()

Dan Carpenter (1):
      exfat: Fix potential use after free in exfat_load_upcase_table()

Geert Uytterhoeven (1):
      exfat: Improve wording of EXFAT_DEFAULT_IOCHARSET config option

Jason Yan (1):
      exfat: remove the assignment of 0 to bool variable

Joe Perches (1):
      exfat: Use a more common logging style

Namjae Jeon (2):
      exfat: remove unnecessary reassignment of p_uniname->name_len
      exfat: fix incorrect update of stream entry in __exfat_truncate()

Pali Roh=E1r=20(3):=0D=0A=20=20=20=20=20=20exfat:=20Simplify=20exfat_utf8_d=
_cmp()=20for=20code=20points=20above=20U+FFFF=0D=0A=20=20=20=20=20=20exfat:=
=20Simplify=20exfat_utf8_d_hash()=20for=20code=20points=20above=20U+FFFF=0D=
=0A=20=20=20=20=20=20exfat:=20Remove=20unused=20functions=20exfat_high_surr=
ogate()=20and=20exfat_low_surrogate()=0D=0A=0D=0ATetsuhiro=20Kohada=20(6):=
=0D=0A=20=20=20=20=20=20exfat:=20replace=20'time_ms'=20with=20'time_cs'=0D=
=0A=20=20=20=20=20=20exfat:=20optimize=20dir-cache=0D=0A=20=20=20=20=20=20e=
xfat:=20redefine=20PBR=20as=20boot_sector=0D=0A=20=20=20=20=20=20exfat:=20s=
eparate=20the=20boot=20sector=20analysis=0D=0A=20=20=20=20=20=20exfat:=20ad=
d=20boot=20region=20verification=0D=0A=20=20=20=20=20=20exfat:=20standardiz=
e=20checksum=20calculation=0D=0A=0D=0Ahyeongseok.kim=20(1):=0D=0A=20=20=20=
=20=20=20exfat:=20fix=20range=20validation=20error=20in=20alloc=20and=20fre=
e=20cluster=0D=0A=0D=0A=20fs/exfat/Kconfig=20=20=20=20=20=7C=20=20=207=20+-=
=0D=0A=20fs/exfat/balloc.c=20=20=20=20=7C=20=20=208=20+-=0D=0A=20fs/exfat/d=
ir.c=20=20=20=20=20=20=20=7C=20222=20+++++++++++++++++---------------------=
-----=0D=0A=20fs/exfat/exfat_fs.h=20=20=7C=20=2048=20+++++-----=0D=0A=20fs/=
exfat/exfat_raw.h=20=7C=20=2085=20+++++++----------=0D=0A=20fs/exfat/fatent=
.c=20=20=20=20=7C=20=2017=20++--=0D=0A=20fs/exfat/file.c=20=20=20=20=20=20=
=7C=20=2025=20+++--=0D=0A=20fs/exfat/inode.c=20=20=20=20=20=7C=20=2057=20++=
+++------=0D=0A=20fs/exfat/misc.c=20=20=20=20=20=20=7C=20=2046=20+++++----=
=0D=0A=20fs/exfat/namei.c=20=20=20=20=20=7C=20=2063=20+++++--------=0D=0A=
=20fs/exfat/nls.c=20=20=20=20=20=20=20=7C=20=2052=20+++-------=0D=0A=20fs/e=
xfat/super.c=20=20=20=20=20=7C=20262=20+++++++++++++++++++++++++++++++-----=
---------------=0D=0A=2012=20files=20changed,=20423=20insertions(+),=20469=
=20deletions(-)=0D=0A=0D=0A
