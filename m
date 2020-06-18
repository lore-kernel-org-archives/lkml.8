Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A9720734
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o3fL+jKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgFRLhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:37:43 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:28143 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgFRLhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592480260; x=1624016260;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=ZJq5jod7o37KgX0rG4DZcl10Hx/gKEOzJOIZ43OXlcg=;
  b=o3fL+jKY7BJOCPTDJNlbarnVhpKH1ApKB1+3SxMJP8guzNLKuRlmTZb3
   t1F3cFFnoJTUQAtl6/objpat8Y7L/Cejaf9GnsCuZ8Tt/mCndzlkKlyKM
   YYoEZ5sd6n8Jbzc4uksy9RRjiOAaNB/mwaO41gC7WdyGKSY0oOEVgCovQ
   Y/zjT/QUxxSjIeh4s2LINM2AMA18r88cNFogMO+lV4W0E6jekYmNaUppx
   4dmYdlSw4CobB7ef0LGHApX5SD8SAMTefp61INN9JTn8RXUMMBsv9anEi
   MB1YJBLaB/DuMqRG1bpmTEuCxaTwbv91I+UQ4yOp33RSD7aHGazwuj/qA
   A==;
IronPort-SDR: tPdpgi3n4Ck3dXTCN+pqPqWOXoFIW95EElUe/F0GR3xUJ/p+hHug0sAHbFY1oR4ItG41OczY2q
 +uQjDYozTcj9ZrELMZQQCs5dxn85VdeJ97z8cm7QxiFKmiX+Ju+1fL6HOKhLoLlc746Gc3hyyc
 6iUsO0JgFpkY+xQLpjDbvaT13YoyZGYhrALptLsRypbOdU5IGniZhdPsEABDRRqv/TiJ1IvlKA
 70+u6QxoYWM45qqEApRx43pWqace/YAStYVVecKRMqbCNF7ezyIZH8ZphvGf+7/eKUXZHMdZNq
 +Ug=
X-IronPort-AV: E=Sophos;i="5.73,526,1583218800"; 
   d="scan'208";a="84121961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 04:37:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 04:37:33 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 18 Jun 2020 04:37:37 -0700
References: <20200616082556.27877-1-lars.povlsen@microchip.com> <20200616082556.27877-4-lars.povlsen@microchip.com> <b44120d8-67fe-4ba3-bc76-80a5a0970dad@roeck-us.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
In-Reply-To: <b44120d8-67fe-4ba3-bc76-80a5a0970dad@roeck-us.net>
Date:   Thu, 18 Jun 2020 13:37:36 +0200
Message-ID: <87eeqcwqnz.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Roeck writes:

> On 6/16/20 1:25 AM, Lars Povlsen wrote:
>> This patch adds a temperature sensor driver to the Sparx5 SoC.
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  drivers/hwmon/Kconfig       |  10 +++
>>  drivers/hwmon/Makefile      |   1 +
>>  drivers/hwmon/sparx5-temp.c | 136 ++++++++++++++++++++++++++++++++++++
>
> This will also require documentation in
>         Documentation/hwmon/sparx5-temp.rst
>

Sorry, forgot to ack this. I will add the necessary information.

---Lars

-- 
Lars Povlsen,
Microchip
