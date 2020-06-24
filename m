Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3821CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EB620768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IoxWfpGY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i1u6aysD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbgFXHto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:49:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52308 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390013AbgFXHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592984982; x=1624520982;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+UpfrI3doIVPQ06DIMAdrAcfFkjKihzQH7teECCGS8Q=;
  b=IoxWfpGYno/JWATDKr3s4k3yoGjLVCunFFqIATrLAhxRw48o9EGsCyZj
   tcovkTYMjLqFbxXnkNgoYLu/Gym0tXI9Z2R+fOsjGnsZn39StN/SJW/PX
   iHKmqM2O+yHUYv/pF5k8oUVUibmQfDGfE6x+egjgL8NHdnGh3AgJIxT5n
   HGp6u+BjmA5MWSoKq4gQIDhFYC/UYGkjxjbQ237i2qeEFUweWb2d6ivkl
   bnUawM+XSoOrdJ2qHU39RChomclsGgAU28d/TMydnpJlOL6yIxULTpXDK
   jJF0AA4GXjqj9DiPbzmIvm8+lhF6DgATRmls66bnOz7hv/YcIM0D7LO4a
   A==;
IronPort-SDR: V6fmFRwZgtLRVqkh9/M1JOoYze7QuxBMABLewOKw1t8igBoANgNXiMTVVOJ5KHrJKSf9i05LMC
 KMyRiAP+GrU6wkJ7/wxIPojidKveLOe2yX3w7LBe4p7lEJCbTPFTeZvQHh58gsazjIW3hRq0O3
 XBqpLQFrAOvC56bFb2Zb5r7F9CRl18r1Y5pIh+YY2PT1BzcqhaUEl5LyrQMXFjhbHQJbwK+iEY
 jzwFbAnaTkMpmIBI7UH9vnZwXUQPxlwIHIJkutk9UgOoq7GJp5RRRM3NkQOXDqtPl3j9nRBh5h
 Qd4=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="142151319"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 15:49:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIam/gYwdEmsIi+MTusYAwPRhm927UNLbOoFrjvNpwNOXbrYSLh/i7cyI2M57KYUOVvv52gfjDKfDHXthGqpKXgjRqJxNgMsKZbgN6HDoQQDT8PlKz/edEEMrICVvD5Y6rb9/L9bsa8W7K420XJAfXuL+SZrVAduEt0nhhcXaBsIakpb3G6Z1KypRY6yrBDABZlCNwlQvwDQQXI7QbpZV1XBGSQbkmmkxP7qUatXIOWJft4siRM7hlYgO2nYkTXuUxTJux4iCM4k44chkrkIt9mor7FyF8sRbNO5X9OYPOzQAUBPiQl3DnA0hz0y5FhAm35I09u3Ve9mQHpnTF3b4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYnxSAq5iBX6daQrkOzf267ata1WO/NQj2/HXhIGLLk=;
 b=FObILLuZx1KyaKfJfdqaGaEYO0m9KNmJZ4bSegVW5W2kw91l6KfsxAlZeSQjg/GUOYKm7uB+jIDq7bRp4WVj50lVyzLA41iZmzDr3oFGJ/16LcsR0N6+pOoCD4lqZz6V26hss8tS7WGmAEn905KgXZTvys/+uAf8CNcZN57MzsigplaM5jY93QViO8lo+6E+27CZdcEJnT3MOOA7xHGXcg6XJ329x/oKLx9D0y6Ny9ZwUCjDHrRxc2EvlB6Z+m8kgtQPiZyIEizKeILeoEGCyHCjwqdwiohJHPMy7QCI4RM1WK5I+SZHjcPLPJ5mzp+UnT4F9eFIPG17bEkxwVLwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYnxSAq5iBX6daQrkOzf267ata1WO/NQj2/HXhIGLLk=;
 b=i1u6aysDJV6txHHrPE577LnjFAfKWky1G84iKW217d4swvG+DkTJ0EVB/6Jkdpfa2r5+p/1NaPmDvQKG2/UGwy+++2/imVcMDsyefx0LZE9cokpoqmnxkZKtCmHo2cYTO4toAB82DHPJScqnWGvCzuvDGIm1grsunVK/1287UJs=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3633.namprd04.prod.outlook.com (2603:10b6:910:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Wed, 24 Jun
 2020 07:49:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 07:49:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Ignat Korchagin <ignat@cloudflare.com>
CC:     "snitzer@redhat.com" <snitzer@redhat.com>,
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
Date:   Wed, 24 Jun 2020 07:49:38 +0000
Message-ID: <CY4PR04MB375123D338D4CB4FD586FE61E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619164132.1648-2-ignat@cloudflare.com>
 <20200624050452.GB844@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4911720-8d6a-4c23-4281-08d81813256f
x-ms-traffictypediagnostic: CY4PR0401MB3633:
x-microsoft-antispam-prvs: <CY4PR0401MB3633F457882CDBF3F72F3432E7950@CY4PR0401MB3633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdkC1K4U3KGsl2yqLDZ0j4FO5MAvQL0RmWlnJJCf9n5J3X78DypCx/pEVW0HbJ1iZmB25cNywOr/PQBlYNU3GVqSa1JSQHKUhGDaKY1891is2ZuOtf95YZWrLjA/HjM06xSrc5713+b1UbP8J0gN6RL+nAZiT+kgKEV2hsRsvTkTn5ocFgNvelrhxnvaVE2utA8JLK+f+mOb/Q0GPF+qehW8T74abLU7B27UrNIiB1ybYFOxUsXnLkbkYkSPFuGkXdaG7lEmqEwDu40HQQ/W0vj9ELkYvIOa7yqldKLagPEbDYg57KTZRjRDeS/cE2F8SDFmKCznFbvyu4kTK3TMA3wS/LlGXIoxBZU66PBhyPfaKWF6PutIYIDC79SscLPQZDrCevGnTvtxFpDlNgawqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(66946007)(91956017)(76116006)(9686003)(66476007)(33656002)(66556008)(64756008)(71200400001)(83380400001)(66446008)(186003)(86362001)(4326008)(8676002)(54906003)(26005)(966005)(8936002)(110136005)(55016002)(6506007)(53546011)(52536014)(316002)(7696005)(5660300002)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3F21mC+Z5/fDo0dh3J/DLeTNkno5AOxwUotFc8boHcmKwA8unwfrgzpmGknhfGpniUyZL32oHK3zKnBIDeexSUkqDiWi0omK8aJeS/aPE0YPk/1ueLR+3YCDvYb0SNY7HLO7c+PHQVs1yPF8Tv6hsUJrzDf/gyjV4rC8MY0MJM0NBKa2x41ZG5bVrH77k0Wu3sKYti2oIBEfgNcQSwz4gRsZbFEhN1qYo713D9n/D1/uOMBWa8uIaNLg6fgeymn/BvhGtXJwSG6x0xkNzdSJ7wErJdLMo1RIJT0+Oz3xpI+k+g8a2oXFJH9HIF3O1nUiEpvaCBicTYvPDbVXkOSEK3Dm/SzfK+/q3Bl/yAbTiql/6TwQ4mNqn8bk6CCHynE3QTorCuKd9brAAaDvlq7VEW3X+ugCw2Vjtqabxqsx0NID7lwRQWnuJFTccnpRLbsNsHaGHP8gIi+aq1W9FxPR9KvXzk0slvRmrSEiOBsqnQGveQTNDX0Bhi7o/dlt/tbo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4911720-8d6a-4c23-4281-08d81813256f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 07:49:38.3009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmmBylYaKN9NRJ3Vn7cRVlYaLSjmFfW/+xb8GIwEDQ0YBHBd7EQF1yGX9/HaR9LzRpWDPGOmljJwaQmnrzFtbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/24 14:05, Eric Biggers wrote:=0A=
> On Fri, Jun 19, 2020 at 05:41:32PM +0100, Ignat Korchagin wrote:=0A=
>> Sometimes extra thread offloading imposed by dm-crypt hurts IO latency. =
This is=0A=
>> especially visible on busy systems with many processes/threads. Moreover=
, most=0A=
>> Crypto API implementaions are async, that is they offload crypto operati=
ons on=0A=
>> their own, so this dm-crypt offloading is excessive.=0A=
> =0A=
> This really should say "some Crypto API implementations are async" instea=
d of=0A=
> "most Crypto API implementations are async".=0A=
> =0A=
> Notably, the AES-NI implementation of AES-XTS is synchronous if you call =
it in a=0A=
> context where SIMD instructions are usable.  It's only asynchronous when =
SIMD is=0A=
> not usable.  (This seems to have been missed in your blog post.)=0A=
> =0A=
>> This adds a new flag, which directs dm-crypt not to offload crypto opera=
tions=0A=
>> and process everything inline. For cases, where crypto operations cannot=
 happen=0A=
>> inline (hard interrupt context, for example the read path of the NVME dr=
iver),=0A=
>> we offload the work to a tasklet rather than a workqueue.=0A=
> =0A=
> This patch both removes some dm-crypt specific queueing, and changes decr=
yption=0A=
> to use softIRQ context instead of a workqueue.  It would be useful to kno=
w how=0A=
> much of a difference the workqueue =3D> softIRQ change makes by itself.  =
Such a=0A=
> change could be useful for fscrypt as well.  (fscrypt uses a workqueue fo=
r=0A=
> decryption, but besides that doesn't use any other queueing.)=0A=
> =0A=
>> @@ -127,7 +128,7 @@ struct iv_elephant_private {=0A=
>>   * and encrypts / decrypts at the same time.=0A=
>>   */=0A=
>>  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,=0A=
>> -	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };=0A=
>> +	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD, DM_CRYPT_FORCE_INLINE =3D=
 (sizeof(unsigned long) * 8 - 1) };=0A=
> =0A=
> Assigning a specific enum value isn't necessary.=0A=
> =0A=
>> @@ -1458,13 +1459,18 @@ static void crypt_alloc_req_skcipher(struct cryp=
t_config *cc,=0A=
>>  =0A=
>>  	skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);=
=0A=
>>  =0A=
>> -	/*=0A=
>> -	 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs=0A=
>> -	 * requests if driver request queue is full.=0A=
>> -	 */=0A=
>> -	skcipher_request_set_callback(ctx->r.req,=0A=
>> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>> -	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
>> +	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))=0A=
>> +		/* make sure we zero important fields of the request */=0A=
>> +		skcipher_request_set_callback(ctx->r.req,=0A=
>> +	        0, NULL, NULL);=0A=
>> +	else=0A=
>> +		/*=0A=
>> +		 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs=0A=
>> +		 * requests if driver request queue is full.=0A=
>> +		 */=0A=
>> +		skcipher_request_set_callback(ctx->r.req,=0A=
>> +	        CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>> +	        kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
>>  }=0A=
> =0A=
> This looks wrong.  Unless type=3D0 and mask=3DCRYPTO_ALG_ASYNC are passed=
 to=0A=
