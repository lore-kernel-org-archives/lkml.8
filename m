Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D6C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57112222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgDPQv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:51:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:5528 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgDPQvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:51:20 -0400
IronPort-SDR: R2IdWx56wEWraMyrXGXBFY3//qj3eFCKBlmSA7nHI9BVEcpNsGuQpIOdHFnaVlAf3/4q/wUJCN
 kZ4dfxX0uV8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:51:18 -0700
IronPort-SDR: ak+3S0j6sDqOFGFT/3cgjGIRLkm2WdcJEc+2FtgpItsOgDIUFmG93ls1QG9XOaLL5EvmqOvril
 h6opWpXGFb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="278060192"
Received: from ernestom-mobl.amr.corp.intel.com (HELO [10.251.128.102]) ([10.251.128.102])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 09:51:17 -0700
Subject: Re: linux-next: Fixes tags needs some work in the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20200416094111.3f37623f@canb.auug.org.au>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <14195fe3-14b2-eb80-3409-f7ca817b95f5@linux.intel.com>
Date:   Thu, 16 Apr 2020 07:55:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416094111.3f37623f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/20 6:41 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    101001652ee7 ("ASoC: SOF: topology: fix: handle DAI widget connections properly with multiple CPU DAI's")
> 
> Fixes tag
> 
>    Fixes: 4a7e26a4d833 ("ASoC: SOF: topology: connect dai widget to all
> 
> has these problem(s):
> 
>    - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: c59aca98c912 ("ASoC: SOF: topology: connect dai widget to all cpu-dais")
> 
> Also, please do not split Fixes tags over more than one line and keep
> all the commit message tags together at the end of the commit message.

Sorry about that. I always run checkpatch.pl and didn't see an error

../patches/20200415/0001-ASoC-SOF-topology-fix-handle-DAI-widget-connections-.patch
-----------------------------------------------------------------------------------
total: 0 errors, 0 warnings, 0 checks, 49 lines checked

My theory is that the SHA1 check is fooled by our use of worktrees. This 
SHA1 does exist but on another SOF development branch. Is there a way to 
restrict the checks only to the base upstream branch, e.g. Mark's 
for-5.8 branch?

If not, we probably need to make sure we have a separate directory just 
for upstreaming, to avoid any pollution from SOF branches?

Thanks
-Pierre
