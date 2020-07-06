Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADDF2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jrMIxGSq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="twJz8i3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGFCZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:25:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5899 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgGFCZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594002304; x=1625538304;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6914c4hsGFny0hxK7/UjAv5RMjnVT6c+P2rU370+AdI=;
  b=jrMIxGSqGB+Z3FyXClDU2D8UYV9AYcEEIXpE1G/WDdk9i/J6fXw2buJF
   0MXDygICMOUVYMT6DAFX25azAjMlLmHmNE4Zd4ztWJSj5lEWQy7eMNVfl
   olKQu9N7ovGkvL24MggAdN2uUhQHuW4iphJj7siR50ujJJmCFZsPtiCqI
   5oQffdDhlrprQDzLrscUdQ5CQn1rebunnP5rYG5hjrYcd6gTenSFK0Shy
   Dr3ZeeFU3WXtY11F5b69nVkpTT69w2Cn0j6gN7rgXDswyCSDzU0G1lc67
   NWMH/YDogpS+KD8o6Q/0mutQxmEUpKLP9Syk9Wlwb4dhaBftB2FRjUb7B
   A==;
IronPort-SDR: UA2k7gRZ0Dp3ij4SZE5HeGQ+UHWd+UePkqajVT+IMbqhujp81LJP13uWLnGwHTNUS6L2JkvAQN
 lh7WhiWnuI5u1tjje+GwxRxJ6DsVjtCdiRACQQR+pmgjaKww5Nc/v5vBCdEUAZQR0lbptKeVkt
 NFtpEuIvJRTlcIxzWyTB8lLV93VA4vrHsAQld36q7PC5nNDHPrLfPwRz5oVUpdw7SFFcj459r/
 aLjNI9RCdUUobapFT8Cmybv+bnvbkvpe1URWoj4/DQYBz+wkCzAcZyiT0PNwqan+t1CitGQN4H
 AiM=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="146022062"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:24:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpGnUi2/HXOEf1O142GRkZZ3hk4oKJWfghryyRW4iP4KmLRsLyn7zZlOUu71Ix9nRqBfh5cW4+u1ffyJv79C6Cu4EleijjK8JAvfg8crFWw6liN0EJ0OwHhxugMGVQlaNk18U1avsQ5rSy2oxPfrJXic3/N8YkMM3Kqyvec9M2XCQyVSKifmD+zF/9zItF0CG98irwIlLoUl46pFSeLFM+carF6GNBd0MT6aqcd4SwxwqlDMHee0K+zIHDIJczz3LHbXrfTd0h8htIY9chHhmUgtwcVw1ReZd7WJw34nUu34GjuBU35HhqyK6PYeODNv0Nj2Mpc/WPm9Rp99adeKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6914c4hsGFny0hxK7/UjAv5RMjnVT6c+P2rU370+AdI=;
 b=bt5rCDyuW/2jgBox1hFjch0Y0wb5PIzLFPUeOpAEES4yh7LkkjYtGhRWP/Vot0nqAaY+tddD6rL1RtUVOXGBjeHRnjdXkDm8Rco9tNf/YsLpF1rW9vazA1XOacxxY9V3U9YGIzMKpRNTekUmxduoyxALnJuKZGN/cWkk78fZggKFuv5PEBY18bmuWflDi1K9Hd/V25MgWk8mon5IgjyRWZrYfejmEzVUkzSqDXP6Ygp9bP3F1k9nUjIaHj+haswX4Vlvv679T5kbEDlwmZnYtv1i3z02s6UcRDRrZJ8ZGsQRZBa3Rjc5J4M13HWqa9NgQSB4EikJSHhnunfubIHgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6914c4hsGFny0hxK7/UjAv5RMjnVT6c+P2rU370+AdI=;
 b=twJz8i3ie7RUa2S7WKpJtvpNWVZF/qnAnZFCjBBB1hOV31JcMSDu47saOaCBYzNoF4jT//wVQabEuNm8KYGICwO+60zv4oINsNaaU5C0Bhe03nwRPVziyPm1O378e2rWwFdefcJ0uRRBDtIaQCQM7WPpJiNnPkSQRNGBzIBiRoc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 02:24:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:24:47 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] nvme-pci: Use the consistent return type of
 nvme_pci_iod_alloc_size()
