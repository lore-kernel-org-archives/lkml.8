Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01813C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09C22177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH0Qvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:51:55 -0400
Received: from mout.perfora.net ([74.208.4.196]:47847 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgH0Qvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:51:54 -0400
Received: from [192.168.0.166] ([47.134.10.147]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MZBIA-1jumdK33kq-00KuTw;
 Thu, 27 Aug 2020 18:46:51 +0200
To:     linux-kernel@vger.kernel.org
From:   Jody Bruchon <jody@jodybruchon.com>
Subject: Help with Realtek RTL8156 USB 2.5G NIC not working and cdc_ncm syslog
 flooding
Cc:     jody@jodybruchon.com
Message-ID: <dc255e58-b2dd-6b22-4e24-7a3591c64e27@jodybruchon.com>
Date:   Thu, 27 Aug 2020 12:46:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:U0cuyF1HpNeU4PDANLiwFqT1duKKd3vzkWBI8VTMGGEBVhgNKXm
 ldKv78XywyOJi2Ub4VOEhtytW3pgmv76W2P964yjcyEGoWoePal+F6vvr6cfrSoecJUyHDQ
 oIwqX6Vj9UNNO5EWKDl18cdHaR0zRBcbm+0M7QlDdnPHvzOKi8FvJQuJm8ujw7BkN3Wfwvh
 z8laa2kPH9HBSwwyDwLhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8Al786Tnlk=:FM8UlyqPmvM6tNLODdMPl/
 vDve9ZHXRECUO08AVw/F9lP63Xzg3p7PjInOov1npYei3cDK+xP4pg1Tq8f78LEhVFK7LyFPT
 zxv+FKQmvGaOgyk4+Z8Edes46/LxKPQX7XFXBHwLsGBK09ZKLW7eTWfF5mxezMNlhAV+7nEhg
 3xGfGuSrkekvS/f1lorpsYd62vn4FQQ1tWBabGkX+E/qm32x2rP4LApOXWPAZChJvlxfxjceI
 6uHgr6ZatzxPS6N2kj83+6ldffywlf4TS37EugQ0v4dG3csHo4C2bkA3JTSr4u4mE/2ZgmJzz
 28Z917YJlk8zweHvfGSGxRK9B9wKECWIusfmP6OQuDCEAd/TnJQyS7KTpKht4fLTE1gnPu1db
 0CpDV9U7tccjUvJlIh9ny1O2nBm1x6hysbTDTJPjV37aN1JpfPh8HZkIQjTe+jn3HBAo0CpaJ
 phZxcq5SPzVPlX1H/IdWzIPl4lSLi1KZxwedPrcclvHTgI37o14s5zZs+JbBg+9LIwDngWRKz
 VKEl2xSCHXZM1hP9fXnobxOfT29om5ngvpHw+gNU9sf0r+WoUpnqUPTWpjyGaq15WPGYuhuO8
 ESyUCRrc2ieVpTcBuDlg3wRoxlKFLj6088wIvSrVpzabzs6qXbgy368sVE7uTGj+lF1pB2ZlR
 ctzlIiOC9MP3fr7vXuHBj6XQU8dp4sO4HOoLfFzeANmhuXtNGjm69YftgL4YQ90AmSj2wFlfT
 dvqZD1SAe4Gz5yhrxZics2DlwsPA1+wwB5ubi2ExkLb1KGiAqevPeWifHsoesJjkEvaLAkcB/
 GdZVKagcTuUSsCOEhgIfaVxPc96+EYU0YbNKsiTFhTHCDp/LhX5rYY9tsOqbjEDw06ZGl2R
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: please CC me in replies since I'm not subscribed to LKML.

I have a RTL8156-based USB 3.0 to 2.5G NBASE-T ethernet adapter made by 
Plugable and I'm using a recently compiled Linux 5.8.1 (I checked 
changelogs up to the current 5.8.5 release and didn't see anything 
relevant mentioned). It's supposed to work with the cdc_ncm driver, but 
the sheer amount of syslog spam by cdc_ncm regardless of link state is 
astonishing, and the adapter behaves erratically as well. This is the 
log spam from one single second with the interface up but no network 
cable attached:

[173944.031631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.063629] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.095630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.127628] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.159630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.191629] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.223631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.255631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.287630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.319630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.351627] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.383633] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.415627] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.447627] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.479631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.511631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.543630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.575629] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.607628] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.639628] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.671630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.703629] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.735631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.767631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.799622] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.831629] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.863630] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.895634] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.927631] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.959633] cdc_ncm 2-4:2.0 usb0: network connection: disconnected
[173944.991628] cdc_ncm 2-4:2.0 usb0: network connection: disconnected

