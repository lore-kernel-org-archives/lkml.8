Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E9220716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgFVPul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:50:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65356 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgFVPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:50:41 -0400
Received: from 89-64-85-91.dynamic.chello.pl (89.64.85.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id ef2a4d4d13a8983b; Mon, 22 Jun 2020 17:50:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH 0/2] ACPI: sysfs: add missing newlines when printing acpi module parameters
Date:   Mon, 22 Jun 2020 17:50:37 +0200
Message-ID: <1963218.YzJNvkzdAc@kreacher>
In-Reply-To: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 16, 2020 11:14:07 AM CEST Xiongfeng Wang wrote:
> When I cat module parameters in '/sys/module/acpi/parameters/',
> I found several parameters need a newline.
> 
> [root@hulk-202 ~]# cd /sys/module/acpi/parameters/
> [root@hulk-202 parameters]# cat acpica_version
> 20180810[root@hulk-202 parameters]# cat ec_event_clearing
> query[root@hulk-202 parameters]# 
> [root@localhost parameters]# cat trace_method_name
> (null)[root@localhost parameters]# cat trace_state
> disable[root@localhost parameters]#
> 
> Xiongfeng Wang (2):
>   ACPI: EC: add a newline when printing module parameter
>     'ec_event_clearing'
>   ACPI: sysfs: add missing newlines when printing module parameters
> 
>  drivers/acpi/ec.c    |  8 ++++----
>  drivers/acpi/sysfs.c | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> 

Both patches applied as 5.9 material, thanks!




