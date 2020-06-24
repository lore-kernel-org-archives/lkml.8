Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C11BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FABF206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgFXJG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:06:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728732AbgFXJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:06:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O965RB123852;
        Wed, 24 Jun 2020 05:06:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ux06hph1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 05:06:16 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05O96Gos128689;
        Wed, 24 Jun 2020 05:06:16 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ux06hp4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 05:06:13 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05O8ndH3022644;
        Wed, 24 Jun 2020 09:04:18 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 31uursucyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 09:04:18 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05O94HUB44630278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 09:04:17 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3F536A058;
        Wed, 24 Jun 2020 09:04:16 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 403606A047;
        Wed, 24 Jun 2020 09:04:16 +0000 (GMT)
Received: from [9.211.67.55] (unknown [9.211.67.55])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jun 2020 09:04:16 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
To:     Tejun Heo <tj@kernel.org>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
 <20200622175343.GC13061@mtj.duckdns.org>
 <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
 <20200623231348.GD13061@mtj.duckdns.org>
From:   Rick Lindsley <ricklind@linux.vnet.ibm.com>
Message-ID: <a3e9414e-4740-3013-947d-e1839a20227c@linux.vnet.ibm.com>
Date:   Wed, 24 Jun 2020 02:04:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623231348.GD13061@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_04:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 cotscore=-2147483648 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Tejun, appreciate the feedback.

On 6/23/20 4:13 PM, Tejun Heo wrote:

> The problem is fitting that into an interface which wholly doesn't fit that
> particular requirement. It's not that difficult to imagine different ways to
> represent however many memory slots, right? 

Perhaps we have different views of how this is showing up.  systemd is 
the primary instigator of the boot issues.

Systemd runs

     /usr/lib/systemd/system/systemd-udev-trigger.service

which does a udev trigger, specifically

     /usr/bin/udevadm trigger --type=devices --action=add

as part of its post-initramfs coldplug.  It then waits for that to 
finish, under the watch of a timer.

So, the kernel itself is reporting these devices to systemd. It gets 
that information from talking to the hardware.  That means, then, that 
the obfuscation must either start in the kernel itself (it lies to 
systemd), or start in systemd when it handles the devices it got from 
the kernel.  If the kernel lies, then the actual granularity is not 
available to any user utilities.

Unless you're suggesting a new interface be created that would allow 
utilities to determine the "real" memory addresses available for 
manipulation.  But the changes you describe cannot be limited to the 
unknown number of auxiliary utilities.

Having one subsystem lie to another seems like the start of a bad idea, 
anyway.  When the hardware management console, separate from Linux, 
reports a memory error, or adds or deletes memory in a guest system, 
it's not going to be manipulating spoofed addresses that are only a 
Linux construct.

In contrast, the provided patch fixes the observed problem with no 
ripple effect to other subsystems or utilities.

Greg had suggested
     Treat the system as a whole please, don't go for a short-term
     fix that we all know is not solving the real problem here.

Your solution affects multiple subsystems; this one affects one.  Which 
is the whole system approach in terms of risk?  You mentioned you 
support 30k scsi disks but only because they are slow so the 
inefficiencies of kernfs don't show.  That doesn't bother you?

Rick
