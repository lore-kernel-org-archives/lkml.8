Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB538C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF20208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="oya7M2Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEGUcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:32:45 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:29950 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgEGUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:32:45 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047KTmvf031978;
        Thu, 7 May 2020 16:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=rPAJ8LZwqCBPWhT585JNmeF+aZt0Nu3YZmtZwvC2+qI=;
 b=oya7M2IyeTtwzY86Xv+auhzSKzfk/PVKTUOlLUhTBaTqNIiBhrtTnwOSE7D7W1z9d7xo
 G9zUmdcevHVcTF4KBocduoFB1Ns1ZBreVaXIO6x2wx/8yd3RwZQht5/vc64/Q0TB8I1r
 cveZcJpI3GUKEyZWRFMh3JgRE6WKPIlGwHdj0j1VX6SoB3lhm8580ctOlJyPxQ3mPX7F
 Gn+fR4s6KD7LGjhtsn1Grj1/VVyddyBm0S7NsJHk2IzB7LrHNU3nIfLRW21UUCspNTdd
 2vhjE9FsmVPRqfDZPEJFQRYblKBosyDUaKaFI3S0tO8D2xBsmJW3hgUAhXck9pkcfTSc 2g== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30s4py7kah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 16:32:45 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047KVekE018316;
        Thu, 7 May 2020 16:32:44 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 30vkj3p13a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 16:32:44 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="546829762"
From:   <Mario.Limonciello@dell.com>
To:     <koba.ko@canonical.com>, <andy.shevchenko@gmail.com>
CC:     <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Topic: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Index: AQHWJFPpvfyIH0nLT0eHUvql2g/2/6icw1oAgAADsACAAEt3MA==
Date:   Thu, 7 May 2020 20:26:36 +0000
Message-ID: <e0eb1c5f17574bfcb6dd58d12b37ce7b@AUSX13MPC101.AMER.DELL.COM>
References: <20200507094242.7523-1-koba.ko@canonical.com>
 <CAHp75VeDFpjwZoNWj6SwvnHE70o4x+U9GnK-tbrFpK6fkBN7MA@mail.gmail.com>
 <CAJB-X+U9vOzKNt3Z-BzZrEJhyU0Gd_5rVM=yqfy3TZTWNn2_YA@mail.gmail.com>
In-Reply-To: <CAJB-X+U9vOzKNt3Z-BzZrEJhyU0Gd_5rVM=yqfy3TZTWNn2_YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=f76a65f6-cc68-492e-9330-b8ed44b69bad;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-07T20:26:28.4606728Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_14:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=737
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070162
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=830 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBoaSBBbmR5LA0KPiBpdCdzIGRlbGwgZzMgMzU5MC4NCg0KT0ssIHNvIHRoaXMgaXMgcmVsZWFz
ZWQgaGFyZHdhcmUgaW4gSW5zcGlyb24uDQoNCkkgdGhpbmsgdGhpcyBwYXRjaCBnZW5lcmFsbHkg
bWFrZXMgZ29vZCBzZW5zZSBmb3IgdGhhdCBjYXNlLg0KDQo=
