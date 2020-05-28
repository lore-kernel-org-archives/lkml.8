Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E96C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D000206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436657AbgE1VhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:37:06 -0400
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:33090 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436603AbgE1VhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:37:02 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from 88-109-182-220.dynamic.dsl.as9105.com ([88.109.182.220]:60864 helo=[192.168.1.219])
        by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1jeQCt-000ve8-Jk (Exim 4.92.3)
        (return-path <amc96@hermes.cam.ac.uk>); Thu, 28 May 2020 22:36:55 +0100
Subject: Re: [PATCH 1/6] x86/entry: Introduce local_db_{save,restore}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, daniel.thompson@linaro.org
References: <20200528201937.038455891@infradead.org>
 <20200528202328.418625592@infradead.org>
 <17e097f5-f92c-bd7e-fb1d-ee08c4169dbe@citrix.com>
 <20200528211550.GR2483@worktop.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <8831da5e-b65d-a4e8-2a3b-ac46282f4591@citrix.com>
Date:   Thu, 28 May 2020 22:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528211550.GR2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2020 22:15, Peter Zijlstra wrote:
> On Thu, May 28, 2020 at 09:52:30PM +0100, Andrew Cooper wrote:
>> On 28/05/2020 21:19, Peter Zijlstra wrote:
>>> --- a/arch/x86/include/asm/debugreg.h
>>> +++ b/arch/x86/include/asm/debugreg.h
>>> @@ -113,6 +113,31 @@ static inline void debug_stack_usage_inc
>>>  static inline void debug_stack_usage_dec(void) { }
>>>  #endif /* X86_64 */
>>>  
>>> +static __always_inline void local_db_save(unsigned long *dr7)
>>> +{
>>> +	get_debugreg(*dr7, 7);
>>> +	if (*dr7)
>>> +		set_debugreg(0, 7);
>> %dr7 has an architecturally stuck bit in it.
>>
>> You want *dr7 != 0x400 to avoid writing 0 unconditionally.
> Do we have to have that bit set when writing it? Otherwise I might
> actually prefer masking it out.

Not currently.  I guess it depends on how likely %dr7 is to gain an
inverted polarity bit like %dr6 did.

~Andrew
