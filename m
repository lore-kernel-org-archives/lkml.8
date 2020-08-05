Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B890DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6092520792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="QyGJRddO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHEUKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:10:44 -0400
Received: from us-smtp-delivery-162.mimecast.com ([216.205.24.162]:45478 "EHLO
        us-smtp-delivery-162.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgHEUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:10:20 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 16:10:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1596658205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+9mWlKgawWyzm6IVadGDHV4bGfBtDf+UhcobH0DMQkQ=;
        b=QyGJRddO44tkROFseqW/kOFFgqVdRe3wqqKbz5UNu/aQKLqXmJ5r4eNj0ZjcKzt9Cgy8Dd
        rY0TL+7ZyzR5Z5Il+eIdMM2JmWqyWkUc06LBhG0Zm/BUIpPz72VKviz2RdP7I1/0M6eFK0
        byFI266t1tylAkNF2hAELr5Doc9jyMs=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-2p1KVlywNoCtmxE5cRJzhw-1; Wed, 05 Aug 2020 16:03:33 -0400
X-MC-Unique: 2p1KVlywNoCtmxE5cRJzhw-1
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::13) by TU4PR8401MB0733.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 20:03:32 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::402e:74e4:29e4:6b82]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::402e:74e4:29e4:6b82%5]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 20:03:32 +0000
From:   "Bhat, Jayalakshmi Manjunath" <jayalakshmi.bhat@hp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: DRBG CAVS test error
Thread-Topic: DRBG CAVS test error
Thread-Index: AdZrY3vHWwqYoDEaT/2M2s+J7Jrz8Q==
Date:   Wed, 5 Aug 2020 20:03:31 +0000
Message-ID: <TU4PR8401MB1216BF9450F95187F94BCE01F64B0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.51.105.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7570faa9-83ae-44d1-b90d-08d8397aa0d7
x-ms-traffictypediagnostic: TU4PR8401MB0733:
x-microsoft-antispam-prvs: <TU4PR8401MB07339F4282AD033AA8F5808CF64B0@TU4PR8401MB0733.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2arix/vhU8KmB5tv6cCdWd3WQYqMTWHjQdRaV+0QxFlqdqOLXI4ci1Re7ojz3NfZ3mRQLxSBN5WJx/4Be6EzAbSvTAixgLvaP2Q3MOk7YSIEKPxRugE39oP+BBH00X1wLrNTar/kYM9aKkfGMKzrsNmkKVqx4Wyu14+vmY+IH01NuuN0ukWKigYm/nXM575di1H4bqbnU3rxlMl3cG3NZdYR+gQL2MN+CruXCVi5lp15y+7xWLgIV/q33eI9MVuLOth4xkhHZRRG1/zl7BvqIV6xG1B2nVMy9AkmVPdpFbjFPTuSVPjUu3Vf9gXqMx3xONEOpdFZtcg4zBaqhaiBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(136003)(39860400002)(346002)(9686003)(478600001)(76116006)(2906002)(5660300002)(86362001)(3480700007)(26005)(52536014)(8936002)(55016002)(33656002)(55236004)(71200400001)(8676002)(66476007)(6916009)(66946007)(66446008)(66556008)(64756008)(186003)(316002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2txvO2VguWG57kyzxw7FPbx3w8KLMf7QPi+Yp9AyLy1t2EgCTuw/QkgBVLa+ufqOkbb5BINP/5f27UwthQ5tEd0y2Is90kgVmgvGvhJQPAXVqxBEV27pYuQL4wVfuLwEXmFBkngpQdhs99NyPlfR3zuaEwpvM4B6hAT37o9eb7zhSy0wUN/ye3dAeP0wXKgA1UYaaDQ4u9nqP8oxTpBSLF72zcDSKt4aQhrf07VaMPEVgrhOJ+GNtTwhcGA139Jxp56ahU82/Q+xC7xnxyqn+mAOM9F3Jmz9M0fGsWupsEN7Aes96cZtDfNQYAdm59vCv4pTNvIn0Nyi/6m7NGzsAr2BC3Jn/FXDsjUfdTluHMIvWWDM7Er4iXuiQHXHBKWbgKut4FizMaStGycQ9q4HTMjKwzDTlzgSKF5HSsK24eRjuqjfDpsyOcH9VOJJFcplK7UtOMBVZ0HwjOaEMHbCuOmZjbE+GfhIuGK0AR5IiQ3QPm/Xcv2vrpwfGVPzII/g2VlOLfkIrcQV2LmJ4sZn9iBFmDqNrRSgI+l+e16XLuIAjZObBTPggS0/uVZ04a73ge+qe68/CaiUzWjCFBGcN9O8LTa0H7ofobQYFn8AnuEQB5NJM7mkcEK5tdo8NC4HSQmGS9OW68cPiwhLyPh/GA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7570faa9-83ae-44d1-b90d-08d8397aa0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 20:03:31.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkZkcijue985djURgHnFT8FIPZmMJTK/KO2EU30xYHd84xG0GDbTjJlR2CWLUfSOxKiI1NRn7iYXCExOciMn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0733
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=jayalakshmi.bhat@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I am executing DRBG CAVS test, using drbg_nopr_hmac_sha512. Below is the co=
de snippet.

test_data.testentropy =3D &testentropy;
drbg_string_fill(&testentropy, drbg_st->entropy_nonce_input, drbg_st->entro=
py_nonce_len);
drbg_string_fill(&pers, drbg_st->personalization_string, iv_struct->persona=
lization_string_len);
ret =3D crypto_drbg_reset_test(drng, &pers, &test_data);

drbg_string_fill(&additional_input, drbg_st->additional_input_reseed, drbg_=
st->additional_input_reseed_len);
if (drbg_st->entropy_input_reseed_len >0)
=09drbg_string_fill(&entropy_input, drbg_st->>entropy_input_reseed, drbg_st=
->entropy_input_reseed_len);
ret =3D crypto_drbg_get_bytes_addtl(drng, buf, test->expectedlen, &addition=
al_input);

drbg_string_fill(&additional_input,   drbg_st->additional_generate,    drbg=
_st->additional_generate_len);
if (drbg_st->entropy_input_generate_len >0)
=09drbg_string_fill(&entropy_input, drbg_st->entropy_input_generate, drbg_s=
t->entropy_input_generate_len);
ret =3D crypto_drbg_get_bytes_addtl(drng, buf, test->expectedlen, &addition=
al_input);

drbg_string_fill(&additional_input, drbg_st->additional_input_final,    drb=
g_st->additional_input_final_len);
if (additional_input_final_len > 0)
=09drbg_string_fill(&entropy_input, drbg_st->entropy_input_final, drbg_st->=
entropy_input_final_len);
ret =3D crypto_drbg_get_bytes_addtl(drng, buf, test->expectedlen, &addition=
al_input);

However the output generated seems to be wrong. Can any help me to indicate=
 what I am doing wrong

Regards,
Jaya