Thread-Topic: [PATCH 4/5] nvme-pci: Use the consistent return type of
 nvme_pci_iod_alloc_size()
Thread-Index: AQHWUOVYQX8o8MSgvUOS83VqkZWdmg==
Date:   Mon, 6 Jul 2020 02:24:47 +0000
Message-ID: <BYAPR04MB4965E1A26D792C3CCF61570D86690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <f6a3c779f68ae170076ea37a721c9c06a9dc70f3.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4be6a074-f8d4-4bbc-be61-08d82153c0c0
x-ms-traffictypediagnostic: BY5PR04MB6550:
x-microsoft-antispam-prvs: <BY5PR04MB6550C340DC1F84D4549A45CA86690@BY5PR04MB6550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ajPqZeMhhpJkebP06kJRIYSPM+BOLYffNHJznxN5PctbBGaP4sYrws4iwnXylXfTKbE0MBekAgN/MrTxDCcvJXDLW7V+tTCLqYftmQu4cSiaCvdQERmwJdJbQMWewacl2j6SyMhnwa5C3nDaClfiH6Bry+8LJ8gB1jmbja/3Qj9hB5rJqaysPzjmQk70DdNpDWNwfFIggVPKjOmbHkAyO/1z2vPdmfxqLKAnedzkaqpgDJFQpPn6vpe0uQ0lw5Pb7jP4ApyU17Ml3RZjfdxWkH3jbTNV4t0EJFn+3/AP9ZwVnn85m+GN5xidvU7zuXMp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(4326008)(186003)(54906003)(86362001)(110136005)(8936002)(8676002)(2906002)(55016002)(316002)(9686003)(33656002)(558084003)(6506007)(53546011)(26005)(76116006)(478600001)(71200400001)(66446008)(66946007)(66556008)(66476007)(64756008)(52536014)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GpDAs7zmbeyWxYguM9q+ENPR4Y48nv53+F/QOU7HfQyipZYOZJt5PJLcFgj6+16+VOxNuaQmIZGIPGpUeSEWP1k9rz+PKQuSTyC5HY11/f9x7twM52YT8wGTKcaKObZ5ACiT8Eoz3MdZlNBW/+cFV44kjtxNifRtcxkIUHHV+Eap0Zx2FaI/FPfgvidfsS+pR7RT0l7D3Vw0/TpP+rJCpGSBhqG36cH5JJq4hl6tcmG5aD58rXW/QMzIZXy2eFluFaacj1+wUMn6YkUP+oMNDys/JI5agnEVFJqBTTfD005fjgoeToZi75dxbwewYZdjAKkCl2k5WJq3e7b7R7mzcLRK1XM94TpnrZSd6xblzRsnBszLidtxCMBDudBfn9YROkMcsUCZN50+2GfOL8VnCbPTRJEtPJxB9n25AHJdjk3Q5PozWf7xwar/91YNtCi7dlnet4R2/hMZTwepaCLvv7AnUWXbsXj4PCHepgmaQfg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be6a074-f8d4-4bbc-be61-08d82153c0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:24:47.1775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yilgrtdVqAanVYSym1vidQy3MB6jbIfIbfqbdWq+7hORMiYAtHOLaxWNY8N5l+Av6v6Ri/uRFDvSYHlXUCuMR3DkZbLakAlb6cmDFxLgxV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 7:55 PM, Baolin Wang wrote:=0A=
> The nvme_pci_iod_alloc_size() should return 'size_t' type to keep=0A=
> consistent.=0A=
> =0A=
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
