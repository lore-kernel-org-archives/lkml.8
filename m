Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6BCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7948220714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Qx0vK0fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGVHq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:46:26 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:36484
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbgGVHqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMpqg1qJ6WAZi6heXuG3ulu/dQ07UGndKWi07af3eN3lCQGEQdxPzYVE26M014W3p0ecBEurRTSlrPNtaCe+qZD2XH7Wp78kzNTsrlSObUSYfMo5Nm39p6Wz8HH7sBzuKAg699N0Nmf4BpY3kp1fg+Hpl+ciaLhcDFu99hcZK28iXVkW/oZUlumcZYhNEkRvfMAVdhXhf2a52p6q2jIAVc8xHG5WWthgShKqTCoPmjmgmuZdagVw+BJYCqlChpNj/f2eRPgJ4l7PkgR6KzMJJ1DJD30FkNFHWrflvdTz/A+M5NmBaIBv6MDSoSoHS8j2jaek1SkFTZZqnNHPTTWJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnCctu3vmdAHTLCMXZiyHPufMNQrlPxsbltTBWSpKAQ=;
 b=kfC0gG+iWCKddFPiw8eUgP0hCbKBXVwiFz5pV8xiIqa/9jOFyvG9OueF5AiMoh01R6amcr9YlW5giqOJbR6FUC6srwD4cXsT6+PpG5Xsr3HTKCWqMR8/F9RyOpTVfmqt7whDMCPDP9kBXR8WwTARxVyT2szT/mVUlK+xVh4p4s18rue5a4gEYo4NrjD/LkXc64wWQ3YxZtspnZiYsAogUe+Fgvw8Bb70ljVrPI9OYpOX3qL4903yHjVPh4Qn4gUmL+KRMwxOOf+zxnLgoivov2NTSP51s6/5Tmh5L5P/Xn1EHPm2EtwVqk6fMT6yXItSaQZtsJtscRUosYJ5wXcFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnCctu3vmdAHTLCMXZiyHPufMNQrlPxsbltTBWSpKAQ=;
 b=Qx0vK0fiL+jzJYEzAvCLGrcCxeGXoFQq5vqMAJ2mZRcGnXfx6zH4RP4WmuHOIK86F0xmjU4+bK76K6d1zWVdupIlYszrAcQnPnFVZXqoxMghFewRV6M8wbqu0w8FD8uVOnxh66yNl+PwSnAW0e/OWDJUU0/1minIzVirmqiKMA0=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR0501MB2226.eurprd05.prod.outlook.com (2603:10a6:200:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 22 Jul
 2020 07:46:21 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 07:46:21 +0000
Date:   Wed, 22 Jul 2020 10:46:17 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     kernel test robot <lkp@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V2 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200722074617.GA210999@mtl-vdi-166.wap.labs.mlnx>
References: <20200720071416.32112-11-eli@mellanox.com>
 <202007202033.m3akyfrJ%lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007202033.m3akyfrJ%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 07:46:19 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51fdd91a-88d2-4223-74bd-08d82e13531a
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB222639F00219401764D2809BC5790@AM4PR0501MB2226.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aIiBNexg7aT8bhHmWQMhcdbXBZXg8xHPyj/OfBw8QxXZxsfe2NsXE+8tXu6pVRZipGysKH8pmG0dkQKsz3vAxx3DmA1DFfJerwffDbNvxYCLFcUje4SzHxrfnhJWgueaYZsnqMgLLDiKVncS1B6Xe/lHwlRf5Pc4Qen3mq/EKzaDlm0VItIFV+kofqdi/fUVXeHxECsjQvvlHt6mmdJ1OiJwAMaFA5wPVWh377USCkp7Ps12gT3Bl8qiMDU+1u+S4+/s3aFlmBeVaR3PbSZMub6hfNAqbIYp5I5KFlWsbav0g+2GgVsxt4EwGZWr3r1gTOQ2MODkSxjMRm1xlaFJwV4SCEpwDQ5WA8MnaSiZXwxfDLL0c+y42wmJkHaHhBgotuSZuMGmDFIf2b2tyWEcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(86362001)(6916009)(6506007)(1076003)(66946007)(16526019)(52116002)(7696005)(186003)(8936002)(55016002)(9686003)(26005)(107886003)(4326008)(8676002)(2906002)(956004)(33656002)(316002)(478600001)(966005)(5660300002)(66476007)(66556008)(83080400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JBEo318OmE6MC4FFOpqma1RKwhIccmmNn5Qh/xX1+tmmFd3tTNqrFAJ827rAG8fTdA3y2k0X1mTuZ/vH6tvw9eDS8KEWv/RQ4CGxg6SaO6X1ax/WYGAcp6uJfvvZ7JWC7IBnkpUkF+IxIcet44lTPuvl39y/A93GYy0JVQdsGBI5r4uXTX7oj7TRPrlkqoTqdlybEW9NqAw4UBN3cXTc5+J2wG248LJAmV3weIbKDfV6/JjylyiP7cLqN02rd9S+VySA5eEhKZmSNsKq8FJ5T14HAhHBjRI2PFeCExRAoc1Ud+fQERw4bgBRlW+BmbMr3cylzgUvZG0+IRFwRko3Ul8DeK60z7HwvrZ4PldtujUUtDJyeb0NQS/q1i4XNE9wdF94+FT7ls+PvSdZn6BnMF3nlmD/GOU+UtwVWipS8/4Rd0r98pf4Pq4lw/4BsvKl1bRneIRG0CKG3sDXzkSgwSlDzavEnqT4hwOY2/SktuI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fdd91a-88d2-4223-74bd-08d82e13531a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:46:20.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcxdgBmeLYmu2f+xTvJd8eqaZkMIg9Sp0bqXiKGWthxtpq6uK8jhxHIQtHANF3hUfRS8EV0OzR9ECXJAJNkwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 08:55:54PM +0800, kernel test robot wrote:
> Hi Eli,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20200717]
> 
> url:    https://github.com/0day-ci/linux/commits/Eli-Cohen/VDPA-support-for-Mellanox-ConnectX-devices/20200720-160220
> base:    aab7ee9f8ff0110bfcd594b33dc33748dc1baf46
> config: arc-allyesconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/vdpa/mlx5/net/main.c:7:10: fatal error: mlx5_vdpa_ifc.h: No such file or directory
>        7 | #include "mlx5_vdpa_ifc.h"
>          |          ^~~~~~~~~~~~~~~~~

Does anyone understand this error? The code compiles with no issues. I
think there may be an issue with the tool not interpreting the include
path in the makefile:

subdir-ccflags-y += -I$(src)/core

>    compilation terminated.
> --
>    In file included from drivers/vdpa/mlx5/net/mlx5_vnet.c:12:
> >> drivers/vdpa/mlx5/net/mlx5_vnet.h:13:10: fatal error: mlx5_vdpa.h: No such file or directory
>       13 | #include "mlx5_vdpa.h"
>          |          ^~~~~~~~~~~~~
>    compilation terminated.
> 
> vim +7 drivers/vdpa/mlx5/net/main.c
> 
>      3	
>      4	#include <linux/module.h>
>      5	#include <linux/mlx5/driver.h>
>      6	#include <linux/mlx5/device.h>
>    > 7	#include "mlx5_vdpa_ifc.h"
>      8	#include "mlx5_vnet.h"
>      9	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


