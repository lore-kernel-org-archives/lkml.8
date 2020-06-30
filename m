Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D715F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kCIegd/Q";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mhN7s0/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgF3IUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:20:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37706 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727919AbgF3IUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:20:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U8H1nK018416;
        Tue, 30 Jun 2020 01:19:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=SNQC+xgsW4mZIXXqZCx1wLjkiVPDuvcjUKTHNqkx3Nw=;
 b=kCIegd/QEAQQ5rCtZjBOy5W9GsKpMKotVN0HyjjOHgskeWfjgVMXzf15y7cVZBXhLyQm
 KgP0Zn2Ofhe2c32hCtX0XnHtDemOatstfWF7s0TtyStfJ03SeqkFRKEpx3+CrilFx8i/
 YHaBB8f7fSOnfg3uOIecru5OlPApd0Iqkd9pE3X8DTECNrrEikLBRBubHbeRj2AROSPh
 8gr78LVQJZnJxVLA8lVLyjMcEP78N70mt+rcTilDiZuOb78+ftCbhq3H5IYBmklop5Ey
 CqirN9cEKZ3VDgDx2VFD+g3N2689I1DwfwF+zozLAkk/PnoxGgUXlpf2kMQVCGYz83PI eA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxsecv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 01:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az975eDY0IBpVHHuN6Kl971tC5Gui+/7km0nlYy4uW/mBr22wK7jXA+y79ef8WHtiq6fbQh6RCLofBaUxGmDQtnQYggUGjxQbtN4K+hXn0tZX/fomgSHMRJ7LAxHRogFQfXK0UbI2iqruXjV/42L2x2D8HfUonq7ci9Pgeed3tONFYafsoL+pW7wMZ357V9uemuPbl/rOnIKCuNeZq7KxkNfhGYKv4Ms9gdsA/lNH16o/sdvHAS3oyn+elLA7+/bmU0kYnE7Afab7z1eyPwbovu9RBh9Yi6oiH9Az4sgO28EDscFc5F5Y8OBCBhMwgfRpIjtBxm3bnetUE1mBpGujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNQC+xgsW4mZIXXqZCx1wLjkiVPDuvcjUKTHNqkx3Nw=;
 b=MW8jLJ6xgpWZ+tk38v/IXzs4LpIElDg+IcHxzqpPc0x8szFvBDeCbJ/6HrFa6cAIffPsPH9I24mHuY8HunOB2qMdpb8cteAB82FyCdnsG3G46/7qaDNMlTtco/gvYFf/BysoryQnPUeJHl79wgWMqsGatLdChn/cAZWQfzpMF7d8xBUSyZhvQl3dVFJxoAFYoybOg2JjfY1UgjovnSAjktGqj1508U49QBywydygypep/6ucGOGR4AOoTJyfVVX7zTXx0yJKTUPRhSHJvscz9rpWRID1oKEr06XLIg+6f/rVlFg0FxeS6WPz+MoedVT2wJJ7sa4u05idxGgCqq8lMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNQC+xgsW4mZIXXqZCx1wLjkiVPDuvcjUKTHNqkx3Nw=;
 b=mhN7s0/bk7BXFje8/ePHEKbmspf74hJ5JEBwfXSDZj+qaDkoc8jziIpjqwkiPEcIzZqXrxpcusNgYfDd9V09N9yvhNcVfrieYSYL3uFUsVXFFuS0+h0wUMTfgS/T/05jB8LLpNoY7o9WY0olCepBnYRbH1Jsgk6nMh9CE9BKK/M=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB5833.namprd07.prod.outlook.com (2603:10b6:5:15d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Tue, 30 Jun 2020 08:19:31 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 08:19:31 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
Subject: RE: [PATCH RFC 1/5] dt-bindings: add binding for CDNSP-DRD controller
Thread-Topic: [PATCH RFC 1/5] dt-bindings: add binding for CDNSP-DRD
 controller
Thread-Index: AQHWS3YaUXR5UoRWjU+yxJTU8QCwxqjwK00AgACovcA=
Date:   Tue, 30 Jun 2020 08:19:31 +0000
Message-ID: <DM6PR07MB5529615EED6E4A4322481383DD6F0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-2-pawell@cadence.com> <20200629220326.GA3017609@bogus>
In-Reply-To: <20200629220326.GA3017609@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNmE3NDA3NmQtYmFhYS0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDZhNzQwNzZlLWJhYWEtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjA0OCIgdD0iMTMyMzc5Nzg3NjkyMTU1MDk2IiBoPSJEYWRrdFA0aW5iV1lwdnVWdmluRVgzME5EYVU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6b939d7-717f-44cc-1001-08d81cce5095
x-ms-traffictypediagnostic: DM6PR07MB5833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB5833AF451277119152DA4980DD6F0@DM6PR07MB5833.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFZSfe3z7s4TL6eY6pPQoEu87lVRtdGDLQtUniJ2GjjDZJr0MUzsnvW72sVg+TvhdRipo1dshnSkE9/wcn6UQh09X79gpTxPmZqWT4kOLk9Iytvlf8fe90YYuIUA5zj8hioyF3+qvJeQUaBmbtaivDbtFiJCJmUjj/LGiml5eRRBmLIzjZndow5fKSLfLu454MIY65fStyRSzZY1NrWshwXFQqkGSOUqTw4n3DwcldI7weTzj88YBql+FPnB9RQ3ttCNj0P1kVaSHtLT1CP5YC/o9S6fUUeos8xRq+89BW2FieqzgwtFrWoB4De/Q6RrpAoZNUsHeQBnt9mgzE4fVgwyoLE5CGO2VSmfYW+6nITOHWxrJ/O55fKoDqyXzLCu7Hlmo9JNzIzAWfQzWXcyRTxurWj2Ee5nMojUo42/ySvVs/sg38j7X9EzThuM1+mwo+gdTgGX/cxWdvEyluUxTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(36092001)(966005)(478600001)(52536014)(26005)(9686003)(55016002)(186003)(86362001)(33656002)(7416002)(71200400001)(8676002)(6916009)(54906003)(6506007)(7696005)(2906002)(4326008)(66556008)(64756008)(66446008)(66476007)(66946007)(8936002)(5660300002)(83380400001)(316002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Qv3yDTTbpoYdPvVR2ySi6Tx/s7RP/ejF5MRQCDc471VxBa7qWIxebPs+H/LTXIvmQ0h+4Jpug8+jEjGU87Yir5vN2liwOeata7hJ2VmQAEnGErDDkKfRIoO9oeKWUKIoQqlmp8tBANq5pchewLoiwxsYNALwGrEiz6hHR4h9XWc+GRrp9mQmS9gREHFV/UbbGtuNQTJ0HgKT1+0LcPaXS4+scRAckZMB2EIj6GEgNJfqKqzyMeiH8mKE9KJ9iKOPw1Zd/7FvJrpEZWMeSPUiL24jEDYU0mnhl/HlMZTW6YG/8a4J0ddEj/9PjHJAd5LoMYuvEmkPjZeDD/NPovohKVi3G7ZIWAihaEq8FXk97mujlGmQ+bRHEZQpHUn07LJ3WeTeiWC+BtHhp52fOvYYted11MzVnCJp7G8afCx11hjVyuyC8KXgo3rv38Ad2wRZ5PPcwMrgOpl/KT8WeWrBAY9c7/g4Zv9JcCXlw2/UKZ432QYL3GovfwG2Bdql+5aL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b939d7-717f-44cc-1001-08d81cce5095
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 08:19:31.2622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl94vE5oQP9jvj5xigXS7g1mlm4MtHAQnkd2i9ZpuD5MeCB3Vog/msz08EW9JOVLBkLbemoeZJe2+e5YshZYBTvIqkMr9BiATyXO2iENVCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_02:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=907 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Rob

Yes, I see the same issue.  As you wrote probably dt-schema was not up to d=
ata.=20

I have fresh system, and I had problem with running 'make dt_binding_check'=
=20

The script complain for:
dtc needs libyaml for DT schema validation support. Install the necessary l=
ibyaml development package
but in reality it was lacking pkg-config.

It could be good to add some information about this package in documentatio=
n or some checking in script.=20

I leave it to your decision.

>
>
>On Fri, 26 Jun 2020 06:54:46 +0200, Pawel Laszczak wrote:
>> This patch aim at documenting USB related dt-bindings for the
>> Cadence CDNSP-DRD controller.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  .../devicetree/bindings/usb/cdns-cdnsp.yaml   | 104 ++++++++++++++++++
>>  1 file changed, 104 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-cdnsp.yam=
l
>>
>
>
>My bot found errors running 'make dt_binding_check' on your patch:
>
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/c=
dns-cdnsp.example.dt.yaml: example-0:
>usb@f3000000:reg:0: [0, 29437952, 0, 1024] is too long
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/c=
dns-cdnsp.example.dt.yaml: example-0:
>usb@f3000000:reg:1: [0, 4076929024, 0, 65536] is too long
>/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/c=
dns-cdnsp.example.dt.yaml: example-0:
>usb@f3000000:reg:2: [0, 4076994560, 0, 65536] is too long
>
>
>See https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1317380=
__;!!EHscmS1ygiU1lA!THRFzEi4Bx7XfHahLfM_Oo53V-
>hW49AW-xHAcJ7J53DIaLVRbpAOTe92Jrsu6A$
>
>If you already ran 'make dt_binding_check' and didn't see the above
>error(s), then make sure dt-schema is up to date:
>
>pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --=
upgrade
>
>Please check and re-submit.

thanks,
pawell=20
