Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97611C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2AC2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHXKhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:37:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:16332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgHXKgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:36:09 -0400
IronPort-SDR: XJDUzDJFnIlLLFCVFikzgo9lIyvN/4Ewst2p/epp9WTj7OFcrnTZ8+ZwcTMmwKHGuijBOl2chT
 JijkPNgpMKBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="217408727"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="217408727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 03:36:08 -0700
IronPort-SDR: osPngUDB3K/p+N6QSIx9oQkxtBxKiK17qxip9wQLUxEhfbD9F7NUITjA95AHvGSomG6cd7PlGl
 RA+MQ7hIQkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="298659142"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2020 03:36:08 -0700
Received: from [10.255.145.126] (vramuthx-MOBL1.gar.corp.intel.com [10.255.145.126])
        by linux.intel.com (Postfix) with ESMTP id 4F27D5805EB;
        Mon, 24 Aug 2020 03:36:06 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200817070009.4631-1-krzk@kernel.org>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <2879914d-7ad6-4d98-8b9c-a7646719f766@linux.intel.com>
Date:   Mon, 24 Aug 2020 18:36:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Thank you for the patches and optimized the code as well.
  I have applied your patches and tested, it's working fine
  with few minor changes as per Intel's LGM board.

  can I send the patches along with patches or we need to wait until
  your patch get merge?

  Please suggest to me go further, Thanks!

On 17/8/2020 2:59 pm, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1:
> 1. Mutex unlock fix in patch 8/13.
> 
> Best regards,
> Krzysztof
> 
