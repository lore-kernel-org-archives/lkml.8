Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C18C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA9D2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDFIy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:54:58 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:58937 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbgDFIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:54:58 -0400
Received: from [100.113.5.27] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 90/A4-35964-06EEA8E5; Mon, 06 Apr 2020 08:54:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRWlGSWpSXmKPExsVy8MN7Xd2Ed11
  xBhN7WSzufz3KaHF51xw2ByaPO9f2sHl83iQXwBTFmpmXlF+RwJrx/e5v1oI9rBW/u7tYGhg3
  sHQxcnEICaxllLj6uJOti5ETyKmQODm5lxHE5hVwk5jf3cwOYrMJWEhMPvEArIZFQEXi4cQGs
  BphgXCJaTtuAw3i4BABip97Yw5iMgtESPw5xQwxRVDi5MwnLCA2s4CExMEXL5ghNhlInF7QyD
  KBkXsWkrJZSMoWMDKtYrRMKspMzyjJTczM0TU0MNA1NDTWNdM1NDXQS6zSTdJLLdVNTs0rKUo
  EyuollhfrFVfmJuek6OWllmxiBIZPSiHbtB2MV9a+1zvEKMnBpCTKO/VFV5wQX1J+SmVGYnFG
  fFFpTmrxIUYZDg4lCd4Dr4FygkWp6akVaZk5wFCGSUtw8CiJ8C55BZTmLS5IzC3OTIdInWLU5
  dh5dN4iZiGWvPy8VClx3jtvgIoEQIoySvPgRsDi6hKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDk
  YlYV4WYJQK8WTmlcBtegV0BBPQEWx57SBHlCQipKQamKpeln8T4p0Qrb3xjidLSvWjowyic/3
  5Dqoc+/b4WbK7QXlSYcvy4huf0o9ndsyXyfIxCNtfsKEkgG19oFHboimt7vk3dMKW1PPe/c4w
  JXDx2k5H019+G6fF7fhytdo3dNX2Pbtq34Vbl2T8VxHWiniTunzNvdoUdj5jJS3DRP3Xs+ddC
  dikVtF1OJIv8Mfse70h00/9eBK3O6RZtiv/Psev+VKK21atDPJdYdXkrK74XedF+w1nWxZ3v0
  e1X+pmcCdGMLTztfobLupfdf+q1zunHLfQDBu33OzaO06apgf3NHjG1J573HNZ8N/Bed7TeMw
  rNlgcbKyU8ZuVZXDSZNfmouwVbJ5eAc56ZR+VWIozEg21mIuKEwE2z51CJgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-246.messagelabs.com!1586163295!1375517!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21691 invoked from network); 6 Apr 2020 08:54:56 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-3.tower-246.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 6 Apr 2020 08:54:56 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Mon, 6 Apr 2020 10:54:55 +0200
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 0CA633FB8D; Mon,  6 Apr 2020 09:54:55 +0100 (BST)
Message-ID: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 6 Apr 2020 09:54:54 +0100
Subject: [RESEND PATCH v2 0/2] Resolve revision handling and add support for DA silicon
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

v2:
 - Use raw I2C read access instead of a temporary regmap to interrogate chip and
   variant id registers

Adam Thomson (2):
  mfd: da9063: Fix revision handling to correctly select reg tables
  mfd: da9063: Add support for latest DA silicon revision

 drivers/mfd/da9063-core.c            |  31 -----
 drivers/mfd/da9063-i2c.c             | 249 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/core.h      |   1 +
 include/linux/mfd/da9063/registers.h |  15 ++-
 4 files changed, 235 insertions(+), 61 deletions(-)

-- 
1.9.1

