Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A257C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C74B2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="Q7umbbDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHZHH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:07:29 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:39948 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgHZHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:07:25 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95B0D640BE;
        Wed, 26 Aug 2020 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598425644;
        bh=kuHtmExW8Yw02JbwLf+n/UO/6GZaBIwKid1I4hrmEQM=; h=From:To:Date;
        b=Q7umbbDaqToR96Tl7LuX6sw1fRG3nYOFudY37SxqRtrgN/LW7cXBCAB2fAIc5l/rD
         93sZjdjtJsmkToL8V17HI3Fy137GfI2R2OHQVe1kHbIaHTuh7RclZ79F/n/F1hMEWn
         TOD9rPvf4pCgRgEfC7s2yUs26chicJi92XzXCqEs=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 921FD64067;
        Wed, 26 Aug 2020 00:07:13 -0700 (PDT)
Received: from SJDC-EXNABU01.us.trendnet.org (unknown [10.45.175.97])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Wed, 26 Aug 2020 00:07:13 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU01.us.trendnet.org (10.45.175.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Wed, 26 Aug 2020 00:07:12 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Wed, 26 Aug 2020 07:07:09 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913%18]) with mapi id
 15.01.1979.003; Wed, 26 Aug 2020 07:07:09 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Topic: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Index: AdZ5/y9ucVi7Kf0NSwa8vnc6Q/ol0wAL6hEAAAENaQAAHQZRAAAMWPyAACXNoJA=
Date:   Wed, 26 Aug 2020 07:07:09 +0000
Message-ID: <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25626.005
X-TM-AS-Result: No--19.029-5.0-31-10
X-TMASE-MatchedRID: 98bUcqHGRvbUL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jRd964B0EJ1lSio
        vVyGVXbFKmeI7ghTOjcfhLGyUXA59/KFri4StE39LFirdaqw+KE2G/FPZyfo2eD3XFrJfgvzrKo
        fIiDqo7megzVPOSQLWBgIvzKkEDfZM5HyYnErO2L0VCHd+VQiHsRJLE/FNr2DjiLABC6i+1hgnM
        5OW7uHdM/ymgF2tZzvhmZWBnxHZ3lBfzHhcQGKcamukiZOfPi2gE4FBVDR3kM8qL0sJ8BVQMnVM
        c+t6fuTzM2aIr4VkeyHvsREzkPkKKA4ukC2XUZKIfL45CnfneZVogWRsEaR/misn1mjz82fdD+P
        c7R2toEs2xnl9FoUry6pAEHv9hRcIf+ogqnxgeDWxKMzYVwHVzoSfZud5+GgVj3J63pAR3yqSAN
        PD7m9/OHLiIj0hrvXHuJmtbnD+5h//2guIJ+U2MK1Ib9JAALxfS0Ip2eEHnym8jxRk5/juPc8OJ
        c7+0VJ9xS3mVzWUuC1PimItaljun7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.029000-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25626.005
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: 663136F2045C0C09973C77CE489421AD1B67191AFAC6FF281615FF44B84AA26B2000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--19.029-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: peterz@infradead.org <peterz@infradead.org>
> Sent: Tuesday, August 25, 2020 8:09 PM
> To: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; linux-kernel@vger.kernel.or=
g; x86@kernel.org; David S. Miller
> <davem@davemloft.net>
> Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at funct=
ion entry is not optimized (trigger by int3 breakpoint)
>
> Surely we can do a lockless list for this. We have llist_add() and
> llist_del_first() to make a lockless LIFO/stack.
>

llist operations require atomic cmpxchg, for some arch doesn't have CONFIG_=
ARCH_HAVE_NMI_SAFE_CMPXCHG, in_nmi() check might still needed.
(HAVE_KRETPROBES && !CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG): arc, arm, csky, mi=
ps

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>
