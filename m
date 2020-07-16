Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B5AC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB64A2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rxqKikns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgGPTnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:43:21 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:20502
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728788AbgGPTnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:43:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCM3qDAU64QAzJQjBysztnDqKAMqvdfztEXUatHfXXo86WrWkh4LgnzsB0sctiC7HCSDfhutAaiKH3TvLN5Cx3zEjETYwG/J7pWGq/p75mrysH70/b02pU56kFLo1moKmbai+Lk8HammEnlPxMk84IAEioj25r/8tNadpiMraZRI+K5M5nkMdCMUEjaoYjCzAYMyUiaQNa/GDHazdHz1E6yLDi9cyYcsvfgphkp5UfH/BgosechJDuz47KsbzSii3HRU2aGXzbJGlRcR6PPWvgqdj5NW+BenwYshSwsPjFN+cqZixyI4Ka6VOq7iCgKO/Sgl2IP5K8IE8OisQZV8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=499bS4tL2p7jyXXVZ+T2pCyJIO7uNyzDjkyf6/7WISc=;
 b=dk4sWPfW6xYtENnXK4Lxmb5NVSsOEidC/ODS2l+lAD7BzUOw/OUFaGkRNXEAUPGptpXp6twcBWXWgjaNAaHZD0zdasvvHkqFnfpm9Ejieh4eb6+KFDcZCldT80zlYOP1XFJiZX70PO+CLanceQnae1TLMPd84C/V3zSFKjkwrHFTzMlH0yMuUE9lWteC0cY2dNDM5zLnyMErjWOE+2wZUedN7TQOV54LHHZpmj8VRaQuvjhZhIgt4N5/fKtb7DIk6auMXBSDZ7UCA9CfJC7vmMoJFPIW8gKK1oJS0y5OpnhNpwVGNyvsHiOn8IqAqFOvp9U5Zo+DlI5y/eTvCHmPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=499bS4tL2p7jyXXVZ+T2pCyJIO7uNyzDjkyf6/7WISc=;
 b=rxqKikns8ZlEzeZ93I575YiFA9GH5yW/SX57cUZV4YhlUiTmL7MiKINK4eG3WT1uTD8ImH3gtQGrHM5USxq3WPU99ffH/qNez/ed97VXAScrUTSSEDyCKCkkbBdKlYMj7XhffRbxQZE8Gs3nUpEU7aYbQxVYzgeJNp1u3LUhYXk=