> crypto_alloc_skcipher(), the skcipher implementation can still be asynchr=
onous,=0A=
> in which case providing a callback is required.=0A=
=0A=
Another point: for a skcipher implementation that is asynchronous, for the=
=0A=
regular case/not-inline, can't we just issue the request directly without u=
sing=0A=
the workqueue ? If yes, that would save one context switch, since queueing =
of=0A=
the request can be handled by the crypto API when the request callback is s=
et=0A=
with CRYPTO_TFM_REQ_MAY_BACKLOG. At least that is how I understood the=0A=
documentation & comments. I may be wrong here...=0A=
=0A=
> =0A=
> Do you intend that the "force_inline" option forces the use of a synchron=
ous=0A=
> skcipher (alongside the other things it does)?  Or should it still allow=
=0A=
> asynchronous ones?=0A=
> =0A=
> We may not actually have a choice in that matter, since xts-aes-aesni has=
 the=0A=
> CRYPTO_ALG_ASYNC bit set (as I mentioned) despite being synchronous in mo=
st=0A=
> cases; thus, the crypto API won't give you it if you ask for a synchronou=
s=0A=
> cipher.  So I think you still need to allow async skciphers?  That means =
a=0A=
> callback is still always required.=0A=
> =0A=
> - Eric=0A=
> =0A=
> --=0A=
> dm-devel mailing list=0A=
> dm-devel@redhat.com=0A=
> https://www.redhat.com/mailman/listinfo/dm-devel=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
