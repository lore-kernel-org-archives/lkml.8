Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273DF246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihkb5lVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgB1VZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:25:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56296 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgB1VZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:25:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SLO7j9038447
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2020-01-29;
 bh=E7XyFkTvbjpmPkHbdIsblJhB2bTjT3iJeDgMpf7dsPY=;
 b=ihkb5lVk4aI6H6lnZpcDpKsoOcz1nqFXFBv3vaBGbyAIn83DUGBuAoWH6+UoNhaycT4E
 d9e0hV+i/F+Ycvsrv5ogSn8NuHIc3sr9KMA806LPj7zfXEJhRu4oQrayxJhpcV9JuQWO
 eHG32X0XhNhexGcD//A3GB2Yla3gjjPrnzS05c4+GdtRys/msixFLBtIfHxPzTK8yoHb
 8EP8TpiJndAYA0rFReUynPlWJdIqsjyVtzDur7+sIryirdE6WKNGzEXUpbeQgpKms/j2
 vs2/Rzg/8QZHwVLiI4Ur79CsluuZKiQIisf7YaohkujNzXU0HglVrdt4V/XAjJ9Z0/du oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ydcsnwg2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:25:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SLGtlS115527
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:25:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ydcsg76cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:25:18 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SLPIMs001480
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:25:18 GMT
Received: from dhcp-10-154-108-96.vpn.oracle.com (/10.154.108.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 13:25:18 -0800
From:   John Donnelly <john.p.donnelly@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH ] ipmi_si: Fix false error about IRQ registration
Date:   Fri, 28 Feb 2020 15:25:16 -0600
References: <161D2B48-8034-4467-A085-7B69458144C9@oracle.com>
To:     linux-kernel@vger.kernel.org
In-Reply-To: <161D2B48-8034-4467-A085-7B69458144C9@oracle.com>
Message-Id: <5E488521-038E-4F6E-A2DB-5A5A61271069@oracle.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=5 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=5 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Ignore . =20

Let me correct the contents in v2=20


> On Feb 28, 2020, at 3:22 PM, John Donnelly =
<john.p.donnelly@oracle.com> wrote:
>=20
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error =
message
> to platform_get_irq()"), platform_get_irq() will call dev_err() on an
> error,  even though the IRQ usage in the ipmi_si driver is optional.
>=20
> Use the platform_get_irq_optional() call to avoid the message from
> alerting users with false alarms.
>=20
> Orabug: 30970275
>=20
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
> drivers/char/ipmi/ipmi_si_platform.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c =
b/drivers/char/ipmi/ipmi_si_platform.c
> index c78127ccbc0d..638c693e17ad 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -194,7 +194,7 @@ static int platform_ipmi_probe(struct =
platform_device *pdev)
> 	else
> 		io.slave_addr =3D slave_addr;
>=20
> -	io.irq =3D platform_get_irq(pdev, 0);
> +	io.irq =3D platform_get_irq_optional(pdev, 0);
> 	if (io.irq > 0)
> 		io.irq_setup =3D ipmi_std_irq_setup;
> 	else
> @@ -378,7 +378,7 @@ static int acpi_ipmi_probe(struct platform_device =
*pdev)
> 		io.irq =3D tmp;
> 		io.irq_setup =3D acpi_gpe_irq_setup;
> 	} else {
> -		int irq =3D platform_get_irq(pdev, 0);
> +		int irq =3D platform_get_irq_optional(pdev, 0);
>=20
> 		if (irq > 0) {
> 			io.irq =3D irq;
> --=20
> 2.20.1

