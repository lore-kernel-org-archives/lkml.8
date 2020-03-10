Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3245C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508A92468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gsef4vcz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="NhOA9gBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCJMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:18:37 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39156 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgCJMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:18:36 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D0E0DC08E4;
        Tue, 10 Mar 2020 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583842715; bh=yNj++G4P+gDySRZKOasJLK05jyU5+SQ5UDE9u+nTMf8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Gsef4vcz3lu92Y42wLhIl8PJeXlIAp6cOP+sHewc7K4Tr4nkRMhsJ9HLw6mPY4Biq
         dl4dVxQgp/RYRFF0paIXPLlcRfMB0r6QbAmjyvdCnSf4Y7darc4NsMra/BN6yFfSo4
         Q0OgZNhC3gFrSNsp/EL0hj++WUSl7/uNEiM9It/sGvnOwTXO3rm5Kp0mf64uY816jL
         HqwSpQiJMkvJAXh8DJfBgkCMvZkVuaaSqU5Wq7Ba/Aanl4YUo/HGXRaWKp9li2byAx
         6lZMeCaDn8twPtzNciePG/PHvV3zOaGr4jDc+usPQj81MFKrs1geLGoVp39NsL1OAn
         c04JL0TWEiYYA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9BC47A0079;
        Tue, 10 Mar 2020 12:18:24 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 05:18:19 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 10 Mar 2020 05:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbZX/gUXzAjCx5qg+Ok/Ohis7IohyFkvsvyTkOGxnDZYv/sBGB4zIR7lmia9z960b9QyPP58W+ISteHHL3nyqciZmfOsnhhNbbuc1Z2AHNq50vgHRea6WIq0F61UVbb15uiZ6vn9f63xZrwNK5qs5eXFPfZBz/9v/6HyFPLhJe498mtNWzRNICatqjo4P8eNwi6dEiW76QaBr+au4z6v/HVJZNCv/+1D/o11ncUM6CRJVu+tg5+YZWA3k9Uw3q9zW/OZBQ6hUdaWiIM4SBK6iAtW3R9pIItlDvXxdwyh0vZnTcRHjbja1WMFInt86s1XaDD5ZqqMl08OoAfpFSIPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNj++G4P+gDySRZKOasJLK05jyU5+SQ5UDE9u+nTMf8=;
 b=AE3mcy55gkv8gg0B/UTJgv4/tmJzEGhdLqBNnZiVJA+bSSl0xscmtveT8PbAdQ4GMEfjbgEF1Ka2qv7G43aVjj2i7xd+SHtk+h126SAc0oxBfXpm4dR2WDfKrL/mY8PPOMY2PP/KZiA0cuPiVMrvu9nFXG2/r+opZ8NqpGw8DPb+zoZY2LHwiQK890CRepuDHXm90EKODsbuGM0jwSYx+IDY7FwZLRNC/jqIbvsIiQviyCxYYrPzGpmJzMtn1HKjW1H5723D7AMjo1LQni15+M4buUzsOdIMdyr88iUjFxHHJ1U+DNIKvrNzs1lgbTNVfZLtk5jvMndFBSBcxYMU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNj++G4P+gDySRZKOasJLK05jyU5+SQ5UDE9u+nTMf8=;
 b=NhOA9gBCQpPakB5LnqgI5EATx9VEcdda7LNe9Krety1T2coKIT5WSC1QpLxv1vvFUGFSbKTCGP4bo4nCorg7fbDKW+FizyHKbC8cq+LCe515XsOKb/K420hrwqQJO7i4iXQ9ZMAxq8dT5PLMHN3rCHaF+4KGqyvIMXil+HG8B/o=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 12:18:15 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 12:18:15 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ARC: handle DSP presence in HW
Thread-Topic: [PATCH v2 2/4] ARC: handle DSP presence in HW
Thread-Index: AQHV8ykv/JMPPGHpokOBrJCtc4/bvKg8Q+KAgAV+8B0=
Date:   Tue, 10 Mar 2020 12:18:15 +0000
Message-ID: <BY5PR12MB40344989C3CB5881729F660CDEFF0@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
 <20200305200252.14278-3-Eugeniy.Paltsev@synopsys.com>,<2d11b6d9-a37a-8cc3-1feb-a9dbc345de12@synopsys.com>
