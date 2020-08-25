Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C00C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02ADD206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OsQBSo3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgHYAbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:31:41 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:60546
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbgHYAbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzewL6lVaKpFx7OJwt7JFJaWlrDhw1e6IHgJz0mmDIYRjx9qNTaTjbCrV01V9+ymJxd3hQL5C3zm1T+ognJXn3xBLrdq7Ef3q3gc+aAY8gTo/UC6VBB6/Hg978jjHfcMORLayGUoPCO9RzmkbgapHt2ReQQNVqd51XPWQcbUrIkhXFVHkt+FdqOPo+SiOdRErgM+vzB4oncdA/nQJhTF5CkqfZEWFYoMIqjDYkAYvxa1AnMhSAaUPCLrCfP5QgW6DW/lw5xeLU9YSw5hu5qAEpVbH7njOPhYvS0Me24Mh8CS5RMwFGZbqrr1arpZfZej6bW9/S3zwTb264YYnSKS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrZjh4y/sjipYl33K53Wvp5oQdjy9UjSlXUhr6Y7qM4=;
 b=NGnte5gkSH5KZdRJetNrF+Kd+k0aHrFr7LikabhzqBknUWx29Sb+CoqWrz5wFMa5H41oXEX102bcYRQ42K3FjusnY/pnj4C8uzjUxU46w4/WgD8HpKkj+3Vh3WzksJLK5Fb5bO7ABYzFah0W/qUHtQPTEBARC5UmfG9Z7QNpMdVKii6c5Nj4ilDNU9C2dj2ulYw4Qn38Yd2Y6Ll5mnhhmrIgpDQyUJGZGhOo6luirCQ5g+gR6unmzfme9LYP/vsYvlMFCykAAHSWcjx4fg6dw9PaKs+H9pAQKOOy1ZJ/70MJlOaN8AIIPpCfmuZIDQag0wbabvLK9XIMFDhQCS5h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrZjh4y/sjipYl33K53Wvp5oQdjy9UjSlXUhr6Y7qM4=;
 b=OsQBSo3o2/rdDy5RjX8YFwLkF6pzKSWy5IyGkCq82zm0FTOHt19KiZyJKMY5Fc6HWi1Ogu6C5xXRXFnJjxvyS/8WYp9XFgnTtyPgVt8tFOGgBB1ZjA0YSeblrlagTHkI6EoAsUaVIhUHVgZTd2dM4lPW8W8cfADpY9/BQD1YrSE=
