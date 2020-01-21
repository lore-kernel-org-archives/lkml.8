Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD6C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D10C22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgAUGfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:35:06 -0500
Received: from mout0.freenet.de ([195.4.92.90]:33188 "EHLO mout0.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUGfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:35:05 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 01:35:03 EST
Received: from [195.4.92.165] (helo=mjail2.freenet.de)
        by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1itn34-0004wO-8u
        for linux-kernel@vger.kernel.org; Tue, 21 Jan 2020 07:30:02 +0100
Received: from [::1] (port=48248 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.92 #3)
        id 1itn34-0002y4-75
        for linux-kernel@vger.kernel.org; Tue, 21 Jan 2020 07:30:02 +0100
Received: from sub8.freenet.de ([195.4.92.127]:59914)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.92 #3)
        id 1itn0z-00026u-M3
        for linux-kernel@vger.kernel.org; Tue, 21 Jan 2020 07:27:53 +0100
Received: from p200300de571bdf00505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:571b:df00:5054:ff:fe15:ac42]:57682 helo=mail.maya.org)
        by sub8.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1itn0z-0007Q7-Jw
        for linux-kernel@vger.kernel.org; Tue, 21 Jan 2020 07:27:53 +0100
Received: internal info suppressed
References: <20200118172615.26329-1-linux@roeck-us.net>
To:     Kernel-Mailingliste <linux-kernel@vger.kernel.org>
From:   Andreas Hartmann <andihartmann@01019freenet.de>
Autocrypt: addr=andihartmann@01019freenet.de; keydata=
 xsDiBDz/vtQRBAC+OSpes1p57fA8ENLYy3Nl/CpEvtRoDdhy7DPyc1+adE57vpK52naRfaZB
 f0RSMvIZwJYggMio+emiN5Du7kL9y2IEjmHBvp/1x68dEwswHP9X4hJmHmyOJL3IB2WsvEdh
 QF97913bWX34MYCeuOoSJ1OWvBLGfNs0zv70HOTfJwCgricyy8N1itEryLwoeu5HWz0SmDED
 /2IiuDhPZ332i0Ylp40RQb2Wb0xBvpscVeRZDItsYYbJ/Sgmso1sn93sFFWmmrvGUyg3MNCt
 +u+7P8Wg3VXte8cHbNwdzNtXHTfYyTcgZXC4xJN2akZt4pdR531mXyP2kFxmKtAEmW6bNpvV
 oNnkgZVWvoT4BHLloLzA62JUEgFJA/9dHilAVS3Ezv5ECB02Lt2vNNzMvPlyNbxBhWnrb6VC
 mFMCRg9bOK2io1zYb8C4gEpJ33wl8hEBxOWfCOEEKesAUCjViosNvxqGNtGWjk5p1O2QBWE2
 D6u5+itACQRqhmmgNl+dK6Of2yGG9GxOYWozIELEfL9ZB4xQ7A2tDFR0Zs1HQW5kcmVhcyBI
 YXJ0bWFubiAod2VpbCBkZXIgUmVjaG5lciBuZXUgaGVpc3N0KSA8YW5kcmVhc0BkdWFsYy5t
 YXlhLm9yZz7CYAQTEQIAIAUCTMsY3gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBhU
 mcTgYeNVT1QAoJ4cJ2jl6Jgmi+PmWCXPk4m8lgAGAKCjkxgK/PjE3+cNsLa/xEpReqYwRs7A
 TQQ8/77WEAQAqBBex8oxPC1srpaSFbq8NCM/Gy7SKucKsQPqG/De46WQESbmnMElVft2xCBC
 rOJ7E02k10h/twe0yQnNdXMJDMDM0w0EEyX9ljekIr3SFbXpU2S4wUl3C6CW2hizUgOyLsg0
 chpfGMB9+wiVycyjZahafoc14wuuDj5BqWEOCccAAwcD/14lh1PTPKx4hs7ITtFZh5TI6+5f
 xAWIBBUeQL+GEt+CKwyNc/hWp8YTPJ3SAedmDrEMX+2yPO95KeIfg6bnnIVvI/aTR/vJFsWK
 GKMx+KaKx+IEwuhCpNIMUASpJWRvVlo3lMIvqAMJIBj79uKq/X9fppblcJst29QVO6aWf3Gh
 wkYEGBECAAYFAjz/vtYACgkQGFSZxOBh41VBAgCfZRiPCQ+jNvdT5iR2fEblqTtBrF0An0nb
 M8B1Lpkm44214BbtIQKneVrYwkYEGBECAAYFAjz/vtcACgkQGFSZxOBh41UjjgCgoua1QYf+
 FcHpxrRgoioO3D7ddkUAnAkRf8FH9i94x8f6LfS4npozycQc
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
Message-ID: <c5d5aafb-282e-9ed1-ff1e-be6105446d39@01019freenet.de>
Date:   Tue, 21 Jan 2020 07:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:de:571b:df00:5054:ff:fe15:ac42!57682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.20 at 18:26 Guenter Roeck wrote:
> This patch series implements various improvements for the k10temp driver.

Tested with Asus Prime X370-PRO / 1700X / Linux 5.4.x

Tested-By: Andreas Hartmann <andihartmann@01019freenet.de>

Idle:

