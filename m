Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1266FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BE52075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YGX3Czlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgDGPgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:36:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37342 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgDGPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:36:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id n17so2988617qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yfPVQGibhMomAOfYcoICtCwUK/9R3QEEWW5iQ0Auk1w=;
        b=YGX3CzlpC2QNzcEluGVU9Ex60Lgiy0GQl+62qk6Ti8XWPKDX+E7JWzafU36nL/Hns0
         yLbie3q9Ul9kwZL89s1Om5Lj/Cit35DuhGHp7kD0V4w/P7PotjyK53t+uCtf40/OPOO5
         /HyOJW1XG4gcevpxKLKKZR74gXHYWPWCb/oKXVEJRBSi/lMmtKpvPBruEPT4KadjG5Hz
         GwPTKuDnwHwqp5ceKZf9K6Dj4xFdlqVZBw+VUa/iGMYtlOHkQ8jjjHaaByPhbGDooMs4
         hY6H8PiGn1Cm0rMDT4bcqgYn31rcx5qalP94/DImbB0CkB8V+jfnWH/8t0NttUig0VqS
         tg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yfPVQGibhMomAOfYcoICtCwUK/9R3QEEWW5iQ0Auk1w=;
        b=NBqvzU23kwLfnbt69ek8r+aJPZIRn3KvqtF9+okqG0yEBSRGoEa2UdkT/nnwrzRwaQ
         tSKjE5e7wZNnMJZGe2XLAYGC+ng/mmo/ZMr5iimx+ppoLpKzS6nJBW37PTw8eVVO2n8C
         8LZaAiU6DOE2xls/WROWrlGPWcOmwWss/J3T6Vi0p8zloWfReyv62gHKxHHMGaLSpKhl
         b46WeneGz4THWTxtHPyaqKms/gUa0+bRqjvXBzOFW5A7cqrtAknC58iI7mbPt+CP3oSr
         QmDZNiqkPPfDh0eMDetFQfCxQqCIwJg7qaR2QJkfdiTPhLH5GAt5t5c/3sYzxRuCJ1y5
         3pwQ==
X-Gm-Message-State: AGi0PubFM5Nu48KmrKkvcgQjWHLDL0BdOq2yzt4TTbkVgodLAhpsHT9f
        8QcgkQNd7NOdQR9FBdw6ArBUeZmlO8ltuA==
X-Google-Smtp-Source: APiQypJ7IFEvxrg9/g/xTUjNwz5reLxxPlh8/GSKSJzcop5WMssKUPKhZ2mZ2JHs+BwlVjkAxdBMqQ==
X-Received: by 2002:ac8:4a94:: with SMTP id l20mr2840111qtq.302.1586273766929;
        Tue, 07 Apr 2020 08:36:06 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h135sm9916013qke.61.2020.04.07.08.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 08:36:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200407021246.10941-1-cai@lca.pw>
Date:   Tue, 7 Apr 2020 11:36:05 -0400
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
References: <20200407021246.10941-1-cai@lca.pw>
To:     joro@8bytes.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2020, at 10:12 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> fetch_pte() could race with increase_address_space() because it held =
no
> lock from iommu_unmap_page(). On the CPU that runs fetch_pte() it =
could
> see a stale domain->pt_root and a new increased domain->mode from
> increase_address_space(). As the result, it could trigger invalid
> accesses later on. Fix it by using a pair of smp_[w|r]mb in those
> places.

After further testing, the change along is insufficient. What I am =
chasing right
now is the swap device will go offline after heavy memory pressure =
below. The
symptom is similar to what we have in the commit,

754265bcab78 (=E2=80=9Ciommu/amd: Fix race in =
increase_address_space()=E2=80=9D)

Apparently, it is no possible to take the domain->lock in fetch_pte() =
because it
could sleep.

Thoughts?