Received: from DM5PR11CA0022.namprd11.prod.outlook.com (2603:10b6:3:115::32)
 by BY5PR02MB6321.namprd02.prod.outlook.com (2603:10b6:a03:1f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 00:31:10 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::72) by DM5PR11CA0022.outlook.office365.com
 (2603:10b6:3:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Tue, 25 Aug 2020 00:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 00:31:10
 +0000
Received: from [149.199.38.66] (port=59108 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1kAMrJ-0003Ug-Sf; Mon, 24 Aug 2020 17:30:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1kAMrm-0002Po-5E; Mon, 24 Aug 2020 17:31:10 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07P0UxTN005458;
        Mon, 24 Aug 2020 17:30:59 -0700
Received: from [10.23.123.104] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1kAMrb-0002Kz-4p; Mon, 24 Aug 2020 17:30:59 -0700
Date:   Mon, 24 Aug 2020 17:30:58 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Ben Levinsky <BLEVINSK@xilinx.com>
cc:     Stefano Stabellini <stefanos@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
In-Reply-To: <BYAPR02MB44074C112F383606E2292F4AB5560@BYAPR02MB4407.namprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2008241730450.24407@sstabellini-ThinkPad-T480s>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com> <20200811033213.20088-3-ben.levinsky@xilinx.com> <alpine.DEB.2.21.2008131103230.15669@sstabellini-ThinkPad-T480s> <BYAPR02MB44076F48364A94C05F636870B55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
 <BYAPR02MB44074C112F383606E2292F4AB5560@BYAPR02MB4407.namprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aea195a4-2674-43a3-fef2-08d8488e2a3b
X-MS-TrafficTypeDiagnostic: BY5PR02MB6321:
X-Microsoft-Antispam-PRVS: <BY5PR02MB63216A6CA2E2612511B19B3FA0570@BY5PR02MB6321.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/HGjKPt84Ssi0ATqwS7GODTNOtPTwA3COY7lry4BLmGCXIh50IlcS60gG0aoG475cTNPJTVlx49L1MyNQpUpIuWiSgI81S08Ocd8qEc7wtWuEqIiWGobR56o+o+iHCbAA7ivObiRsft6FVK1mG/A9uaIaxBH11W6KszrJc6TamX5fPx4PcvKEalt0R72jt0nI9uXxfGbSOizzoy3rSxDnxBIyGNvJo+8DXFkBJF6PxpqSRKYxZiuINjo1FqqpuXgkOXY4dqB4Vn4QK7MARHlk+N9+eTktRxzNo2exE8RVhvkcOXpSwMY8a+br/LqkAbrJzM78PoK/N/kq0i3zrlLBrU34tGUbrsK1pORpNGn0I8O3ofOVOtcqNIVxE7wGu3fjEC1uDsN9CTg/Xl+Ya5og==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(7916004)(396003)(346002)(136003)(376002)(39860400002)(46966005)(8936002)(2906002)(82310400002)(81166007)(83380400001)(5660300002)(356005)(9786002)(9686003)(33716001)(478600001)(53546011)(6636002)(54906003)(47076004)(6862004)(8676002)(186003)(426003)(316002)(82740400003)(26005)(70206006)(70586007)(44832011)(4326008)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 00:31:10.3866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea195a4-2674-43a3-fef2-08d8488e2a3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020, Ben Levinsky wrote:
> > -----Original Message-----
> > From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> > owner@vger.kernel.org> On Behalf Of Ben Levinsky
> > Sent: Tuesday, August 18, 2020 7:24 AM
> > To: Stefano Stabellini <stefanos@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; devicetree@vger.kernel.org;
> > mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> > kernel@lists.infradead.org
> > Subject: RE: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > > Sent: Thursday, August 13, 2020 1:36 PM
> > > To: Ben Levinsky <BLEVINSK@xilinx.com>
> > > Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> > > <michals@xilinx.com>; devicetree@vger.kernel.org;
> > > mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> > > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> > > kernel@lists.infradead.org
> > > Subject: Re: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
> > >
> > > On Mon, 10 Aug 2020, Ben Levinsky wrote:
> > > > Add shutdown/wakeup a resource eemi operations to shutdown
> > > > or bringup a resource.
> > > >
> > > > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > > > ---
> > > > v3:
> > > > - add xilinx-related platform mgmt fn's instead of wrapping around
> > > >   function pointer in xilinx eemi ops struct
> > > > - fix formatting
> > > > v4:
> > > > - add default values for enumv3:
> > > > - add xilinx-related platform mgmt fn's instead of wrapping around
> > > >   function pointer in xilinx eemi ops struct
> > > > - fix formatting
> > > > v4:
> > > > - add default values for enum
> > > > ---
> > > >  drivers/firmware/xilinx/zynqmp.c     | 35
> > ++++++++++++++++++++++++++++
> > > >  include/linux/firmware/xlnx-zynqmp.h | 22 +++++++++++++++++
> > > >  2 files changed, 57 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > > b/drivers/firmware/xilinx/zynqmp.c
> > > > index 8d1ff2454e2e..f1a0bd35deeb 100644
> > > > --- a/drivers/firmware/xilinx/zynqmp.c
> > > > +++ b/drivers/firmware/xilinx/zynqmp.c
> > > > @@ -846,6 +846,41 @@ int zynqmp_pm_release_node(const u32 node)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
> > > >
> > > > +/**
> > > > + * zynqmp_pm_force_powerdown - PM call to request for another PU or
> > > subsystem to
> > > > + *             be powered down forcefully
> > > > + * @target:    Node ID of the targeted PU or subsystem
> > > > + * @ack:   Flag to specify whether acknowledge is requested
> > > > + *
> > > > + * Return: status, either success or error+reason
> > > > + */
> > > > +int zynqmp_pm_force_powerdown(const u32 target,
> > >
> > > If the target is really the node id, why not calling it "node", the same
> > > way as below?
> > [Ben Levinsky] good point. Will change to "target" in v9
> > >
> > >
> > > > +			      const enum zynqmp_pm_request_ack ack)
> > > > +{
> > > > +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack,
> > > 0, 0, NULL);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(zynqmp_pm_force_powerdown);
> > > > +
> > > > +/**
> > > > + * zynqmp_pm_request_wakeup - PM call to wake up selected master or
> > > subsystem
> > > > + * @node:  Node ID of the master or subsystem
> > > > + * @set_addr:  Specifies whether the address argument is relevant
> > > > + * @address:   Address from which to resume when woken up
> > > > + * @ack:   Flag to specify whether acknowledge requested
> > > > + *
> > > > + * Return: status, either success or error+reason
> > > > + */
> > > > +int zynqmp_pm_request_wakeup(const u32 node,
> > > > +			     const bool set_addr,
> > > > +			     const u64 address,
> > > > +			     const enum zynqmp_pm_request_ack ack)
> > > > +{
> > > > +	/* set_addr flag is encoded into 1st bit of address */
> > > > +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address
> > > | set_addr,
> > > > +				   address >> 32, ack, NULL);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
> > > > +
> > > >  /**
> > > >   * zynqmp_pm_set_requirement() - PM call to set requirement for PM
> > > slaves
> > > >   * @node:		Node ID of the slave
> > > > diff --git a/include/linux/firmware/xlnx-zynqmp.h
> > > b/include/linux/firmware/xlnx-zynqmp.h
> > > > index bb347dfe4ba4..4d83a7d69c4c 100644
> > > > --- a/include/linux/firmware/xlnx-zynqmp.h
> > > > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > > > @@ -64,6 +64,8 @@
> > > >
> > > >  enum pm_api_id {
> > > >  	PM_GET_API_VERSION = 1,
> > > > +	PM_FORCE_POWERDOWN = 8,
> > > > +	PM_REQUEST_WAKEUP = 10,
> > > >  	PM_SYSTEM_SHUTDOWN = 12,
> > > >  	PM_REQUEST_NODE = 13,
> > > >  	PM_RELEASE_NODE,
> > > > @@ -376,6 +378,12 @@ int zynqmp_pm_write_pggs(u32 index, u32
> > value);
> > > >  int zynqmp_pm_read_pggs(u32 index, u32 *value);
> > > >  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
> > > >  int zynqmp_pm_set_boot_health_status(u32 value);
> > > > +int zynqmp_pm_force_powerdown(const u32 target,
> > > > +			      const enum zynqmp_pm_request_ack ack);
> > > > +int zynqmp_pm_request_wakeup(const u32 node,
> > > > +			     const bool set_addr,
> > > > +			     const u64 address,
> > > > +			     const enum zynqmp_pm_request_ack ack);
> > > >  #else
> > > >  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> > > >  {
> > > > @@ -526,6 +534,20 @@ static inline int
> > > zynqmp_pm_set_boot_health_status(u32 value)
> > > >  {
> > > >  	return -ENODEV;
> > > >  }
> > > > +
> > > > +static inline int zynqmp_pm_force_powerdown(const u32 target,
> > > > +				    const enum zynqmp_pm_request_ack ack)
> > > > +{
> > > > +	return -ENODEV;
> > > > +}
> > > > +
> > > > +static inline int zynqmp_pm_request_wakeup(const u32 node,
> > > > +					   const bool set_addr,
> > > > +					   const u64 address,
> > > > +				   const enum zynqmp_pm_request_ack ack)
> > >
> > > code style
> [Ben Levinsky] for this, the argument goes over 80 chars if aligned like the others. With that in mind for style, is it better to have the set_addr and address args aligned with ack or to push ack to the right but have the >80 chars style issue?

I don't have an opinion on code style -- anything that passes
scripts/checkpatch.pl is fine for me.
