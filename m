Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE0C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D09207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiP1NH8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgANBIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:08:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38294 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgANBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:08:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so4526539plj.5;
        Mon, 13 Jan 2020 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/vfhkrlWhIH14AG8+cuyneg/lF282r5qmWZu7Iqzvho=;
        b=EiP1NH8FTf45TBKB+uAelC4TFn88d0sWDTASBzy4Hi7fPLjzYrHxhaKSVIZ4yQn2SQ
         PtLC0aHXLj7SRALP+Nk+qzdkpsArZ0f/b+skgzKZUnYxneLVwHMs3JUz3tLn48iM5jky
         i/GIJe937uK9pRNmbRAF/yHIS9fleaQPnWHIDJ5l/g80XLjYGzBxAfFqKLu22UjrwXk4
         HqWRTtN/Dv2SfymPLTwCBzEyEw3xd/GQv6/fUEqriHOWMDa+o9z5/wm9fV89cKJ89Vt5
         ar4DyMeCLlUz4wAJKUbR0CD0ZNLawrGk6juv9CMBSQMiHY4onYDS4NTG9GAgDeVvMwvo
         X1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vfhkrlWhIH14AG8+cuyneg/lF282r5qmWZu7Iqzvho=;
        b=YmMEAFeaHCSM4VoVKABqPuJopqOBCcurCTrpb8CjRPgU73rwoENbtVyom8BuqPhOdW
         NjiHXlScyReQfztS2ReetrNwp1RJCSXhK7ESDMORmMn4kKYK56ZzOQrLUq20pv5iHsqE
         GIsvaFhv7vxxk6UYB3IGm2q4q8md4Hsizs5HcymzBTMJqHvdflFpIqC67WQ9uV4+nK4p
         8mXjv+Pfm5lZh+0LdSjaGXTpGWWqvp5CnWVlAaV1/dpwSKZoUVc7lmxW6EaGj3UuXTZg
         iKftdJzO6+7fZxCizBV7KtcuO0nl61o+dzE+JkXHa8tYLbOy6y2K0qTh2haEu6eZ41Jx
         3dWw==
X-Gm-Message-State: APjAAAUajrRwg92vLt9kDTu84i0fX1wpf1xiBBS5LQqTTDTSbxVQl59b
        Cr1EwS6pt+ftBIobXIuS1+4=
X-Google-Smtp-Source: APXvYqxwdOrqEYxB77Extt+wnJ5mkSzOQ9kKIAwwxbaqWQU7CbbOM7Ndbv2g6CDY4hGdww0OMeuMWg==
X-Received: by 2002:a17:90a:8685:: with SMTP id p5mr25897192pjn.92.1578964110381;
        Mon, 13 Jan 2020 17:08:30 -0800 (PST)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 199sm16710114pfv.81.2020.01.13.17.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 17:08:28 -0800 (PST)
Subject: Re: [PATCH V2 5/7] USB: serial: f81232: Set F81534A serial port with
 RS232 mode
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
 <20191023115300.GU24768@localhost>
 <f3a8b0bd-79f7-3bef-4d07-69774c87873a@gmail.com>
 <20200108143502.GJ30908@localhost>
 <3c79f786-de34-550e-3964-d7fb334f6d56@gmail.com>
 <20200113151732.GC2301@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <c386949c-18f3-bd5b-35e3-4a7894265131@gmail.com>
Date:   Tue, 14 Jan 2020 09:08:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200113151732.GC2301@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Hovold 於 2020/1/13 下午 11:17 寫道:
> On Thu, Jan 09, 2020 at 10:37:09AM +0800, Ji-Ze Hong (Peter Hong) wrote:
>> Bus 001 Device 053: ID 2c42:1636
>> Bus 001 Device 044: ID 2c42:16f8
>> Bus 001 Device 043: ID 2c42:1608
> 
> Can you post verbose ("lsusb -v") output for the three device types for
> completeness?

