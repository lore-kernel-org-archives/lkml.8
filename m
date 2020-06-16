Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499712074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BL1D7zf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgFPJDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:03:25 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:6144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgFPJDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:03:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MD0AtnFlewPij0ASAWRT5JIXp0anEdFNgzLycFRyuHQkxoUaUgjKtL4Ze8Fs+vdXyqpSA5XUYP3DaAD7/OrHFuAYytVVglbmJcNWmFXZdaBkOr3Er/EacRHHA2eKl3mSWgcIGNmYmD+pw3+H3DI0RczQXu3Csjpi7Z8JJWCQfchhQWXRJTAvGVTSgMPdbmbdU/fMNIlW+L+d7UWrAGMN/fpVwo+hcbHwRJyGG2ubE/ASsvluxOWCHOMrkNrj9hbMvzGk0hVSMatMf2ExAG8zzeI+NQ6Ca2OaoaiNWHLekDp39Yv0clnkjBlv9/luJKixzSfT40RmS9od2+O3gFrkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LIPuUCQfNj+KHiK9rx5zNCPa/+ndf2ma/xPZg6UMoc=;
 b=QSzrnRRiQhMP8tZtlxm4G7QUx0LfnikYw4MZWjqH74QiAIiifrOz190EzMEGIOGddkHztZ/IXFHvaEgkD8ZBAsV8tp6v/BrCXXhtqZYcEdkRg0IGHG0597dsHg3Dp5tR68+ddAl8rlLXALGjqb5wGm6i0f9l6A0kvuk1K/mrrKgwvyJ/A9H6E8LaF+3ic8xVM1JC1tgTAs9BZhNO/3/9yN+3jSGJgC33xPZ4rMJlwV381ibCPIpZ7sgqWw4j9SQJLMwJTm+Qr+MmXTIh8X4tBqp6xLw8UNXxBRv8eGleBRU+VFo9uyOkacl+kCci62CcJr00Vc8Vth2YuLUL4C3TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LIPuUCQfNj+KHiK9rx5zNCPa/+ndf2ma/xPZg6UMoc=;
 b=BL1D7zf5hbwsdeUFXvtD3TNFE40nfxcHX4lnSSa36YI2y+PAcCBljd9M+gbM7rBXU8AU+FhPXM3l4nVCNYkSHPpXKrdoU7nCQFC0ZjmjnzFsWon6aCom6cc4keuRxHOkAKAA+diOYiZjhxBsYMESCWypzHer3WHTrPPaashd8Mw=
Authentication-Results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4792.namprd03.prod.outlook.com (2603:10b6:a03:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 09:03:21 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 09:03:21 +0000
Date:   Tue, 16 Jun 2020 17:03:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Query]usb: dwc2: suspend/resume support for
 DWC2_POWER_DOWN_PARAM_NONE case
Message-ID: <20200616164712.67bf105c@xhacker.debian>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:404:e2::23) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR02CA0059.apcprd02.prod.outlook.com (2603:1096:404:e2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 09:03:19 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6658c7b-9af4-462b-413b-08d811d41e37
X-MS-TrafficTypeDiagnostic: BYAPR03MB4792:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4792F8D0B59DF94C3AD60EDCED9D0@BYAPR03MB4792.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qyQ6EsN/fVnp0YS4zkIdX4K4ck1rOvkzemdh9rpWi0lm2PQDwNFvDh1GnW4SUjdZ5ZHuqK33Q6Z5/OJ8l9rn03W5H+6x0wLhmDwmKui6iVbFpdLay0hcS9O4Aw3xFaQxJ7VYc035R1oYCOLKhLQquueW5Hqqk07fXX8HuCFsSyZNPMQVknB6SfjV4SjMeoh6/vCsrAFM42kJeXW1AKMfeaC9CsWvmM0iaL50Tu3Iqm04Fgw8m/uqUV0we5wT1Vl+uxdq/p4cll7Dmde482fJG380dZKw1fV9OhAbsp6a59DtKfg3VoWQMoeb7NpmeePZjceUR9cp+oGArSppQS7Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(316002)(2906002)(6506007)(66556008)(66946007)(66476007)(26005)(15650500001)(16526019)(4326008)(186003)(55016002)(7696005)(52116002)(956004)(86362001)(9686003)(6666004)(478600001)(1076003)(5660300002)(4744005)(110136005)(83380400001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RdzuWZJH5n3HhgFx/2kdPW52M4FjdBVzcU+Zm+wgFuK/IK0IMjdJhth6FHCYIaxmyfjPL5z680ibFHjHXy/vInGFOvWviHRyyOgjpfwzNNevjf5iWa/x2nbp3yUS4oTi5ftnu9Y47kIKZuMuu38wGcU0YHG6pt1Sn6yijA8mALiP2lMHnQEW6W+zfnoedAP9QWliZydCE0ffEFF32aEa4ipANaDSNfwDRPj31a3EvYx8XopX2tXHa5yuhZlYwN8C3zALZRn6Mo/nvQTAqvBexURUa2wYDljL96jzHALT97wR3f1ePq794D3ASYgjJckN1y4Ch/MIYW79QdvoXT8AkIX5Lny4osM/ohzVH8cCJWZFr6TKbZXwUSOvfp1HWbFMvmcOqw7f72JO3/PSukT+3ICTifrNa+cYlnbCyc5b7BGqlVPK0v/L717LXwa0zqqjE/q4iK7ng5iYOXo96g0z9UDf0JioI+NET5cZ2W/IbRD7pBSALyXRh4zCIZ+d/g3N
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6658c7b-9af4-462b-413b-08d811d41e37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 09:03:21.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4QZ32oArkmgJDBX8ghu0IHRvyGgKbbGCITuKwOMFdRedFUMu1F7k4FV/VLfugyKq9bljBD9OoTB3pdfMjKMOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After reading current dwc2 code, I got an impression that resume from suspend
to ram isn't supported for DWC2_POWER_DOWN_PARAM_NONE case, right? In fact
we do see usb device can't resume properly with DWC2_POWER_DOWN_PARAM_NONE case.

If the impression is true, what's the proper technical direction? Add 
dwc2_host_enter_suspend() as dwc2_host_enter_hibernation()
and 
dwc2_host_exit_suspend() as dwc2_host_exit_hibernation()?

Thanks in advance,
Jisheng