It's just as bad when the link is up:

[174451.007591] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.039592] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.071637] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.103630] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.135630] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.167630] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.199631] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.231622] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.263634] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.295631] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.327629] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.359628] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.391631] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.423629] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.455631] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.487630] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.519632] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.551629] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.583629] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.615634] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.647631] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.679628] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.711632] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.743631] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.775630] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.807627] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.839630] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.871628] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.903631] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.935628] cdc_ncm 2-4:2.0 usb0: network connection: connected
[174451.967629] cdc_ncm 2-4:2.0 usb0: 2500 mbit/s downlink 2500 mbit/s 
uplink
[174451.999633] cdc_ncm 2-4:2.0 usb0: network connection: connected

This is what the lsusb -v output looks like for the device:

Bus 002 Device 002: ID 0bda:8156 Realtek Semiconductor Corp.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               3.20
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         9
   idVendor           0x0bda Realtek Semiconductor Corp.
   idProduct          0x8156
   bcdDevice           30.00
   iManufacturer           1 Realtek
   iProduct                2 USB 10/100/1G/2.5G LAN
   iSerial                 6 000000001
   bNumConfigurations      3
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           57
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              128mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass    255 Vendor Specific Subclass
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0400  1x 1024 bytes
         bInterval               0
         bMaxBurst               4
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0400  1x 1024 bytes
         bInterval               0
         bMaxBurst               4
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0002  1x 2 bytes
         bInterval              11
         bMaxBurst               1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          104
     bNumInterfaces          2
     bConfigurationValue     2
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              128mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         2 Communications
       bInterfaceSubClass     13
       bInterfaceProtocol      0
       iInterface              5 CDC Communications Control
       CDC Header:
         bcdCDC               1.10
       CDC Union:
         bMasterInterface        0
         bSlaveInterface         1
       CDC Ethernet:
         iMacAddress                      3 8CAE4CDD0417
         bmEthernetStatistics    0x0031500f
         wMaxSegmentSize               1518
         wNumberMCFilters            0x8000
         bNumberPowerFilters              0
       UNRECOGNIZED CDC:  06 24 1a 00 01 2b
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               8
         bMaxBurst               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass        10 CDC Data
       bInterfaceSubClass      0 Unused
       bInterfaceProtocol      1
       iInterface              0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass        10 CDC Data
       bInterfaceSubClass      0 Unused
       bInterfaceProtocol      1
       iInterface              4 Ethernet Data
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0400  1x 1024 bytes
         bInterval               0
         bMaxBurst               4
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0400  1x 1024 bytes
         bInterval               0
         bMaxBurst               4
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           98
     bNumInterfaces          2
     bConfigurationValue     3
     iConfiguration          0
     bmAttributes         0xa0
       (Bus Powered)
       Remote Wakeup
     MaxPower              128mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         2 Communications
       bInterfaceSubClass      6 Ethernet Networking
       bInterfaceProtocol      0
       iInterface              5 CDC Communications Control
       CDC Header:
         bcdCDC               1.10
       CDC Union:
         bMasterInterface        0
         bSlaveInterface         1
       CDC Ethernet:
         iMacAddress                      3 8CAE4CDD0417
         bmEthernetStatistics    0x0031500f
         wMaxSegmentSize               1518
         wNumberMCFilters            0x8000
         bNumberPowerFilters              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               8
         bMaxBurst               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass        10 CDC Data
       bInterfaceSubClass      0 Unused
       bInterfaceProtocol      0
       iInterface              0
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass        10 CDC Data
       bInterfaceSubClass      0 Unused
       bInterfaceProtocol      0
       iInterface              4 Ethernet Data
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0400  1x 1024 bytes
         bInterval               0
         bMaxBurst               4
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0400  1x 1024 bytes
         bInterval               0
         bMaxBurst               4
Device Status:     0x001c
   (Bus Powered)
   Test Mode

If I do this, then it switches from 'usb0' to 'eth1':

/sys/devices/pci0000:00/0000:00:15.0/usb2/2-4 # echo 3 > bConfigurationValue

Regardless of whether I try to use it as eth1 or usb0, it does not 
communicate. I have turned off USB autosuspend for the device, but with 
no change:

/sys/devices/pci0000:00/0000:00:15.0/usb2/2-4 # cat power/control
on

At this point, I don't know what else to try. My understanding is that 
cdc_ncm supports this device and the Realtek-provided driver shouldn't 
be needed anymore. The r8152 driver already in the kernel doesn't pick 
up this device.

Any help would be greatly appreciated.

- Jody Bruchon
