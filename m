Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0BA20735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="naE0di6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgHPPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:25:05 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728346AbgHPPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJB0wpq4oleVAa4S8YpH+ErvI3vJCHCHw3JO2tTzteXuS8zZR/txA1dfeiQFBid45+wn+h9mrApF2H89s4WfNefor4M2Wc81i2huqlNQMeEe+umVntqRWnzmTvPI9fRCOcJ4mMU2cr9XPA8ObhTI3QMFYdvySXP+yhNiyrK5rck1RdPYvTTsi9kF0TzgF4JVy7DIXTfghepSU3+fTae5G8Uesa/38mYXHSdqDq/GYxR2P+MHg/Yn+U5RDRflIraAzwC/+R0euEgEhhMjqWpZVf3ZcOxykUgHWrftjwz0cjb31vImRMXO0w9BxSz1xU55vWFmlM9bBUWQiC66VvtKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+VlM0Eg1pbE/Zna/DJBtf9OizAIbWR9cyeFHrTHsQg=;
 b=MtXu/hmFZu9ChArji/0H8DkNNysCnq4xbQUBev88ls+9TD1sRoXBjZz6Szffybg4ZuIJPvbqHsxYfJPEtTpjlFakLZS1JmAMfGw5ssfGIS0BT555JrzY4F3Tfu047LAlFTLYOpe0rJd8T60adwgs89nxt7MFKUF2X8s3iWCldogCcF3i7lkY8OkcOcIL2zQTmg3Lzh+J9rmrumRnDLhWvfO406YNxp419KuBSNhHRagKXFC3pAesl6cnqMmykpQ9KRvqNvoiK8/XJQRasXyPI2oHl9hI2oWHXxOxVB+8KpyBtg084rydzW5O+xvP0O71r6OUpJC5gTd4SJbKWn9A3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+VlM0Eg1pbE/Zna/DJBtf9OizAIbWR9cyeFHrTHsQg=;
 b=naE0di6RYzwDWZT5FQxa3Q3OXlc1iPM8Ds9FhuyMxvtQknffyec3GoV1nT/GpyeGZ7kUTwB4+x16e7w3dCM1Z3byBntQDwiQtczgJg6S/UsazLoeR8ZJLDglydIdC4AwQi7kN16m8vOkZANMlgTwnL7GLZbZgY8ivNmX3vIZRTw=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:33 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:33 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 8/9] habanalabs: use 1U when shifting bits
Thread-Topic: [PATCH 8/9] habanalabs: use 1U when shifting bits
Thread-Index: AQHWcy3plqIK9YtPIE63GpD6pu7VYqk6urQQ
Date:   Sun, 16 Aug 2020 15:24:33 +0000
Message-ID: <DB8PR02MB5468D7925F5D600537156508D25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-8-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-8-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c08425f9-967d-4cac-e21c-08d841f87a7b
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3547F94951904C05796EAFC8D25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UvO2xi/PY2NVeu5Pz3y86V+iyTUXU77UH1MN/HJ6hclXWxl8vk9CAp4wPN8eCfKjZWMcwCNMQ+thLRdrOour2Cjn4WBVuLU7B5ygMD6JvvBUXu7H3llilYQzUGw7sBDxWUHZonkxNuGi6o6UEEZsleIO9xLpLWeb76G3apUg4oHo1rSxQ/bgE6T4A2RjEL0jiUdTrN2lI+iPx0v64eZRqKh4ehI0d5PU/FCyV846G7G/up111aO2ToWe37fWyE2ckDPrsrqnE8YdpVyS3p+jT2ARMPUdzVlVOUf+j3qeuyMsFrT+Gk6kggKk9ngWX79WjJcLCE+agBC5rh10JpybiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(83380400001)(7696005)(86362001)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(558084003)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bk7zWj1qDQAVcCBi+u47RgI8MyrkOwmn3IR2Ls90VkCnzrCDW8tOQ9+97C81papBckne3g0GUCrCaER1BzYqMF8ZKanx8/dM2t5C0Opm6MxpDDVV2uXU2jH4/fkL4XNUpFiU1lq5Ep7niHIA3CW+lI3ZGs2NPCu/lYPRjwqRxJXucjwFNcyeRDj45i500e16VkasuNxvVCSeOx820W/OJoGH1lWrMRKqqYxZfY8NImuuSqk64TLgm2cw60kSRNjLD/D2hOilDmeYBsUOiEB+lDVXx9PkYTxERKT5obgUFJy0APIRNCNxlqzELbn/FR6Vm2aG3a+rNjdTXtzWHdewSuZ8Q1qxl8pi2mnMEUKIwrn/IKeH4vJdgEBmmf9118SxCAXsozE/xL2dyp9sFM37PRZHSaDbOsGOSToeGx7c2eURs/ujrdB1Wu+Wq//j6KTtGGDUsDrhzcwG/WwIV5xDZn3Xjsnrp48m5AS+gni7HMo6vz/OqvdF5h9DWg4RGtWTxjnhYXetV0PfRiZkU7CX9UJ4OPO7xYRwt3mAGS+iTjz2h79Oj3N7a04cpjpcssTvrFf8rzWqIKo13R9GVFNNmWx2Pa3Mijm+mClwn805ACLoI7369emvIL5bRiYf4j/xoMBBqsf759jpcWH69yzKIg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08425f9-967d-4cac-e21c-08d841f87a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:33.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hGTAjuEl4Zc3hBUaw2o1bjhr+PXiXiPmbRttIiYLzJUc/Q/qkllPteloWEe2z8HYjvgbc7Tor0FJNaxVvcoVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Eliminate following warning:
> warning: Shifting signed 32-bit value by 31 bits is undefined behavior
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
