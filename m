Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A03DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F8E204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="s166Xe35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGPKZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:25:42 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:45604
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbgGPKZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:25:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSqaT1IVQ1JnsCZ5CgTRv8lyZRuCLL6f5TCK/K6o1X3Yy02EDWSK3GLXAU4HeKaIVsRSQWxvp8+6TXGgZp2CLeGqLDj6XRHwbVuPcovCaaRoHjF3li7KhuMV2Z9juUdGY7a5R7S3srLrFQ8secPgPFMBLQWN5PCxvsOHyOzQwPcGrT4f38TgwCNy04bCIIiPyz33POrbnN5u0VUX+3mVA9f/1rZ7pz9c8ehpx2PsIlWzimnYJg+S9o2giq6n5a4H3/AvUVWXdCjY6FN9oOMQcjVOrRDgfC1SMBFlTUmDcnGU84Oi6yr+zrFechCVIvCnQ+qPTc5CDtDOLRi1N4DdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i75q4s/OxUnPLi0nSp4I5H/PDs/ldNjvtc96uQ9saiE=;
 b=NNlF4lIE4xvKTKnlUBJ3+DnbrHUmf4ysBN9RksaT4QgJsPoir/PweiuOVVagE9W7megx3m0BWClJJIXFwtRnBTp2LsPNZgVDCyv7s/MXIvbdj8OAYs2G34h75zSxLqx2jFWpZJwdEjfZIWzda3a3TE9yRYM6GFWLK6y45HGkIz8Gpf8O4zH/IfdJZZ7OyM+oRa7rfghdnX8QAmEd3UzCCW4licOUYAeP5GdSdde1QkITIF2pNOqKm79Rm1eAaoKwY/0l7T0MeEqA2I9Yjl1AWgS5IQNWuIdn7nhzUd2NFQ7ADUNFpyw5DiWuw0v0MtZ0f9X4SLdsdFrn2bWqni+EvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i75q4s/OxUnPLi0nSp4I5H/PDs/ldNjvtc96uQ9saiE=;
 b=s166Xe35aVxjcwfAqEJ6j9DFGU5vpt0aUAF0qhyXmAUX04HZXQtj4c3pZ+lviHj5aVnvYyU3THeSii5UqjoMDQLleNqr1IibDkuTBvsQVABqLzM9YlLk0UIRFOonjIbZpj+QJcFJH+rFP7T5fKUSvLqMR0yDHBLftyX/bQ2vO7o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR05MB3378.eurprd05.prod.outlook.com (2603:10a6:205:d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 10:25:37 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 10:25:37 +0000
Date:   Thu, 16 Jul 2020 13:25:33 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq
 status on get_vq_state
Message-ID: <20200716102533.GB186790@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
 <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
 <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
 <296e6fcb-946c-f577-2e22-46528f78fda9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <296e6fcb-946c-f577-2e22-46528f78fda9@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR06CA0134.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::39) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR06CA0134.eurprd06.prod.outlook.com (2603:10a6:208:ab::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 10:25:36 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12205df0-a6b0-439f-1583-08d8297294b3
X-MS-TrafficTypeDiagnostic: AM4PR05MB3378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR05MB3378F7707D3F31F710646763C57F0@AM4PR05MB3378.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vM++P70jWARhPWYr1CO9GVw4uR3jQ//GiU+TNwGsCQ5HkoAUtb7mgVdWOuf5vNS2oC4nAYvLqisWzittSUjsZi9/LXrszx1/3Ok7petvbAt0Qjo7HfeEFYw4E3FFK5hhRQmtuNb4pmW7IZXlpTzPej9+JGLDBthVKmndFPwr2+T958LxpGqmvByWqc7X3vxat4+xXwb1zdOBvPIMBchPWgW2DQyy15vD9wGIS9EPFekkXjHhTigFr0ih0yNnL2FRhUiTOsv3YMr5ZI8c3zX95437bZ5Fc8L4D/bC2jqywiCLWwLtePj6UJG9MES22GFmvfZOUE9pvRsT4a9b5KGaKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(5660300002)(8936002)(2906002)(107886003)(66476007)(8676002)(4326008)(86362001)(956004)(66946007)(6506007)(66556008)(9686003)(6666004)(16526019)(186003)(478600001)(55016002)(26005)(1076003)(33656002)(6916009)(7696005)(52116002)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: L3h2Qn6avgyJe4hp2kmeh0LuIB5Zy2HtnU1xyHtkmPu5aa84QhevkUsigKgy1joV9ie4O+7lyozO+Hs0V2dQTPrDb2sJQcbbypM0bQblwv5QfRMQAVoD2y6vA1xkci/Kx4+X/frvUisbkM8/ldcbPxjzb/kBKqWuScyCjXLuPPR3IrKLcES39widtYQx+TkMeePdGVSNOMdM+BqdMdws3o6fI24y8IqmxDCH8o7ScpkQpkHK/AD3qWQumo9onIXUjI2bV64xjxfrHhutMDPoZm3Mpi5slLEEFRxPsjGM6UXwTm2GLw7lUIpr/taU+lT694MrkFApcmTloiNvXUkcWrnBQSRfCdwkU7aEuy5E8yD6V/hwRd0tiWQCIkXvT9gTyP/xiz/L0esNWL0C3MdH2Wki9rsnS8DaqUFF4tvaXoltsCbjD6F8SjQCpjK3dJXZ+I/A0zeR2YSNW2pZkrq97rwO7nvndqqS7RFViTljkTA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12205df0-a6b0-439f-1583-08d8297294b3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 10:25:37.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9gK8AfHuL6MbqcB9CNVcL68Z1tt9GsMUSrefn/Zm0pdWUN/du3cCbhh8I6M4mWbUWpSp6XkjAg+J5EUTXzPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:35:18PM +0800, Jason Wang wrote:
> 
> On 2020/7/16 下午4:21, Eli Cohen wrote:
> >On Thu, Jul 16, 2020 at 04:11:00PM +0800, Jason Wang wrote:
> >>On 2020/7/16 下午3:23, Eli Cohen wrote:
> >>>Currently, get_vq_state() is used only to pass the available index value
> >>>of a vq. Extend the struct to return status on the VQ to the caller.
> >>>For now, define VQ_STATE_NOT_READY. In the future it will be extended to
> >>>include other infomration.
> >>>
> >>>Modify current vdpa driver to update this field.
> >>>
> >>>Reviewed-by: Parav Pandit<parav@mellanox.com>
> >>>Signed-off-by: Eli Cohen<eli@mellanox.com>
> >>What's the difference between this and get_vq_ready()?
> >>
> >>Thanks
> >>
> >There is no difference. It is just a way to communicate a problem to
> >with the state of the VQ back to the caller. This is not available now.
> >I think an asynchronous is preferred but that is not available
> >currently.
> 
> 
> I still don't see the reason, maybe you can give me an example?
> 
>

My intention was to provide a mechainsm to return meaningful information
on the state of the vq. For example, when you fail to get the state of
the VQ.

Maybe I could just change the prototype of the function to return int
and the driver could put an error if it has trouble returning the vq
state.
