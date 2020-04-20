Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8955C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3FA20722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="c3/4bJ/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgDTN0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgDTN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:26:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA75C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:26:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di6so4594918qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sCegpLgyeLvs6qN2/1JbngJ3uEKPNLHvT6q0OtKcerY=;
        b=c3/4bJ/KEMjjLB5WUe9Lo1uv0FDYpF5gyVS3atAxX5092wJG6uG2HlaE4ydsFL+Vpa
         K8wmq4FkyDfeMX/8bT/J2EKwlT6QMlYoH7Pz4eEJLrW1HJnBUeI7Gu8YhVfJE2JfY/r7
         3cShtiPtR5UOrQD/3nv9C8XXFLQeaAAIzsvI7Sftr5V3GixVPM7XiIE8VM17z8hnA8N2
         FQJhQK8YsxOSFnLrSfk0p6i9PIcXQRMS2LMzu2BEKEo0VMOdjzpoI8iRG0zZGUrUWO3x
         kLk1ZbVZ6msyBFi+VDT5sNAcjXNQQQKTBBVpP+vxsfWm4qvptZH+3WdV/yGky6uklyeO
         qrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sCegpLgyeLvs6qN2/1JbngJ3uEKPNLHvT6q0OtKcerY=;
        b=aRli9G/VxtO07YcofOSHJbTB12jyPJZNbK6G9jzXV9z9Kj2MCA8PM+gESIdYt/fRRD
         vEEHIPCYTPU1Ci0fzk+I7KlkL6cMUSvzdaY9je0k+xZd2x9ROZj4f5ILO3U7w2RfG93L
         LR03TyA69/GSWDCOg6TfMMUZi+oqytVOw8UdpPNI7Vt22y0Qz5Hm/PZQxYyE93RE4MFa
         8j86xXgHbGkRGuejF8XpQwayZADYzIXLZTjSK19O2J3ULS4wxz5feDMLXLaMNErOOVAO
         4gwI1zcwUkf5LNSLOmAnCbz4TcfzdOgvDrApFGTlPryLTnoTP6bySCfKe3X5Dzp4wSKs
         vPeA==
X-Gm-Message-State: AGi0PubalxapuvO7sF9gEGfXW6NLo1Scwdc7MxAyOi/GYokczV1eWlMu
        ts2t9bXJQemnPdgTxQYE1kZeJwfuBlKjMA==
X-Google-Smtp-Source: APiQypIO/tZZ30pqN8ji7fhqlwU/yISS2ezzKmmdxuYNY0eOAelunHdF3TwYYsRmrbpxzvbyJ5yz0w==
X-Received: by 2002:a0c:e549:: with SMTP id n9mr15261857qvm.214.1587389174002;
        Mon, 20 Apr 2020 06:26:14 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b201sm558203qkg.32.2020.04.20.06.26.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 06:26:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200418183429.GH21900@8bytes.org>
Date:   Mon, 20 Apr 2020 09:26:12 -0400
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 18, 2020, at 2:34 PM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Sat, Apr 18, 2020 at 09:01:35AM -0400, Qian Cai wrote:
>> Hard to tell without testing further. I=E2=80=99ll leave that =
optimization in
>> the future, and focus on fixing those races first.
>=20
> Yeah right, we should fix the existing races first before introducing
> new ones ;)
>=20
> Btw, THANKS A LOT for tracking down all these race condition bugs, I =
am
> not even remotely able to trigger them with the hardware I have =
around.
>=20
> I did some hacking and the attached diff shows how I think this race
> condition needs to be fixed. I boot-tested this fix on-top of =
v5.7-rc1,
> but did no further testing. Can you test it please?

No dice. There could be some other races. For example,

> @@ -1536,16 +1571,19 @@ static u64 *fetch_pte(struct protection_domain =
*domain,
> 		      unsigned long address,
> 		      unsigned long *page_size)
...
> 	amd_iommu_domain_get_pgtable(domain, &pgtable);
>=20
> 	if (address > PM_LEVEL_SIZE(pgtable.mode))
> 		return NULL;
>=20
> 	level	   =3D  pgtable.mode - 1;
> 	pte	   =3D &pgtable.root[PM_LEVEL_INDEX(level, address)];

<=E2=80=94 increase_address_space()

