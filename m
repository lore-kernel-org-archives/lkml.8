Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3FBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E868F206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J/6ngXc6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NxmEUIFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgF3Dpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:45:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58107 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgF3Dpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593488752; x=1625024752;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lyRTWOVhF2DKbo+FwGHIPcLshXhKIbhWFQPC6Z1xtNQ=;
  b=J/6ngXc64w6SXqCgWrvybFtneQ/blw6dLduc5nsU6rAqEujjWtLLygbC
   EvcM8q8AR9W1zZDRkTkDCCsfQD2IfXv9fEeGBNsn+MNgMl+XzkQ6FRon8
   ye9WNg/LeBriKxeWOM71AQOYc6kKCNesfSTSUdR7zVoLpLLi+f9/6voxT
   M4qm2Dsepff+KvzIZ7fcBWKRkUoKfI1ZVsZEiRQlhwGFJdcCaYb1qU6AF
   KeQBpaDd4PfkQ8RkSKWxnQ03DCKGzy42seNoreUC1yMXI+m5khFs5jXqK
   FpUPq55WlXufDd7qK7GvIAYkgueNhuQ+A1pH7IjfGi30Y6Bh5Ehgr5ZeH
   A==;
IronPort-SDR: Jd288VGPAwgy4b4TdXOPE/95tmXIVnzoIGOHasWlIv2cKXFbazBZbqFFinPbjLr8ZZ1hOJAgDo
 OvetUAfhr7+/DOMTGWC9S4FI85E0uOgPdekdqCFdq6l6nQUtQVcMXtnUblvNP5xry6QfEX1cx4
 HwYaavGL9CB2cqLS6rUhPRG1Cuf404zVC6UIdJk+t6ADOehNBqCarhx9vo4tLS4Ka5Ywhlgw4o
 KaIsiEg2yyY0XQeEosMsJ24uknLhxAUjV4U9/crPSspgmBWleLSK9rVsavqSIaFcC+uQXB/OJH
 BGw=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="145562266"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 11:45:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuhYLDyqTcdyJOZp1jXMiLOnS68DzJu3lwwdlgzOSCDOzCwg/8qMnDbngTlQbaGKki3I8nTc2Dm9AoVu5cssUgvUwoandkciq7/iekVYQoQwvrmdJseHzpjZRRLp7Az01bvhVpzpbtLooCJzt4SjDNxAxAiM9hfBY2H21ddZec5R+OxdZbNqrcudXQECOC7oglhlFadwYkLeREFBV/L/DiIxfsx9Ohdj7NyaLiHmAyLh4V2aQmPTr2xh9ycW0KDZeTknByiEH95FRyJ7rEri0na2zGav+BjwZYKdPwkvnbh9PqtY61uPlcqIXB0Q0lg5/nFcktu0cCfGXpOreNPIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs9QQte8VkcGX1L7rHurK3HeC+SBf6Va/7nhW0j5RWU=;
 b=FPvWlC15YaWCl0M+43GALF5RFhqb9hu1X9KtqfsYUxyERtV2p4dJzLEaM31Se7kw0lfqJDoheDIh4Bi6TbSMpkOrjxLXDNh4zyWYIZ6oRaUtrEmOHjHXIv5kHl7DLopBwmi71xUjU9RUNj3gy3gbK514v5Kj6sB1dHo+HO/AuGr5DWAa4d0H9uL3AzySrMRLkS5OlcC3iI0EkI9B8sDRBattR+qKxONHtH+yuy9MA0YYUGXUjJx68xkXbBYoox1A/vunv7i/G0dNoGKpBm0N+PjKU4Qft1OLEGDPsTFlWQMNA8ALR3qEbahxFXs6pkqnUMbJND8dAxrxyJVu932wjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs9QQte8VkcGX1L7rHurK3HeC+SBf6Va/7nhW0j5RWU=;
 b=NxmEUIFlsEPecAGoEh4MZabP3ALTbjO43Do3MIBWiTrtEVDRGLB68zI0ZgsMYkDAHktP4dPwnHTfVMIMCU0/dCJR77t4v8PMYgKXWv8ZAssh/DkhQVKbI308YiEf4KEC6gXHSNslTj8MMt5Kom+JXYpAVf/+q3Fa9KrhpJgGyw0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0422.namprd04.prod.outlook.com (2603:10b6:903:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 03:45:48 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Tue, 30 Jun 2020
 03:45:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Ignat Korchagin <ignat@cloudflare.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Thread-Topic: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Thread-Index: AQHWS/06zZqSdIYp0k2e+HMuy61K4w==
Date:   Tue, 30 Jun 2020 03:45:48 +0000
Message-ID: <CY4PR04MB37518C4BF580DABEDB1BD8F2E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200626210302.1813-1-ignat@cloudflare.com>
 <CY4PR04MB375127DC313F70875CAAC841E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200630030944.GA20706@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gondor.apana.org.au; dkim=none (message not signed)
 header.d=none;gondor.apana.org.au; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ff93a97-1b8c-4bc0-8105-08d81ca813eb
x-ms-traffictypediagnostic: CY4PR04MB0422:
x-microsoft-antispam-prvs: <CY4PR04MB04223994B9087856F14C8FEBE76F0@CY4PR04MB0422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMdZM/49L9+MyaLzSLZLi5u/W4CNN8mWKz+ixKurtgpNI18UkOquVwAtgmj+7vc9PfiR9SjIHb4vnppGNTBrqp7ZhchOz5HCJBwjxZiPktcrb28OeKlACeH7aO1k5X/I6ZuF5+tMcmW777ufnjATwrqZ3+zklAjkaXLabV+gFrH3+siSuirJjULvZCNzdTEjeLGkKoZ0KctKGfI78VkAKLQUqfRb02LaVZMnWnYgZJYJTHJ69FCGvgFTuzmXYp4bIg8QAobFsrK1tHfOnd+BxGJPcQToHbvm3721qFLPf+vN2o6S9y9eYLBkiVyueibKHeSYF4iNy9Adf6cb+Bm5NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(26005)(66556008)(66946007)(4326008)(6916009)(54906003)(64756008)(186003)(8936002)(66446008)(86362001)(7696005)(91956017)(66476007)(76116006)(316002)(8676002)(71200400001)(7416002)(478600001)(83380400001)(9686003)(53546011)(55016002)(52536014)(6506007)(5660300002)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WrW4uSxBPIlyRaIlviI9+DssoN+wYZXUJ73x9pOCAMhxWeBtR2PFFMj7LCY8k8INbm99OVUQ6ocOulBgbG94bmsHJ2n5AQlPsEtXf87ESYVuDH1qHylqoLb3/pHUqaqnW/nyT9AgsEv9+S3LkAOKcI23gU6WAk+IuuiIxrrT6B8SnkpY6gFy0aebOEmXQI5pTA9omuMg3UNzM3l5lhAYzoiQTJ0MfflKtbFANFGOvSPRvU30ByvKXY8cisUDSNAGYhw4gelxomm/2uUhFgYOfZNICVOsgtCFRPERho6epKjdPjckzJYth+PaWuvIso4/q/HFZ0QYWwTZ4xEEQ2W9bNnkm3YO6b0tSuoCB+ilht2+9fNbSVSTR8rZim2fYu7IUFTcgiQjDyEN+NvM+smfRjjwp24mnL/wLGFyOpFF2BDKNGEoKrzqvEXNGQO/zMhygYvz+llkhkr7GXMngXpUyMi/yIwXzo29W0RLl4eIrzA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff93a97-1b8c-4bc0-8105-08d81ca813eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:45:48.5560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZrfZNnXCRHjVE8zUcSF+f4uxIu8w4jMQS0vFuS646oghFwsQz6UPR5B5+E4J2Qu5i7ht8XPA0+FXKkTcrilKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/30 12:09, Herbert Xu wrote:=0A=
> On Tue, Jun 30, 2020 at 02:51:17AM +0000, Damien Le Moal wrote:=0A=
>>=0A=
>>> @@ -1463,12 +1465,12 @@ static void crypt_alloc_req_skcipher(struct cry=
pt_config *cc,=0A=
>>>  	 * requests if driver request queue is full.=0A=
>>>  	 */=0A=
>>>  	skcipher_request_set_callback(ctx->r.req,=0A=
>>> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>> +	    nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>>  	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
>>=0A=
>> Will not specifying CRYPTO_TFM_REQ_MAY_BACKLOG always cause the crypto A=
PI to=0A=
>> return -EBUSY ? From the comment above the skcipher_request_set_callback=
(), it=0A=
>> seems that this will be the case only if the skcipher diver queue is ful=
l. So in=0A=
>> other word, keeping the kcryptd_async_done() callback and executing the =
skcipher=0A=
>> request through crypt_convert() and crypt_convert_block_skcipher() may s=
till end=0A=
>> up being an asynchronous operation. Can you confirm this and is it what =
you=0A=
>> intended to implement ?=0A=
> =0A=
> The purpose of MAY_BACKLOG is to make the crypto request reliable.=0A=
> It has nothing to do with whether the request will be synchronous=0A=
> or not.=0A=
> =0A=
> Without the backlog flag, if the hardware queue is full the request=0A=
> will simply be dropped, which is appropriate in the network stack=0A=
> with IPsec where congestion can be dealt with at the source.=0A=
> =0A=
> Block layer on the other hand should always use the backlog flag=0A=
> and stop sending more requests to the crypto API until the congestion=0A=
> goes away.=0A=
=0A=
OK. Thanks for the information. So it sounds like this patch still needs so=
me=0A=
more fixes.=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
