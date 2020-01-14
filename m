Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0EAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777F22465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgANMR5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:17:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgANMR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:17:57 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id E191FB3B85A07F6F6CD0;
        Tue, 14 Jan 2020 20:17:50 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 20:17:50 +0800
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Tue, 14 Jan 2020 20:17:41 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Thread-Topic: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Thread-Index: AQHVyExqmWOdrHr7k0CDA2xXZLn68Kfn3yMAgAChbkD//4CPgIABXxGAgAAUOwCAAKNokA==
Date:   Tue, 14 Jan 2020 12:17:41 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340E6EE9@DGGEMM506-MBX.china.huawei.com>
References: <1578725620-39677-1-git-send-email-prime.zeng@hisilicon.com>
 <20200113101922.GE52694@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E41D1@DGGEMM506-MBX.china.huawei.com>
 <20200113122101.GA49933@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E59BA@DGGEMM506-MBX.china.huawei.com>
 <20200114102956.GB10403@bogus>
In-Reply-To: <20200114102956.GB10403@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Tuesday, January 14, 2020 6:30 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> linux-kernel@vger.kernel.org; Sudeep Holla
> Subject: Re: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
> nodes
> 
> On Tue, Jan 14, 2020 at 01:42:25AM +0000, Zengtao (B) wrote:
> > Could you help to explain here?
> > I understand there are two abnormal cases:
> > 1. The cpu node exist in the device tree, but not a possible cpu.
> > This case can be caught by of_cpu_node_to_id's return value.
> 
> Yes if of_cpu_node_to_id returns -ENODEV, it means there's no logical
> CPU associated with this DT node.
> 
> > 2. The cpu node does not exist. This case can be caught by above logic.
> Or
> > do you think of_parse_phandle's return value is enough?
> 
> Again yes, there's nothing extra needed.
> 
> The only change you need is to consider -ENODEV while handling the
> case(1)
> 
Thanks very much for your explanation.
So finally it turns into a very simple patch like this, more cleaner:
+/*
+ * This function returns the logic cpu number of the node.
+ * There are basically three kinds of return values:
+ * (1) logic cpu number which is > 0.
+ * (2) -ENDEV when the node is valid one which can be found in the device tree
+ * but there is no possible cpu nodes to match, when the CONFIG_NR_CPUS is
+ * smaller than cpus node numbers in device tree, this will happen. It's
+ * suggested to just ignore this case.
+ * (3) -1 if the node does not exist in the device tree
+ */
 static int __init get_cpu_for_node(struct device_node *node)
 {
        struct device_node *cpu_node;
@@ -261,7 +271,8 @@ static int __init get_cpu_for_node(struct device_node *node)
        if (cpu >= 0)
                topology_parse_cpu_capacity(cpu_node, cpu);
        else
-               pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+               pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
+                       cpu_node, cpumask_pr_args(cpu_possible_mask));

        of_node_put(cpu_node);
        return cpu;
@@ -286,9 +297,8 @@ static int __init parse_core(struct device_node *core, int package_id,
                                cpu_topology[cpu].package_id = package_id;
                                cpu_topology[cpu].core_id = core_id;
                                cpu_topology[cpu].thread_id = i;
-                       } else {
-                               pr_err("%pOF: Can't get CPU for thread\n",
-                                      t);
+                       } else if (cpu != -ENODEV) {
+                               pr_err("%pOF: Can't get CPU for thread\n", t);
                                of_node_put(t);
                                return -EINVAL;
                        }
@@ -307,7 +317,7 @@ static int __init parse_core(struct device_node *core, int package_id,

                cpu_topology[cpu].package_id = package_id;
                cpu_topology[cpu].core_id = core_id;
-       } else if (leaf) {
+       } else if (leaf && cpu != -ENODEV) {
                pr_err("%pOF: Can't get CPU for leaf core\n", core);
                return -EINVAL;
        }

Any more suggestions? 

Regards
Zengtao 

