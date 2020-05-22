Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD6020748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEVDVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:21:16 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:57734 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVDVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:21:16 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 04M3L1OB004202; Fri, 22 May 2020 12:21:01 +0900
X-Iguazu-Qid: 34trJzXMWLTWgibhZ2
X-Iguazu-QSIG: v=2; s=0; t=1590117661; q=34trJzXMWLTWgibhZ2; m=wrPARnLkF2hEskCsXYqcABH37zzS5Viw1KXT40c9bv0=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1510) id 04M3KxZS038811;
        Fri, 22 May 2020 12:20:59 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 04M3KwbJ004263;
        Fri, 22 May 2020 12:20:58 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 04M3KwHO019853;
        Fri, 22 May 2020 12:20:58 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     "Brown\, Aaron F" <aaron.f.brown@intel.com>
Cc:     "Kirsher\, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "daniel.sangorrin\@toshiba.co.jp" <daniel.sangorrin@toshiba.co.jp>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "intel-wired-lan\@lists.osuosl.org" 
        <intel-wired-lan@lists.osuosl.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] e1000e: Relax condition to trigger reset for ME workaround
References: <20200515043127.3882162-1-punit1.agrawal@toshiba.co.jp>
        <DM6PR11MB2890F48ACD9A4ECF9181A819BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
Date:   Fri, 22 May 2020 12:20:57 +0900
In-Reply-To: <DM6PR11MB2890F48ACD9A4ECF9181A819BCB70@DM6PR11MB2890.namprd11.prod.outlook.com>
        (Aaron F. Brown's message of "Thu, 21 May 2020 07:56:12 +0000")
X-TSB-HOP: ON
Message-ID: <87367sac4m.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
>> Behalf Of Punit Agrawal
>> Sent: Thursday, May 14, 2020 9:31 PM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Cc: daniel.sangorrin@toshiba.co.jp; Punit Agrawal
>> <punit1.agrawal@toshiba.co.jp>; Alexander Duyck
>> <alexander.h.duyck@linux.intel.com>; David S. Miller <davem@davemloft.net>;
>> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH] e1000e: Relax condition to trigger reset for ME workaround
>> 
>> It's an error if the value of the RX/TX tail descriptor does not match
>> what was written. The error condition is true regardless the duration
>> of the interference from ME. But the driver only performs the reset if
>> E1000_ICH_FWSM_PCIM2PCI_COUNT (2000) iterations of 50us delay have
>> transpired. The extra condition can lead to inconsistency between the
>> state of hardware as expected by the driver.
>> 
>> Fix this by dropping the check for number of delay iterations.
>> 
>> While at it, also make __ew32_prepare() static as it's not used
>> anywhere else.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: intel-wired-lan@lists.osuosl.org
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> Hi Jeff,
>> 
>> If there are no further comments please consider merging the patch.
>> 
>> Also, should it be marked for backport to stable?
>> 
>> Thanks,
>> Punit
>> 
>> RFC[0] -> v1:
>> * Dropped return value for __ew32_prepare() as it's not used
>> * Made __ew32_prepare() static
>> * Added tags
>> 
>> [0] https://lkml.org/lkml/2020/5/12/20
>> 
>>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 -
>>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++-------
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>> 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Thanks for taking the patch for a spin.

Jeff, let me know if you're okay to apply the tag or want me to send a
new version.

Thanks,
Punit

