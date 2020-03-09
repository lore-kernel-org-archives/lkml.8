Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C3C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BE9208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCIQDf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:03:35 -0400
Received: from mail-oln040092254045.outbound.protection.outlook.com ([40.92.254.45]:6116
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbgCIQDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThitrIB36IbtAljLV/O9KIQiuEV7v6R6hWOilcPad60HD05YW+1HMxEU97gDNYZgL3uRSWs3D6oMdWaSsGIQeHwGbDcc83sYEvFaXg1htmnjdr0+An7+kRoE0eKVIwtmEyVse3LLV4xM2iVMGi2V2ByQrsIqLbqcvbyfaghim2p/MY2Xo8Cme0tz+LI0/iVYmemMVL66An00JTehGNS84x6ogpioeX/kTVP9ULwWUodv0Cw89EDnaPHU0LJ8RSg4NNq3pXHchIgZjhTTRl3CD1KLW0iLvRVAlMYtzXvdKRliTFWMoItf/3qg792XdInysSS9b19NcVpPdow2E7XpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zXRmhiMb6jCM3iZOj6Ex+guv69Zwd7KgvKfK/O1L0o=;
 b=b5UNk1wNJCMeLBs6iTWJBodvCVSjYG19rIu7nORvxHlxqC9gXSXD11m7++5tXf4BMqFl42Uvx2CDGSjATvPCGeutNQND+KYC4kbV9GZNKHlCtJJqaaN18UW5pbs5uvzJUo+Eu7DWojUj1UrEFcXGrycJnszdDICu1L12LxXDpa02nZNYCjT4jEoZOgwL1bvbZyccz75xMZRq8dpoqhjmUeqKNvpghEKvUjPPp6d/M6+y8I3pWI9tE5YWNDk1DVraqfz8RTzM5sNfgMmSNE66FGVTL7yBUKMyszb+HhAxHNMdP9Obw9Fr/Ac2xfYA63OUwzABSLXAexfjLDVoS/nGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT017.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::33) by
 SG2APC01HT152.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::437)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Mon, 9 Mar
 2020 16:03:28 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.55) by
 SG2APC01FT017.mail.protection.outlook.com (10.152.250.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Mon, 9 Mar 2020 16:03:28 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 16:03:28 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by ME2PR01CA0024.ausprd01.prod.outlook.com (2603:10c6:201:15::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Mon, 9 Mar 2020 16:03:26 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC:     xinhui pan <xinhui.pan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Correct the condition of warning while bo
 release
Thread-Topic: [PATCH] drm/amdgpu: Correct the condition of warning while bo
 release
Thread-Index: AQHV9iAWGvTdIfRZI0Kw62U7ndmsIqhAVmIAgAAV3YA=
Date:   Mon, 9 Mar 2020 16:03:28 +0000
Message-ID: <PSXP216MB0438A4A1EFC2F67579542BB480FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <20200309143458.18411-1-xinhui.pan@amd.com>
 <9da8f3a9-5d28-37b9-cda6-8be336068e7b@amd.com>
In-Reply-To: <9da8f3a9-5d28-37b9-cda6-8be336068e7b@amd.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0024.ausprd01.prod.outlook.com
 (2603:10c6:201:15::36) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:56A6BEE9EDE6721B21D4B0CEDD12E86AAFCCB3BDE54510C40BF28C64C9F85AD2;UpperCasedChecksum:86D8B6F206AA44457AE4A7311CAD5025CF43A2446E0C5D1FAB50961D8103125F;SizeAsReceived:7957;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dE6dk91ZefiW1+TQzKm03HM8Ja+j6COL0VTItOMcLPHeRm7S1biUwidW8Tx96pKG]
x-microsoft-original-message-id: <20200309160319.GA2812@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 33125ac1-888e-451b-e2df-08d7c4436793
x-ms-traffictypediagnostic: SG2APC01HT152:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LhjCBJEkkFHTkkAAVegh1IXPQR1GHNhuxl6cvFuQk1gbvlB7KVnvL4Eqe4vgyKpX1cpAZPr/qLNINNz+Iwo40fD9jl6qg56sPuQAIjOxQwOyJxf90DI07lXYtaRRBuudspu9PFQDs8IG7/zgXXLV2RHyqORAH63cC4I04Lm3butxnxs2icWcXttXicq2zk4E
x-ms-exchange-antispam-messagedata: 7fOxPWnRiQOEFnYSlOjgu1lOR5YNH+OJ/B+OnJ1g5gB+wgTMXChVN6M97zDkH+l/0pE0SlEdChvO12UUAnQpsHxQtE5V8T0oIgxH4ukAzOIeivnmnuZMv5/K91M7k/8W2wCHpCot3EnKok9Ra8OkX1PL1ZGcL0oR/MTJsJuuBcWKiGVNzfmG4RYOms983XoJwIFHNbz3+fO7/wt6mcKwTQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D35AF6ECF8697C469713E19640664B10@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 33125ac1-888e-451b-e2df-08d7c4436793
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 16:03:28.0540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:45:04PM +0100, Christian König wrote:
> Am 09.03.20 um 15:34 schrieb xinhui pan:
> > Only kernel bo has kfd eviction fence.
> > This warning is to give a notice that kfd only remove eviction fence on
> > individual bos.
> > 
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
If applicable (I reported but was not the first to report / you were 
already aware):

Tested-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

The warning went away when applied.

Cheers!
> 
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index 5766d20f29d8..e99f68af2bf7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1308,7 +1308,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
> >   		amdgpu_amdkfd_unreserve_memory_limit(abo);
> >   	/* We only remove the fence if the resv has individualized. */
> > -	WARN_ON_ONCE(bo->base.resv != &bo->base._resv);
> > +	WARN_ON_ONCE(bo->type == ttm_bo_type_kernel
> > +			&& bo->base.resv != &bo->base._resv);
> >   	if (bo->base.resv == &bo->base._resv)
> >   		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
> 
