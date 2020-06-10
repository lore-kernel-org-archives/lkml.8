Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F03C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827292081A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T9b/7hcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgFJHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:34:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1426 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591774442; x=1623310442;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=H0mGDxnEZFg00erzET87dowCc530Z3JfzOW8o5EaPg0=;
  b=T9b/7hcSkVDJ3djV0ATTkwLzimMAUHiqseG8Qa9M8EZxv4n005OvIgAS
   TkJlHUs6Af5VbrRjgYBWP7zgfdnN2oEaxdFMRqbd4vwqiu2F+qwpYhraB
   7bJ1rd5UAYIRfHEhCDH2Yx1UbY8uJr629fyNlpTXEWFjH+KQYvhkWVg33
   hUCDAMXjjdSoaC/E7EbmudsexpABmvUpna23T9QfGAuWRwoqb9Z/bia6t
   fMtRmxtjpooikBxOStk1BEh/FRh6MoTyjGVdOLqo5mLBb4JWChAzJz/MS
   v/kwmXKa4TF4kkbQg8i1MK/OaXnmQCT6lX3nydm9x2UcpSln0Qhyzj2Q2
   Q==;
IronPort-SDR: tRCMCf0cC57dobeWM9CJUIUQEBcjnDkCmmimitTGVaen/LOuUjJfmwx/3UvyiNCGvpEpxrEMxV
 i+fTQD7Jj/YMoq28YKgrurZQZG8LWNIVhLHfRwhwWyWNu6adaMHKRvFsLsAstV2A6PXoZMQ4yW
 PmU+Zqxib8XRTAJ3u+e2Kizd0AyEww1SRjyhWZPcKRaZ19R0Eqqn92I2+UC40fPzDrUnvmV0UP
 0N/+33BfpjbARGiOuL7HUqz26a0R+IK+AMczYoJ/CyhlHXm01hRpjd3axPeR0ZPhHVA/vMn75m
 0HI=
X-IronPort-AV: E=Sophos;i="5.73,495,1583218800"; 
   d="scan'208";a="82940802"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2020 00:34:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 10 Jun 2020 00:34:01 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3
 via Frontend Transport; Wed, 10 Jun 2020 00:33:59 -0700
References: <20200609072828.9088-1-lars.povlsen@microchip.com> <5f006733-52b6-e003-5db3-2ff16596918c@roeck-us.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/3] hwmon: Adding support for Microchip Sparx5 SoC
In-Reply-To: <5f006733-52b6-e003-5db3-2ff16596918c@roeck-us.net>
Date:   Wed, 10 Jun 2020 09:33:58 +0200
Message-ID: <87eeqnidcp.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Roeck writes:

> On 6/9/20 12:28 AM, Lars Povlsen wrote:
>> This is an add-on series to the main SoC Sparx5 series
>> (Message-ID: <20200608123024.5330-1-lars.povlsen@microchip.com>)
>>
>> Changes in v2:
>> - Changes in driver as per review comments
>>
>
> And you expect the reviewers/maintainers to remember what those were ?
>

Well, I can see that this might not be the case. I'll be a little more
specific next time. Sorry about that.

For the record, it was:

- Removed unnecessary #includes
- Statement reordering in s5_read()
- Replaced EINVAL with EIO
- Add 'break' in default: case statement.
- Removed extra ()
- Removed superfluous initialization

I got some more comments from Jonathan Cameron
<Jonathan.Cameron@huawei.com>, so there will be another round.

Thanks,

---Lars

>> Lars Povlsen (3):
>>   dt-bindings: hwmon: Add Sparx5 temperature sensor
>>   arm64: dts: sparx5: Add hwmon temperature sensor
>>   hwmon: sparx5: Add Sparx5 SoC temperature driver
>>
>>  .../bindings/hwmon/microchip,sparx5-temp.yaml |  39 +++++
>>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |   6 +
>>  drivers/hwmon/Kconfig                         |  10 ++
>>  drivers/hwmon/Makefile                        |   2 +-
>>  drivers/hwmon/sparx5-temp.c                   | 152 ++++++++++++++++++
>>  5 files changed, 208 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
>>  create mode 100644 drivers/hwmon/sparx5-temp.c
>>
>> --
>> 2.27.0
>>

-- 
Lars Povlsen,
Microchip