[ 7292.727377][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd80000 =
flags=3D0x0010]
[ 7292.740571][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd81000 =
flags=3D0x0010]
[ 7292.753268][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd81900 =
flags=3D0x0010]
[ 7292.766078][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd81d00 =
flags=3D0x0010]
[ 7292.778447][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd82000 =
flags=3D0x0010]
[ 7292.790724][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd82400 =
flags=3D0x0010]
[ 7292.803195][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd82800 =
flags=3D0x0010]
[ 7292.815664][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd82c00 =
flags=3D0x0010]
[ 7292.828089][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd83000 =
flags=3D0x0010]
[ 7292.840468][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged =
[IO_PAGE_FAULT domain=3D0x0027 address=3D0xffffffffffd83400 =
flags=3D0x0010]
[ 7292.852795][  T814] AMD-Vi: Event logged [IO_PAGE_FAULT =
device=3D23:00.0 domain=3D0x0027 address=3D0xffffffffffd83800 =
flags=3D0x0010]
[ 7292.864566][  T814] AMD-Vi: Event logged [IO_PAGE_FAULT =
device=3D23:00.0 domain=3D0x0027 address=3D0xffffffffffd83c00 =
flags=3D0x0010]
[ 7326.583908][    C8] smartpqi 0000:23:00.0: controller is offline: =
status code 0x14803
[ 7326.592386][    C8] smartpqi 0000:23:00.0: controller offline
[ 7326.663728][   C66] sd 0:1:0:0: [sda] tag#467 UNKNOWN(0x2003) Result: =
hostbyte=3D0x01 driverbyte=3D0x00 cmd_age=3D6s
[ 7326.664321][ T2738] smartpqi 0000:23:00.0: resetting scsi 0:1:0:0
[ 7326.673849][   C66] sd 0:1:0:0: [sda] tag#467 CDB: opcode=3D0x28 28 =
00 02 ee 2e 60 00 00 08 00
[ 7326.680118][ T2738] smartpqi 0000:23:00.0: reset of scsi 0:1:0:0: =
FAILED
[ 7326.688612][   C66] blk_update_request: I/O error, dev sda, sector =
49163872 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 7326.695456][ T2738] sd 0:1:0:0: Device offlined - not ready after =
error recovery
[ 7326.706632][   C66] Read-error on swap-device (254:1:45833824)
[ 7326.714030][ T2738] sd 0:1:0:0: Device offlined - not ready after =
error recovery
[ 7326.723382][T45523] sd 0:1:0:0: rejecting I/O to offline device
[ 7326.727352][ T2738] sd 0:1:0:0: Device offlined - not ready after =
error recovery
[ 7326.727379][ T2738] sd 0:1:0:0: Device offlined - not ready after =
error recovery
[ 7326.727442][ T2738] sd 0:1:0:0: Device offlined - not ready after =
error recovery

>=20
> kernel BUG at drivers/iommu/amd_iommu.c:1704!
> BUG_ON(unmapped && !is_power_of_2(unmapped));
> Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 =
07/10/2019
> RIP: 0010:amd_iommu_unmap+0x1b2/0x1d0
> Call Trace:
>  <IRQ>
>  __iommu_unmap+0x106/0x320
>  iommu_unmap_fast+0xe/0x10
>  __iommu_dma_unmap+0xdc/0x1a0
>  iommu_dma_unmap_sg+0xae/0xd0
>  scsi_dma_unmap+0xe7/0x150
>  pqi_raid_io_complete+0x37/0x60 [smartpqi]
>  pqi_irq_handler+0x1fc/0x13f0 [smartpqi]
>  __handle_irq_event_percpu+0x78/0x4f0
>  handle_irq_event_percpu+0x70/0x100
>  handle_irq_event+0x5a/0x8b
>  handle_edge_irq+0x10c/0x370
>  do_IRQ+0x9e/0x1e0
>  common_interrupt+0xf/0xf
>  </IRQ>
>=20
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> drivers/iommu/amd_iommu.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 20cce366e951..22328a23335f 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1434,6 +1434,11 @@ static bool increase_address_space(struct =
protection_domain *domain,
> 	*pte             =3D PM_LEVEL_PDE(domain->mode,
> 					=
iommu_virt_to_phys(domain->pt_root));
> 	domain->pt_root  =3D pte;
> +	/*
> +	 * Make sure fetch_pte() will see the new domain->pt_root before =
it
> +	 * snapshots domain->mode.
> +	 */
> +	smp_wmb();
> 	domain->mode    +=3D 1;
>=20
> 	ret =3D true;
> @@ -1460,6 +1465,8 @@ static u64 *alloc_pte(struct protection_domain =
*domain,
> 		*updated =3D increase_address_space(domain, address, =
gfp) || *updated;
>=20
> 	level   =3D domain->mode - 1;
> +	/* To pair with smp_wmb() in increase_address_space(). */
> +	smp_rmb();
> 	pte     =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> 	address =3D PAGE_SIZE_ALIGN(address, page_size);
> 	end_lvl =3D PAGE_SIZE_LEVEL(page_size);
> @@ -1545,6 +1552,8 @@ static u64 *fetch_pte(struct protection_domain =
*domain,
> 		return NULL;
>=20
> 	level	   =3D  domain->mode - 1;
> +	/* To pair with smp_wmb() in increase_address_space(). */
> +	smp_rmb();
> 	pte	   =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> 	*page_size =3D  PTE_LEVEL_PAGE_SIZE(level);
>=20
> --=20
> 2.21.0 (Apple Git-122.2)
>=20