> 	*page_size =3D  PTE_LEVEL_PAGE_SIZE(level);
>=20

	while (level > 0) {
		*page_size =3D PTE_LEVEL_PAGE_SIZE(level);

Then in iommu_unmap_page(),

	while (unmapped < page_size) {
		pte =3D fetch_pte(dom, bus_addr, &unmap_size);
		=E2=80=A6
		bus_addr  =3D (bus_addr & ~(unmap_size - 1)) + =
unmap_size;

bus_addr would be unsync with dom->mode when it enter fetch_pte() again.
Could that be a problem?


[ 5159.274829][ T4057] LTP: starting oom02
[ 5160.382787][   C52] perf: interrupt took too long (7443 > 6208), =
lowering kernel.perf_event_max_sample_rate to 26800
[ 5167.951785][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc0000 =
flags=3D0x0010]
[ 5167.964540][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc1000 =
flags=3D0x0010]
[ 5167.977442][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc1900 =
flags=3D0x0010]
[ 5167.989901][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc1d00 =
flags=3D0x0010]
[ 5168.002291][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc2000 =
flags=3D0x0010]
[ 5168.014665][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc2400 =
flags=3D0x0010]
[ 5168.027132][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc2800 =
flags=3D0x0010]
[ 5168.039566][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc2c00 =
flags=3D0x0010]
[ 5168.051956][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc3000 =
flags=3D0x0010]
[ 5168.064310][  T812] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xfffffffffffc3400 =
flags=3D0x0010]
[ 5168.076652][  T812] AMD-Vi: Event logged [IO_PAGE_FAULT =
device=3D23:00.0 domain=3D0x0027 address=3D0xfffffffffffc3800 =
flags=3D0x0010]
[ 5168.088290][  T812] AMD-Vi: Event logged [IO_PAGE_FAULT =
device=3D23:00.0 domain=3D0x0027 address=3D0xfffffffffffc3c00 =
flags=3D0x0010]
[ 5183.695829][    C8] smartpqi 0000:23:00.0: controller is offline: =
status code 0x14803
[ 5183.704390][    C8] smartpqi 0000:23:00.0: controller offline
[ 5183.756594][  C101] blk_update_request: I/O error, dev sda, sector =
22306304 op 0x1:(WRITE) flags 0x8000000 phys_seg 4 prio class 0
[ 5183.756628][   C34] sd 0:1:0:0: [sda] tag#655 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.756759][   C56] blk_update_request: I/O error, dev sda, sector =
58480128 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.756810][   C79] sd 0:1:0:0: [sda] tag#234 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.756816][  C121] sd 0:1:0:0: [sda] tag#104 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.756837][   T53] sd 0:1:0:0: [sda] tag#4 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.756882][  C121] sd 0:1:0:0: [sda] tag#104 CDB: opcode=3D0x2a 2a =
00 00 4d d4 00 00 02 00 00
[ 5183.756892][   C79] sd 0:1:0:0: [sda] tag#234 CDB: opcode=3D0x2a 2a =
00 02 03 e4 00 00 02 00 00
[ 5183.756909][  C121] blk_update_request: I/O error, dev sda, sector =
5100544 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.756920][   C79] blk_update_request: I/O error, dev sda, sector =
33809408 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.756939][   T53] sd 0:1:0:0: [sda] tag#4 CDB: opcode=3D0x2a 2a 00 =
02 4b f8 00 00 02 00 00
[ 5183.756967][   T53] blk_update_request: I/O error, dev sda, sector =
38533120 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.756989][   C49] blk_update_request: I/O error, dev sda, sector =
30181376 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.757045][   C51] sd 0:1:0:0: [sda] tag#452 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.757107][   C51] sd 0:1:0:0: [sda] tag#452 CDB: opcode=3D0x2a 2a =
00 02 95 06 00 00 02 00 00
[ 5183.757125][   C51] blk_update_request: I/O error, dev sda, sector =
43320832 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.757199][   C82] blk_update_request: I/O error, dev sda, sector =
10187776 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.757209][  C109] blk_update_request: I/O error, dev sda, sector =
29812736 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.757215][   C77] sd 0:1:0:0: [sda] tag#849 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.757222][  C110] sd 0:1:0:0: [sda] tag#558 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.757237][   C92] blk_update_request: I/O error, dev sda, sector =
6410240 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0
[ 5183.757244][   C91] sd 0:1:0:0: [sda] tag#73 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.757251][   C68] sd 0:1:0:0: [sda] tag#416 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.757458][   C77] sd 0:1:0:0: [sda] tag#849 CDB: opcode=3D0x2a 2a =
00 02 78 a4 00 00 02 00 00
[ 5183.757467][  C110] sd 0:1:0:0: [sda] tag#558 CDB: opcode=3D0x2a 2a =
00 03 58 94 00 00 02 00 00
[ 5183.757515][  C122] sd 0:1:0:0: [sda] tag#747 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D15s
[ 5183.757525][   C68] sd 0:1:0:0: [sda] tag#416 CDB: opcode=3D0x2a 2a =
00 01 0e 32 00 00 02 00 00
[ 5183.757536][   C91] sd 0:1:0:0: [sda] tag#73 CDB: opcode=3D0x2a 2a 00 =
01 a2 86 00 00 02 00 00
[ 5183.757727][  C122] sd 0:1:0:0: [sda] tag#747 CDB: opcode=3D0x2a 2a =
00 02 a7 24 00 00 02 00 00
[ 5183.758530][   T53] Write-error on swap-device (254:1:64823296)
[ 5183.758758][   T53] Write-error on swap-device (254:1:35201024)
[ 5183.758811][  C105] Write-error on swap-device (254:1:52690944)
[ 5183.758959][   C82] Write-error on swap-device (254:1:6856704)