it8665-isa-0290
Adapter: ISA adapter
in0:          +0.88 V  (min =  +1.27 V, max =  +2.00 V)
in1:          +2.52 V  (min =  +2.76 V, max =  +2.55 V)
in2:          +2.05 V  (min =  +1.23 V, max =  +0.16 V)
in3:          +2.01 V  (min =  +1.53 V, max =  +2.25 V)
in4:          +0.03 V  (min =  +2.67 V, max =  +2.43 V)
in5:          +0.03 V  (min =  +2.39 V, max =  +1.21 V)
in6:          +0.03 V  (min =  +1.67 V, max =  +0.56 V)
3VSB:         +3.31 V  (min =  +2.46 V, max =  +5.43 V)
Vbat:         +3.25 V
+3.3V:        +3.31 V
Fan CPU:      594 RPM  (min =   10 RPM)
Fan back:     380 RPM  (min =   11 RPM)
Fan front:    415 RPM  (min =   12 RPM)
fan5:           0 RPM  (min =   -1 RPM)  ALARM
fan6:           0 RPM  (min =   -1 RPM)  ALARM
CPU:          +28.0°C  (low  = +112.0°C, high =  -5.0°C)
Motherboard:  +30.0°C  (low  = -33.0°C, high = -18.0°C)  sensor = thermistor
temp3:        +29.0°C  (low  =  -1.0°C, high = -105.0°C)  sensor = thermistor
temp4:        +29.0°C  (low  = -74.0°C, high = +126.0°C)  sensor = thermistor
temp5:        +29.0°C  (low  = -49.0°C, high = +127.0°C)  sensor = thermistor
temp6:        +29.0°C  (low  = -82.0°C, high = -79.0°C)  sensor = thermistor
intrusion0:  ALARM

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +0.90 V
Vsoc:         +0.90 V
CPU:          +28.6°C  (high = +70.0°C)
Tctl:         +48.6°C
Icore:        +5.20 A
Isoc:         +7.21 A


Load:

it8665-isa-0290
Adapter: ISA adapter
in0:          +1.38 V  (min =  +1.27 V, max =  +2.00 V)
in1:          +2.52 V  (min =  +2.76 V, max =  +2.55 V)
in2:          +2.04 V  (min =  +1.23 V, max =  +0.16 V)
in3:          +2.01 V  (min =  +1.53 V, max =  +2.25 V)
in4:          +0.03 V  (min =  +2.67 V, max =  +2.43 V)
in5:          +0.03 V  (min =  +2.39 V, max =  +1.21 V)
in6:          +0.03 V  (min =  +1.67 V, max =  +0.56 V)
3VSB:         +3.33 V  (min =  +2.46 V, max =  +5.43 V)
Vbat:         +3.25 V
+3.3V:        +3.33 V
Fan CPU:      798 RPM  (min =   10 RPM)
Fan back:     481 RPM  (min =   11 RPM)
Fan front:    460 RPM  (min =   12 RPM)
fan5:           0 RPM  (min =   -1 RPM)  ALARM
fan6:           0 RPM  (min =   -1 RPM)  ALARM
CPU:          +43.0°C  (low  = +112.0°C, high =  -5.0°C)
Motherboard:  +30.0°C  (low  = -33.0°C, high = -18.0°C)  sensor = thermistor
temp3:        +33.0°C  (low  =  -1.0°C, high = -105.0°C)  sensor = thermistor
temp4:        +33.0°C  (low  = -74.0°C, high = +126.0°C)  sensor = thermistor
temp5:        +33.0°C  (low  = -49.0°C, high = +127.0°C)  sensor = thermistor
temp6:        +33.0°C  (low  = -82.0°C, high = -79.0°C)  sensor = thermistor
intrusion0:  ALARM

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.30 V
Vsoc:         +0.90 V
CPU:          +49.5°C  (high = +70.0°C)
Tctl:         +69.5°C
Icore:       +77.94 A
Isoc:         +9.02 A


it8665-isa-0290
Adapter: ISA adapter
in0:          +1.36 V  (min =  +1.27 V, max =  +2.00 V)
in1:          +2.52 V  (min =  +2.76 V, max =  +2.55 V)
in2:          +2.04 V  (min =  +1.23 V, max =  +0.16 V)
in3:          +2.00 V  (min =  +1.53 V, max =  +2.25 V)
in4:          +0.03 V  (min =  +2.67 V, max =  +2.43 V)
in5:          +0.03 V  (min =  +2.39 V, max =  +1.21 V)
in6:          +0.03 V  (min =  +1.67 V, max =  +0.56 V)
3VSB:         +3.33 V  (min =  +2.46 V, max =  +5.43 V)
Vbat:         +3.25 V
+3.3V:        +3.33 V
Fan CPU:     1044 RPM  (min =   10 RPM)
Fan back:     722 RPM  (min =   11 RPM)
Fan front:    633 RPM  (min =   12 RPM)
fan5:           0 RPM  (min =   -1 RPM)  ALARM
fan6:           0 RPM  (min =   -1 RPM)  ALARM
CPU:          +49.0°C  (low  = +112.0°C, high =  -5.0°C)
Motherboard:  +30.0°C  (low  = -33.0°C, high = -18.0°C)  sensor = thermistor
temp3:        +39.0°C  (low  =  -1.0°C, high = -105.0°C)  sensor = thermistor
temp4:        +39.0°C  (low  = -74.0°C, high = +126.0°C)  sensor = thermistor
temp5:        +39.0°C  (low  = -49.0°C, high = +127.0°C)  sensor = thermistor
temp6:        +39.0°C  (low  = -82.0°C, high = -79.0°C)  sensor = thermistor
intrusion0:  ALARM

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.30 V
Vsoc:         +0.90 V
CPU:          +52.1°C  (high = +70.0°C)
Tctl:         +72.1°C
Icore:       +78.98 A
Isoc:         +9.02 A


=> I can see slight differences regarding CPU temperature and Vcore between it8665 and k10temp - especially on high load (kernel compile).


Thanks
Andreas
