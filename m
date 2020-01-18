Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F740C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FE42468B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="nSA1ClJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgARJQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:16:38 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:41220 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgARJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:16:37 -0500
X-Greylist: delayed 1411 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jan 2020 04:16:36 EST
Received: from [10.8.0.1] (helo=srv.home ident=heh3905)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1isjqY-00014F-U9; Sat, 18 Jan 2020 16:52:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=9Zt73YMWrB9fRw/Y7euwqnit6NOkGlC6M3h5APuHqbI=;
        b=nSA1ClJPIEdna7thwoj4c2T7DDvavIE62hsQzLiwRvUMX+kMO3t4IHudVvZpsKt996LIrB3OqqSruIN+iQ6fwh+8Ygfgp1JS/2durHvkFD0/S3vo+h1vo0Nhilbx46ocdoq+yMRBtHBg8BSr2RzubePvJlb30pJc9eoC+eziJTc=;
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <492345ed-f82e-e4d9-20ac-924b4a00df90@fnarfbargle.com>
Date:   Sat, 18 Jan 2020 16:52:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/1/20 10:17 pm, Guenter Roeck wrote:
> This patch series implements various improvements for the k10temp driver.
> 

Looks good here. Identical motherboards (ASUS x370 Prime-Pro), different 
CPUs.

3950x

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.38 V
Vsoc:         +1.08 V
Tdie:         +69.1°C  (high = +70.0°C)
Tctl:         +69.1°C
Tccd1:        +54.2°C
Tccd2:        +57.0°C
Icore:       +27.67 A
Isoc:        +14.13 A

it8665-isa-0290
Adapter: ISA adapter
Vcore:        +1.41 V  (min =  +0.83 V, max =  +1.65 V)
in1:          +2.51 V  (min =  +1.98 V, max =  +2.73 V)
+12V:        +11.98 V  (min = +11.20 V, max = +12.40 V)
+5V:          +5.01 V  (min =  +4.74 V, max =  +5.61 V)
3VSB:         +6.67 V  (min =  +2.83 V, max =  +3.40 V)
Vbat:         +6.58 V
+3.3V:        +3.33 V
CPU Fan:     3409 RPM  (min = 1500 RPM)
Back Fan:       0 RPM  (min =    0 RPM)
MB CPU Temp:  +56.0°C  (low  = +13.0°C, high = +88.0°C)
Ambient:      +35.0°C  (low  = +13.0°C, high = +43.0°C)  sensor = thermistor
PCH:          +46.0°C  (low  = +18.0°C, high = +61.0°C)  sensor = thermistor

1800x

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.26 V
Vsoc:         +0.91 V
Tdie:         +36.0°C  (high = +70.0°C)
Tctl:         +56.0°C
Icore:       +15.59 A
Isoc:         +7.94 A

it8665-isa-0290
Adapter: ISA adapter
Vcore:        +1.25 V  (min =  +0.83 V, max =  +1.65 V)
in1:          +2.48 V  (min =  +1.98 V, max =  +2.73 V)
+12V:        +11.98 V  (min = +11.20 V, max = +12.40 V)
+5V:          +4.96 V  (min =  +4.74 V, max =  +5.61 V)
3VSB:         +6.54 V  (min =  +2.83 V, max =  +3.40 V)
Vbat:         +6.37 V
+3.3V:        +3.31 V
CPU Fan:     1171 RPM  (min = 1500 RPM)  ALARM
Back Fan:       0 RPM  (min =    0 RPM)
MB CPU Temp:  +36.0°C  (low  = +13.0°C, high = +88.0°C)
Ambient:      +44.0°C  (low  = +13.0°C, high = +43.0°C)  sensor = thermistor
PCH:          +38.0°C  (low  = +18.0°C, high = +61.0°C)  sensor = thermistor

Regards,
Brad
