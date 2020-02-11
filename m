Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA14C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C4D20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="MHJXjCtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgBKKTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:19:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:31253 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgBKKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:19:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 02:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="227464038"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2020 02:19:04 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 02:19:04 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX156.amr.corp.intel.com (10.22.240.22) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 02:19:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 11 Feb 2020 02:19:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkDIw5ZyglY/H9xhPwxH6pzusE5nsPes8nWUeL0gOzAy2KijQ62E/EmAzoXjTXLgVx8deJwP87qFpC3TH1ailAAzrSDwZvyN0ba6Bl5NrOC6vNtLibKTkf/50kadyhdezvo1F13sAaQaE4tU01FTHjgI9OuXNuNeW1RgG2XZtzvbOnvRb0kVffh2RADKzkl7kISeMcF5I/PmQ7588BX2UInzxOdlZ5N8KXx0yAf27xVTrUCRfHEURnJfR1KcqC2FquAnMl/2AT6G77gTnhxDgCqA0LNSUtX+QsoSJpmzIMBF4v6/ZX7wC2hnuICmj0q1peNN3ZL9RJKe3nMaZjyhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t08cy6hoYoRcKho4WsOuUzRFbk4jrnmuBPHcix7WOVM=;
 b=a4guwUgR3JUYXTUUMDeuQxvbfOt7s89CRSHvmbTnzhQWkRZ5gQej5RU3e54oW7thk4gLUfQZMtwTnVoOs8PkqPKfh/t+fH1e72mDFXCN00cGlDNGl6u9sLOeGTRJMR46Qed1WVRCk1eUcB7CiQzREVEIwAxSQSQgyoWWGvu4Twn6/WF/ZJsavVNrvfjp5gRsr9tNN7E1jMnWl7M6lhD0HHormFU7JlWuXcLoCTVBovZfbYHs0yK2W/EQcIfwtYKV6RLKalZ+73M+Nicy8NIMtywRk7eFNv8uqd0/u1oQ4+R8Pk0JTJaKWFF2DPB7OxXMMDaAh9HDmnMRH41ReTNtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t08cy6hoYoRcKho4WsOuUzRFbk4jrnmuBPHcix7WOVM=;
 b=MHJXjCtmBf7W37WD164H5Ikuv4GJZpTzil2Qs8IyhmNns2r9SeWU7qmPO2ZHy9k8J9hZj6LdLY0w6J+//L7U5WTU4AovLp9b6qx5VCaEmYgwluWjl4LhF0FGFcuo23jeTEv9ljJRqSSTPZ+bgx+J6mcyEAxxpWLApd+11H22fJA=
Received: from SN6PR11MB2670.namprd11.prod.outlook.com (52.135.96.25) by
 SN6PR11MB2637.namprd11.prod.outlook.com (52.135.89.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 10:19:03 +0000
Received: from SN6PR11MB2670.namprd11.prod.outlook.com
 ([fe80::d9a3:52a2:97d7:89ec]) by SN6PR11MB2670.namprd11.prod.outlook.com
 ([fe80::d9a3:52a2:97d7:89ec%4]) with mapi id 15.20.2707.028; Tue, 11 Feb 2020
 10:19:03 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cychiang@google.com" <cychiang@google.com>,
        "Chiang, Mac" <mac.chiang@intel.com>
Subject: RE: [PATCH] ASoC: da7219: check SRM lock in trigger callback
Thread-Topic: [PATCH] ASoC: da7219: check SRM lock in trigger callback
Thread-Index: AQHV3+tuqX6FpQoz5UK6Rt5tUMk2f6gUyH2AgAD/0UA=
Date:   Tue, 11 Feb 2020 10:19:03 +0000
Message-ID: <SN6PR11MB26709809E6900F1F1F9F422A97180@SN6PR11MB2670.namprd11.prod.outlook.com>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <20200210185905.GD14166@sirena.org.uk>
In-Reply-To: <20200210185905.GD14166@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brent.lu@intel.com; 
x-originating-ip: [192.55.52.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a59ade5-5f38-49b9-00f3-08d7aedbd1a2
x-ms-traffictypediagnostic: SN6PR11MB2637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB26373C0C5B68E724C748F9BB97180@SN6PR11MB2637.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(8936002)(26005)(4326008)(71200400001)(4744005)(7696005)(107886003)(54906003)(6506007)(186003)(478600001)(66946007)(55016002)(9686003)(5660300002)(76116006)(66556008)(66476007)(86362001)(81166006)(81156014)(64756008)(6916009)(66446008)(2906002)(33656002)(316002)(8676002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2637;H:SN6PR11MB2670.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTbFnD1j8GuV0+dA93vad6bWbhhQiazpVrjJdDczAlkWvtm92lrG4Od5T2+g3Edqs/a3TsbNQZP/zS4aejbJrnhmCG+Q2dCEJVLhEkBi5tf6MtxLqbfGVCYMvdKSXpWDXCeDfYazb6wYkmLCAC/sAujDatsqJRmRzNXi5Phi8BxFfrZKKcP8b7yQDleI3DxcwpYMHJYDmSGsyO5esTYpUEUCnarHjJWQEn96EcZokTmQcTTuT2mjMLMqp7wWTuzGXXK2CyeWJS1xdb6BJdf9R/U92HmxBXWkUEcoMf0d48Sh+7ZDl5tydCaLx7Yg6LbEjkz5f36YMnbnZ8L5o0uQFLQN082YYHQlKvwBIjGaIDURAm5p2YVDtQjHNW+wGJzzNnHxgiQP6bY5vH6wOMWDyMAtliqUWlLdFCxuX8l9BjU7UWwVI7sz+k+vBXWENWn5
x-ms-exchange-antispam-messagedata: jXa7beB+fKYuauN3ThpeBwujcDTGRuUPjAnuoFTWSL3AOp78U+HhmrT2Ow10VAbHC+WORm/Q5biLPfSuRfrXnh/awnlhWqzSc2Jv2WvjsULNq/C6qysFKf9TKUbOfeSX1ujS2KTEoSsnw5TK49xwtw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a59ade5-5f38-49b9-00f3-08d7aedbd1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 10:19:03.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chE3dSI6K9jQiPnMO1DxOdwrY9em9QqKUFz0QTFvrrB1hukoXfG5QiRsOKun/tR0qU1mKQl8Yi9c+dR9t4QePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2637
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Independently of any other discussion trigger is expected to run very fas=
t so
> doesn't feel like a good place to do this - given that we're talking abou=
t doing
> this to avoid noise the mute operation seems like a more idiomatic place =
to
> do this, it exists to avoid playing back glitches from the digitial inter=
face
> during startup.

It still take 50ms waiting for lock on in the trigger so I guess it's not a=
 good
implementation here. And I thought digital mute is called in the pcm_prepar=
e?
I'm afraid it does not work in our case...

Regards,
Brent
