Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED27FC18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C903D2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgDBHtB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:49:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:4785 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgDBHtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:49:00 -0400
IronPort-SDR: bRfx4nvFkBkTWlRyuZpNn31ylIAG/Cb9kg5DjNLxKFesEv8/J2JS3pIbICOh8Ptmi+FVeiIUBx
 l2XOvPR5zbPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 00:49:00 -0700
IronPort-SDR: 4v+838BTvv5dSQJgqNNoDW1HyJDXWviBpViFsaEAdbPvFCcyfksE/qNkxfGGJhuEHsPThYg4yT
 g8ByHB4Aatuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="240752819"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2020 00:49:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Apr 2020 00:49:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Apr 2020 00:48:59 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Apr 2020 00:48:59 -0700
Received: from shsmsx108.ccr.corp.intel.com ([169.254.8.7]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Thu, 2 Apr 2020 15:47:51 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: OOB access on ACPI processor thermal device via sysfs write
Thread-Topic: OOB access on ACPI processor thermal device via sysfs write
Thread-Index: AQHWCMInBN92pltZsEqESgUJHFcCaKhlcwvw
Date:   Thu, 2 Apr 2020 07:47:50 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926377CEB399@SHSMSX108.ccr.corp.intel.com>
References: <s5h5zeiwd01.wl-tiwai@suse.de>
In-Reply-To: <s5h5zeiwd01.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Viresh.

Yes, I've received it.

To me, there is not a hard rule that the cooling device max_state must be static.
We should be able to detect the max_state change and reset the stats table when necessary.

I just finished a prototype patch to do so, and will paste it later.

Thanks,
rui

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Thursday, April 02, 2020 3:42 PM
To: linux-acpi@vger.kernel.org
Cc: Zhang, Rui <rui.zhang@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; linux-kernel@vger.kernel.org
Subject: OOB access on ACPI processor thermal device via sysfs write
Importance: High

[ My post yesterday didn't seem go out properly, so I'm resending with
  a different MTA setup; sorry if you already received it ]

Hi,

after my recent patch [*], I started looking at the root cause more closely, and found that it's a side-effect of the device initialization order between acpi_processor_driver and cpufreq.
  [*] https://lore.kernel.org/linux-pm/20200330140859.12535-1-tiwai@suse.de/

In short:
  
- acpi_processor_driver_init() is called fairly early boot stage, and
  it registers a thermal device for each CPU. 

- A thermal device allocates a statistics table with the fixed size
  determined by get_max_state() ops call at its probe time.
  (The table entry is updated at each time a write to thermal state
  file happens.)

  For ACPI, processor_get_max_state() is called and it invokes
  acpi_processor_max_state() that calculates the max states depending
  on cpufreq, cpufreq_get_max_state().

  cpufreq_get_max_state() returns 0 at this stage because no cpufreq
  driver is available.  So the table size is set to 1.

- Later on, after cpufreq get initialized, the following sysfs write
  causes an OOB access and corrupts memory (eventually Oops):
    # echo 3 > /sys/class/thermal/cooling_device0/cur_state

  The reason is that now processor_get_max_state() returns 3 as
  cpufreq became available.  So the thermal driver believes as if it
  were a valid value, and updates the table accordingly although it
  overflows.


My patch above detects and avoids such an overflow, but it's no real fix for the cause.  The proper fix needs either the shuffling of the device creation order or some automatic resize of statistics table.

Do you guys have any suggestion how to solve it?

FWIW, I could reproduce the problem locally on my laptop with 5.6 kernel, and I believe this can be seen generically on most of machines.


thanks,

Takashi
