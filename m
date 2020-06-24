Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD64C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C068206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ijSzzaGb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="crnPchT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbgFXFV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:21:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2395 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgFXFV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592976087; x=1624512087;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8PfL0sk8uWYFBfWBbDzxYf2o/N+de//druWYDbYhBzY=;
  b=ijSzzaGbJMhdILGQtDPw65oTKdktAcGrC1CMZtDMVicv0qngeRtzbVF0
   C0TOp4O7qTvviXZMsGEM+az7WlaouzpupOdK2zdWRSSy+zxEpWIO9ME16
   j/t+iPgaW4pVc7irTGtLIowVjxUJw2pxCf7OGEknYWpSkRnaHBl9pp7kw
   GKSNlTF3q/yCacbCRXtAzZhX+NaPTmgSqgIStU3SWoXtSVaQmq0OGb16C
   7I1LKaiWCVtLtakCVj9SOYBkA9AlXqRQpoq5+XBuZAnzFmL+dfVAL2LWy
   94z17DOMsbTAnTbCDssEa5k27WmCwb+7yxECb6NYMBqpM2ztQ7w1Ld2Oz
   w==;
IronPort-SDR: 5CflCLXQ2UQs8T/wMc6nLB/j+bqlVVi1Y3LZelAtTW7C0hXlnse4PyzTux7ejC8tDF2INnr5kJ
 I27DD6HNL6tml8rMbFD9Jg0JSDfnGDEP+E3bAABsvKP0gVQ13CV6nIJmU+ULzUUMgDA7XcGoF3
 RBRKMv7bfBkud/VPx3FeuPBeZtBCPWA7Z952rHKNBuwPreYuKn8rhMLaaC/vmVUECdft7Ft/96
 jvKvNraz49wYv7ThMcyTMdX6UEJvyMjb3IrYkwCQYG2eT0TmlCee/TJ9iZQjaqK8jmbSolLKcG
 kuQ=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="249977918"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 13:21:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVJRCAeBtT+XDAM3D4ddBwo8vUqDtPRaaBb2mIVP08rybyAd5kvrWy17HP1thgX76Urly0uKloH+n9W6ATboGbgHRNvsxfPf1cLETyQTXmDsbzNFRTBJ9aIp2avGAefcKGr7k08Nk0PJ8TKALPm+AXnJ2N/s59jsxPSQm+f146QqptDcJSBgfvNVI/iS/ICeeky/AJMUGwR4kmeQdmrXz/b4qfhYeF7Uenztr5dYY6M4xQGrigWXYTfdO7Z9EX9ss/ZPePKNerQEhbnaC839AUnpfPdaIeTIOCFve6U3hvBF/mCx+aibkeiRf++s4QJGUWME6DgJRteVwI8sJWws5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rryw3Ab6oYTRw07K961fCn0cIOWx68MhubTgJexOT+Q=;
 b=Lu6dpSMzC3T7Tbo9ffIcaGpWP33yrQoyD26Knf1l/JKphULmoBXJl5kqIuv4T4nAdsvrxzWTMZWTHv0F/dgqg9LgE386mo+yqEqNxHFfWl3MZEcd5GHAQCEr/GDDGzSJ/6sEkaMIvoHSmwyiWvkAHbMke4iRKVw+9R+xPxF7V1Vhjh/1lMQwpMGVozZ4rFOFs/NBlFGavxfpuAptuMAmmdUl4bxWOa2vigZOZ0xoQTMVK4XfpVzzZFAkF9b5+Wbm57/qxd1oXOkG/LDjMRmeAeiIhuTjts9zLLzgAUhBVAxKCyrimbmiu0DQPubetOI/XG/u38gYJuu1NEedufp7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rryw3Ab6oYTRw07K961fCn0cIOWx68MhubTgJexOT+Q=;
 b=crnPchT0Jxsf50XdcPPHo9txCnGKv6O0Mvv4UHcQKoC5I7nwogmi5S+mx8xY3jOKupPQ80Y/l27cW7p98HCccEmtehMp7M71chWCGN6izhmgWAK6rD5NO4Qm49VofNyxQdTK7LEdWHhkr51yPyCrQsiawKJdyV2t1X5+lay9nwE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0375.namprd04.prod.outlook.com (2603:10b6:903:b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 05:21:25 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 05:21:25 +0000
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
Date:   Wed, 24 Jun 2020 05:21:24 +0000
Message-ID: <CY4PR04MB37515EB3C74CCAE2A006202FE7950@CY4PR04MB3751.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: d54ef20c-e58a-4ef8-8e7f-08d817fe70a5
x-ms-traffictypediagnostic: CY4PR04MB0375:
x-microsoft-antispam-prvs: <CY4PR04MB03752FB83F6E3A73ACAB20BAE7950@CY4PR04MB0375.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kONO3pegNOAQDvBVx9NsiaAjGWrBMG0PA2lLQ8pxKLb8DhF87ROhi5tsjKovOmqLiLJMCxkeumGMpnrJybiTWb8rKf4xU5AuGHgon18mmjo31TbTid8MTbX38ppUVElYnWY/iUpxLMuVphwrHi1hTFwLTbf6yXJ8xDvxL31Cdwu6oDjwhL1k5zkW1OW2FMCih9QEQMQJyDYG/SjsyXPGiFAQqEQjNn1KmHoXykeirptOQgUjH+O9wlaLZbx9qwIATyxuqNHjCsRN4HGHXotXAsVIAfCqe2OlSjlIVSylpzi5PBevtVZRGRshrbuxfQRBfB4g9GWupvP332RxMTkRlNHWt7l0Do/VpQ58xjQC0WJu5R+XJGCpiuTE6ypky5oE5Jn2D9uCc8tRBHvyO/y2Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(26005)(186003)(5660300002)(55016002)(9686003)(966005)(2906002)(316002)(52536014)(110136005)(54906003)(53546011)(6506007)(7696005)(8676002)(71200400001)(8936002)(33656002)(86362001)(66476007)(66446008)(76116006)(83380400001)(66556008)(91956017)(64756008)(478600001)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KeNgUM2jMGjRoPBRuNm4hrEZe111+HlF7QGepfGxT5TEh0a6UvOA2uCtSSuAj/rlDqBb8xhifg5PBv6pzqd52K05QsRng41t22cPQQOvhC4AxatFmxO10Lt2PvUv2ZUrokYQ8ajtaYFNeQGQq8u4dB3YvYDwpbIh9Khh8SvNtWolChcac1yZpO6ZRPGZSRJoArYC5aIJ8T+Gw1WLKZ+fO9kInc/Z0JrivIJq3sDpNXsAw7BLRnw9KyiNWMs+3r+895De9NafqTf2vz51A2UKUyr81+z4eJqCI5u4KFG9hwF3lEGwmR15iiHQOwYFKvcD1K83hI/mBRwoZXB/xCg1YPUdSfPHUNGv8ybyKYzXqBGxjNlWQs+f5X7mKKCgKcoNKF7y5IwTNfBqS8qFsObLsCn80QZIeRScsrMPkldj6AVYHD1VnHqT58LOE/sEGpjfV035zgLNi6TuErVRyC8lEb3kSLUXd/NomSQhz2EB8IqqblAR12Xs8+/yzE6iqPFA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ef20c-e58a-4ef8-8e7f-08d817fe70a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 05:21:24.9766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ol85xOgReHUxcfmqSnk4F/HA57+1KiAQpGRTab7YIN77UrVa6AXLz1k6Qjw/vP8t6nlJGGm1AR6FLYRAa4CyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0375
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
=0A=
Arg... So it means that some skciphers will not be OK at all for SMR writes=
. I=0A=
was not aware of these differences (tested with aes-xts-plain64 only). The =
ugly=0A=
way to support async ciphers would be to just wait inline for the crypto AP=
I to=0A=
complete using a completion for instance. But that is very ugly. Back to=0A=
brainstorming, and need to learn more about the crypto API...=0A=
=0A=
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
