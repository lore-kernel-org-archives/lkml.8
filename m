Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5302AC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B39721D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgDQKzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:55:51 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:58823 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729364AbgDQKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:55:48 -0400
Received: from [100.113.1.220] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 88/C0-36550-13B899E5; Fri, 17 Apr 2020 10:55:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRWlGSWpSXmKPExsVy8MN7XV3D7pl
  xBit/8Fnc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTVj39rP7AX72SrePGVtYJzB
  2sXIxSEksI5R4nrvCcYuRk4gp0Li76G5YDavgJvEgfkPmEFsNgELicknHrCB2CwCqhKL39wEi
  nNwCAsESDy7GQZiigioSJx7Yw5iMgtESPw5xQwxRFDi5MwnLCA2s4CExMEXL5ghFhlInF7QyD
  KBkXsWkrJZSMoWMDKtYrRIKspMzyjJTczM0TU0MNA1NDTWNdQ1tdBLrNJN1Est1U1OzSspSgR
  K6iWWF+sVV+Ym56To5aWWbGIEBk5KIaPVDsata9/rHWKU5GBSEuVVapsZJ8SXlJ9SmZFYnBFf
  VJqTWnyIUYaDQ0mCt6QLKCdYlJqeWpGWmQMMYpi0BAePkghvYidQmre4IDG3ODMdInWKUZdj5
  9F5i5iFWPLy81KlxHllQGYIgBRllObBjYBF1CVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwr
  zMIFN4MvNK4Da9AjqCCeiIaIfpIEeUJCKkpBqYNIubCq7Me5gXabqp/+SE9WxRT3SF+jlXxcr
  eXMPce47pfixHbgrTzCePPgouY8vj+raBr5Ptxrbk6zPavmb6HZ0TO7ln7oyXm4Jt75hMmXyh
  6e6ywjP35T3E7+UZ6P/eaLRjUkXcWSnD93ZSwUt6zVjD5lrtuvL5994ZV5MMBBLj2D/2H8xmu
  LtDI1Th/tvisEVdkto9gtxsL/bP3ny/o689783EG0o7Jh1rPbjzq/zpe+k9Ojv2szxOOFIcc8
  5tG//N0+u+Bh6osGwO8bqpe33Fvej0s69v19mxnntiue1RpKT8qcI+uYquH+sVP2w6pnvirP3
  p9al+p+83vOaX31fhJ6tqftXq04TKc2ql55RYijMSDbWYi4oTAWLbJKkjAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-229.messagelabs.com!1587120944!3257471!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9961 invoked from network); 17 Apr 2020 10:55:45 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-6.tower-229.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Apr 2020 10:55:45 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 17 Apr 2020 12:55:44 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 1B4CD3FB8D; Fri, 17 Apr 2020 11:55:44 +0100 (BST)
Message-ID: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 17 Apr 2020 11:55:44 +0100
Subject: [PATCH v3 0/2] Resolve revision handling and add support for DA silicon
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the currently broken revision handling in the driver's
i2c_probe() function and then adds DA support to existing permitted revisions.

v3:
 - Replaced magic numbers around I2C paged access code with enums and defines
 - Small style tidy ups as requested by Lee Jones

v2:
 - Use raw I2C read access instead of a temporary regmap to interrogate chip and
   variant id registers

Adam Thomson (2):
  mfd: da9063: Fix revision handling to correctly select reg tables
  mfd: da9063: Add support for latest DA silicon revision

 drivers/mfd/da9063-core.c            |  31 ----
 drivers/mfd/da9063-i2c.c             | 271 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/core.h      |   1 +
 include/linux/mfd/da9063/registers.h |  15 +-
 4 files changed, 257 insertions(+), 61 deletions(-)

-- 
1.9.1

