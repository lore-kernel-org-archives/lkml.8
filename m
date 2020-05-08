Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AD721775
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="IObn8K5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgEHRZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:25:29 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:58564 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbgEHRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:25:28 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048HBJX1030513;
        Fri, 8 May 2020 13:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=gxHTONjMJ/6z9rZgSNwvSim25VdhYsckGdfAECNx4JE=;
 b=IObn8K5Byv6MlXZ4IV/TOxdF1vBNk5BHlGolIHsmTZSuz5VrZZcMHiDSUjEEhrxyHd9j
 /kxYyv974bnIhey4SddqEGQFLlPPyZ+wr2b8iyxpdwliSzU2LgiYKbssphRcY9ete/Ec
 wwB2sAQc2hRJa0cCDXXVQZuldRyBu519fMvJrDD8U5/R7oD1AX8Lin27yw5Z6sMcAl9W
 2mkFQvVpvKRC1KrGcC6A0IeC5sXjR3TTTGhXu0M/nWeJz7xPTyo7G37eWcQk0MSfOQBc
 Oy9zF0GPD0exZa0XU0TIPOSDO1d8xR+YSW3Evu5xCJnzD4BeVzHxwcXlqIRVSjvB7rS7 KQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30vtetahg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:25:27 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048HPPvG095919;
        Fri, 8 May 2020 13:25:27 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 30w4myp86a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 May 2020 13:25:27 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1553800230"
From:   <Mario.Limonciello@dell.com>
To:     <koba.ko@canonical.com>
CC:     <andy.shevchenko@gmail.com>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Topic: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Index: AQHWJFPpvfyIH0nLT0eHUvql2g/2/6icw1oAgAADsACAAEt3MIABJgMAgAA5hLA=
Date:   Fri, 8 May 2020 17:25:24 +0000
Message-ID: <99e0ccfba0fe4fba8030a056a2dd7492@AUSX13MPC105.AMER.DELL.COM>
References: <20200507094242.7523-1-koba.ko@canonical.com>
 <CAHp75VeDFpjwZoNWj6SwvnHE70o4x+U9GnK-tbrFpK6fkBN7MA@mail.gmail.com>
 <CAJB-X+U9vOzKNt3Z-BzZrEJhyU0Gd_5rVM=yqfy3TZTWNn2_YA@mail.gmail.com>
 <e0eb1c5f17574bfcb6dd58d12b37ce7b@AUSX13MPC101.AMER.DELL.COM>
 <CAJB-X+UTzknY63mL2iY5mXNDYm9ohm2ZeQBdPDUBZ+MSkcUAFQ@mail.gmail.com>
In-Reply-To: <CAJB-X+UTzknY63mL2iY5mXNDYm9ohm2ZeQBdPDUBZ+MSkcUAFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-08T17:24:35.4438079Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e393018c-57f4-47d7-a741-e33987e6c8cd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_15:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=828
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080146
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=910 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBoaSBBbGwswqANCj4gQXMgcGVyIGFkdmVydGlzZW1lbnQsIFVwZGF0ZSB0aGUgcGF0Y2guDQo+
IFBsZWFzZSBoZWxwIHRvIHJldmlldy4NCg0KS29iYSwNCg0KMSkgUGxlYXNlIHJlc2VuZCBwYXRj
aCBhcyBpbmxpbmUgdGV4dCB0byBtYWlsaW5nIGxpc3QsIG5vdCBhdHRhY2htZW50Lg0KMikgQWxz
byB5b3UgaGF2ZSBhIHR5cG9ncmFwaGljYWwgZXJyb3IgaW4geW91ciBjb21taXQgbWVzc2FnZSwg
eW91IHNob3VsZCBmaXggKG1lc3NnZSBtaXNzcGVsbGVkKQ0KMykgWW91IGhhdmUgYSBncmFtbWF0
aWNhbCBlcnJvciBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlKCJpc24ndCBwcmVzZW50ZWQiKQ0KNCkg
QXMgeW91IHJldiB0aGUgcGF0Y2gsIHlvdSBjYW4gdXBkYXRlIGluIHRoZSB0aXRsZSBmcm9tIFtQ
QVRDSF0gdG8gW1BBVENIIHYyXSBhbmQgc28gb24uDQoNClRoYW5rcywNCg0K
