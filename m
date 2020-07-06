Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C54BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C702070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ia3BYzmt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yLzA8fOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgGFCXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:23:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5809 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgGFCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594002225; x=1625538225;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SLBgOBtVG/fiR67blu75SzABFxs69bVW25CGy9WPVdk=;
  b=Ia3BYzmtlaVzfwc40RWpBs8wsPeqv/sgUmbeo1dyMwNSXFyLF00MxKUs
   HRbMCYkB/me26n5nB8zcCXRV21zVY63uCCrayW0xdr897hqcy3+kWE5Vw
   KfBsaSgnCofN7lhq/vrfbMyq4AKipccIa3urYPXuSAKbwrq989QT4wZrz
   XIfT5yRqqX/O4gpM5ER2qpslP/Alb5/v5GqnH+/ruPRyphiVBZYfOtMn8
   P9vqdxzsWkdowUTLQGSvn417nk36yOUcJIEQwtzEuECXmNUuSkQMgCxwI
   o/7ODr8dwfnoCEP3Xtl8y8U9DBcO3oDnTDJFgC67MH2F0d63BseuKmbq5
   g==;
IronPort-SDR: 7aS3E4Gs9BL2pmBlNpwUaJodx6wn9s0ZWYclhhSIR0mkb1ZjWFzvuXBCv9GdwiyJsnTz1i3bVg
 xLCWby1aKJ8XWS3aSwBE1XKwC32KHmXkZG5enkjyeRffyjRxzSnQRr6O1CVr04D9F5ese7JCdN
 MXbIrDdqpdWZJyS69mQBaDarNno6vCEowG1Jf8rd6DpO9bDSkMElPmDXp4I3konB72Kqavk8c0
 RNW7b9j19W4Y22hWMosGTvNN5XWwwe5s1+mN3lTqjrLkFtKW10XwiFnUSftSFd2pfKUDDTagD3
 m6w=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="146022033"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:23:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4fgF9n6BXVnETyAyiWdqcqN/s8d2jRi8vh7tPbiTbb1GG+aAe7Vfv/BhX2BL16aaCHN7prYqotaaPKkYIf3dOgUwEXyyYhzzyzWwokxnqiNSUDayP8BJyzHcA9vD76Vmcz/b6TwptMQXsonCOTdnr98Xzsl7UAhr+5yXiGKUO6jV2CJsqwEQU5ESbpyPkgNaMUtW8s6z6sgIu6kEgQrngWxfpq0MQcdFY+PK7UhX3rMCjlxr5KTxGsHbswTSCj3aGxZv9uIXOdXOuVxHxFYVo8UvXkGkc7rPdEpseDTh5y2Q/2FjXKea69ozyCo7B7c8k8b2ATxZ8UiroHln8J2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLBgOBtVG/fiR67blu75SzABFxs69bVW25CGy9WPVdk=;
 b=ET/zqdEBHhoTlnMTH3jTfB4ZSCARVEvZJdG/LWNphfTsgaBQX9NGzttZnVhH3AjAA/QzSqShrYc7knd8EjNzPZs87Cui3oFe2EQrN70lEPNbTkrCjobehbfuimHXXLiTOrl+2qnWYfpZOhpkgkn50MWA58zj/EEMrqNCrq1dID3anxa2uJRSKG7QSAYKlZ3RkTOc5doPI54LDZct9h+HG95mncUJKAKSHkKhCoh1QJycH3rMnzvrD4RztrlRHEY+1IHKVq08FwlY+5IHQWcAMfSCNoy+n30QJn8A6RehUHwaG+XX2yJ3zczNLaPoocZijaq50cvz0KOUk1zSjmXN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLBgOBtVG/fiR67blu75SzABFxs69bVW25CGy9WPVdk=;
 b=yLzA8fOskQOSzDriDlCEItQFZnuA43M7eC+NrrO0B1bfzMGibJk4avLSGEDDdVvPhOpLbsfEpgvCPYVzw5SbHghxFIdUIbFIYFJq/BnlCn+f0qpytqEM3GoqEltEzsOTV6kN+MhQ5cgTSonzlcbSWRaY34tmUo7QqIyTd6Wjg8s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 02:23:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:23:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] nvme-pci: Remove redundant segment validation
