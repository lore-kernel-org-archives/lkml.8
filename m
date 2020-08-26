Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC0BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E132075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHZBIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:08:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:45708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHZBIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:08:24 -0400
IronPort-SDR: lhhj6HIH7QmHc0oZmcuS5EMjljIfT411ChX5Bny18NamJAxRl6AHIfzKgu8n0KXE+W1dP7tGb+
 buyAcqMGLkzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="156207646"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="156207646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 17:59:20 -0700
IronPort-SDR: MZqZoLMfNzPxPGFz52Zc703BZo+h3Wr4O3u79OfpRl1v96oaLbsyX/J2/zugAyzoW1p2I1oWU6
 p6VAoW0I6OSg==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="443833246"
Received: from yungchua-mobl.ccr.corp.intel.com (HELO [10.252.187.42]) ([10.252.187.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 17:59:16 -0700
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
From:   Bard liao <yung-chuan.liao@linux.intel.com>
Message-ID: <8bd9593d-c81d-d01b-ee93-b15de2fe7f1f@linux.intel.com>
Date:   Wed, 26 Aug 2020 08:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/2020 1:16 AM, Pierre-Louis Bossart wrote:
> The SoundWire 1.1 specification only allowed for reads and writes of
> bytes. The SoundWire 1.2 specification adds a new capability to
> transfer "Multi-Byte Quantities" (MBQ) across the bus. The transfers
> still happens one-byte-at-a-time, but the update is atomic.
>
> For example when writing a 16-bit volume, the first byte transferred
> is only taken into account when the second byte is successfully
> transferred.
>
> The mechanism is symmetrical for read and writes:
> - On a read, the address of the last byte to be read is modified by
> setting the MBQ bit
> - On a write, the address of all but the last byte to be written are
> modified by setting the MBQ bit. The address for the last byte relies
> on the MBQ bit being cleared.
>
> The current definitions for MBQ-based controls in the SDCA draft
> standard are limited to 16 bits for volumes, so for now this is the
> only supported format. An update will be provided if and when support
> for 24-bit and 32-bit values is specified by the SDCA standard.
>
> One possible objection is that this code could have been handled with
> regmap-sdw.c. However this is a new spec addition not handled by every
> SoundWire 1.1 and non-SDCA device, so there's no reason to load code
> that will never be used.
>
> Also in practice it's extremely unlikely that CONFIG_REGMAP would not
> be selected with CONFIG_REGMAP_MBQ selected. However there's no
> functional dependency between the two modules so they can be selected
> separately.
>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>


