Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5616120825
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="liv9i5S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgFIMzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:55:02 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57913 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591707301; x=1623243301;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=R4d1xFOQANOtBvYugE4Y6z/1+LM4tG8caBxOeDEyPCg=;
  b=liv9i5S21PCOej3E82Sz/28uPN/9ah9nZQivmnSduccmsFjY5M5kNyTr
   4ytXdZ7vbejVr7rVi4nnU/l3wGAld79jiqmvesgXFW5ZoO18euoSoElT8
   Y0HWp1EtxQ8of/sX8sO7l25fB8u7eam/hNrB6QIJzBVk6jm+DuztciVQ/
   jvShsyYeGqgHCS/nQ4PqZs1XAW55PkFYBY8UxUcnsRIwKJR4/7TjIhh3n
   g7Aqxp0Iod9z2GlpQdS1U7Ke8+cWq4k/OOYgShW+1R2gj+Ea4KSKBFz1S
   ysnP+xyEJ9YwYyZkyZcjfdkt5qX61JQVt37cXDNHHHmAf8888iXZ/LtJ+
   A==;
IronPort-SDR: WAUKnIXpcUbDouBuOz024F5bSzIZ7+iHnxZeWI8QHby6MNWMIDw5pmk2jj7PVMdBKyPVy4b81W
 G2ktMI+O5H2bocpkSKi/DiHgvq2xQNE3wrNGF44mZhvL8AwD6GXlSJTS31FRmgqh1h6oKU5l6q
 cBV3erkFaKmMlCnUKLxsDHoePKE46e4UA3nTOGz/4hlr+BYDH8+TJKsR31BRclTeuc3OjHcRVk
 SL0aiMMVWITHhn41N73LPpgA8f6MFnevuSJ/xkG4MG0YZIamcdGmV8Gnwk4D0lyhE29g6mFHpO
 /ak=
X-IronPort-AV: E=Sophos;i="5.73,492,1583218800"; 
   d="scan'208";a="79427220"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 05:55:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 05:54:59 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 05:54:57 -0700
References: <20200609072828.9088-1-lars.povlsen@microchip.com> <20200609074940.9529-1-lars.povlsen@microchip.com> <20200609093808.00003aad@Huawei.com>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-kernel@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] hwmon: sparx5: Add Sparx5 SoC temperature driver
In-Reply-To: <20200609093808.00003aad@Huawei.com>
Date:   Tue, 9 Jun 2020 14:54:56 +0200
Message-ID: <87ftb4ielb.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Cameron writes:

> On Tue, 9 Jun 2020 09:49:40 +0200
> Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
>> This patch adds a temperature sensor driver to the Sparx5 SoC.
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>
> Hi.  Quick drive by review whilst waiting for coffee time...
>
> A few minor suggestions inline.
>

Ooops, forgot to ack the COMPILE_TEST and bitfield.h suggestions.

Both adopted.

Thanks,

---Lars

-- 
Lars Povlsen,
Microchip
