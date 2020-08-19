Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71361C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380FE20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C/iBO/06";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HcXnftgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHSJOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:14:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45480 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgHSJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597828461; x=1629364461;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FjCB3fw6HcRn6CkDKW7rzY3TTevF0bZrlbnOz6lgz8U=;
  b=C/iBO/06160MlSfROaJ1XqqeKSXfzDbLDznlj0+1wv1lA9HDnTUnd1eB
   uh+KlBAYVbuTyiB5dAskm1mYNtdOuN4y39ZymrcnNXREPSFx52w0EEabt
   7FRtjuX4ytFyfgfNMF49Ohkzk5+dmk8txASYmSpMnlSErHAvwaShsa5RW
   OiaBP8ve6KDppnA6Rd4jyOiZ+57l+OYzfiNWf5F7hceKs1l/kFFOYCIgP
   lJllogo98FWeTmCIO8+nd6my/+Mgrre2M0phbVhCHuKG7diDsvL+wcaBA
   uMlb4cc7Ya1IcozzQ8k/amBFOUv/dCwYiuJm2d7fkk7+jSMhgs7EVDfE4
   A==;
IronPort-SDR: cb05Ci/hrHsxpOav2kRPMlk+bCYT449id9p7hrG8L8WAanK63M6QGtH20m73kxgRvVLyZX7jRf
 9/2uY2Huq/liyFoeetGxe9Ob3dcsm/bWJiK4l9N2hz5xVDWgOmmn8G4fy+s0piiMOerbDUSm1D
 Pdw6qkTSACd+Jms8UAi/N3zcQu5ig2hbmZ2w5TL2u3nLKZ1DcQATO/l9ARM2Z2yeVfApWJAadC
 Upcb4v5a7l7evIwSxVehT8njdpKCzb/9aA6DtvT1S4sz80SNlsH+E9wo/6ORJ0qoT4kWAPTxjf
 tfM=
