Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E99C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C59824673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTQB2nh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAWLqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:46:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28096 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729276AbgAWLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579779963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TINMfTTXVCZiZEAT1DE8Sul0vKADWHazf6vsI5AdTmI=;
        b=CTQB2nh9Hac6trZpUpaX8oLTVQVGuCGKtEwYStyQH56z2FB3RpKNrt3U7WZwYD8PiwVdNo
        yiDraA2wDoaFKkq47MrHdx4WM1pODHsGlflKIL+727fvML6zaoiI3Y0rZyZyC8UDcy6XuS
        LB30GMo8a6M1Z4AGx5yrSl1cDAn9vDE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-gAxVici-M7i2NKSGApJkQg-1; Thu, 23 Jan 2020 06:46:02 -0500
X-MC-Unique: gAxVici-M7i2NKSGApJkQg-1
Received: by mail-wm1-f71.google.com with SMTP id q26so471439wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TINMfTTXVCZiZEAT1DE8Sul0vKADWHazf6vsI5AdTmI=;
        b=Ba7EZmUTYk5aMj44muS8wUldLpkm0wCFa9uDH2bHX6Jx4sxlzZtoXwHieTowvZo84/
         jTfPlTiu9KB37u91jr9U5u5laQXCRBQqV0gTlYe/i7iOamIy7fOT8uShmMhcX0MMRqjI
         h1lfbBkKRzjCdysXV4VD/yra0o0O0bvr8Ce5vwWg9USckxwBeyAOvBNK+FIff5W+fjJU
         kW8zpbzDrkYeOXOiz4ZvqEhFTSnAxnYR87ldJpzicJew1fw9NlaM00Kz8S8y4pzpgG26
         YttWtghxgZb0UrmsSEVA1lnufMPnYQ5p2OyOqjbZ3i9kTxrkGstU7PJ31CKJKE5L/Gm1
         OyfQ==
X-Gm-Message-State: APjAAAUivKF3oXMXw5ND9e/mlLLLMS/v6wWCN/74001CShLELpn8nmj0
        KcLV/IiPwF6N2aDDotKZ1dblQCzfrQdQd/tJ6YxIUrjwmomMy6jhTDmZRc6uHpYyEU87sdx8xGn
        QizqbPceUfOHy4AB8xFJlNLw+
X-Received: by 2002:a1c:f218:: with SMTP id s24mr3979411wmc.128.1579779960889;
        Thu, 23 Jan 2020 03:46:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVnwCiCN3NOxdGWRBJAtDImJ6Nrbwlr+9vtghF6EhH/gepoqxynALefGm704TwHdxrrc4Fsg==
X-Received: by 2002:a1c:f218:: with SMTP id s24mr3979384wmc.128.1579779960668;
        Thu, 23 Jan 2020 03:46:00 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id z3sm2609010wrs.94.2020.01.23.03.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 03:46:00 -0800 (PST)
Subject: Re: [RFC v5 11/57] objtool: Abstract alternative special case
 handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-12-jthierry@redhat.com>
 <20200120145401.GB14897@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <b5066ff8-9bfc-635f-a4fd-2ed3e20271b6@redhat.com>
Date:   Thu, 23 Jan 2020 11:45:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120145401.GB14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/20 2:54 PM, Peter Zijlstra wrote:
> On Thu, Jan 09, 2020 at 04:02:14PM +0000, Julien Thierry wrote:
>> diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
>> new file mode 100644
>> index 000000000000..6dba31f419d0
>> --- /dev/null
>> +++ b/tools/objtool/arch/x86/arch_special.c
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +#include "../../special.h"
>> +#include "../../builtin.h"
>> +
>> +void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
>> +{
>> +	/*
>> +	 * If UACCESS validation is enabled; force that alternative;
>> +	 * otherwise force it the other way.
>> +	 *
>> +	 * What we want to avoid is having both the original and the
>> +	 * alternative code flow at the same time, in that case we can
>> +	 * find paths that see the STAC but take the NOP instead of
>> +	 * CLAC and the other way around.
>> +	 */
> 
> That comment ^,
> 
>> +	switch (feature) {
>> +	case X86_FEATURE_SMAP:
> 
> goes here >
> 

Good catch, I'll fix that.

>> +		if (uaccess)
>> +			alt->skip_orig = true;
>> +		else
>> +			alt->skip_alt = true;
>> +		break;
> 
>> +	case X86_FEATURE_POPCNT:
>> +		/*
>> +		 * It has been requested that we don't validate the !POPCNT
>> +		 * feature path which is a "very very small percentage of
>> +		 * machines".
>> +		 */
>> +		alt->skip_orig = true;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
> 

Thanks,

-- 
Julien Thierry

