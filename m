Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0186FC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27DE20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDFIXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:23:42 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:53369 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:23:42 -0400
Received: from muedsl-82-207-238-172.citykom.de ([82.207.238.172] helo=[192.168.178.139])
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
        id 1jLN2M-0002W3-Vs; Mon, 06 Apr 2020 10:23:19 +0200
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     xiaoyao.li@intel.com, philipp.eppelt@kernkonzept.com, bp@alien8.de,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, nivedita@alum.mit.edu,
        pbonzini@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
 <20200403174403.306363-2-benjamin.lamowski@kernkonzept.com>
 <20200403180149.GH2701@linux.intel.com>
From:   Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Autocrypt: addr=benjamin.lamowski@kernkonzept.com; prefer-encrypt=mutual;
 keydata=
 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
 eyh8xxTGorC9MpIYRke0DaE=
Subject: Re: [PATCH 1/1] x86/split_lock: check split lock feature on
 initialization
Message-ID: <f072e3e0-48b0-346e-b383-3e802069fc3a@kernkonzept.com>
Date:   Mon, 6 Apr 2020 10:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403180149.GH2701@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> Calling split_lock_verify_msr() with X86_FEATURE_SPLIT_LOCK_DETECT=0 is
> intentional, the idea is to ensure SLD is disabled on all CPUs, e.g. in the
> unlikely scenario that BIOS enabled SLD.

I was aware of the intention, but I still don't understand under which
scenario this could be set by the BIOS although the earlier feature
detection has failed, i.e. shouldn't the feature have been detected in
all cases where SLD can actually be disabled? If so, checking for
availability first instead of catching a #GP(0) if it is not implemented
seems to be the cleaner solution.


> The first rdmsrl_safe() should short circuit split_lock_verify_msr() if
> the RDMSR faults, i.e. it might fault, but it shouldn't WARN.  Are you
> seeing issues or was this found via code inspection?

We stumbled across this issue because the x86 version of our VMM is not
yet ready for production and when accessing unimplemented MSRs would
simply return 0 and issue a warning. This is of course a deviation from
rdmsr as defined in the SDM and the pieces are ours to keep, it will be
changed to generate a #GP(0) once the last missing MSRs are emulated
properly.

-- 
Benjamin Lamowski - +49.351.41883235
Operating Systems Engineer - https://www.kernkonzept.com

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Geschäftsführer: Dr.-Ing. Michael Hohmuth
