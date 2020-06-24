Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1432C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A082C206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f3YfrwO9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tL+/R1+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbgFXGqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:46:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12885 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgFXGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592981196; x=1624517196;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tbPXfxP1OWgbRlB3vNl3nrYks9MuC7O/a24CVTyctH0=;
  b=f3YfrwO9LWUcU6YxDlO8JTIuNmucsBQjPvcP2lGc7B+++EuYUFaEQRIQ
   JJHD65Fc0eK6biDE4+JdvX/Ppt0AsNEfgXt0vMqIMl1rArlhgW4aUm+PY
   YH4uOhZpQpo1H5BpE28c32Ap8QfUq70iUG3ssmGv7TCXLzYAX/tjF+tAd
   TI9nxkdXNJRlxrjQef/C6cMDCmXYUR55bO9jJ3jHdKShUTG8qBLRi81lV
   FPeB9fBHBM5HjZdCJ7lUFsQtYeqHUe9GPVb/QgjG7v+t9bRP7clXsaZgU
   M0cLYQD7HcIDDx/tNpAZOfwbvchP4LnQGUXW41uNRneAFXceL0ATRJAW7
   w==;
IronPort-SDR: wkMF2LM8J8lYs95fawUk0BISth5q/icDVR8VdzVjbPptwMUQ1ZHyLfx9EKl9FiiPt76eoF1eRu
 Qz37h49iYPZ9ed0EozanQ1thFynFScpNl+U+xamV0rnCjIluAqqiH2Je80Dq2Ifg5u/wLbKtX5
 oNE08KJOd7JPMgR5vsRwDMiPvF1Eg6KkDhLOXRDEluadQnLOBX5QFLHsT56ezmo3mkiU9ZlXtf
 3tyD3t8yj884xnt1aL4fEpnpwRtRwUS+9Hi2Bx8HSkHR0Ii8c3Sf5pFZxLFogL2msWmZsPFCAb
 hus=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="141013120"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 14:46:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0ppgp+NlWq1hYvmztJgHfwgG2hNapa6VUAEY5dYafoNLZ4G0u63lNlOxproDGHRGGKazScZw3RR4b8T6VljhOcsoGV01ytMyyuLn0ijS0dDqOEOiiFIKJyv6N1oOD4tGX1+5EmitytIJmUkSaADF18xCgOcrwWBXS0jfM6RsDgqIGmetm0JiL9shm0LIKW9xejezREr/d3yWuPzP90bg52skBBEBteBdvbFLcNPTBTOP4NR79HBu2nCf5Q/yrhNA2g8iM9OYy25zPv0a5CwBS9XRn1ceuloT9BIGaY99Y8s193BCke499KvexJxBaC8Mho6NQ5u/4bU/oN/tg2NxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQBKXSe3Q2xanX1RZXGdA5RCjdZwcSzFEyyILKp0Aec=;
 b=JNlI3KoMc/k2Jbx+YXFqWmaqTkD+yccUeWyK475yy9du4SxOqP5OOrzMpyl/Z8oMZtXz/3XRsDLmbLZgQO2lJmsqg/DTIqLEjKlxbrRilnzTPxbjOU5jKL++0dfynfOrMzQUR3gB+0xaCj2DMy3E1W6gzHomebLPJaTFjhGo18ZNnEYlBJQ75aMK/zh8FhFdhMTY5zw4Yfli7FeI0YwaNJaiQ3Y8l1t5lOEWSv1K+Go2u9r0qORxj9Nm7olAJe/IuRQOHc/jsjkFnTwqp2FkGg6MlbQBaAUWT1C4nQZTznTcmpvsitJf2/Z5HpLRMHoBocQbgpzjVY+8vq+/I4ocqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQBKXSe3Q2xanX1RZXGdA5RCjdZwcSzFEyyILKp0Aec=;
 b=tL+/R1+MOdnDUEwAAtLoVMjDhDqGF9UMMraUe33fcVSpgQOGsdJ3EfquZZ5Z3cK6OI4h88Tx2nRuzF5ebCMFaMH50kqzta31oQD6iJMpGzOUZRXCfun97RN77/qre48U/Bou/d2BUSILd3VeU7TeCsL80GVIJjkUMags1+QbQOo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2345.namprd04.prod.outlook.com (2a01:111:e400:c60e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 06:46:33 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 06:46:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Ignat Korchagin <ignat@cloudflare.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>
Subject: Re: [dm-devel] [dm-crypt] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE
 flag to dm-crypt target
Thread-Topic: [dm-devel] [dm-crypt] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE
 flag to dm-crypt target
Thread-Index: AQHWSeUPu+0i3SYd0ECUVC1ZCCo3oA==
Date:   Wed, 24 Jun 2020 06:46:33 +0000
Message-ID: <CY4PR04MB375103F66A8064B0EAF8946BE7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619164132.1648-2-ignat@cloudflare.com>
 <20200624050452.GB844@sol.localdomain>
 <CY4PR04MB37515EB3C74CCAE2A006202FE7950@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200624052739.GC844@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7163ea2b-d1e0-4488-d711-08d8180a5577
x-ms-traffictypediagnostic: CY1PR04MB2345:
x-microsoft-antispam-prvs: <CY1PR04MB23455E05053F9BDC55AE1C39E7950@CY1PR04MB2345.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tv/xCVSPhb3udGKAUY9ky7/lOhOJ6wz9RWxY9PfHsh5x2Qdqr7Fvr7nEAMLkkWfQUh5B5okquTfBlPYIe5YMuTj98z2TdO9r03L7VRtnYJeVx89uXs8OTmvP8ryHaasSJ06j+L19/4fKTg0lSrQwKzbV/Sao5rOkKL1w8FA9HflrJVmZaFr0FRZcmLQ798NlMtEL7Vq2FhBqJD/2tmiT/1RUt9qZ1IK8gdpaKQDGiYj5Pp4/YEEJ7qb1+dI0cfJ3Pk75Apw7mvDVpTiT01aaZat0FZAn9F1IzlFoofl0rysF+0l6NBpUK3lpAG/vC4M+1xP1nLJ7r6sckveonWKc6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(91956017)(76116006)(66946007)(4326008)(7696005)(8676002)(66556008)(64756008)(66446008)(66476007)(55016002)(53546011)(71200400001)(6506007)(83380400001)(86362001)(9686003)(6916009)(478600001)(26005)(33656002)(8936002)(186003)(2906002)(5660300002)(316002)(52536014)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aL9233LYV1Le1pg9Nr5L8bnTP92otOHqNaZiE/bot1pLDhj8tRKKPZMvT8UXa5lsJRY//WrnReDZAT3O/nqxJvh/P51ui5Nu22gERV1uzTUY6ZY908voOFvvZ6AAfQXnnDKXmuME4//4spplrttMaV5goo6rifI2BYy83J7sgZv+3iPQgvdZxzj3HdHUIp7yp775Wqf3xuGxtOS42mbNMHYsKp+7bCJIA66RyycRQWHx6ITGtdNka4g5EW/I6E8EeksdN6MCseckws+wBI5wTWuDfKtmkqozHZtaXfEF7DSwu3vX0TM5rmdceOw8Uajc6/QYRBj6E0sf18dJ5ljElbPNkwq4fV/f/+Y40g0MZk8lfDgbPYRc857dVqfzoUCFVPhoeeHUN0xhtLKq+7ZJWbJj5kFs/64RT/st7I1pt1QhDzlHGWyvYpEIGmWg/dpzOP7yTTRO8o3wDIivX55nHWkjq4eiML/gi1SH4wsjlPhzgebWYRaes0yJuKdadhga
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7163ea2b-d1e0-4488-d711-08d8180a5577
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 06:46:33.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnuvDgRsAlByeeXN5sxj7xSBZESyGReesEq54EkoF0mho/WkCqs92aIfH2sIxA7Po7nDQDBezkxE9bPFrurEWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2345
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/24 14:27, Eric Biggers wrote:=0A=
> On Wed, Jun 24, 2020 at 05:21:24AM +0000, Damien Le Moal wrote:=0A=
>>>> @@ -1458,13 +1459,18 @@ static void crypt_alloc_req_skcipher(struct cr=
ypt_config *cc,=0A=
>>>>  =0A=
>>>>  	skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index])=
;=0A=
>>>>  =0A=
>>>> -	/*=0A=
>>>> -	 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs=0A=
>>>> -	 * requests if driver request queue is full.=0A=
>>>> -	 */=0A=
>>>> -	skcipher_request_set_callback(ctx->r.req,=0A=
>>>> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>>> -	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
>>>> +	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))=0A=
>>>> +		/* make sure we zero important fields of the request */=0A=
>>>> +		skcipher_request_set_callback(ctx->r.req,=0A=
>>>> +	        0, NULL, NULL);=0A=
>>>> +	else=0A=
>>>> +		/*=0A=
>>>> +		 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs=0A=
>>>> +		 * requests if driver request queue is full.=0A=
>>>> +		 */=0A=
>>>> +		skcipher_request_set_callback(ctx->r.req,=0A=
>>>> +	        CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>>> +	        kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
>>>>  }=0A=
>>>=0A=
>>> This looks wrong.  Unless type=3D0 and mask=3DCRYPTO_ALG_ASYNC are pass=
ed to=0A=
>>> crypto_alloc_skcipher(), the skcipher implementation can still be async=
hronous,=0A=
>>> in which case providing a callback is required.=0A=
>>>=0A=
>>> Do you intend that the "force_inline" option forces the use of a synchr=
onous=0A=
>>> skcipher (alongside the other things it does)?  Or should it still allo=
w=0A=
>>> asynchronous ones?=0A=
>>>=0A=
>>> We may not actually have a choice in that matter, since xts-aes-aesni h=
as the=0A=
>>> CRYPTO_ALG_ASYNC bit set (as I mentioned) despite being synchronous in =
most=0A=
>>> cases; thus, the crypto API won't give you it if you ask for a synchron=
ous=0A=
>>> cipher.  So I think you still need to allow async skciphers?  That mean=
s a=0A=
>>> callback is still always required.=0A=
>>=0A=
>> Arg... So it means that some skciphers will not be OK at all for SMR wri=
tes. I=0A=
>> was not aware of these differences (tested with aes-xts-plain64 only). T=
he ugly=0A=
>> way to support async ciphers would be to just wait inline for the crypto=
 API to=0A=
>> complete using a completion for instance. But that is very ugly. Back to=
=0A=
>> brainstorming, and need to learn more about the crypto API...=0A=
>>=0A=
> =0A=
> It's easy to wait for crypto API requests to complete if you need to --=
=0A=
> just use crypto_wait_req().=0A=
=0A=
OK. Thanks for the information. I will look into this and the performance=
=0A=
implications. A quick grep shows that a lot of different accelerators for=
=0A=
different architectures have CRYPTO_ALG_ASYNC set. So definitely something =
that=0A=
needs to be checked for SMR, and for Ignat inline patch.=0A=
=0A=
> We do this in fs/crypto/, for example.  (Not many people are using fscryp=
t with=0A=
> crypto API based accelerators, so there hasn't yet been much need to supp=
ort the=0A=
> complexity of issuing multiple async crypto requests like dm-crypt suppor=
ts.)=0A=
=0A=
Zonefs fscrypt support is on my to do list too :)=0A=
=0A=
Thanks !=0A=
=0A=
>=0A=
> - Eric=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
