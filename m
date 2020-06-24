Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E77C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684FB2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LZTNed17";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WLLslxQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbgFXHYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:24:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32899 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgFXHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592983488; x=1624519488;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kUAfysK4lNfU4I/JffH2jh2wigX6lLcUXr0I5NFL6hQ=;
  b=LZTNed17ZextEj5pKPIfpH9jh5qI3TLric+naRX3Yw6vb08iEhF4UAn4
   0vp8pTnevhpH/eExBb6o6uO60CpKHyP7t6IvI1C9MZk1AF8lulMwOrJHY
   B1gzEL9pEEXXJzPPBFJLxRej0i1dKptWhzZZEQUeFqog5R5GojueqtozG
   1nL9nsdtkzt550D3r4iqbKNF1EGzuoHucSpx9U344wUjcdNZMu3ReKCya
   5BBMnyCnAyGUEhcJuGADc+25LBMUG6Oaymx56v9zoQ8u/0ZN/BwxFxBAb
   3Mn0gcHPcIdGz2eMU5qVf6tOybfE/a4PlrUYmtq6za7Q7RNSqviH53Cok
   Q==;
IronPort-SDR: nZKwKwVsyYlMeTIFxNeKePGr0z2z6A/bFh0z2FUZqub2yGT5VbQpzOv9ixUXsenFwaTnfrotGD
 KSEOknR0UEiylupK3LEtCoEFpvH9dd7irX9Xwu9CHk0PoCKL64hrCARcQ287hNvKrZER0uJU9l
 ec7wnUMst1gpRqGKbxpnl1JUh4qUpFKFhGauhinhwjTQSNFxAuqr2L/CJboTa6Lh84meKMK3Uv
 L8AFcLjF5Yip55eM/nVxC+ixWJ0qCCcYtD5iTlvBph010fTzQS3sADE0Vgj09i6bgaQNrroYK0
 kuk=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="145102576"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 15:24:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcqeFVkR3L0KLHqZPxg+n4WCVWXC4F/TIzD2E2OLmAtheSYbAYFr3KWzP+NfewRsOq4vQ8a5bipih/0QjrNBd95s3Gw3PY82+Q3R1lf9GqBKqlynbebDfYqgMW/Au7MLIXtFSIB1z8nReBlpdH1wLCnbHwGU+YWKD1V3Bw5Plvaxf4tLVS4HJ9K1R1nCSloCTDH18SMDqwTtrMBL+4fBGoQnLlqy1IehIl1kfFo1JaYvJBnmaYh70EBmIbbpcCShRfTdHbhbhbhkMgMmgI/D8xcqNsrvHEybxQ1bQ7pFmdXxBChzrLecdoqYdXFkoGLUUrXQn0PhoHgMRPZPakj/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydMVJcS/QMtUTuQ4FKmCRd5J/rHswtN3cVzgj1Nt4kM=;
 b=ekkuSFMGg685TAoWOacq9NkcF1BN7DQQzsamWyvYdRn9nnOA0R40aSeX9AraGqQ0lr6EdIwkqmjhsPEGV4L0M0pGgOfHsx8CtKuqoyAxdfPerrnZfpi9z1LTDSpZFs83TPGCHrmJ9rXMNSGJy1biVpw9HY9Dotcwls4h63jkFqzCtV7qM96lmuWlBnS72VI0bIHQHfaMeF4x/TwO9Ww4/6y0gxampCSlbCoTv1f1z/d7V7AsNJo+TY4oo5FjnB/0/ZlzVrr371yzOwUNd8Qp7iIR6UwSos6LQ9ngTwpfQT5LFj16XqJ7b5btnr4UbV9eS3w/dBohGHr8NBCXyUohkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydMVJcS/QMtUTuQ4FKmCRd5J/rHswtN3cVzgj1Nt4kM=;
 b=WLLslxQ2fWbY4oEr4p+G3Wlfk3f5yeNPkrvxtJVbRALYvTISQa/PPjm7RxX2vChrPYB2n9HLYOV1FdnAZCp6D+Bfnj4wUY0fx2ZJdiyiVIklgMnwrutOnBBwgd+hpAg3NHbPpo7XJqxU4lWtdrw00j72PtLDEDBQoL0O0STN968=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1206.namprd04.prod.outlook.com (2603:10b6:903:b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 07:24:46 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 07:24:46 +0000
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
Date:   Wed, 24 Jun 2020 07:24:46 +0000
Message-ID: <CY4PR04MB37510A3565060D9243607A80E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 943ff73e-9570-4be5-1ae5-08d8180fac38
x-ms-traffictypediagnostic: CY4PR04MB1206:
x-microsoft-antispam-prvs: <CY4PR04MB1206D53CBD70E6872C6B2879E7950@CY4PR04MB1206.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ev2co5UVELn9HyB9ZMJ/LkhZ6Pabiv7GlTVa+w+4B+l7yo7nxwfOi9twhwhPR7LdR+R+l2ZOmovB3TSYWf4vzk5Xlb8g+4Fok2hEtiKmEdMkUMfvJirLJCf8Hx0lE4Tk+wkVQxqGcl95OZsipEtpgkm9q0ohv4LUEZ83XVBrZs9af8/41YvJZssaoSVbisYb1VMSbtZqFBdUicgcViwsd0iJTXNradLq5sGEtxPdCIsxizaIDDqYVu99rASXq0TMdz7Dk//UgA3469Qix7t02+Y9BsSmh2rl7bkR0ZWYwdVWvxiwPiSh/JH8xWsk6cJ0IGk5Ivx+uNPar+UL6adB8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(6506007)(9686003)(66946007)(5660300002)(86362001)(8676002)(26005)(186003)(8936002)(66446008)(66476007)(66556008)(64756008)(2906002)(91956017)(55016002)(76116006)(4326008)(7696005)(54906003)(83380400001)(53546011)(33656002)(52536014)(71200400001)(316002)(478600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FA3cK2Huw7aAqJUeDumuBUmSRJ5bX70Prp7HcS0V6DdYiQZOrmjLdekDKPmIZh2o0pN0FVJLUThFFCICe0zYnEtICFZBe1oDZ3g6c/qOx0aMRCFQa0cY7fxOX/SwMul4RpR0xzY6znkAmqL+A8QGSXmxKljxCpivtOZBYAVFP2mGXZieYwYYhQjYi/L2NcRZWzG7ktGm9X7Gy/qrtjSef2fH/Msoou6JAMpWjbShYaVifGGA9M+Doj4oR+aE0m8EORXC8stF8qQkYRbmGZaPgVAxmyhjS+xp1GNF3QOM6IlqA4nB0E3I0yR6s+zgfE+BnY69g2Bzfm70v7sWXgSfD82qZHVCrxcqJWx6KBuQdPAjHusj/S13/ygBi9sWW+abhRyZuocSSQajpYxwcNCoR7GmL2AszD4D4bM65xRYgKdi81el5Y4ntFkzgXWNvhK9zMLvGnG/I4gRpuMba5WU0vNJLKdRPTyDldLYvoq1mN8OJzsqTGzdiql+RWu8m8+F
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ff73e-9570-4be5-1ae5-08d8180fac38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 07:24:46.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52Wv79OEgiyno+qOqVh3I1203lDAgQINHgdF07ex9OC27uXBtxm+bg4OOCgBiFImUPJ7rqMgnaPCUV91W2XPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1206
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
=0A=
Digging the code further, in light of your hints, it looks like to fix this=
, all=0A=
that needs to be done is to change crypt_convert_block_skcipher() from doin=
g:=0A=
=0A=
	if (bio_data_dir(ctx->bio_in) =3D=3D WRITE)=0A=
		r =3D crypto_skcipher_encrypt(req);=0A=
	else=0A=
		r =3D crypto_skcipher_decrypt(req);=0A=
=0A=
to do something like:=0A=
=0A=
	struct crypto_wait wait;=0A=
=0A=
	...=0A=
=0A=
	if (bio_data_dir(ctx->bio_in) =3D=3D WRITE) {=0A=
		if (test_bit(DM_CRYPT_FORCE_INLINE_WRITE, &cc->flags))=0A=
			r =3D crypto_wait_req(crypto_skcipher_encrypt(req),=0A=
					    &wait);=0A=
		else=0A=
			r =3D crypto_skcipher_encrypt(req);=0A=
	} else {=0A=
		if (test_bit(DM_CRYPT_FORCE_INLINE_READ, &cc->flags))=0A=
=0A=
=0A=
			r =3D crypto_wait_req(crypto_skcipher_decrypt(req),=0A=
					    &wait);=0A=
		else=0A=
			r =3D crypto_skcipher_decrypt(req);=0A=
	}=0A=
=0A=
Doing so, crypt_convert_block_skcipher() cannot return -EBUSY nor -EINPROGR=
ESS=0A=
for inline IOs, leading to crypt_convert() to see synchronous completions, =
as=0A=
expected for inline case. The above likely does not add much overhead at al=
l for=0A=
synchronous skcipher/accelerators, and handles asynchronous ones as if they=
 were=0A=
synchronous. Would this be correct ?=0A=
=0A=
=0A=
=0A=
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
> =0A=
> We do this in fs/crypto/, for example.  (Not many people are using fscryp=
t with=0A=
> crypto API based accelerators, so there hasn't yet been much need to supp=
ort the=0A=
> complexity of issuing multiple async crypto requests like dm-crypt suppor=
ts.)=0A=
> =0A=
> - Eric=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
