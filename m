Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F44C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EF12053B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XDZamv4y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zQXBd5AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGADKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:10:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48465 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgGADKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593573041; x=1625109041;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jatNm88rCG8Wt1Iqi4MIEm494SgsPM9UuZf/Lm7uLz8=;
  b=XDZamv4yUwaZqHg+cijaX6fEHjL6TENDdM8sdrGgOfmoDqa2a/vwOL7s
   tVcF3HMSbY45KyWI0JEz/p2Oexndg/aLFUPCX2CQ0J+W35uzLnIUaCwoj
   FIQlKBfX42CzEJPJehsxbepdU9etCJXuDNt75adAE5cP2SRG84ugV74m+
   DvH+YvWx+esR0DUpZXcd1aA0RTZZlWA6dmNLNYh6HkE2ahlv20/22BDSK
   54YaVs5om1xNHRHJpXH87YI5y25TMK8HLH2V80SW6qqprhlzKXBGkldmw
   1UsQMvWRNoQMC/ElK9DJITBof44FQUDIwUVyFYTCPIEQppouT3mvAdAqu
   A==;
IronPort-SDR: C8xmXGLU94zB9GuRUCEnlBbb/XVoNpWek3z01SjXfmhJ43hLWhYuXrZHwgu98wrUXFH1zouiWB
 WWTKY4vfDIgh3vlvJBRcF4DG2A72psuerPZVinIG+XcGyODseEVCRpzkOlKHZTNq8I82tUR8jf
 gkxSpe07RB3EJWCIvzRe6lV19/4LGTGWdHIi/PbmGTW4LSFF9dXx8wnh8nGZ3cnweT4vb1JJyc
 Tn9Ib1+MDNjDM6XW12hQUNuqedLwo070mgST7qkpBlJjpVWBXr27ub/P5QElrjQ9DMODTVK/Es
 qK0=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141539475"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 11:10:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFgICI6MA3+8NvqlvmfQJjsLqJkOFxdEbEsWTya90+8CRnA5XxwpKHqunNZbvQhxVR8E9GLpaP6kEETPzhNG6+2cMoay2Nt6bSjvPGZgzC5gkLlV9ejOyYrqfN/81IrE4PBEJRzCXdA5+5rsWsO3op+g4h181thftxWvaKwMzlRsHjvh7sFMV3BNlaD4hPx1AqvbIi9iJ+dp1Qm5bFWHoJxplGUx0ghIMTDXBnpPswTfSYRvjOXg0YeLi4D6aBIgLOMzDWTwLABomMQCdbxBJ7MStF65D9D3gJJR7fVsXC9mj03tUwGA2vKSTSt0P7wHnxYkU3HIqauvge6Rc4DC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSeoh6v+GEDYHuNbgOvrvBLB5iP1W5h4vXlAUksUBG0=;
 b=gt70659M4safRmWjo+unO6rAX6fGigHeJDrj7CdMIHENeMDKdyGkR4bGBUWFi9QlQHWZjEiA3yZYkPx4CaqujEtgOQsYE8AFE9tpIN3PtaRb4TLqR4T5kfdqvNP6mXOdZvGEBr6HYW6IHXa6jxc2pRlVr34ox5SyewzDIkD62Q72kOBRAkW9bFtfjmXDur4TuwcxsqKM+UXFojsLPH9gGLh3ELvPWo+IFzNMWONSgJKI4+pmxkX2QKUyw7oclbbMHQksKdovVaTBCLMBwCPkkHfz1+DZ+8M+PIE0SGfau9tYzwhNU7Pbg4waWkHobn1q2e1W3qKOQH0aAUZoOrsVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSeoh6v+GEDYHuNbgOvrvBLB5iP1W5h4vXlAUksUBG0=;
 b=zQXBd5AUkmcY9q4FbzOZv7t/6gfZ28+28Jx43N//6UXSLwmWJV42jDGlykpMlwj/MreUN9OQmMnxBYEhmEOIsuULrbPngbf0/cCNH65E/zfTRjWpFRE6OLHPR80bVk8INJtgiqeyYDMRMWbOdR6V7lFgumu0TxC5rFwx4c7/Vk0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1033.namprd04.prod.outlook.com (2603:10b6:910:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 03:10:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Wed, 1 Jul 2020
 03:10:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