Received: from MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15)
 by BYAPR02MB4885.namprd02.prod.outlook.com (2603:10b6:a03:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 19:43:15 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::a0) by MN2PR16CA0002.outlook.office365.com
 (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Thu, 16 Jul 2020 19:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 19:43:15
 +0000
Received: from [149.199.38.66] (port=43023 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1jw9l4-0004N0-GY; Thu, 16 Jul 2020 12:41:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1jw9mk-0005B9-W0; Thu, 16 Jul 2020 12:43:15 -0700
Received: from [10.23.120.244] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1jw9mb-00053N-9i; Thu, 16 Jul 2020 12:43:05 -0700
Date:   Thu, 16 Jul 2020 12:43:04 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
cc:     Rob Herring <robh@kernel.org>, Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefanos@xilinx.com, BLEVINSK@xilinx.com, tomase@xilinx.com
Subject: Re: [PATCH v2 1/4] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
In-Reply-To: <20200716171903.GA3286345@xps15>
Message-ID: <alpine.DEB.2.21.2007161232400.3886@sstabellini-ThinkPad-T480s>
References: <20200630024922.32491-1-s-anna@ti.com> <20200630024922.32491-2-s-anna@ti.com> <20200714171553.GA2522956@bogus> <20200716171903.GA3286345@xps15>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(6029001)(7916004)(136003)(396003)(346002)(39860400002)(376002)(46966005)(356005)(82740400003)(316002)(9786002)(426003)(33716001)(47076004)(44832011)(8936002)(107886003)(5660300002)(8676002)(336012)(83380400001)(82310400002)(6916009)(81166007)(54906003)(70206006)(26005)(9686003)(2906002)(186003)(478600001)(4326008)(70586007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edf69671-d444-428f-4dc4-08d829c07b6f
X-MS-TrafficTypeDiagnostic: BYAPR02MB4885:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4885AB42EFB337EEF66DBB3FA07F0@BYAPR02MB4885.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PivKsktWsdvqUBPEEJEd6J4IVhOBcxdhbUV60uevvmKRdR/v8HFWiT9VKFyZqyhrN/dmf0eXcDP1GD+XAgOiSqxKqx8fznJZexJDrfkaim3KJLENvJENczfHiuCwmfgFvMtYfM+/H4v3R8rqTd8KBEJ0xYb+P0/FVOIZXaURAOrJI1qMguah97Z9OEQm9PrDlX1w8BDg29O18gbHUeNLIsGD5QSkQCVZDGbyqlDW2fm9t66HI+EeI0u0jhybu1HGMNe+IXgqQpON1B1rUONbn5v4GsQC3eASWI7QfsqzCKghBJ+mlF+1apUrBwv+KJ/oO+xuFv8JADrGUCB0kL8KsHL6WI2ippXuBIrKk9m9r4okykRWaXFecaqsZ8Hs3YC+SLS5KiyBwhr8RouvuK2FLQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 19:43:15.4136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf69671-d444-428f-4dc4-08d829c07b6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020, Mathieu Poirier wrote:
> Hi Rob,
> 
> On Tue, Jul 14, 2020 at 11:15:53AM -0600, Rob Herring wrote:
> > On Mon, Jun 29, 2020 at 09:49:19PM -0500, Suman Anna wrote:
> > > The Texas Instruments K3 family of SoCs have one or more dual-core
> > > Arm Cortex R5F processor subsystems/clusters (R5FSS). The clusters
> > > can be split between multiple voltage domains as well. Add the device
> > > tree bindings document for these R5F subsystem devices. These R5F
> > > processors do not have an MMU, and so require fixed memory carveout
> > > regions matching the firmware image addresses. The nodes require more
> > > than one memory region, with the first memory region used for DMA
> > > allocations at runtime. The remaining memory regions are reserved
> > > and are used for the loading and running of the R5F remote processors.
> > > The R5F processors can also optionally use any internal on-chip SRAM
> > > memories either for executing code or using it as fast-access data.
> > > 
> > > The added example illustrates the DT nodes for the single R5FSS device
> > > present on K3 AM65x family of SoCs.
> > > 
> > > Signed-off-by: Suman Anna <s-anna@ti.com>
> > > ---
> > > v2:
> > >  - Renamed "lockstep-mode" property to "ti,cluster-mode"
> > 
> > I don't think that's a move in the right direction given this is at 
> > least partially a standard feature.
> > 
> > As I said before, I'm very hesistant to accept anything here given I 
> > know the desires and activity to define 'system Devicetrees' of which 
> > TI is participating. While maybe an rproc node is sufficient for a 
> > DSP, it seems multiple vendors have R cores and want to define them in 
> > system DT.
> > 
> > Though the system DT effort has not yet given any thought to what is the 
> > view of one processor or instance to another instance (which is what 
> > this binding is). We'll still need something defined for that, but I'd 
> > expect that to be dependent on what is defined for system DT.
> 
> Efforts related to the definition of the system DT are under way, something I
> expect to keep going on for some time to come.  I agree with the need to use the
> system DT to define remote processors and I look forward to the time we can do
> so.

I'll take this opportunity to add that I should be able to publicly
present a System Device Tree proposal for this during the next call (the
next one after the call early next week that has already a full agenda.)


> That being said we need to find a concensus on how to move forward with patches
> that are ready to be merged.  What is your opinion on that?

In my opinion we don't have to necessarily wait for System Device Tree
to make progress with those if they look OK.