Bus 001 Device 007: ID 2c42:1608
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0 Unused
   bDeviceProtocol         1 Single TT
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1608
   bcdDevice           80.ff
   iManufacturer           0
   iProduct                1 FINTEK_USB2.0 HUB
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           25
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xe0
       Self Powered
       Remote Wakeup
     MaxPower              500mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         9 Hub
       bInterfaceSubClass      0 Unused
       bInterfaceProtocol      0 Full speed (or root) hub
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0002  1x 2 bytes
         bInterval              12
Hub Descriptor:
   bLength              10
   bDescriptorType      41
   nNbrPorts            13
   wHubCharacteristic 0x00e9
     Per-port power switching
     Per-port overcurrent protection
     TT think time 32 FS bits
     Port indicators
   bPwrOn2PwrGood        8 * 2 milli seconds
   bHubContrCurrent    100 milli Ampere
   DeviceRemovable    0x03 0xc0
   PortPwrCtrlMask    0xff 0xa2
  Hub Port Status:
    Port 1: 0000.0503 highspeed power enable connect
    Port 2: 0000.0503 highspeed power enable connect
    Port 3: 0000.0503 highspeed power enable connect
    Port 4: 0000.0503 highspeed power enable connect
    Port 5: 0000.0503 highspeed power enable connect
    Port 6: 0000.0503 highspeed power enable connect
    Port 7: 0000.0503 highspeed power enable connect
    Port 8: 0000.0503 highspeed power enable connect
    Port 9: 0000.0503 highspeed power enable connect
    Port 10: 0000.0503 highspeed power enable connect
    Port 11: 0000.0503 highspeed power enable connect
    Port 12: 0000.0503 highspeed power enable connect
    Port 13: 0000.0503 highspeed power enable connect
Device Qualifier (for other device speed):
   bLength                10
   bDescriptorType         6
   bcdUSB               2.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0 Unused
   bDeviceProtocol         0 Full speed (or root) hub
   bMaxPacketSize0        64
   bNumConfigurations      1
Device Status:     0x0001
   Self Powered

Bus 001 Device 008: ID 2c42:16f8
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x16f8
   bcdDevice           80.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3 88635600168801
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           18
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
Device Status:     0x0000
   (Bus Powered)

Bus 001 Device 016: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           88.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 015: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           87.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 014: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           86.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 013: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           85.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 012: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           84.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 011: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           83.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 010: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           82.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 009: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           81.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 020: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           8c.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 019: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           8b.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 018: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           8a.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

Bus 001 Device 017: ID 2c42:1636
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x2c42
   idProduct          0x1636
   bcdDevice           89.00
   iManufacturer           1 FINTEK
   iProduct                2 USB TO UART BRIDGE
   iSerial                 3
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass         0 (Defined at Interface level)
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval              10
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0080  1x 128 bytes
         bInterval               0
Device Status:     0x0002
   (Bus Powered)
   Remote Wakeup Enabled

>>> Can you read back the enable state of each port?
>>
>> DTR pin of the F81534A series are strap pin on power on, when IC detect
>> it pulled to low, the UART device can't enable and DTR change to input
>> mode.
> 
> Can you read back the state of the DTR pin when pulled low? So that you
> can determine which UARTs have been disabled in hardware?

If the DTR pin pulled low, the UART device always can't be enabled.
We can read the port en/disabled infomation in GPIO device only.

> 
> I'm leaning more towards not exporting this as a gpio device at all.
> It's clear from the datasheet (and your implementation) that these pins
> are supposed to be used with your own tranceivers. You can start with
> only supporting RS232, and then we can discuss an interface for
> switching modes later.

OK, I'll send patch v3 only with UART & device enable function after
clarify all issues.

>>>
>>
>> Our device VID/PID is changeable, but we assume don't change it.
> 
> Ok, then I guess we must assume that the MODE pins are only connected to
> your tranceivers and hardcoding the various configurations is fine.

Agree

-- 
With Best Regards,
Peter Hong