Thread-Topic: [PATCH 3/5] nvme-pci: Remove redundant segment validation
Thread-Index: AQHWUOVXtR7Eg0/4Hk2VuWAjK0lOzQ==
Date:   Mon, 6 Jul 2020 02:23:40 +0000
Message-ID: <BYAPR04MB49656927FC38696FDC8AB10286690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <84ef8fd8eb4d7289fa92b5be12cc71eb1af46c5b.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5be66fcb-0df8-48ff-16ee-08d82153994e
x-ms-traffictypediagnostic: BY5PR04MB6550:
x-microsoft-antispam-prvs: <BY5PR04MB6550F70BAD45BB440E5F188086690@BY5PR04MB6550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dExtBVXdL3Sdq6Gh8ntggnMJsbK5zuimrm2um5jlMdXpGKV8Mu4PdWLu/r2sUWCYzYTBprYRgowqQO+4GrNRcJmrm/Pd6kNmMMPu/6R+g1mOv5xnHjHmdoEYZNAxUKRfVJceGrN5b0Nt0XuSFRGM1WV9FjMpMK146EaS6S1dWizM7yuo9NxVtugJNR2PCTmumPndQ7YJiidh+EYXyoXpODwRqiDZn+YM+jLW4AsKoZ4XI31E1LIXnxUnX6FncFFyo5ORF367ddsadVxLiFKBSu4977zrD/SUtZ+bjoj0JysTPPr77Xj1H7tAx1FTpkYpN940Hbgdhou61ckospMemg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(76116006)(26005)(53546011)(6506007)(52536014)(5660300002)(4744005)(7696005)(83380400001)(478600001)(71200400001)(66446008)(66946007)(66556008)(66476007)(64756008)(110136005)(86362001)(4326008)(186003)(54906003)(33656002)(9686003)(316002)(2906002)(8936002)(8676002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5pglaNL0twU4a4JF7ZV9tdxvscf1FUv89sxdkCCHTurVDjtZxVKD/3UESE5FLLcXj1+28lxmcnVLCdTbQR+61YYpIlOexEU3jpQ8tRnDhOV7/9PrG9RV0Cxj/LOf84RkJNNRyGmD2Z5kOZj9zq1ul4/790PYE1iIczWB/AgKhp+tYLxM8+VNbrGa2pUJSx6yxp5UeSsUav+0pazcMYnkOdSVzxI7+soBqamV5zHsJzB7v1BlMrpzN3rDgUZ+EbmwhhtxrlrXxEHl0FOgRkktyDc4qIyRm31wTOqlcs+9Fi589tdQYL0b0TUrg7Y1bu1qApyjxvwdpA2tOLbnpznfBp2GponkpWhcM0v0dK41dkwJW5cy8mYRJ+2Bb1fgS7RaF8uZOFpnu21Vh53GXmXAzCFq5CC2CRzn9reaD1t7xRyD0cZ4Bi8BX16Fe5whlevPbqW+reWhITglHIUUBkDzmTaGBKX6IaXWdE8lYBc9iNw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be66fcb-0df8-48ff-16ee-08d82153994e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:23:40.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNEeAd8QyrZDO4pocfqOUxqdLFXz0cfMw6OJd+MdFze2UBDR18Ws91M6SNjCT04k5LaMF0DKpydvYMzku2NBS07GF34L2ix0eiUrCriJb3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 7:54 PM, Baolin Wang wrote:=0A=
> We've validated the segment counts before calling nvme_map_data(),=0A=
> so there is no need to validate again in nvme_pci_use_sgls() only=0A=
> called from nvme_map_data().=0A=
> =0A=
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>=0A=
=0A=
Indeed we do call blk_rq_nr_phys_segments() in nvme_queue_rq().=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