CC:     "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Thread-Topic: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Thread-Index: AQHWS/06zZqSdIYp0k2e+HMuy61K4w==
Date:   Wed, 1 Jul 2020 03:10:37 +0000
Message-ID: <CY4PR04MB375171927DD3506E0958A2FCE76C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200626210302.1813-1-ignat@cloudflare.com>
 <CY4PR04MB375127DC313F70875CAAC841E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CALrw=nFu+ZQ5qP+2OuZa470rjPDEVLNDc5-YLaYGpi2Ke1d6Fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73247b62-c0ea-43b8-b99e-08d81d6c5436
x-ms-traffictypediagnostic: CY4PR04MB1033:
x-microsoft-antispam-prvs: <CY4PR04MB103383FDC72F6A96207C0553E76C0@CY4PR04MB1033.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6hXkpx8w7viyQqQ+w4mf/FeZ/s7dMaQ8t9qUbOrTAsIrjTc3reA/3vutMrtes1UJGBSWVBF18qK4LhJbulcljGoLN5a1+Hh4FHYE/hwZkLPqoGPGH3mvkR4MyHkTZ7eDkK5KDwakeOJARVh5LXHBIGEYCe9npoFriMBtbam2VEQa90zyhtmoGqzIdkE+hHg8X4m362DKpVwk70oTRQDGrBP+EKWfHw6OCcb5WByr414ATQAq9gOZz2ogDPtsswg3egXbbYZ3Jy3Q6Dylq6/98LlYdXM+6dsyGIv7eD2QXXmrjK1AB421U6rYZHU1xlLq1lkdJ4rrJvTXXXJTosQtFmHQq+A18XgzQ8rG8guG+yRJY8TAzGKJMX9xbcLeFtc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(7696005)(8676002)(6916009)(478600001)(5660300002)(54906003)(86362001)(6506007)(71200400001)(8936002)(7416002)(53546011)(33656002)(2906002)(26005)(55016002)(186003)(52536014)(9686003)(316002)(83380400001)(66556008)(66446008)(91956017)(76116006)(30864003)(4326008)(66946007)(66476007)(64756008)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lEK1xx+tncfCMIXIhjy8Vw8W3B8pvYRXk9tkXKUGqPUW/sF1kc/NSEW1RttDmtBf5UuKMOnATixwTuqHryECCOFMJnjiPq8mfzM1GR+YgGqFpmZ8c9QyzQPFKzVwgnxxob6FRqm1s+OCJ1MnCecL8f2wfX68rd/c7GN6nm/1RBrW510s/RR6ARQUaaKpPPshuTGwmhvEXT/sJHFhkcEN2r+t/aElluEGiHEKIxwk2ZWeE0JWrX0olg8yNL6JOln2bKTcVZiYxt9MtsEJVnvzDtCF7QJd8pR/l3Il/9m6sLM3djv1fIwIaD+D3jsqgJznFtp/I1/Rsy21LEBGKiRwCFL1R1kAMXpf7OrV7OFVaJoRHZUQdfbd81ALQIUnvlFnuTyX3V1b86gHtOddfZtQN/dE1eQnG3zl3PwmgvElwpQ7cslJcaKAqoT5T/bh5dzcEJV/ksBi+A+DKoaezzZ75jZQio5efHSufUKdufa+gx3uc4hCTG/RLD18B7X90Udn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73247b62-c0ea-43b8-b99e-08d81d6c5436
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 03:10:37.7921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v86oC+vjDCKJGY6k+dUeeXzl6aLKog5lSpbIhzNOORvRfal9zsj9K9quJuVP5Sj5vPnAhLL1162L3UaXjIXHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/30 18:35, Ignat Korchagin wrote:=0A=
[...]=0A=
>>> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c=0A=
>>> index 000ddfab5ba0..6924eb49b1df 100644=0A=
>>> --- a/drivers/md/dm-crypt.c=0A=
>>> +++ b/drivers/md/dm-crypt.c=0A=
>>> @@ -69,6 +69,7 @@ struct dm_crypt_io {=0A=
>>>       u8 *integrity_metadata;=0A=
>>>       bool integrity_metadata_from_pool;=0A=
>>>       struct work_struct work;=0A=
>>> +     struct tasklet_struct tasklet;=0A=
>>>=0A=
>>>       struct convert_context ctx;=0A=
>>>=0A=
>>> @@ -127,7 +128,8 @@ struct iv_elephant_private {=0A=
>>>   * and encrypts / decrypts at the same time.=0A=
>>>   */=0A=
>>>  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,=0A=
>>> -          DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };=0A=
>>> +          DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD,=0A=
>>> +          DM_CRYPT_NO_READ_WORKQUEUE, DM_CRYPT_NO_WRITE_WORKQUEUE };=
=0A=
>>=0A=
>> I liked the "INLINE" naming. What about DM_CRYPT_READ_INLINE and=0A=
>> DM_CRYPT_WRITE_INLINE ? Shorter too :)=0A=
>>=0A=
>> But from the changes below, it looks like your change is now less about =
being=0A=
>> purely inline or synchronous but about bypassing the workqueue.=0A=
>> Is this correct ?=0A=
> =0A=
> Yes, from the test with the NULL cipher it is clearly visible that=0A=
> workqueues are the main cause of the performance degradation. The=0A=
> previous patch actually did the same thing with the addition of a=0A=
> custom xts-proxy synchronous module, which achieved "full inline"=0A=
> processing. But it is clear now, that inline/non-inline Crypto API=0A=
> does not change much from a performance point of view.=0A=
=0A=
OK. Understood. So the name DM_CRYPT_NO_READ_WORKQUEUE and=0A=
DM_CRYPT_NO_WRITE_WORKQUEUE make sense. They indeed are very descriptive.=
=0A=
I was just wondering how to avoid confusion with the DM_CRYPT_NO_OFFLOAD fl=
ag=0A=
for writes with better names. But I do not have better ideas :)=0A=
=0A=
> =0A=
>>>=0A=
>>>  enum cipher_flags {=0A=
>>>       CRYPT_MODE_INTEGRITY_AEAD,      /* Use authenticated mode for cih=
per */=0A=
>>> @@ -1449,7 +1451,7 @@ static void kcryptd_async_done(struct crypto_asyn=
c_request *async_req,=0A=
>>>                              int error);=0A=
>>>=0A=
>>>  static void crypt_alloc_req_skcipher(struct crypt_config *cc,=0A=
>>> -                                  struct convert_context *ctx)=0A=
>>> +                                  struct convert_context *ctx, bool no=
backlog)=0A=
>>>  {=0A=
>>>       unsigned key_index =3D ctx->cc_sector & (cc->tfms_count - 1);=0A=
>>>=0A=
>>> @@ -1463,12 +1465,12 @@ static void crypt_alloc_req_skcipher(struct cry=
pt_config *cc,=0A=
>>>        * requests if driver request queue is full.=0A=
>>>        */=0A=
>>>       skcipher_request_set_callback(ctx->r.req,=0A=
>>> -         CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>> +         nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>>           kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
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
> Yes, so far these flags should bypass dm-crypt workqueues only. I had=0A=
> a quick look around CRYPTO_TFM_REQ_MAY_BACKLOG and it seems that both=0A=
> generic xts as well as aesni implementations (and other crypto=0A=
> involved in disk encryption) do not have any logic related to the=0A=
> flag, so we may as well leave it as is.=0A=
=0A=
OK. Sounds good. Less changes :)=0A=
=0A=
>> From my understanding of the crypto API, and from what Eric commented, a=
 truly=0A=
>> synchronous/inline execution of the skcypher needs a call like:=0A=
>>=0A=
>> crypto_wait_req(crypto_skcipher_encrypt(req), &wait);=0A=
>>=0A=
>> For SMR use case were we must absolutely preserve the write requests ord=
er, the=0A=
>> above change will probably be needed. Will check again.=0A=
> =0A=
> I think this is not an "inline" execution, rather blocking the current=0A=
> thread and waiting for the potential asynchronous crypto thread to=0A=
> finish its operation.=0A=
=0A=
Well, if we block waiting for the crypto execution, crypto use becomes "inl=
ine"=0A=
in the context of the BIO submitter, so the write request order is preserve=
d.=0A=
More a serialization than pure inlining, sure. But in the end, exactly what=
 is=0A=
needed for zoned block device writes.=0A=
=0A=
> It seems we have different use-cases here. By bypassing workqueues we=0A=
> just want to improve performance, but otherwise do not really care=0A=
> about the order of requests.=0A=
=0A=
Yes. Understood. Not using the current workqueue mechanism for writes to zo=
ned=0A=
devices is necessary because of write ordering. The performance aspect of t=
hat=0A=
is the cherry on top of the SMR support cake :)=0A=
=0A=
> Waiting for crypto to complete synchronously may actually decrease=0A=
> performance, but required to preserve the order in some cases. Should=0A=
> this be a yet another flag?=0A=
=0A=
Yes, blocking may be a performance concern. I will be checking this careful=
ly.=0A=
As for another flag, I do not think one is needed:=0A=
1) Using bdev_is_zoned(), zoned drives can be trivially identified and=0A=
DM_CRYPT_NO_WRITE_WORKQUEUE forced-set.=0A=
2) Any other additional change needed for zoned block device write requests=
=0A=
handling can be conditional on bdev_is_zoned() & bio_op() =3D=3D REQ_OP_WRI=
TE.=0A=
=0A=
Currently, for zoned block device write, I see 2 different approaches I nee=
d to=0A=
check & test:=0A=
=0A=
1) If the crypto API calls with BACKLOG set preserve request order (creq=0A=
completion order is the same as issuing order), then all that is needed is =
force=0A=
setting DM_CRYPT_NO_WRITE_WORKQUEUE for zoned devices.=0A=
2) If (1) does not hold, then excuting encrypt operations with crypto_wait_=
req()=0A=
should work. Blocking may be an issue with performance though.=0A=
=0A=
Another possible approach may be to use a modified write_tree/write_thread =
to=0A=
include the crypto calls together with backend BIO issuing in sector order.=
 But=0A=
