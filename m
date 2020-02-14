Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133472187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="oh8JQgw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgBNOJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:09:31 -0500
Received: from mail-eopbgr90099.outbound.protection.outlook.com ([40.107.9.99]:26171
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgBNOJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrkXbM3Mb+DC4a9Hq5hqSB0zYFSZWWuSi9nj0+860IfS1dbj+i25mrjipQUNwuRLwQdbsmBTcfyMjj3YcJfR/wWvjUq9mK58x9qjt89SLhmWEOQh6iPmFsEVzd+XLr05iU0094ciBdxJsG9JX7Y4Jghytn+EB1/CqqlvP1ZmU7J4/ubTV1tQC/qjUZoELo3C15zOdCpskpXcypwTHHRkYDm5YM3Tq/w2RpcpzsvFiNy6FXlr1qNQfOn8YTCedQzcvleK16lTrziCQiPSORpnkqDFm+C4nEhZnc+oJi3FlZNKLpFgedVz+jU0eNGPVgwWaQ3bDiVeUxXLE9dAmG2wJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4eNzFzTFnAIyshEaYNa1EMQNRB2RhVV42eRgpxMtj8=;
 b=dGLQ+89yAsCQ0a9v8tEl2ueryGk26NsZ56LYZUcnFwtAlIXEfi1CPtLM2alLIOem3kI2C6f+ttYMTiypXjRXwGn/vomLnQFsvX1is5fgWpkFUiKz+8yT3XIaMvjGpTYqIxstSTCsE93l5KkshqN+/AQgUTF3VLJdPISJNYnUK7oWBsM4j3zRLLiECmFtIY0d4LG28ys8DCYcFfdVJ9qfGpfh84FKvxIk3z+NudpHEF42IsF8NMVmz540CAIf/Kp/dUoWbI15V3M321QzSvlFYelAmHqT4PUHNoqtAenDQCw8x78RABkB0f+6I3YncnrM7p5bRnHr9IAzx8ZAiHMUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4eNzFzTFnAIyshEaYNa1EMQNRB2RhVV42eRgpxMtj8=;
 b=oh8JQgw163wf1F5pWeXfATsfI+u5yPtO1GNYY9nuiEyngvRQXFeuRCrun+HTbYpUSFdndR4dZ8KEC56SgQyUz1cg5Krwj+fetqH366CG1ZZ6/98li5x6Uf4oKdeKP6U0PyiKHqkq5rQQTQGx7Bwbo5hV1Sz7NBu3bYwv+Xk3KbY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=benjamin.bouvier@nokia.com; 
Received: from PR1PR07MB4938.eurprd07.prod.outlook.com (20.177.210.24) by
 PR1PR07MB4844.eurprd07.prod.outlook.com (20.177.208.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9; Fri, 14 Feb 2020 14:09:27 +0000
Received: from PR1PR07MB4938.eurprd07.prod.outlook.com
 ([fe80::e023:5d75:70ae:2d85]) by PR1PR07MB4938.eurprd07.prod.outlook.com
 ([fe80::e023:5d75:70ae:2d85%4]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:09:27 +0000
Subject: Re: [PATCH] x86/reboot: Enable restart_handler mechanism
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Patrick Lelu <patrick.lelu@nokia.com>
References: <20200117134535.7224-1-benjamin.bouvier@nokia.com>
From:   "Bouvier, Benjamin (Nokia - FR/Lannion)" <benjamin.bouvier@nokia.com>
Message-ID: <9df401d0-6744-f4c3-f1a8-9d3087fe620c@nokia.com>
Date:   Fri, 14 Feb 2020 15:09:25 +0100
In-Reply-To: <20200117134535.7224-1-benjamin.bouvier@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::34) To PR1PR07MB4938.eurprd07.prod.outlook.com
 (2603:10a6:102:8::24)
MIME-Version: 1.0
Received: from [135.117.115.37] (131.228.32.165) by PR2P264CA0046.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 14:09:27 +0000
X-Originating-IP: [131.228.32.165]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2f5e8f2-e6f5-46bd-e49a-08d7b1578096
X-MS-TrafficTypeDiagnostic: PR1PR07MB4844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR07MB4844578CCEF49499B9C9B65E81150@PR1PR07MB4844.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(86362001)(6706004)(6486002)(16526019)(186003)(53546011)(5660300002)(8676002)(8936002)(2616005)(956004)(81156014)(26005)(81166006)(36756003)(31686004)(478600001)(107886003)(66946007)(66476007)(66556008)(52116002)(2906002)(4326008)(316002)(31696002)(16576012)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:PR1PR07MB4844;H:PR1PR07MB4938.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMZSgWmgiWlEa1MAPq6zJrekkIOetrCFoi49Gs1Us64Z+Ipb06b/jfK1l2iQh9H+DFc46sHWqnrezDJkmXcXOfZ7l+2kv06zAkOPScCl74Gx833uYKbbBVc7BdyC2aGc6n1D2s3fI2d/nvJ1c2D0KQ8tAukjfxvxs3+EV67hAz/E0Jw/ihmqSSYWkKHyKmkkIUZB1nHf6nO1lT7rwv47gD5JOQQH6mAmEtQNRnd8LTAulqNe9foLZoJjczuu2U9+rHZTkSBXA6jlRWS3NKwA8N/S5rzxp8cV05gpSNOBpFk5L8srF8hKm3xK6t2SBdSSMt+WgWZFeyMpyhorvGjJltfqEr4T1r1IpO+lVFuyguHjFPF4BJzpRvRPXHDczFygeBczecSyxZd8Ftl6YQrJE/u6Qxbm5ZAxbJUTEsjbCU2FmPJiUkwz6Lmk1IhrsTcVflQwpE1ammwjG1g8uC4iYNRle6j3zOdw4nobjfpGAOCQCzBmgdm5d6RDIj1hphsjEhqkslBcbSbqP7X4ZUmYgtbtkcVTki5NDOOwCuBz3Qk=
X-MS-Exchange-AntiSpam-MessageData: +VyEQaCBoyVTEx1qFY20whkpM29IIZWCOmw3D/y+URlcsKQHfGGC3miySJNssuQRcgqXDcntj2ElN8KE8qCv7yq58npY9QKLJzprELlnMSs9OA/lqQBoQQBbdZqeVFhSdCWUrKJoFdIC6j82OG7xNA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f5e8f2-e6f5-46bd-e49a-08d7b1578096
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:09:27.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sADIOi1KvweoaVunw3Hy4m30nYrJKCkiCcYHVECN+JsVysY7pwh/TIddWW+/3ZGfGN7gTXwJyeasfFmbEbsxDwdTMOUsdIiUpSI0kLjgYXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR07MB4844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle reminder.

Thanks.
Benjamin

On 17/01/2020 14:45, Benjamin Bouvier wrote:
> Drivers may want to register restart_handlers for case where an external
> reset is needed to reset a complete system and not only the processor.
> This case is currently missing in x86 architecture.
> So include call to do_kernel_restart() to use handlers registered
> through register_restart_handler() API when the processor restarts.
> 
> do_kernel_restart() cannot be called in machine_restart() as required by
> documentation as final step, because it will never be reached (restart
> having already been carried out). So call is done inside
> native_machine_restart(), and only here to not let drivers managed reset
> in hypervisor case where function native_machine_restart() is overridden.
> 
> Co-developed-by: Patrick Lelu <patrick.lelu@nokia.com>
> Signed-off-by: Patrick Lelu <patrick.lelu@nokia.com>
> Signed-off-by: Benjamin Bouvier <benjamin.bouvier@nokia.com>
> ---
>  arch/x86/kernel/reboot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 0cc7c0b106bb..53c3d5a3f89d 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -718,12 +718,13 @@ static void __machine_emergency_restart(int emergency)
>  	machine_ops.emergency_restart();
>  }
>  
> -static void native_machine_restart(char *__unused)
> +static void native_machine_restart(char *cmd)
>  {
>  	pr_notice("machine restart\n");
>  
>  	if (!reboot_force)
>  		machine_shutdown();
> +	do_kernel_restart(cmd);
>  	__machine_emergency_restart(0);
>  }
>  
> 