In-Reply-To: <2d11b6d9-a37a-8cc3-1feb-a9dbc345de12@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [5.18.243.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dda1ec26-6ecc-46fa-98f1-08d7c4ed1c6c
x-ms-traffictypediagnostic: BY5PR12MB4035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40350049416295F9C3B412CBDEFF0@BY5PR12MB4035.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(66946007)(26005)(4326008)(52536014)(33656002)(66476007)(8676002)(81166006)(81156014)(76116006)(64756008)(9686003)(66446008)(66556008)(55016002)(91956017)(6506007)(110136005)(7696005)(54906003)(2906002)(186003)(8936002)(71200400001)(498600001)(5660300002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB4035;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYPkY1/GyUJK1Avh/TDfrFkvK0GzcU+wGQ74KTA889SBVhksHoEFGRlgQobJEAmAqSvSW8mI4CEb3HVwDsSdTVmsQemgbV5Hv1vl/l4+p7FYcwB/VIekdYphk6t2PXjaqcRrLFqY7njAlWNl5vfp8FXxzF1cWOHCkeAjvyOslPlUhDdj0pfoOx4SR2pVf0at0zEwUjSp5O/sL4FRbFdBDeVAHRK1oVYtXDZscJs0/IzfCvM7l1MjSebB42oE7o1lK0MWkv27rukEHrEbZyG/QDXL9wJEuCa+nwVm0ZjlInaXpQtOm5pRHkgnfeRRzkSrot/pExj0RgAcEKXUrMAHq07JtwKvMIgSvwhWUC/JjJsxMjEaYk+1eyhZIMGofPTXJm7FdIJVpCwkPlkqrVVr4BWVOtq2EL26QgOIV0RhjxB5LQ+wtPQF8utyc+s0YE5O
x-ms-exchange-antispam-messagedata: khmwjiJgozrhCdJg/XGkYipzY8r/6JjZtghu1YhFn7dmEmSEk/WXGp1YNmU/Pv41vp+flDPbrLnpfAMJP/aJG/Dl30FFJJZUkQjBADdNAXxbHuGzZkzMATnCKMxoOY5wCKkRJzwB07R3up8ePmnDDw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dda1ec26-6ecc-46fa-98f1-08d7c4ed1c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 12:18:15.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WsxxZe6+WncowQJ7yNEW5Z/0oyw3pYIoOwRHX3CUTxnGNgboGmCNw9cVE1qK7g9V7IQYQTsNLZND+ir9WoswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>Sent: Saturday, March 7, 2020 03:12=0A=
>To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
>Cc: Alexey Brodkin; linux-kernel@vger.kernel.org=0A=
>Subject: Re: [PATCH v2 2/4] ARC: handle DSP presence in HW=0A=
>=0A=
>On 3/5/20 12:02 PM, Eugeniy Paltsev wrote:=0A=
>> In case of DSP extension presence in HW some instructions=0A=
>> (related to integer multiply, multiply-accumulate, and divide=0A=
>> operation) executes on this DSP execution unit. So their=0A=
>> execution will depend on dsp configuration register (DSP_CTRL)=0A=
>>=0A=
>> As we want these instructions to execute the same way regardless=0A=
>> of DSP presence we need to set DSP_CTRL properly. However this=0A=
>> register can be modified bu any usersace app therefore any=0A=
>> usersace may break kernel execution.=0A=
>>=0A=
>> Fix that by configure DSP_CTRL in CPU early code and in IRQs=0A=
>> entries.=0A=
>=0A=
> How about below ....=0A=
> =0A=
> "When DSP extensions are present, some of the regular integer instruction=
s such as=0A=
> DIV, MACD etc are executed in the DSP unit with semantics alterable by fl=
ags in=0A=
> DSP_CTRL aux register. This register is writable by userspace and thus ca=
n=0A=
> potentially affect corresponding instructions in kernel code, intentional=
ly or=0A=
> otherwise. So safegaurd kernel by effectively disabling DSP_CTRL upon boo=
tup and=0A=
> every entry to kernel.=0A=
> =0A=
> Do note that for this config we simply zero out the DSP_CTRL reg assuming=
=0A=
> userspace doesn't really care about DSP. The next patch caters to the DSP=
 aware=0A=
> userspace which this actually saved/restored upon kernel entry."=0A=
>From: Vineet Gupta <vgupta@synopsys.com>=0A=
>Sent: Saturday, March 7, 2020 03:12=0A=
>To: Eugeniy Paltsev; linux-snps-arc@lists.infradead.org=0A=
>Cc: Alexey Brodkin; linux-kernel@vger.kernel.org=0A=
>Subject: Re: [PATCH v2 2/4] ARC: handle DSP presence in HW=0A=
>=0A=
>On 3/5/20 12:02 PM, Eugeniy Paltsev wrote:=0A=
>> In case of DSP extension presence in HW some instructions=0A=
>> (related to integer multiply, multiply-accumulate, and divide=0A=
>> operation) executes on this DSP execution unit. So their=0A=
>> execution will depend on dsp configuration register (DSP_CTRL)=0A=
>>=0A=
>> As we want these instructions to execute the same way regardless=0A=
>> of DSP presence we need to set DSP_CTRL properly. However this=0A=
>> register can be modified bu any usersace app therefore any=0A=
>> usersace may break kernel execution.=0A=
>>=0A=
>> Fix that by configure DSP_CTRL in CPU early code and in IRQs=0A=
>> entries.=0A=
>=0A=
> How about below ....=0A=
=0A=
> =0A=
> "When DSP extensions are present, some of the regular integer instruction=
s such as=0A=
> DIV, MACD etc are executed in the DSP unit with semantics alterable by fl=
ags in=0A=
> DSP_CTRL aux register. This register is writable by userspace and thus ca=
n=0A=
> potentially affect corresponding instructions in kernel code, intentional=
ly or=0A=
> otherwise. So safegaurd kernel by effectively disabling DSP_CTRL upon boo=
tup and=0A=
> every entry to kernel.=0A=
> =0A=
> Do note that for this config we simply zero out the DSP_CTRL reg assuming=
=0A=
> userspace doesn't really care about DSP. The next patch caters to the DSP=
 aware=0A=
> userspace which this actually saved/restored upon kernel entry."=
