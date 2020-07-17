Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1746C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D33620737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RWb+tGqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGQSSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:18:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:33202 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgGQSSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:18:49 -0400
IronPort-SDR: ExEDRUaHGDSQJBv7KkABN3109/kSYcksjtUtGUlgpOxkk+L1FMyzhmbEk6BNnjl6AE3yBep/vm
 ohEvaeKd6+ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="129734831"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="129734831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:18:48 -0700
IronPort-SDR: VlRttUfKtFlriv3Wt1LCem7s8+TEqk4AchpE2fphPijayi/xJUydLfysTX8xGKQZNNnZx+33wo
 NAMn8HwmFPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="361420962"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2020 11:18:48 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:18:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jul 2020 11:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPxLQDmetmbQSrp8wc9o+QiJmpJcMjMwFw08xJq0KGxL/L6iYA+jDXX6HvWeOBsxx8z2Rp+4yF6r/M058eHjJT6h7jU/UVfaCuGb1z4u7uHBfXvEMaCFmVSMFHTXHyOj8VRweUTzLQZw7J8j28zotFq+cq8JcRY88B+JEXMR5Visbum/WatRgPnT731ZWTOp98ILtdVY51HxPghed8rvqlHYUWjF8/b6p41moKILP8Sqn4zfVctOEqZmbSGOWSOUPdeBcjl2bZrdlwykaKf/TiJ5Z5yewLU1Tr4rogMor1Cba9Uo6gPEXGV1ugwmyPTwKh7Z/y0Y/FN+W1IqtuZzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEXkfvfDq88nOpaiRFMEK1mcmKa5TaC5m7aRxeoNYlI=;
 b=jF4JeOk+wHZCSZqD5aN1PDwB1XDtpjwt43TLjnNBUehj5c5wBYy64XoG7kNTZQILxIgESphn0ZQFvYZraUEPYNfaX1aaREfHx2udiWpDn3rXLMGeDtuftTaKUjp8C1TNgg5aSxuu5/ZA9xHeLAO1VVcgYyirtktKM6ncQSWSQRwvzD0r3k6noDXr4rUyZa0vvN1kXAKlOMpMgt2/16NTru03Y3TX32/d6BQ1n2eqZv45ab+qw7NXs4sKsif/yoVGrFS5pY7U4Om9DOjG4XNDjtpoGhfTu2JOMMBmfggD4Fu8GSHIAui621R3Rcv23ENQ/bip5zchcvwWMiVLtyghGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEXkfvfDq88nOpaiRFMEK1mcmKa5TaC5m7aRxeoNYlI=;
 b=RWb+tGqpQyMLKKN3vxT4Y9lqAKS/0zjrGu7/pOBEz5TqGYp4CLArmw11xHBKja9KlrE235RC0yVTPg7eDf4X0MK+PjbydHLxrOXWJfE6Y7JZ0hBypzK4FnZNy6e6bfOyk11ASQw6v+K57rdjY2FyfM7Wzt5vvKb79RJtKBIR3Dk=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB2880.namprd11.prod.outlook.com (2603:10b6:805:58::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 18:18:47 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 18:18:47 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Topic: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Index: AQHWWGU9Tth4ik4BzU63g7CSJsQmkakKx86w
Date:   Fri, 17 Jul 2020 18:18:46 +0000
Message-ID: <SN6PR11MB2574E9B6F6957D765BC18F29F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155810.GC186665@kroah.com>
In-Reply-To: <20200712155810.GC186665@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b2509b2-1da2-4c31-feb3-08d82a7dd8e5
x-ms-traffictypediagnostic: SN6PR11MB2880:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28806BD6C89EC1687B4199CBF67C0@SN6PR11MB2880.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dAZefiVP18H2FfbOvcNHToDSbRu2pBWeEUxIN+EjFBzPe/nePXpL2RWV5GDH32CuAvKIYDVATreVZ1xjOmya7IGn1qSJrPhkUiH73kNFb0e5MnPQLW5906Kou6j5qnPr6qxQLrEWJl5GcdDj5rhlKsM0qJpWSdTRRoeiTI/HI5/57vBRqTOaGQ17H1veFxgy3H+rUu2kngJ0EWzWiwp7oj61gXDl9utPqwZlK2r1mWKECx2ykGbiTXmPw0CnyC300SUf/PfSg1IU01HWWf9inYSTlr/mNSNuUq1L7UsRYpasEM7Z0hbMEQ31VJItxaEqUBNZZvVMgUOISSq0VszNSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(55016002)(71200400001)(9686003)(66946007)(66446008)(66476007)(64756008)(316002)(66556008)(8936002)(83380400001)(7696005)(54906003)(2906002)(52536014)(5660300002)(76116006)(8676002)(86362001)(26005)(53546011)(186003)(107886003)(6916009)(6506007)(478600001)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nyfG4G2UKWcZcqaZckl6ouUJTaYT6X2WIJtWiHFWLgjJo7UXFMcIu2h3TWsBAqObAFo4BDMdGxF3ol3ivir6VZAsv+VA4OIOrkrMp8Mx3P2yoi3ip+JXD61/o0pNu/LPwoMmiEZC+8UDf8A0/x/kKUQogm/KiflauYfVgshLEGXNQKf4WkW3qPIdO1wBrKVEZpBHPuDifu3W/REtEz1clvHrB4mrLkmJxXP4xQrTzeHR0TGDa0D8qTvZ2qcAQYj+n4OpLDCsd76zgdq2tnOnd9K6SwcrpSy8LQw+jFPWRu8RlAarZrJYEavILPloZhFBACZCLpO8nPHneo8slfCQmzKBq3dp90QkFDp2GL3fDlWtvyYORxKSb5NKkdEHag4jBsdGHFhwBC8cVCr8O4evhljG5mE2jZvsC7jTlaMjZu4JKAnWOivG4kFgk8DKcScQmEzWAcA9juAx56hgpQRDwpbQ2YPkOhzoBdDZPTP+GtE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2509b2-1da2-4c31-feb3-08d82a7dd8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 18:18:46.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhbGh+jB+MJY7sluxShvpZ4vZjgtz+03x7fk5/JwI07KwTakSt7yLAZ0nWp11cVsMmo3Rvb4w1jHaQIbqaadYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2880
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, July 12, 2020 10:58 AM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
>=20
> On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > +static int dlb2_probe(struct pci_dev *pdev,
> > +		      const struct pci_device_id *pdev_id) {
> > +	struct dlb2_dev *dlb2_dev;
> > +	int ret;
> > +
> > +	dev_dbg(&pdev->dev, "probe\n");
>=20
> ftrace is your friend.  Remove all of your debugging code now, you don't =
need
> it anymore, especially for stuff like this where you didn't even need it =
in the
> first place :(

I'll remove this and other similar dev_dbg() calls. This was an oversight o=
n my part.

I have other instances that a kprobe can't easily replace, such as printing=
 structure contents, that are useful for tracing the usage of the driver. I=
t looks like other misc drivers use dev_dbg() similarly -- do you consider =
this an acceptable use of a debug print?

Thanks,
Gage

>=20
> Same for everywhere else in all of these patches.  I'll stop reviewing no=
w,
> someone at Intel should have caught basic stuff like this before now, sad=
...
>=20
> greg k-h
