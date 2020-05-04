Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12AFC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F3920746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEDFqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 01:46:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:45500 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgEDFqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:46:20 -0400
IronPort-SDR: lw3kJGtvlqQRXSPboZblne3yJceKbiUpsCarMewnOSmX3ZL5baGiU3UQ7XwgvOZyyXn5NZm9aV
 J4bwAT2QwYdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:46:20 -0700
IronPort-SDR: TXvKDZUMGElupqRIHsEDPTP3SAOJqu/4Te3id4ZK9HdrJQLpbjoszE0PQZf2gLedKfVr3+DDuR
 77c9leqmWWZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,350,1583222400"; 
   d="scan'208";a="433989799"
Received: from mylly.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2020 22:46:16 -0700
Subject: Re: [PATCH] i2c: fix missing pm_runtime_put_sync in i2c_device_probe
To:     Wolfram Sang <wsa@the-dreams.de>,
        Alain Volmat <alain.volmat@st.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
References: <1588261401-11914-1-git-send-email-alain.volmat@st.com>
 <20200430163503.GA15047@ninjato>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <0a0b4ad7-3c5a-075d-1484-1e95b976ff48@linux.intel.com>
Date:   Mon, 4 May 2020 08:46:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430163503.GA15047@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 7:35 PM, Wolfram Sang wrote:
> On Thu, Apr 30, 2020 at 05:43:21PM +0200, Alain Volmat wrote:
>> In case of the I2C client exposes the flag I2C_CLIENT_HOST_NOTIFY,
>> pm_runtime_get_sync is called in order to always keep active the
>> adapter. However later on, pm_runtime_put_sync is never called
>> within the function in case of an error. This commit add this
>> error handling.
>>
>> Fixes: 72bfcee11cf8 ("i2c: Prevent runtime suspend of adapter when Host Notify is required")
> 
Right, I was blind to see this.

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
