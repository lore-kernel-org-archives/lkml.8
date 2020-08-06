Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB742086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LRaJTvTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgHFQyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgHFQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:50:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9080CC0D942C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIcGnlhXsL2JHZTHArjIyTci93TGBNAFek9b/Zpr83Lxv8fDLhZi+gTGzVvTcGlqFpOH56/PQCxxW8dZRS2avhttaT86U1kObnMMMTM9S6f4nETHAQl665Xp3pGfvGh+RtULvRoo3JCmAcbJFjTxKyG/zQy8d1P4rHa790GkKhSEwV4b5lcXcZ6vQaxBYsLuNlry/L7Tifc+eoJJ7iqv+MBEZfv59AMzV1zT/PSk8YdP40UubgqKT8aXq5zfVEswi6KxkG6xw1yO0xo2pIVJ1Z0pr13MsGyT7ggg9DztgUSktXWkpD4Wf4JpBDfgH4/W8NwsTzXnQYyVY8LQHHfTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMjay+xK+PsR1kMGpTyND9dKSV6ajylT4lusBHJ0bkk=;
 b=QRB1UcMfKGwkCtKhyeV2cwxCtA5+2ilWNaaCiuK8HK3FZY4z2tfSLrdOzwSC/EH7WAMzsxzi3OLXv0cNDG90W+3lbFRturiP9diRT20wsDoSV2ynmqVGRBXaRM6NgTxjoiWEutRMI5Tai7ewNtvuZ9rFJcoCqJBHKbMed7vN6LXgHp41NTSJmylyKAo+m/2WOrsCbKT30u8hOoRRp5AQiDGa90Dy2GjbdYznG/q8mKSFMueFlKSKtDPlfjvjTFBoaSu1L7UgtelY9RlQfaThonA2u28QOhHhUf1JTbGv4G3a9Yi0xsCyIHKyc+yBwvoMnCKo+wV783O2NCg0d06cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMjay+xK+PsR1kMGpTyND9dKSV6ajylT4lusBHJ0bkk=;
 b=LRaJTvTWXuChZPcwnLlvdHm2cT0huNyHlxBvviS4uzHtOVg+PI/rODk/e2MnPIFuGCP/6lCBkfNkyaZ0z/FdnYgR8EzEJihesGMMNgq/ZTixZMjsIMMr0GC5B6hEeKk44cDrvKjuxPIsYwYzOa3MTIWl1p3BAWxIwvu2YnErXkI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB6628.eurprd05.prod.outlook.com (2603:10a6:20b:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Thu, 6 Aug
 2020 12:43:59 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Thu, 6 Aug 2020
 12:43:59 +0000
Date:   Thu, 6 Aug 2020 15:43:54 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806082727-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.13 via Frontend Transport; Thu, 6 Aug 2020 12:43:57 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d17f53a-f0db-43b8-c27e-08d83a06638e
X-MS-TrafficTypeDiagnostic: AM0PR05MB6628:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6628BE7BAC483329EB370B46C5480@AM0PR05MB6628.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRbOEy3dPRTd9iBLY4apxq3j+OnXkB103y11VfjEbxwnkvSw2GEowFi/cTHXXy6yKVcH3Phvn2yLXk8V9l5tpORBUEjSLC1CBaF9dk+yGj7V/9QcO2phI4UQ9jNxNTSl1+aswZybRQoaFXv3+xVAb7mN0dYm6TqD/ZrBcPrsgeVQhIEB3PshGqaazKhPLWtt73Or6JjUbaBflIP92oPwKW/DZpwsAoxYr97fCcqq1PQKlgRtO9d0PbdbpC2eW5IXMRXJ/wAa8bvrXWBjeoxNgGz/+nw4AKm/mjyf6l3rWEAFY5s5LPpl9YDKg4HyiINa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(7696005)(9686003)(52116002)(6916009)(33656002)(4326008)(5660300002)(316002)(83380400001)(66946007)(66476007)(66556008)(55016002)(7416002)(6666004)(8676002)(1076003)(8936002)(26005)(956004)(2906002)(86362001)(6506007)(478600001)(186003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Qyj+g/y1Mxv3h07bwRSN+9PUDKK3D00UrJzcdsQzMeMeMvYliUH9qCU4bc7K1eJ9hRLsukhhBVm9JV7ki/ORK43sgDokUurA9esk8gv+tDdjSvEEM1+6itJqRokxSPHXIoY11jBnVCYvUldS45wo/pzzVRKz8bT4ks4n4KObE/DtV+fmKbhqbBPFWLlskQGLrszGGNGoCh7vxoWZ23xSt40um3cSGmnt/qSXt8qOEvsUq9O83F/00y9UXQURg1X4jSi/Bv3OlewEggWtLxmW/NZmbT65bSmvjIROprXAjBGgZy9n1SRd6T6PzwO/usrJs5VYhdvBBnTvfqvuj+c2XnANqxLMCi7RV6hSFD4Szx/4X4Mpgig7zyrYV3j95hLzVlCF3oUpTqWWklwz4YplLpbbsl+vJYkmxroiXr6E+QlWNgCLXJxDM6JURapO+6Tpfcf4lZ0oScSqgw9Joa5q7pU0XFjFipW7gySCfZmeIbT4rtnjy0cuj7KmJpHvLYDUvNYSRGdpgaDYPrLd+o7RbSt5nsvfI+4jVCgG34jwFMm2j7thBl0bJZlqnvpeeTNWnTiFBj/zHTyf6KWpXSkIIE3DEaGwF4kiNybPU4lGVo7PCIstycORAaFuTff75GsdVTugR36HS35BjC65xcGJzQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d17f53a-f0db-43b8-c27e-08d83a06638e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 12:43:59.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXXLlkcepGdTTije8PBzn8urm8vJcxodDNTkw8TtU45FyOZNF99jFefBP+RvGWXIk5THTkekNUEyImqFV8yO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 08:29:22AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
> > On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > > This patch introduce a config op to get valid iova range from the vDPA
> > > > device.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  include/linux/vdpa.h | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > index 239db794357c..b7633ed2500c 100644
> > > > --- a/include/linux/vdpa.h
> > > > +++ b/include/linux/vdpa.h
> > > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > > >  	unsigned int index;
> > > >  };
> > > >  
> > > > +/**
> > > > + * vDPA IOVA range - the IOVA range support by the device
> > > > + * @start: start of the IOVA range
> > > > + * @end: end of the IOVA range
> > > > + */
> > > > +struct vdpa_iova_range {
> > > > +	u64 start;
> > > > +	u64 end;
> > > > +};
> > > > +
> > > 
> > > 
> > > This is ambiguous. Is end in the range or just behind it?
> > > How about first/last?
> > 
> > It is customary in the kernel to use start-end where end corresponds to
> > the byte following the last in the range. See struct vm_area_struct
> > vm_start and vm_end fields
> 
> Exactly my point:
> 
> include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
> 
> in this case Jason wants it to be the last byte, not one behind.
> 
> 
Maybe start, size? Not ambiguous, and you don't need to do annoying
calculations like size = last - start + 1

