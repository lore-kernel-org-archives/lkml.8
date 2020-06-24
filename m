Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C106C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16857206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j0i1T0ph";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DTPKjltg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbgFXFMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:12:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9534 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgFXFMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592975563; x=1624511563;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZvgnrjfuVm9egd3XkcFnFYeu3Rcqh0DFWgeNt6qvM1A=;
  b=j0i1T0phA7vYi2NYbNSAnJUtXOGXfTSro/LOWeDeAL8f30Oe2+t8gFyR
   XFscCR9fe0frhdPYeFwLMOA3s3UaTe9SXB0Oswm10ochkULkYOAtVkqnh
   6rOZ3k0Bpm9GRDNUbFZuI76vbViyxGG117NB/NWYv5du3uYpSDHgb0+gk
   LNLLN5KBcnc8jXz980xQI9uz9kvoopCmbAP7J0IKziItU+PJtELB54Q2i
   lipiuiIij3qAAxs1c7CqdBR2Cqpd+2DsNXAqNdNZwqZYOgHY9tEMqpzQ3
   359PZGBx2DZiuhjGMX43jFEUPyGMODOTZgZIASrp25PlfUWohVrB9XkrK
   A==;
IronPort-SDR: y4tGI7w3zBugVQ7ebPCRHmHsq9ytTvuQxZBYzxZXvjjZjtB//XvyThr92lbSrk8BsGs+r0er1D
 s84+3kcdTo8YxspGI1Zm6Zvk8NkjR5qLwbLLp+RF5nNXjCI8X+CdtXqdknQZPG3sLETeiobD0L
 mhds39IRpr2/qrJCxzNfHu1jiWyWDV+JdO/js7HEjeQysoCJ85pi2wu+T0DarpPQhDrV1Ox7XB
 y/nhbopTUmuGqgxt2HfPZ4cWfd4acUaxZLPvRxzpyWnbacoZ7V8jZgMJuba9WUths1sAMZEp1e
 xqc=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="141007286"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 13:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkKfG2wxsXWLjn0L0M9+9Ttpo6xEyD0jF5mROaAGa/lin9s+wsuooJv7TRxyVxAV14fgHTvBlAutoDYzgOP/e5vbz+5MkAhZHELlSd9NSGfAnHtBpTmCfn8tcP7aaMCkbcuSkdebgqGX19bJQQsWPMMlkDaPxoysvFFxxvrmzVLhuUDnNqePLuQl4x/jEn9cD6gnT6tGyi9t7+TpSbND5ibEbPr69ohrWRsuK7qfjmkDdgtZechjpHL1A430kiqRKJZ08EZKiWlVpCdIPUu25ANWODu3wXaUnVtAt/+9d+uFR29eOnMrkKR6tSBxLi+OHJBjNqT8re3eJx2QCfkjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9y0LUpntpSgCj5pSLottWs1zfsOLBy4S+M6UgeKjHc=;
 b=MYq5QCOKR4M3hdEG/Bs4Fum1VXxP9uUAsrvEguaJgdjWHeCAiNKDOG7UzFmH6X/lyH3aqNROpbzrQet5EGgDH8Yj2xBk0W2JpGCxjkpfJ8SrbOUFeoRtVasLnQ7kqxWGWRJU8gPAXG9XNryWZyvcWr0/18diOya5bm410BAmpT9iuXAfP1tbECUvdXRWJS3cfjCDdIRG79XH7ojlULYqMsTYCbOGqweZhyneJOAzxsgDj8WNh711nTBh/YCxIZq/g88YWFl+rAqR11wG2nJaRTUXPZ8v8yLEVLG+n0luyzwNLEUk8MJgrBCNb+zZTf52AFsKBJrqYHL5ZGIJYVBNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9y0LUpntpSgCj5pSLottWs1zfsOLBy4S+M6UgeKjHc=;
 b=DTPKjltgo2/5+f6kwCi/hlUsdKUl1CrsFXw4LBQCJ0unDdpz4cCQqc16KiPzMCYM3Lg5M1Njupu2h1O3OAjcWK0PH6XW47Xfc8Q3ELxDrd8pYr1sJvj4HZfdVHOCxduE/EYy744hf7n1b83Sud1HZMw/PcAq2Ivt13YF7HnHIRU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 24 Jun
 2020 05:12:40 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 05:12:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ignat Korchagin <ignat@cloudflare.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [dm-devel] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE flag to
 dm-crypt target
