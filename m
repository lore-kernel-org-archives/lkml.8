Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D193C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F32C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgC3LKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:10:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:37395 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgC3LKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:10:39 -0400
IronPort-SDR: AMfUC+Q5q7GHPpL4c1UWKU1GOwA6Tj81hPj0qPBr1ZZPLv44Jse2w++Rs+I2ZJ8RTmWrSYcKyO
 VWA6Y4X4Gtug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 04:10:38 -0700
IronPort-SDR: bppOdF40OdLoDwKSFJtP2VGF7LktLALGDFxSycraXvH9JdU6WwwdaBRjeVDMPnp3Lp+aeivARV
 JglWs2pepCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="359146234"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.6.130]) ([10.213.6.130])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2020 04:10:35 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mark Brown <broonie@kernel.org>, kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <20200330102356.GA16588@light.dominikbrodowski.net>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <43c098c9-005e-b9f4-2132-ed6e4a65feee@intel.com>
Date:   Mon, 30 Mar 2020 13:10:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330102356.GA16588@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-30 12:23, Dominik Brodowski wrote:
> 
> Seems this patch didn't make it into v5.6 (and neither did the other ones
> you sent relating to the "dummy" components). Can these patches therefore be
> marked for stable, please?
> 
> Thanks,
> 	Dominik
> 

While one of the series was accepted and merged, there is a delay caused 
by Google/ SOF folks in merging the second one.

Idk why rt286 aka "broadwell" machine board patch has not been merged 
yet. It's not like we have to merge all (rt5650 + rt5650 + rt286) 
patches at once. Google guys can keep verifying Buddy or whatnot while 
guys with Dell XPS can enjoy smooth audio experience.

Sneak peak Dominik: there will be more suspend/ resume patches coming 
soon ^)^ reducing power consumption in low-power state which honestly 
you might not even notice, but hey why not :P

Czarek
