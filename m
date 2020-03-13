Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CCEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ABC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lTwGnuyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCMQxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:53:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26578 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgCMQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:53:05 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DGikUU025339;
        Fri, 13 Mar 2020 17:52:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=arHqyZMcMY2U5UePP3d/A6h4uuFwryqbpgb/SdplBto=;
 b=lTwGnuyb67U5yuzXx07vk2tjTfpezVq0/nNNVTwLXH/TqR04GQpSOzpSHEGECnBffzkZ
 misMTC2eb0g4LulXFIeYwjmnaJle0qa9xqgkRzA6eQ+MdKhyAe7IPfPqJ7Oo+f4vwRTI
 LiRn0+y8K1EXvwSwSk9Dp52U4q+7/DMcsreNIxP6IRZri/Szxv9abVZ/4TWdCvdaYkeI
 +/PZHHRtB/CeOUW3J4sNN1J9LQ1V8fUKy/LBPUADcBXNs93dkin7l0AyDzHiH3TnSHMP
 5igkQ53oYFys+RDFXgLZKovyf58AD67apuMik/iWRx3Wt4uHvh+5vfRSKF45PbESiL2w lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yqt7t34m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 17:52:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8914110002A;
        Fri, 13 Mar 2020 17:52:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B3F72B187E;
        Fri, 13 Mar 2020 17:52:52 +0100 (CET)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Mar
 2020 17:52:52 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1473.003; Fri, 13 Mar 2020 17:52:52 +0100
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] remoteproc: fall back to using parent memory pool if
 no dedicated available
Thread-Topic: [PATCH 1/2] remoteproc: fall back to using parent memory pool if
 no dedicated available
Thread-Index: AQHV8z8wdNhXoitGJkaDXZkUeB6A96hGxfVg
Date:   Fri, 13 Mar 2020 16:52:52 +0000
Message-ID: <ce37072d2f304214aa920e66fa3b30b1@SFHDAG3NODE1.st.com>
References: <20200305224108.21351-1-s-anna@ti.com>
 <20200305224108.21351-2-s-anna@ti.com>
In-Reply-To: <20200305224108.21351-2-s-anna@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_06:2020-03-12,2020-03-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

> -----Original Message-----
> From: Suman Anna <s-anna@ti.com>
> Sent: jeudi 5 mars 2020 23:41
> To: Bjorn Andersson <bjorn.andersson@linaro.org>; Loic PALLARDY
> <loic.pallardy@st.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>; Arnaud POULIQUEN
> <arnaud.pouliquen@st.com>; Tero Kristo <t-kristo@ti.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Suman Anna
> <s-anna@ti.com>
> Subject: [PATCH 1/2] remoteproc: fall back to using parent memory pool if=
 no
> dedicated available
>=20
> From: Tero Kristo <t-kristo@ti.com>
>=20
> In some cases, like with OMAP remoteproc, we are not creating dedicated
> memory pool for the virtio device. Instead, we use the same memory pool
> for all shared memories. The current virtio memory pool handling forces a
> split between these two, as a separate device is created for it, causing
> memory to be allocated from bad location if the dedicated pool is not
> available. Fix this by falling back to using the parent device memory poo=
l if
> dedicated is not available.
>=20
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma
> memory pool")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/remoteproc/remoteproc_virtio.c
> b/drivers/remoteproc/remoteproc_virtio.c
> index 8c07cb2ca8ba..4723ebe574b8 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -368,6 +368,16 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev,
> int id)
>  				goto out;
>  			}
>  		}
> +	} else {
> +		struct device_node *np =3D rproc->dev.parent->of_node;
> +
> +		/*
> +		 * If we don't have dedicated buffer, just attempt to
> +		 * re-assign the reserved memory from our parent.
> +		 * Failure is non-critical so don't check return value
> +		 * either.
> +		 */
> +		of_reserved_mem_device_init_by_idx(dev, np, 0);
>  	}
I aven't tested your patchset yet, but reviewing you code,  I wonder if you=
 cannot declare your  memory pool
in your platform driver using  rproc_of_resm_mem_entry_init. Something like=
:
	struct device_node *mem_node;
	struct reserved_mem *rmem;

	mem_node =3D of_parse_phandle(dev->of_node, "memory-region", 0);
	rmem =3D of_reserved_mem_lookup(mem_node);
	mem =3D rproc_of_resm_mem_entry_init(dev, 0,
							   rmem->size,
							   rmem->base,
							   " vdev0buffer");

A main advantage of this implementation would be that the index of the memo=
ry region would not be hard coded to 0.

Regards,
Arnaud
>=20
>  	/* Allocate virtio device */
> --
> 2.23.0

