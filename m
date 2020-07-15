Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC542067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1FdLCpqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGOGvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:51:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgGOGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:51:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06F6FpUX024368;
        Wed, 15 Jul 2020 08:51:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=vbuvzM4B1pzYFNQAdA/xW0KuMdcMV+YHFNrF1pRM0Ao=;
 b=1FdLCpqARMTs+AHaN4/DCuR7Lx+oGxPz/ohUXhAcMQB6ROpr2iG6wpQTmHtwqe3pwH8b
 qf+X8nh6NFFNMBxhv09fRdBKYnVkSf9FVCUT6PTIzRVN2nKUJpfR9reXXDkttml6C73C
 o7qTigMTDaplbFrTpWG42fBYl49TvS60IBDEKG/Lf8muLmGeLR6uL3z2HUZ5PJLX23t/
 3j594oHhZ85fO1a147T4sBjLxApedV1C59s2XCGGUazbLxvxob2gxIxvHWtwu3d2gmWw
 60AwtahQE+HS/2NAS0cFR6dS7/gBgaby+xSAZBD/esQk8m/ILbDjMlEHMn6zG9/hOnz6 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 327bkvbedu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 08:51:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A17610002A;
        Wed, 15 Jul 2020 08:51:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag7node1.st.com [10.75.127.19])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 89C3521CA7F;
        Wed, 15 Jul 2020 08:51:15 +0200 (CEST)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG7NODE1.st.com
 (10.75.127.19) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 08:51:14 +0200
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1473.003; Wed, 15 Jul 2020 08:51:14 +0200
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH v6 00/11] remoteproc: stm32: Add support for attaching to
 M4
Thread-Topic: [PATCH v6 00/11] remoteproc: stm32: Add support for attaching to
 M4
Thread-Index: AQHWWhoHKFc9kYSe9EGYwzCL4AzvBqkIMyOA
Date:   Wed, 15 Jul 2020 06:51:14 +0000
Message-ID: <1cde5c1d5d9047149c93e031c5093492@SFHDAG3NODE1.st.com>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_02:2020-07-15,2020-07-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

> -----Original Message-----
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> Sent: mardi 14 juillet 2020 22:05
> To: ohad@wizery.com; bjorn.andersson@linaro.org; Loic PALLARDY
> <loic.pallardy@st.com>; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> mcoquelin.stm32@gmail.com; Alexandre TORGUE
> <alexandre.torgue@st.com>
> Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; linux=
-
> stm32@st-md-mailman.stormreply.com
> Subject: [PATCH v6 00/11] remoteproc: stm32: Add support for attaching to
> M4
>=20
> This set applies on top of [1] and refactors the STM32 platform code in o=
rder
> to attach to the M4 remote processor when it has been started by the boot
> loader.
>=20
> New to V6:
> 1) Removed extra newline in patch 06.
> 2) Re-worked title and changelog of patch 08 to better reflect
>    what is done by the patch.
>=20
> Tested on ST's mp157c development board.

I don' t know if you don't see  it on last  version or if you prefer that I=
 review your update first... so for the series

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

>=20
> Thanks,
> Mathieu
>=20
> [1].https://patchwork.kernel.org/project/linux-
> remoteproc/list/?series=3D318275
>=20
> Mathieu Poirier (11):
>   remoteproc: stm32: Decouple rproc from memory translation
>   remoteproc: stm32: Request IRQ with platform device
>   remoteproc: stm32: Decouple rproc from DT parsing
>   remoteproc: stm32: Remove memory translation from DT parsing
>   remoteproc: stm32: Parse syscon that will manage M4 synchronisation
>   remoteproc: stm32: Properly set co-processor state when attaching
>   remoteproc: Make function rproc_resource_cleanup() public
>   remoteproc: stm32: Parse memory regions when attaching to M4
>   remoteproc: stm32: Properly handle the resource table when attaching
>   remoteproc: stm32: Introduce new attach() operation
>   remoteproc: stm32: Update M4 state in stm32_rproc_stop()
>=20
>  drivers/remoteproc/remoteproc_core.c |   3 +-
>  drivers/remoteproc/stm32_rproc.c     | 214 ++++++++++++++++++++++++--
> -
>  include/linux/remoteproc.h           |   1 +
>  3 files changed, 198 insertions(+), 20 deletions(-)
>=20
> --
> 2.25.1