that may just add unnecessary context switches.=0A=
=0A=
Once you send a v3 of your patch with BACKLOG fix and other cleanups, I wil=
l=0A=
rebase my work and try different things.=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
>>>  }=0A=
>>>=0A=
>>>  static void crypt_alloc_req_aead(struct crypt_config *cc,=0A=
>>> -                              struct convert_context *ctx)=0A=
>>> +                              struct convert_context *ctx, bool noback=
log)=0A=
>>>  {=0A=
>>>       if (!ctx->r.req_aead)=0A=
>>>               ctx->r.req_aead =3D mempool_alloc(&cc->req_pool, GFP_NOIO=
);=0A=
>>> @@ -1480,17 +1482,17 @@ static void crypt_alloc_req_aead(struct crypt_c=
onfig *cc,=0A=
>>>        * requests if driver request queue is full.=0A=
>>>        */=0A=
>>>       aead_request_set_callback(ctx->r.req_aead,=0A=
>>> -         CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>> +         nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
>>>           kcryptd_async_done, dmreq_of_req(cc, ctx->r.req_aead));=0A=
>>>  }=0A=
>>>=0A=
>>>  static void crypt_alloc_req(struct crypt_config *cc,=0A=
>>> -                         struct convert_context *ctx)=0A=
>>> +                         struct convert_context *ctx, bool nobacklog)=
=0A=
>>>  {=0A=
>>>       if (crypt_integrity_aead(cc))=0A=
>>> -             crypt_alloc_req_aead(cc, ctx);=0A=
>>> +             crypt_alloc_req_aead(cc, ctx, nobacklog);=0A=
>>>       else=0A=
>>> -             crypt_alloc_req_skcipher(cc, ctx);=0A=
>>> +             crypt_alloc_req_skcipher(cc, ctx, nobacklog);=0A=
>>>  }=0A=
>>>=0A=
>>>  static void crypt_free_req_skcipher(struct crypt_config *cc,=0A=
>>> @@ -1523,7 +1525,7 @@ static void crypt_free_req(struct crypt_config *c=
c, void *req, struct bio *base_=0A=
>>>   * Encrypt / decrypt data from one bio to another one (can be the same=
 one)=0A=
>>>   */=0A=
>>>  static blk_status_t crypt_convert(struct crypt_config *cc,=0A=
>>> -                      struct convert_context *ctx)=0A=
>>> +                      struct convert_context *ctx, bool noresched)=0A=
>>=0A=
>> "noresched" is named after what will happen, not after the reason for it=
. So to=0A=
>> clarify, why not rename this as "convert_inline" or "do_inline" ?=0A=
>>=0A=
>>>  {=0A=
>>>       unsigned int tag_offset =3D 0;=0A=
>>>       unsigned int sector_step =3D cc->sector_size >> SECTOR_SHIFT;=0A=
>>> @@ -1533,7 +1535,7 @@ static blk_status_t crypt_convert(struct crypt_co=
nfig *cc,=0A=
>>>=0A=
>>>       while (ctx->iter_in.bi_size && ctx->iter_out.bi_size) {=0A=
>>>=0A=
>>> -             crypt_alloc_req(cc, ctx);=0A=
>>> +             crypt_alloc_req(cc, ctx, noresched);=0A=
>>>               atomic_inc(&ctx->cc_pending);=0A=
>>>=0A=
>>>               if (crypt_integrity_aead(cc))=0A=
>>> @@ -1566,7 +1568,8 @@ static blk_status_t crypt_convert(struct crypt_co=
nfig *cc,=0A=
>>>                       atomic_dec(&ctx->cc_pending);=0A=
>>>                       ctx->cc_sector +=3D sector_step;=0A=
>>>                       tag_offset++;=0A=
>>> -                     cond_resched();=0A=
>>> +                     if (!noresched)=0A=
>>> +                             cond_resched();=0A=
>>>                       continue;=0A=
>>>               /*=0A=
>>>                * There was a data integrity error.=0A=
>>> @@ -1879,6 +1882,9 @@ static void kcryptd_crypt_write_io_submit(struct =
dm_crypt_io *io, int async)=0A=
>>>       unsigned long flags;=0A=
>>>       sector_t sector;=0A=
>>>       struct rb_node **rbp, *parent;=0A=
>>> +     bool nosort =3D=0A=
>>> +                     (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, =
&cc->flags)) ||=0A=
>>> +                     test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)=
;=0A=
>>=0A=
>> "nosort" is a little obscure as a name. Why not just "do_inline" ? In an=
y case,=0A=
>> since this bool is used only in the if below, you could just write the c=
ondition=0A=
>> directly there.=0A=
>>=0A=
>>>=0A=
>>>       if (unlikely(io->error)) {=0A=
>>>               crypt_free_buffer_pages(cc, clone);=0A=
>>> @@ -1892,7 +1898,7 @@ static void kcryptd_crypt_write_io_submit(struct =
dm_crypt_io *io, int async)=0A=
>>>=0A=
>>>       clone->bi_iter.bi_sector =3D cc->start + io->sector;=0A=
>>>=0A=
>>> -     if (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) =
{=0A=
>>> +     if (nosort) {=0A=
>>>               generic_make_request(clone);=0A=
>>>               return;=0A=
>>>       }=0A=
>>> @@ -1941,7 +1947,7 @@ static void kcryptd_crypt_write_convert(struct dm=
_crypt_io *io)=0A=
>>>       sector +=3D bio_sectors(clone);=0A=
>>>=0A=
>>>       crypt_inc_pending(io);=0A=
>>> -     r =3D crypt_convert(cc, &io->ctx);=0A=
>>> +     r =3D crypt_convert(cc, &io->ctx, test_bit(DM_CRYPT_NO_WRITE_WORK=
QUEUE, &cc->flags));=0A=
>>>       if (r)=0A=
>>>               io->error =3D r;=0A=
>>>       crypt_finished =3D atomic_dec_and_test(&io->ctx.cc_pending);=0A=
>>> @@ -1971,7 +1977,7 @@ static void kcryptd_crypt_read_convert(struct dm_=
crypt_io *io)=0A=
>>>       crypt_convert_init(cc, &io->ctx, io->base_bio, io->base_bio,=0A=
>>>                          io->sector);=0A=
>>>=0A=
>>> -     r =3D crypt_convert(cc, &io->ctx);=0A=
>>> +     r =3D crypt_convert(cc, &io->ctx, test_bit(DM_CRYPT_NO_READ_WORKQ=
UEUE, &cc->flags));=0A=
>>>       if (r)=0A=
>>>               io->error =3D r;=0A=
>>>=0A=
>>> @@ -2031,9 +2037,29 @@ static void kcryptd_crypt(struct work_struct *wo=
rk)=0A=
>>>               kcryptd_crypt_write_convert(io);=0A=
>>>  }=0A=
>>>=0A=
>>> +static void kcryptd_crypt_tasklet(unsigned long work)=0A=
>>> +{=0A=
>>> +     kcryptd_crypt((struct work_struct *)work);=0A=
>>> +}=0A=
>>> +=0A=
>>>  static void kcryptd_queue_crypt(struct dm_crypt_io *io)=0A=
>>>  {=0A=
>>>       struct crypt_config *cc =3D io->cc;=0A=
>>> +     bool noworkqueue =3D=0A=
>>> +                     (bio_data_dir(io->base_bio) =3D=3D READ && test_b=
it(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||=0A=
>>> +                     (bio_data_dir(io->base_bio) =3D=3D WRITE && test_=
bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags));=0A=
>>=0A=
>> Since this variable is used only in the if statement bleow, why not used=
 the=0A=
>> condition directly in that statement ?=0A=
>>=0A=
>>> +=0A=
>>> +     if (noworkqueue) {=0A=
>>> +             if (in_irq()) {=0A=
>>> +                     /* Crypto API's "skcipher_walk_first() refuses to=
 work in hard IRQ context */=0A=
>>> +                     tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,=
 (unsigned long)&io->work);=0A=
>>> +                     tasklet_schedule(&io->tasklet);=0A=
>>> +                     return;=0A=
>>> +             }=0A=
>>> +=0A=
>>> +             kcryptd_crypt(&io->work);=0A=
>>> +             return;=0A=
>>> +     }=0A=
>>>=0A=
>>>       INIT_WORK(&io->work, kcryptd_crypt);=0A=
>>>       queue_work(cc->crypt_queue, &io->work);=0A=
>>> @@ -2838,7 +2864,7 @@ static int crypt_ctr_optional(struct dm_target *t=
i, unsigned int argc, char **ar=0A=
>>>       struct crypt_config *cc =3D ti->private;=0A=
>>>       struct dm_arg_set as;=0A=
>>>       static const struct dm_arg _args[] =3D {=0A=
>>> -             {0, 6, "Invalid number of feature args"},=0A=
>>> +             {0, 8, "Invalid number of feature args"},=0A=
>>>       };=0A=
>>>       unsigned int opt_params, val;=0A=
>>>       const char *opt_string, *sval;=0A=
>>> @@ -2868,6 +2894,10 @@ static int crypt_ctr_optional(struct dm_target *=
ti, unsigned int argc, char **ar=0A=
>>>=0A=
>>>               else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"=
))=0A=
>>>                       set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);=0A=
>>> +             else if (!strcasecmp(opt_string, "no_read_workqueue"))=0A=
>>> +                     set_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);=
=0A=
>>> +             else if (!strcasecmp(opt_string, "no_write_workqueue"))=
=0A=
>>> +                     set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);=
=0A=
>>>               else if (sscanf(opt_string, "integrity:%u:", &val) =3D=3D=
 1) {=0A=
>>>                       if (val =3D=3D 0 || val > MAX_TAG_SIZE) {=0A=
>>>                               ti->error =3D "Invalid integrity argument=
s";=0A=
>>> @@ -3196,6 +3226,8 @@ static void crypt_status(struct dm_target *ti, st=
atus_type_t type,=0A=
>>>               num_feature_args +=3D !!ti->num_discard_bios;=0A=
>>>               num_feature_args +=3D test_bit(DM_CRYPT_SAME_CPU, &cc->fl=
ags);=0A=
>>>               num_feature_args +=3D test_bit(DM_CRYPT_NO_OFFLOAD, &cc->=
flags);=0A=
>>> +             num_feature_args +=3D test_bit(DM_CRYPT_NO_READ_WORKQUEUE=
, &cc->flags);=0A=
>>> +             num_feature_args +=3D test_bit(DM_CRYPT_NO_WRITE_WORKQUEU=
E, &cc->flags);=0A=
>>>               num_feature_args +=3D cc->sector_size !=3D (1 << SECTOR_S=
HIFT);=0A=
>>>               num_feature_args +=3D test_bit(CRYPT_IV_LARGE_SECTORS, &c=
c->cipher_flags);=0A=
>>>               if (cc->on_disk_tag_size)=0A=
>>> @@ -3208,6 +3240,10 @@ static void crypt_status(struct dm_target *ti, s=
tatus_type_t type,=0A=
>>>                               DMEMIT(" same_cpu_crypt");=0A=
>>>                       if (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))=0A=
>>>                               DMEMIT(" submit_from_crypt_cpus");=0A=
>>> +                     if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->fla=
gs))=0A=
>>> +                             DMEMIT(" no_read_workqueue");=0A=
>>> +                     if (test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->fl=
ags))=0A=
>>> +                             DMEMIT(" no_write_workqueue");=0A=
>>>                       if (cc->on_disk_tag_size)=0A=
>>>                               DMEMIT(" integrity:%u:%s", cc->on_disk_ta=
g_size, cc->cipher_auth);=0A=
>>>                       if (cc->sector_size !=3D (1 << SECTOR_SHIFT))=0A=
>>> @@ -3320,7 +3356,7 @@ static void crypt_io_hints(struct dm_target *ti, =
struct queue_limits *limits)=0A=
>>>=0A=
>>>  static struct target_type crypt_target =3D {=0A=
>>>       .name   =3D "crypt",=0A=
>>> -     .version =3D {1, 21, 0},=0A=
>>> +     .version =3D {1, 22, 0},=0A=
>>>       .module =3D THIS_MODULE,=0A=
>>>       .ctr    =3D crypt_ctr,=0A=
>>>       .dtr    =3D crypt_dtr,=0A=
>>>=0A=
>>=0A=
>>=0A=
>> --=0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
