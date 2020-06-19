Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002BC20890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="mJPTeHMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgFSIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:22:46 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:30338
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731378AbgFSIVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgJCOmQiRFbDEdD1JbCoDVpsYor0RuxpBdyBIdRMgE0=;
 b=mJPTeHMNhI6jMivr69zVUEb2wa7zvi24uaUkY4jffssVkjtSJFAU83THQGyplL3xV6gpftnNSzYkWBZvsm81Zcwy8Rg+XUKk4H2NCATcTcJmnadhJK3vEiSihpw3W/rKTBf1L+ebsd7YrrVOMVYDSAtfyjUPp/BxmJE7jBD0Eaw=
Received: from AM6P193CA0082.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::23)
 by DB7PR04MB5244.eurprd04.prod.outlook.com (2603:10a6:10:21::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 08:21:43 +0000
Received: from HE1EUR01FT006.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::26) by AM6P193CA0082.outlook.office365.com
 (2603:10a6:209:88::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Fri, 19 Jun 2020 08:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT006.mail.protection.outlook.com (10.152.1.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 08:21:42 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.112) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 19 Jun 2020 08:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7wkivcxmHCKuuai88oOdgv630jM8dbgSvR3yvJJxakStuSW6tCHn0NdWdY9PodeJZd0x9r7NPpZlbX+GCiZQKLm5piwcaQUVfSZHPp3yMwgox1Nqi+zH9Lm4XRvqqO+ypO4a3lO45i+0dckrgzzQjJEEEX6sKiuh0/7LWXjcSXjvnCJnDt8uxKntitXCFORLDixW6D/KMV5qk0QpxKDeYWBstafYR/7osyco7rHb4aMj0nF0EWWCTwgLJvl5k3g/GzhlfaT3X+7caJRIWoCo7OgClJJURpzbwbgKc3RDoZ1CBOPQaG7C/nnVLS4BvvSme4aEoe4GensFjQ9fhr5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bniLtBVeVfXzgGd73eWO1OKXN70Y2NBcOYf1liwSPhE=;
 b=gEwMHdU6U7nIuOqPVCT5G+TAsItYv+Jy4sJIsTMmhWfqMpx5a0ahFnOytrD3zLzSM/OmxatSvaho8quUAEbYaMIF5UE+TjnL59UxR+HH7/RSBldxGdpquFVITJEwFgf6bOPdK/tSZM36s6gfiFYhXU51Nt/fifXnDvrI3FK1NaXo182bCQNI/28QS8t+30llrUKzsMQJrtIdQdXFGfq8b0LHNfj6Z3UaC6YPzx3Z/oTMKkK5cMGqfrwHS4A2q+5qxYJ40Us/oogO55PdesxVnwtvlVHVm3nC1o2zfSvYAfhQK6syfD3NXh3vDNByd1+uPkYePLoGhjW0JEgsnuLMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6378.eurprd04.prod.outlook.com (2603:10a6:10:3d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 08:21:40 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 08:21:40 +0000
Subject: Re: [PATCH v2] usb: dwc3: Add support for VBUS power control
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Rob Herring <robh@kernel.org>
CC:     Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20200603120915.14001-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.37aec1ae-7fee-44cb-ae24-a10a151abcb3@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.3fedbcf4-0977-416b-9979-d557fd9233a7@emailsignatures365.codetwo.com>
 <20200610202255.GA3646369@bogus>
 <504080a1-cbc9-f781-04bb-12d5679ba697@topic.nl>
 <CAL_Jsq+6cj99+7cb1vrZ9eLouo-pPWTDjDEOotDQExazdrx-XA@mail.gmail.com>
 <413a840f-6765-51ba-a4b4-dd6204265fb7@topic.nl>
Organization: Topic
Message-ID: <70866852-20d3-d84a-6d15-552be716ecb4@topic.nl>
Date:   Fri, 19 Jun 2020 10:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <413a840f-6765-51ba-a4b4-dd6204265fb7@topic.nl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::40) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR06CA0135.eurprd06.prod.outlook.com (2603:10a6:208:ab::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 08:21:40 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b18f49d3-b8fb-4a19-3dc3-08d81429cc97
X-MS-TrafficTypeDiagnostic: DB8PR04MB6378:|DB7PR04MB5244:
X-Microsoft-Antispam-PRVS: <DB7PR04MB5244CEE700E05E45059657B296980@DB7PR04MB5244.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:8273;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b3api/AlxBrRRAUyc6byc8HVHrcZ+qrZfOn9MMG+mQcWeaqqXeuWYzSA2z288OjHLyWQqanjTvhxgwV7+LqN2xiI5xTYqQoQAEXUc7xx7wygxrNx5dtcRlu74rKJuqVdzOmtyZCYIQkcFIPxe+6mx1+p/jNxevLuIhHgAwl46bP6OYaTRn10n7xb/G3dJQGFr8+4kOkm5cwKnlMDp+4EUQNpzAmxmR/Ave/aQC6S72zMIYZ6GQ+HDAGRYrLCN4wl/WFO8byDxrIFyafBVu78P8nfWXSW7OLD+3os64YSe/tTo69sNcRRZhMjd35HQnkjMxoLNWkh5jncjuSjzbgLLqAyOfZ3pNx6sXQNjXT7SIcrw4S7bBBmv3/bjVgeaGSh
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(366004)(396003)(39840400004)(36916002)(2906002)(6486002)(36756003)(16526019)(186003)(42882007)(26005)(8936002)(2616005)(52116002)(6916009)(44832011)(956004)(4326008)(8676002)(53546011)(66556008)(16576012)(316002)(83170400001)(31696002)(508600001)(83380400001)(5660300002)(54906003)(31686004)(66476007)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8I7xDia8Ovs1rqgdx3AlIsdNYOp3PzMwyOuqh8hc7bJF9zwtHfC3jcuM3Q9os+Ss+9rNzd3hl3zR2GlZg1YdkrhW1+YO8xFqFSs6oJ0J+wOjdcq1dU+sLbFjLPKs/nskolsw/EszyKR2T5NIwk8Wfk0lsKOQssrANyCORDNSt7ngxfaNJ/LMpEzvgAm8JvpcIQcg6edEd8B0BtJS7WFrE+6aCm8JDB5l6EBqh4JsASNs3ebQ5KXmlYY+ws4D7UdcJbYlsaiXJ5ImDSOt0PP+sP6YpPHK+4d9oXqVOpOhfcPKF426c607bn7fA3HU1ykDqQWCTAxtW2/WXvQd3hLBPzTOKfgBajlazjc+bmPQXgM/ZVUlLzuVTPh0QhUO3PC0Zoay24oCkM0xY59A9tBnW7m71kMq46bbSAMp7EKvBoYuO21dUGuyRy5xQZX/9I/ZpWUUiip5Qp40VX3UiJoNNF2lzCwCukFsiXh44YeE2xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6378
X-CodeTwo-MessageID: 28f56e6d-2d53-4d41-95ff-4a5215c0001d.20200619082141@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT006.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39840400004)(396003)(46966005)(44832011)(316002)(36756003)(70586007)(336012)(54906003)(70206006)(956004)(4326008)(7596003)(83380400001)(82310400002)(8936002)(2616005)(42882007)(7636003)(356005)(83170400001)(6486002)(15974865002)(2906002)(36916002)(47076004)(53546011)(5660300002)(16526019)(26005)(186003)(8676002)(508600001)(31686004)(6916009)(16576012)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7a4b5509-08aa-4f0f-6b47-08d81429cade
X-Forefront-PRVS: 0439571D1D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxfz5v5iLgjvi+qkoPQES+KQgWUBkKdYSJ1RODp1MT6e4MNhYGJdo8reX+uSvv09ZeMS8EexaJ0CtJxlm/aCDcY/O3LIJYoT2jorPzWtXuLBN93fbJREKizHDwPecVD9vS3aeT+JXClWRhMRHvOVl5V/Dk5CCUUbwKZFTlA1pZum5jsYEI7DVaL78rXSer2Vzg4OBS0dIMEPQT5xrmqwLyD2hFObYBFGjeAcruaToaC1pEmybBGxWIhDue92cGIzZpsLM/i3uqcYZ/0vMMeKfwiJ73WKIWTd+3UX/AAU8jfWSq+dremM1QlLB9kcXYFW/IwCsVSoNSYD5QTkqUanpCC5o/Wf/ChzLCD7xB6PNR4eLfgLUJRq/abeOdOoA7zpo2ZFNev8IN3aOraTpmItGNUmLqlXEAOivCFFMgr9HmVcBoqtsM02klR7+5lG/fsV4jC54vQrZVYszfp/7beICyFo3uF9NFwAfG+6E1vlXaU5FiJscMEdn7xSyDX1Fkpv
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 08:21:42.9854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18f49d3-b8fb-4a19-3dc3-08d81429cc97
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 17-06-2020 19:28, Mike Looijmans wrote:
> On 17-06-2020 18:13, Rob Herring wrote:
>> On Wed, Jun 17, 2020 at 8:38 AM Mike Looijmans=20
>> <mike.looijmans@topic.nl> wrote:
>>> On 10-06-2020 22:22, Rob Herring wrote:
>>>> On Wed, Jun 03, 2020 at 02:09:15PM +0200, Mike Looijmans wrote:
>>>>> Support VBUS power control using regulator framework. Enables the=20
>>>>> regulator
>>>>> while the port is in host mode.
>>>>>
>>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>>> ---
>>>>> v2: Add missing devm_regulator_get call which got lost during rebase
>>>>>
>>>>> =C2=A0=C2=A0 .../devicetree/bindings/usb/dwc3.txt=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>> =C2=A0=C2=A0 drivers/usb/dwc3/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 34=20
>>>>> ++++++++++++++-----
>>>>> =C2=A0=C2=A0 drivers/usb/dwc3/core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
>>>>> =C2=A0=C2=A0 drivers/usb/dwc3/drd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
>>>>> =C2=A0=C2=A0 4 files changed, 33 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt=20
>>>>> b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>>> index 9946ff9ba735..56bc3f238e2d 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>>>> @@ -37,6 +37,7 @@ Optional properties:
>>>>> =C2=A0=C2=A0=C2=A0 - phys: from the *Generic PHY* bindings
>>>>> =C2=A0=C2=A0=C2=A0 - phy-names: from the *Generic PHY* bindings; supp=
orted names=20
>>>>> are "usb2-phy"
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or "usb3-phy".
>>>>> + - vbus-supply: Regulator handle that provides the VBUS power.
>>>> Does the DWC3 block require Vbus to power itself? Doubtful. This
>>>> belongs in a usb-connector node. If the DWC3 driver wants to get the
>>>> Vbus supply, it can fetch it from that node.
>>>>
>>>> Rob
>>> Okay, I've been digging into that. But there's no actual driver that
>>> binds to a "usb-b-connector" compatible, so how do we get to the
>>> vbus-supply from there?
>>>
>>> [devm_]regulator_get only accepts a device as argument, and will not
>>> look into child nodes. The only way to get at the vbus of a child node
>>> (or a node linked through a port) would be to hand-code the equivalent
>>> of of_regulator_get(), which will not be acceptable.
>> Doesn't it look into child nodes calling of_get_child_regulator()?
> Looking at the code in regulator/core.c, yeah, it should. I'll have to=20
> add some debugging lines and look into why it didn't work in my test.

Ah, I had put my "connector" child in the wrong node. If I add the=20
following fragment to the dwc3 node, the vbus patch works:

 =C2=A0=C2=A0=C2=A0 connector {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 compatible =3D "usb-b-connector";
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 label =3D "micro-USB-otg";
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 type =3D "micro";
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 vbus-supply =3D <&reg_usb0_vbus>;
 =C2=A0=C2=A0=C2=A0 };

The driver indeed picks up the vbus supply from a child node.

This would mean there's no change to the devicetree bindings, it's using=20
already existing bindings.

>> You're right that it wouldn't work if graph is used. The connector has
>> to be either a child of a controller for the connector or the USB
>> controller. I'd expect you'd have the former for Type-C, but for
>> "usb-b-connector" the parent is more likely just the USB controller.
> For my current case, using a direct child would be fine, there's=20
> nothing else connected. But I expect that we'll produce a board with=20
> some USB-C connector some day yeah.
>>
>> In any case, having a struct device shouldn't be a requirement and
>> most subsystems expose a get function only needing the DT node.
>>
>>> Or is it the intention that I write a usb-X-connector device driver
>>> first that handles the vbus?
>> That's a kernel implementation detail that is independent of the
>> binding, but yes we'll probably need a driver or library helper
>> functions eventually. Note that it is possible to have a struct device
>> without a driver.
>>
>> Rob
>
>

--=20
Mike Looijmans

