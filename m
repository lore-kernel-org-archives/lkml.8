Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84EC20702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHUABV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:01:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:1502 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgHUABS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:01:18 -0400
IronPort-SDR: XTU6GajE9DhcV7cY5W7SU+rxH7hxjYDKCDeGlWd75bMalXtfcej+9XWiawC3p5Qz2TFuojKADH
 RXZrQoXVRfIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240248547"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="240248547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 17:01:17 -0700
IronPort-SDR: aIrQRzVbnSy4fGnpPk3fTLjyEOg2meO3TrdwzhaKiqR4HWbjeg6fyBA7R/6ux3NtGV44fSkOJm
 OZUJHtGddR6w==
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="321073087"
Received: from ralvare1-mobl1.amr.corp.intel.com (HELO [10.212.254.51]) ([10.212.254.51])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 17:01:16 -0700
Subject: Re: linux-next: build warnings after merge of the sound-asoc-fixes
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard liao <yung-chuan.liao@linux.intel.com>
References: <20200821093901.4257afdc@canb.auug.org.au>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a8b47ba9-7b45-bef1-08a2-820fe48c4cc4@linux.intel.com>
Date:   Thu, 20 Aug 2020 19:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821093901.4257afdc@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/20 6:39 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc-fixes tree, today's linux-next build
> (x86_64 allmodconfig) produced these warnings:
> 
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_acpi_scan from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_probe from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_process_wakeen_event from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_startup from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_exit from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_enable_irq from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> WARNING: modpost: module snd-sof-intel-hda-common uses symbol sdw_intel_thread from namespace SOUNDWIRE_INTEL_INIT, but does not import it.
> 
> Presumably introduced by commit
> 
>    82cb71d68c22 ("ASoC: SOF: Intel: add build support for SoundWire")

There is a companion patch 1eb629363aa35 ("ASoC: SOF: Intel: hda: import 
SOUNDWIRE_INIT namespace") that does the import, not sure what causes 
the warning?



