Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12885C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C507A215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JzCi/SFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCJUzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:55:17 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:62017
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgCJUzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:55:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQl579z/o2r9PBmhNTKqNgNdD+dQ1A4k9PUjOL6wf8cOJSUb8KqimntLIdRLcufjMooe22nufgnnmVMJhjHei1KRXAqDwUszAbTCF5wQ4tKHATIt9CTBNsrNdVSkv8sgnOm1DlBeyRvonnhBFeGByWLmpO3AEDI2lyMJuQQlta3+y3eregPiJCKJixpFx3AvhNjDw82NgV785Pc9eL15g7qadyO+WbfhXPtBxQK9C14edGSB88UZBOQ3HFyVuA7kec+lbzi/PB4AHfx3Y8Z9q89vjWXC1TXzUuOb+tQQzRKeVJxDLRGVUj8sicS8hPoe1a8/UhYn80KcovIYNVnfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWNOy7UQ+gcEFrKy+Sxi2eXxpoqap/njQwc4iSsQl7E=;
 b=nKged3WER2yVUJyOXVOXWyqeFJ8uTuExAr5D1O0OWg5i9oToLif6dyqNkagumQBL2lgrgKidZpyjfdplAqD/ePvcXC3YXqOp7qQiFckzqLXSP+g0yFgDMu3wn0/S2TPD47mSLuGPbfBkdn67677xnKuysTVmqzU/vZ8zofj9QClLX7BXXNAJhX2+Wx+s86uvTAa6atE/Kr/iC8IbAhPTFHx2UynIvIUzJUMKeGv1wsxYwgkldf14WJ9AQdlMD5NGfl+Pn7e85QPg80RBu9f8Ow0PbTaOTu+C78CG3anZW9QODHz4QwK5xzkRwYifWrdNTyos/lIZMYd/dJ1XlgPa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWNOy7UQ+gcEFrKy+Sxi2eXxpoqap/njQwc4iSsQl7E=;
 b=JzCi/SFgJ4fPawbT3PxRu8jLhyO2aqvNJsxmHHlb6qfilXrYBPBwXdMdp6nEhXxFrmYQMI3JqbOSDpbJaH2BPxCcyJqnhEzsTEVcjgWfQ5QCcCatyoGybKuDfYv3SSBi6VdZOZrL2Da+Su1/m6eVfIVecHMvgoLN+3rWtVGxiFs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB4031.namprd12.prod.outlook.com (2603:10b6:208:16e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 20:55:16 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:55:16 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 0/5] ntb perf, ntb tool and ntb-hw improvements
Date:   Tue, 10 Mar 2020 15:54:49 -0500
Message-Id: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::24) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 20:55:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d14c03be-45a9-4646-ac56-08d7c535558a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4031:|MN2PR12MB4031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4031426AB83C1BB765DB3971E5FF0@MN2PR12MB4031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(86362001)(316002)(66946007)(6636002)(8936002)(956004)(8676002)(5660300002)(81166006)(66476007)(66556008)(52116002)(7696005)(2616005)(4326008)(478600001)(6666004)(6486002)(2906002)(81156014)(26005)(36756003)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4031;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX5OGgEoAhaSd0rnSsvGOOjt13ss/MlrJvB+kQXrtDYrcR/7HKlfcPkJo9fklgJxBVlGnyOyRx50V8Muxo5bccR11iVdTBrp4uiFHqHTYJrYkTr59J6yXyTNgK0bfBJnwd49P27JbDILG6pUghMqLcgIj5xXjovPPL3cKGCkTVCse6ii8OQQFwnEnL7ua182hjbxYYDjBOFLNxkjVhGXfQWyPN5TTNM5ew/x0Oap8+vGOMFuRXNaYydq6Oei48Q9/fKW+dtqmBXCCek7sMj6JGNPKNcsVjfA+oHyUrFhXCIMgAjQjdzbE0JVIaUASTpEynbobBpi9GB9lvwZpKRlCGJMbuDiZSwxtMslUJjeYxUwtUTZx1af4ZH0+aJ54VVIu6LZ9oA8HiQ/IeLrqb0hNIG9WpbpdqFSqUOjAp4YygWFrNYQKcWXGhX1ZbDl+jqa
X-MS-Exchange-AntiSpam-MessageData: sqeu0tI4hWONAQ9/AP0Vvy5NqIOV9gewiU8Yw3j+MaWHyPO3t+sdxCy1kcchOk9SPPnABEfYoNJewoR6CaG1VzYeHcFizqQCZuvBAf5HiNq/jgIME/eyhzYU2BuB0m8umaL+x6tIo2ZHrW9d2W9yEw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14c03be-45a9-4646-ac56-08d7c535558a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:55:15.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHQUssLaIuOFzEDoC/nygrTf0pvfYBCwhu1KKdMGLkQTj187M0tKcusgjlhjOmdyxJRWD4cR2DQBQ8Ee1zOWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series modifies the ntb perf code to
have separate functions for CPU and DMA transfers.
It also adds handling for -EAGAIN error code so
that we re-try sending commands later.

Fixes have been made to ntb_perf, ntb_tool and 
ntb_hw* files.

The patches are based on Linus' tree,

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

v2: Incorporated improvements suggested by Logan Gunthorpe

Arindam Nath (2):
  ntb_perf: refactor code for CPU and DMA transfers
  ntb_perf: send command in response to EAGAIN

Logan Gunthorpe (1):
  ntb: hw: remove the code that sets the DMA mask

Sanjay R Mehta (2):
  ntb_perf: pass correct struct device to dma_alloc_coherent
  ntb_tool: pass correct struct device to dma_alloc_coherent

 drivers/ntb/hw/amd/ntb_hw_amd.c    |   4 -
 drivers/ntb/hw/idt/ntb_hw_idt.c    |   6 --
 drivers/ntb/hw/intel/ntb_hw_gen1.c |   4 -
 drivers/ntb/test/ntb_perf.c        | 167 +++++++++++++++++++++++++++----------
 drivers/ntb/test/ntb_tool.c        |   6 +-
 5 files changed, 126 insertions(+), 61 deletions(-)

-- 
2.7.4

