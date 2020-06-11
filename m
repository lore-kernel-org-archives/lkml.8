Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0544AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21EC20691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="re314xT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgFKNO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:14:59 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:50164 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgFKNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:14:58 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BDDgwh018476;
        Thu, 11 Jun 2020 09:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=aTCE/pasSWUWuGDYqRZBQC/dpb9VxP8Sxs048GpAW9I=;
 b=re314xT7nTSZAJv8K6JsnsYB2NQxgbmCY/4U+IMoUDRalh1zJ+DhCb54MoDHl5VUbrkc
 QWE8P/a/+8/uQlfkkzjg2j6zL5RANtqAbvBQem0rB2yUienGSpJfks+kGPBrHCjpukrL
 +1dUeq3NwePPFILZ6y8daaDfYrNCx1QAcXiTC65mpsp4n6/eLJwRiuYRU+jrxkTJqXu0
 /U4XFH7OqamkcpYaSlrd+fwq23BuY/hl196/LQPgkJhjNnhHyOfmknLpLux3ood/EB1E
 l+BCg77lhxJTe6WoyskvILTE93P0jTuov6sb6bFcuH6bD5WU7qPfRLQxjI/IVteHo6xq uA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31kmfqg614-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 09:14:57 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BDBxi6026642;
        Thu, 11 Jun 2020 09:14:56 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 31kmmd0qmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 09:14:56 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1396607749"
From:   <Mario.Limonciello@dell.com>
To:     <kai.heng.feng@canonical.com>
CC:     <alex.hung@canonical.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
 platforms
Thread-Topic: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on
 HP platforms
Thread-Index: AQHWPz3dlpIDtGIT702KohBct4fb0ajR/puQgAFXIQCAABAKUA==
Date:   Thu, 11 Jun 2020 13:14:54 +0000
Message-ID: <3b47d04a379a4c709d38f0ca4c17dff4@AUSX13MPC105.AMER.DELL.COM>
References: <20200610153747.27040-1-kai.heng.feng@canonical.com>
 <4d0714fe5e2548b6b638ea447ad19490@AUSX13MPC105.AMER.DELL.COM>
 <82013BD4-B247-4E4E-94AB-1BEF8403E6E6@canonical.com>
In-Reply-To: <82013BD4-B247-4E4E-94AB-1BEF8403E6E6@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-11T13:14:50.9418029Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=b02f13e2-2eee-4ada-9e20-aa46b53ae43e;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_14:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=779 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110103
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=861 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just having the ACPI device present doesn't actually mean that the user
> > has a kernel compiled with hp-wireless or that it has finished
> initializing.
>=20
> We can use IS_REACHEABLE() to see if it's compiled.

Yes that was going to be my first suggestion.

>=20
> >
> > I would think this needs a better handshake in case hp-wireless was
> unloaded
> > or not present so the event could still come through intel-hid in this
> > circumstance.
>=20
> However, it's hard to determine if the other driver has finished
> initialization or any form of cross module handshake.
> Can you please point me to any good example if there's one?

Take a look at how drivers that use dell-wmi-descriptor work.  They can rel=
y
upon looking at -EPROBE_DEFER return code when trying to access the functio=
nality
and do a handoff.

>=20
> >
> >> +
> >> 	return AE_OK;
> >> }
> >>
> >> --
> >> 2.17.1