Thread-Topic: [dm-devel] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE flag to
 dm-crypt target
Thread-Index: AQHWSeYV77vE9ehTTUSGmjh9RgGvoA==
Date:   Wed, 24 Jun 2020 05:12:40 +0000
Message-ID: <CY4PR04MB375140A86968BAEA71C8EDDFE7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619164132.1648-2-ignat@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec5941ca-0d5a-47d7-a1d9-08d817fd37c1
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-microsoft-antispam-prvs: <CY4PR04MB1030B399F7B4551B0311AC95E7950@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNZm2/ibr10US0jEFGouX0s6TiMnuq9ab2JukBXQj+EC1U7by7ELTwtiTy9jjG4Fi4z6BuY4nfw1tLBWDpI0CoYLcY5I+U/XXiSygwYuqYU1+WXm79W+WpVfMGRf80xM2350YpzvG8mVGRCr5qy2PNpl08PbHydmMbxiSTTqZKvN5BG1OFKIEPY+U+jSPg1wa9uH5YsVP3+XIBGlHKcLrzRMMI0tX4MHq/aKiIqXFcM3w/B7KWmF85Y6crgTC7+cgZBwCMU2ePgNKYvOjbGsDlTYu0xBraO9hQiafPpcNz8jnEQA29H52nHsMXX9c9pl3f2U6OiwE7bQnJeKWao6waN33JS1YNAdhOKgHwXGuCFYHjPa3GB3SYyvnPNDhk2b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(7696005)(5660300002)(478600001)(52536014)(91956017)(66946007)(316002)(66556008)(66446008)(64756008)(6506007)(53546011)(76116006)(66476007)(8936002)(33656002)(110136005)(9686003)(55016002)(71200400001)(83380400001)(2906002)(26005)(86362001)(186003)(4326008)(8676002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eYfHLpXnqh2TyDD+94uq+DY0gdlujSR0d4SLrCxyjZ+e9Hr3wJA24nwCvv9VQpgLzXD8tijB0N6F3uM0fw0472btihvyewCFFK/zJzD/T1xt8uSLfvG8eC//vlRwgsh3Sp93knGkilgKprbpEWqXcuv1BBFd/vWsKrnU9utFr4498FDlmfwbQyifckoYQf1ykmniDEJdgyOygS4zbQXqJ2JeZRa6C/y5LrUDUDs7o0MJU7hGjuFcBL96++i9gNq59mW4cBkGG/L5Ksng8DtyExh9CBsQPX4HkgSRNGfKb+kJexn7ylAe7UK1d+MPdcN4gsrr5dqG0B5eboJXLMr3PDIENSrRChok6luzpxl5h2gyAtbBNLJ4r6+DRQ2O3+cV+c0dY1yG0ZjAj5fnKtZ2T4DPGMFLa73BSRhknB50vR5k8dzcasAk/XWM6tDxru2GFtn1vf1D6kz2dXwGUtruz3ajqnqc0mq4+inCDlL8I3AIwG/FUCwWCIy2Wdfm+cAr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5941ca-0d5a-47d7-a1d9-08d817fd37c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 05:12:40.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cflfz8W/XPqZYvIqHJ8LMKE4gGhMN8RiCFvXK2+bD0dX8FxC0xbBEy8fvZpO50WUhj5rJwZoBguhZDdPTbUjBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/22 17:47, Ignat Korchagin wrote:=0A=
> Sometimes extra thread offloading imposed by dm-crypt hurts IO latency. T=
his is=0A=
> especially visible on busy systems with many processes/threads. Moreover,=
 most=0A=
> Crypto API implementaions are async, that is they offload crypto operatio=
ns on=0A=
> their own, so this dm-crypt offloading is excessive.=0A=
> =0A=
> This adds a new flag, which directs dm-crypt not to offload crypto operat=
ions=0A=
> and process everything inline. For cases, where crypto operations cannot =
happen=0A=
> inline (hard interrupt context, for example the read path of the NVME dri=
ver),=0A=
> we offload the work to a tasklet rather than a workqueue.=0A=
> =0A=
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>=0A=
> ---=0A=
>  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------=
=0A=
>  1 file changed, 43 insertions(+), 12 deletions(-)=0A=
> =0A=
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c=0A=
> index 000ddfab5ba0..5a9bac4fdffb 100644=0A=
> --- a/drivers/md/dm-crypt.c=0A=
> +++ b/drivers/md/dm-crypt.c=0A=
> @@ -69,6 +69,7 @@ struct dm_crypt_io {=0A=
>  	u8 *integrity_metadata;=0A=
>  	bool integrity_metadata_from_pool;=0A=
>  	struct work_struct work;=0A=
> +	struct tasklet_struct tasklet;=0A=
>  =0A=
>  	struct convert_context ctx;=0A=
>  =0A=
> @@ -127,7 +128,7 @@ struct iv_elephant_private {=0A=
>   * and encrypts / decrypts at the same time.=0A=
>   */=0A=
>  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,=0A=
> -	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };=0A=
> +	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD, DM_CRYPT_FORCE_INLINE =3D =
(sizeof(unsigned long) * 8 - 1) };=0A=
=0A=
I do not see why a special value needs to be defined for DM_CRYPT_FORCE_INL=
INE.=0A=
It is clear from the number of members in the enum that we have far less th=
an 32=0A=
flags. Also, it may be good to add DM_CRYPT_FORCE_INLINE as a new line to a=
void=0A=
the long-ish line.=0A=
=0A=
>  =0A=
>  enum cipher_flags {=0A=
>  	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper */=0A=
> @@ -1458,13 +1459,18 @@ static void crypt_alloc_req_skcipher(struct crypt=
_config *cc,=0A=
>  =0A=
>  	skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);=
=0A=
>  =0A=
> -	/*=0A=
> -	 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs=0A=
> -	 * requests if driver request queue is full.=0A=
> -	 */=0A=
> -	skcipher_request_set_callback(ctx->r.req,=0A=
> -	    CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
> -	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
> +	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))=0A=
> +		/* make sure we zero important fields of the request */=0A=
> +		skcipher_request_set_callback(ctx->r.req,=0A=
> +	        0, NULL, NULL);=0A=
=0A=
May be add a return here to avoid the need for else ?=0A=
=0A=
> +	else=0A=
> +		/*=0A=
> +		 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs=0A=
> +		 * requests if driver request queue is full.=0A=
> +		 */=0A=
> +		skcipher_request_set_callback(ctx->r.req,=0A=
> +	        CRYPTO_TFM_REQ_MAY_BACKLOG,=0A=
> +	        kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));=0A=
>  }=0A=
>  =0A=
>  static void crypt_alloc_req_aead(struct crypt_config *cc,=0A=
> @@ -1566,7 +1572,8 @@ static blk_status_t crypt_convert(struct crypt_conf=
ig *cc,=0A=
>  			atomic_dec(&ctx->cc_pending);=0A=
>  			ctx->cc_sector +=3D sector_step;=0A=
>  			tag_offset++;=0A=
> -			cond_resched();=0A=
> +			if (!test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))=0A=
> +				cond_resched();=0A=
>  			continue;=0A=
>  		/*=0A=
>  		 * There was a data integrity error.=0A=
> @@ -1892,6 +1899,11 @@ static void kcryptd_crypt_write_io_submit(struct d=
m_crypt_io *io, int async)=0A=
>  =0A=
>  	clone->bi_iter.bi_sector =3D cc->start + io->sector;=0A=
>  =0A=
> +	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags)) {=0A=
> +		generic_make_request(clone);=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
>  	if (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) {=0A=
=0A=
A little inline helper such as kcryptd_crypt_write_io_inline(io, async) wou=
ld=0A=
simplify things here: the conditions leading to an inline write will be gat=
hered=0A=
together and can be explained. And for SMR, since we also need an IO type b=
ased=0A=
selection, we can extent the helper without needing another change here.=0A=
=0A=
>  		generic_make_request(clone);=0A=
>  		return;=0A=
> @@ -2031,12 +2043,26 @@ static void kcryptd_crypt(struct work_struct *wor=
k)=0A=
>  		kcryptd_crypt_write_convert(io);=0A=
>  }=0A=
>  =0A=
> +static void kcryptd_crypt_tasklet(unsigned long work)=0A=
> +{=0A=
> +	kcryptd_crypt((struct work_struct *)work);=0A=
> +}=0A=
> +=0A=
>  static void kcryptd_queue_crypt(struct dm_crypt_io *io)=0A=
>  {=0A=
>  	struct crypt_config *cc =3D io->cc;=0A=
>  =0A=
> -	INIT_WORK(&io->work, kcryptd_crypt);=0A=
> -	queue_work(cc->crypt_queue, &io->work);=0A=
> +	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags)) {=0A=
> +		if (in_irq()) {=0A=
> +			/* Crypto API will fail hard in hard IRQ context */=0A=
> +			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io-=
>work);=0A=
> +			tasklet_schedule(&io->tasklet);=0A=
> +		} else=0A=
> +			kcryptd_crypt(&io->work);=0A=
=0A=
Same as above: return here to avoid the else ?=0A=
=0A=
> +	} else {=0A=
> +		INIT_WORK(&io->work, kcryptd_crypt);=0A=
> +		queue_work(cc->crypt_queue, &io->work);=0A=
> +	}=0A=
>  }=0A=
>  =0A=
>  static void crypt_free_tfms_aead(struct crypt_config *cc)=0A=
> @@ -2838,7 +2864,7 @@ static int crypt_ctr_optional(struct dm_target *ti,=
 unsigned int argc, char **ar=0A=
>  	struct crypt_config *cc =3D ti->private;=0A=
>  	struct dm_arg_set as;=0A=
>  	static const struct dm_arg _args[] =3D {=0A=
> -		{0, 6, "Invalid number of feature args"},=0A=
> +		{0, 7, "Invalid number of feature args"},=0A=
>  	};=0A=
>  	unsigned int opt_params, val;=0A=
>  	const char *opt_string, *sval;=0A=
> @@ -2868,6 +2894,8 @@ static int crypt_ctr_optional(struct dm_target *ti,=
 unsigned int argc, char **ar=0A=
>  =0A=
>  		else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"))=0A=
>  			set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);=0A=
> +		else if (!strcasecmp(opt_string, "force_inline"))=0A=
> +			set_bit(DM_CRYPT_FORCE_INLINE, &cc->flags);=0A=
>  		else if (sscanf(opt_string, "integrity:%u:", &val) =3D=3D 1) {=0A=
>  			if (val =3D=3D 0 || val > MAX_TAG_SIZE) {=0A=
>  				ti->error =3D "Invalid integrity arguments";=0A=
> @@ -3196,6 +3224,7 @@ static void crypt_status(struct dm_target *ti, stat=
us_type_t type,=0A=
>  		num_feature_args +=3D !!ti->num_discard_bios;=0A=
>  		num_feature_args +=3D test_bit(DM_CRYPT_SAME_CPU, &cc->flags);=0A=
>  		num_feature_args +=3D test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);=0A=
> +		num_feature_args +=3D test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags);=0A=
>  		num_feature_args +=3D cc->sector_size !=3D (1 << SECTOR_SHIFT);=0A=
>  		num_feature_args +=3D test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_fla=
gs);=0A=
>  		if (cc->on_disk_tag_size)=0A=
> @@ -3208,6 +3237,8 @@ static void crypt_status(struct dm_target *ti, stat=
us_type_t type,=0A=
>  				DMEMIT(" same_cpu_crypt");=0A=
>  			if (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))=0A=
>  				DMEMIT(" submit_from_crypt_cpus");=0A=
> +			if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))=0A=
> +				DMEMIT(" force_inline");=0A=
>  			if (cc->on_disk_tag_size)=0A=
>  				DMEMIT(" integrity:%u:%s", cc->on_disk_tag_size, cc->cipher_auth);=
=0A=
>  			if (cc->sector_size !=3D (1 << SECTOR_SHIFT))=0A=
> =0A=
=0A=
Apart from the above few comments, this all looks OK to me (and tested).=0A=
One question though: do you have patches for cryptsetup user land tools to =
allow=0A=
controlling the specification of the inline flag on device open ?=0A=
=0A=
It turns out that the most difficult part of the SMR support is patching=0A=
cryptsetup. Not much work needed for plain use, but formats such as Luks do=
 not=0A=
write super block and metadata sequentially, which causes problems with dri=
ves=0A=
that do not have conventional zones at LBA 0...=0A=
But this is my problem to solve :)=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