X-IronPort-AV: E=Sophos;i="5.76,330,1592841600"; 
   d="scan'208";a="145259265"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2020 17:14:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0sOuYhx61IIa/snWAnavdlL1M6pxkr+OHI2MMbWqUiqjIB3lKuuVRBKfyxua8r/iYpKDgwsBnStLkgBRrg6xnGXZOh66QbWOFaNrU3nid4hvTvExXMPn4iM3aynhgJL2a2PnThEMmZV/VSo3pHt3vuBVJw4c2KHWwZs+WIOhZM3p2+YwrKHrNAXRlr7mn1zFv0dQF2b6EebGoncvqOKXe+WConcfaKco7/GEJ1KQP0A8IQHIpQdwEtbJFq3qM31Ra3P9u5AzTPRruB1t0jTjeer7ly2d5CX3pbDI/wF6b+saIu9bxi4yQuHHGEQ9Ajxoh/snBY9ERHANdVyCZ5+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdD83oIFybb2CcxQ1VxUunCRJCfKgmVvYv5joTZG/l4=;
 b=I6xnHwl2gb4pJNmW4qM4ZzbqFTce3+UzVoRiibY8XPy/vOkyNhxJH7B6KVtFkKGKYpTU7U+am72EmMKyOTm3qwK6ASF00zGB/JbptiXVoxjNTTorcNzCQY62UCugKckqlStdZxKwju0SGNekcC0IjxxDeCQSFdgqaXKJv4EgL6nSj2Xiradnjya4fE/d/ULFvlXLPw25PC+SrJrST4bRNBOEfOmqIu7omRlzcE1aOmLxCcYLHnTSElhanko/n+wuZrt2YFXLptyCOloBOU+i51VbnXl4zfODJvM62fPg3whgKLTon2z58DprpifrJFbNr97w9XAcBhgyevAcKMS71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdD83oIFybb2CcxQ1VxUunCRJCfKgmVvYv5joTZG/l4=;
 b=HcXnftgnYdhNx5OCDOUODYKtVsPYhk4H/3InEKeax0JOnm4p0z2xMG8PNAPConBsMlk19pRhK0abGGtUWNCWUx1vty7cbUD5re4k2M3OQDN/VizSw8mqYkleAnjYR0tqd2ZPNjLS5ftwKsjkjji7EUALlXsymBoerCa4gqLEMzY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0249.namprd04.prod.outlook.com (2603:10b6:903:37::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 19 Aug
 2020 09:14:13 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.028; Wed, 19 Aug
 2020 09:14:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Javier Gonzalez <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Kanchan Joshi <joshi.k@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Thread-Topic: [PATCH 2/2] nvme: add emulation for zone-append
Thread-Index: AQHWdSEOep7b6SwjrkaV8sjqDWd2vg==
Date:   Wed, 19 Aug 2020 09:14:13 +0000
Message-ID: <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
 <20200819083353.rwblagiesocfcq7i@mpHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12a98498-06f7-4eeb-8c23-08d844203d75
x-ms-traffictypediagnostic: CY4PR04MB0249:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB02497ACD5ACC19197AC9B844E75D0@CY4PR04MB0249.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3laP4D4F4PIEi5yoTZye1WLSVEZaPnPN8pyjSScornnMC37H7tOrOGaNkV+aHrnMXWKeIli2FiCBhLwb9+/ipug3/Tif0k469MPHczYvtbehiijN7/GKjHtn1NlWKaCaVOpW88Gvc/FvB4WEKgHIfcZFrVUdCtynX/oeZz1DHq3kW6vGikoo80dP+J+twR7t3qFs7Jd1OVZVN2jtBFt3s8bS4HlETG6MZaSuuVCl9uvuIw+OBvQ+JQu4s1Xs586O2DbdywBmtUjMAjFphmm3FVRFiuNrWyJP7KQfQlEehoDBNlPEjdwWJmIJHjRyxoXil5cGFYg2MhaMBDvRREl2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(83380400001)(7696005)(71200400001)(86362001)(9686003)(5660300002)(478600001)(26005)(8936002)(53546011)(55016002)(186003)(66946007)(54906003)(64756008)(6506007)(8676002)(110136005)(4326008)(66556008)(33656002)(66446008)(52536014)(316002)(66476007)(2906002)(91956017)(7416002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lfSBQyj43QHCqR8p8Xtv1wtZIqqpon07vxMLw1d+cpm1FmWdhkMdDHrL79+BXPkY/5EgsTQmHoFS6RDvy8N9Nr5uaJr5TR7Zz762UWoWvgw1nqHs/W75upAqgdElAN/wg3WxlOt3b2o8JbTYtFjgfetzNO9uDKO3h9Zc6k/TtFSDIo8ydNrc1L9toGY0hTSvW8vBqYuJxRjrIR+2AXaQWmV2Q+fVTiYhInaqMOC6wOfaS7u2thdYPamdHNxOp6W5dSgROEaXBhCZRpcuh1FKEnrT+L9wqlMrSC/WJDUGx3k9VOCPX+D1dGTsU7ck7dNR8AF3a9ebiGH7SHZKzJSRa7p51NxobM9YJzr3gvxXmD6XBrAi9RHrai2twfKe+H+w6iIcQyfBigL4s/UvTW/VrWl8jh4RXeBZL+9vgnBv5mL3DxhmQmR0ODWs8xtGzRoqd/7qjYufARHEVVT4Mvg15rKy0gNurMjQ7WwjEAyKcH+Uch5xUo6LUdRTb2IpPfbfS8X4HNtyXmVOZR8aGRqRoU/ld/t8CI8fbObQjgssFYDRd9HBbVmGZHGwcPbShvKq7fqj6Yhqp5g4Ai4kzny+oPuS/hgqp82noAYTIuyLFwYLJIOjrm1YKRAO5Kz1xp8KTMHrBBs/WiYwD9wmiF91MQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a98498-06f7-4eeb-8c23-08d844203d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 09:14:13.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qX5cExk6aEzeIGNC/nyqz/c9IiiyvmtRUhJ7wquQOo2bV+VuD4UfzxtsUW9qxpOPTjySg7viE6zuNTN5b12gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/19 17:34, Javier Gonzalez wrote:=0A=
> On 19.08.2020 09:40, Christoph Hellwig wrote:=0A=
>> On Tue, Aug 18, 2020 at 08:04:28PM +0200, Javier Gonzalez wrote:=0A=
>>> I understand that you want vendor alignment in the NVMe driver and I=0A=
>>> agree. We are not pushing for a non-append model - you can see that we=
=0A=
>>> are investing effort in implementing the append path in thee block laye=
r=0A=
>>> and io_uring and we will continue doing so as patches get merged.=0A=
>>>=0A=
>>> This said, we do have some OEM models that do not implement append and =
I=0A=
>>> would like them to be supported in Linux. As you know, new TPs are bein=
g=0A=
>>> standardized now and the append emulation is the based for adding=0A=
>>> support for this. I do not believe it is unreasonable to find a way to=
=0A=
>>> add support for this SSDs.=0A=
>>=0A=
>> I do not think we should support anything but Zone Append, especially no=
t=0A=
>> the new TP, which is going to add even more horrible code for absolutely=
=0A=
>> no good reason.=0A=
> =0A=
> I must admit that this is a bit frustrating. The new TP adds=0A=
> functionality beyond operating as an Append alternative that I would=0A=
> very much like to see upstream (do want to discuss details here).=0A=
> =0A=
> I understand the concerns about deviating from the Append model, but I=0A=
> believe we should find a way to add these new features. We are hiding=0A=
> all the logic in the NVMe driver and not touching the interface with the=
=0A=
> block layer, so the overall model is really not changed.=0A=
> =0A=
>>=0A=
>>> If you completely close the door this approach, the alternative is=0A=
>>> carrying off-tree patches to the several OEMs that use these devices.=
=0A=
>>> This is not good for the zoned ecosystem nor for the future of Zone=0A=
>>> Append.=0A=
>>=0A=
>> I really don't have a problem with that.  If these OEMs want to use=0A=
>> an inferior access model only, they have to pay the price for it.=0A=
>> I also don't think that proxy arguments are very useful.  If you OEMs=0A=
>> are troubled by carrying patches becomes they decided to buy inferior=0A=
>> drivers they are perfectly happy to argue their cause here on the list.=
=0A=
> =0A=
> I am not arguing as a proxy, I am stating the trouble we see from our=0A=
> perspective in having to diverge from mainline when our approach is=0A=
> being upstream first.=0A=
> =0A=
> Whether the I/O mode is inferior or superior, they can answer that=0A=
> themselves if they read this list.=0A=
>>=0A=
>>> Are you open to us doing some characterization and if the impact=0A=
>>> to the fast path is not significant, moving ahead to a Zone Append=0A=
>>> emulation like in SCSI? I will promise that we will remove this path if=
=0A=
>>> requests for these devices terminate.=0A=
>>=0A=
>> As said I do not think implementing zone append emulation or the TP that=
=0A=
>> shall not be named are a good idea for Linux.=0A=
> =0A=
> I would ask you to reconsider this position. I have a hard time=0A=
> understanding how zone append emulation is a good idea in SCSI and not=0A=
> in NVMe, when there is no performance penalty.=0A=
=0A=
While defining a zone append command for SCSI/ZBC is possible (using sense =
data=0A=
for returning the written offset), there is no way to define zone append fo=
r=0A=
SATA/ZAC without entirely breaking the ATA command model. This is why we we=
nt=0A=
after an emulation implementation instead of trying to standardized native=
=0A=
commands. That implementation does not have any performance impact over reg=
ular=0A=
writes *and* zone write locking does not in general degrade HDD write=0A=
performance (only a few corner cases suffer from it). Comparing things equa=
lly,=0A=
the same could be said of NVMe drives that do not have zone append native=
=0A=
support: performance will be essentially the same using regular writes and=
=0A=
emulated zone append. But mq-deadline and zone write locking will significa=
ntly=0A=
lower performance for emulated zone append compared to a native zone append=
=0A=
support by the drive.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
