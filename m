Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0D02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391522AbgAXLZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:25:40 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:41093 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391388AbgAXLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:34 -0500
Received: from [46.226.52.108] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 92/0A-01118-C24DA2E5; Fri, 24 Jan 2020 11:25:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsVy8IPnUV2dK1p
  xBs9uC1rc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTXj4sG1jAXnWCp+belib2C8
  xdzFyMUhJLCeUeLg4aVADieQUyFx9upyJhCbV8BN4uXvY2wgNpuAhcTkEw/AbBYBVYnGnVtZQ
  WxhgRCJi28WA8U5OEQEVCTOvTEHMZkFIiT+nGKGmCIocXLmExYQm1lAQuLgixdQmwwkTi9oBI
  tLCNhLTH9/lRmkVUJAX6LxWCxE2FDi+6xvLBBhc4m167wmMPLPQjJ0FpKhCxiZVjFaJBVlpme
  U5CZm5ugaGhjoGhoa6RpamugamhnoJVbpJuqlluqWpxaX6BrqJZYX6xVX5ibnpOjlpZZsYgQG
  ZkrBoQU7GKd+eqt3iFGSg0lJlLdrrlacEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQle+0tAOcGi1
  PTUirTMHGCUwKQlOHiURHg9QdK8xQWJucWZ6RCpU4y6HDuPzlvELMSSl5+XKiXOOxukSACkKK
  M0D24ELGIvMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmTQOZwpOZVwK36RXQEUxAR7gogR1
  RkoiQkmpgclOvVHvVpV/6YNM+vwiJSzZzNt5i1Y030rile76kiXnTLacs92nfrOv33lnmZBn1
  MUe9o6f+HEtmzjqZ0MUBdw1Ppk26wNDOZPKkiHPvQa/6a+Vx+g9zud7oSe88z+yh9U3L1L4x4
  spRo5u5u9U3PsnL3NFxJWPNolSBuTExmrbJNrySzU/VLySl1TzpcOmpfXksutZOzeTE3DMLr6
  hYsDw7x3hNNZqnYI71n1/VB6LXH6rx/rmktv7opivPGp+s+C36oOVOusFippITmydrXY48qC2
  beVu3t8c/ldGunM+WecO5TwKv3aauXp7sXhEiVO2waUIXz6ni5TpH/HiYFvzP1LmdPmH2iaWf
  DpQrsRRnJBpqMRcVJwIAPmQ9olMDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-28.tower-272.messagelabs.com!1579865131!1056631!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26580 invoked from network); 24 Jan 2020 11:25:32 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-28.tower-272.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 24 Jan 2020 11:25:32 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 24 Jan 2020 11:25:30 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 6AC183FB8D; Fri, 24 Jan 2020 11:25:30 +0000 (GMT)
Message-ID: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 24 Jan 2020 11:25:30 +0000
Subject: [RESEND PATCH 0/2] Resolve revision handling and add support for DA silicon
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24/01/2020 10:17:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the currently broken revision handling in the driver's
i2c_probe() function and then adds DA support to existing permitted revisions.

Adam Thomson (2):
  mfd: da9063: Fix revision handling to correctly select reg tables
  mfd: da9063: Add support for latest DA silicon revision

 drivers/mfd/da9063-core.c            |  31 -----
 drivers/mfd/da9063-i2c.c             | 254 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/core.h      |   1 +
 include/linux/mfd/da9063/registers.h |  15 ++-
 4 files changed, 240 insertions(+), 61 deletions(-)

-- 
1.9.1

