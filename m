Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576ECC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DF120637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpkOfKIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCERFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:05:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42437 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCERFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:05:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id v11so5986658wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KY/+AA/X+vmMaT8JmKrZPvVhnyW63l/Qn9k0Ear+Z80=;
        b=qpkOfKIPeUauBeKa+GcXonlKmWrtkMDOAuQp5D+IGn34l2m7WwnHskvCWPLJsKvwxv
         8Zr/wfNCm5LiJsf83DmTJTZv6H0M34mDgZ8Z+jXNXUAw6TpZgKuWBy/Xy+lHKNj1LVec
         ARNSOFH7gij5XNzSjUNEyOg0Oq5BikMHy+NPk9pooq88/L+2oQeB+UpJ31EUwVNuVi6n
         zPrSyvtgaEdEFjHgGwWy6G2a+uz7Dz6QbDn3hjv3f8M/KA9OuTLUFRqKRxbHExVrlg69
         RiAFm0VQvtf1r2uuVTKB2JXVWRWchF/Z3UniKjYLf5asyBHf/w4RFQxf0FFJJsLxr+30
         qCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KY/+AA/X+vmMaT8JmKrZPvVhnyW63l/Qn9k0Ear+Z80=;
        b=HZEkC9Epq4XoEPmim5J7j4tncKaUkJGUSrH+5svjim6AxG0br8yNwYwOwQibM1p9l9
         rLiwd1GKO8I8NJD8fbqCz+6eKBR2V1BFohToXkX/Q1we2E8h3NBrFP4IZ4VejU0miEyS
         29MctsFNhrnClG5qSduzS7trAIt7L0jiZz0hM1exVFAoYlwc/g9rCWcAUq+zYFU2iDm1
         3yslHS2dllSKjSLrynxpCu7LMcYxi99y5WGCqwndLF5umGudftnMQ0QtFrpXxzOUZeAe
         +UiW3lZJJ5yjso3BSGUOF8+e+yuN1kG4dfcnmF3UdnA0x6v7ZHThGY/13HDvgP3cTqIh
         qgvw==
X-Gm-Message-State: ANhLgQ10jnHZeh+aw8ebV0zaC49N1oKJ8JHZ4zKX5aVXERZ21rH4k1iT
        Ose2roTCXAYPYqJTV71Ur3jepAe5VXo=
X-Google-Smtp-Source: ADFU+vuhV/vgw2KQG7w7zFquzgovzNbFD6hhvJd/rWV5O26+Y9q1Bbh78DrxmuWhW9lbWUTbkpcI5w==
X-Received: by 2002:a5d:5301:: with SMTP id e1mr10401607wrv.44.1583427949459;
        Thu, 05 Mar 2020 09:05:49 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t14sm13003555wrp.63.2020.03.05.09.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:05:48 -0800 (PST)
Subject: Re: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200303103310.GN2540@lahna.fi.intel.com>
 <PSXP216MB04384541A10255DF4E70F4D480E50@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200304161827.GQ2540@lahna.fi.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <101ca1ac-c3d3-6685-e21b-4c519346b67f@linaro.org>
Date:   Thu, 5 Mar 2020 17:05:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200304161827.GQ2540@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2020 16:18, Mika Westerberg wrote:
> On Wed, Mar 04, 2020 at 04:07:29PM +0000, Nicholas Johnson wrote:
>> On Tue, Mar 03, 2020 at 12:33:10PM +0200, Mika Westerberg wrote:
>>> On Mon, Mar 02, 2020 at 03:43:29PM +0000, Nicholas Johnson wrote:
>>>> This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
>>>>
>>>> Since NVMEM subsystem gained support for write-only instances, this
>>>> workaround is no longer required, so drop it.
>>>>
>>>> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
>>>
>>> Assuming this goes through The NVMem tree:
>>>
>>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>> If that's not the case, please let me know. I can also take them through
>>> the Thunderbolt tree.
>> I do not know how this would normally work - I have not experienced much
>> cross-subsystem work. Perhaps it should be taken through your tree. If
>> it goes through your tree and not part of this series, perhaps it does
>> not make sense for it to be authored by me, either. It's just a revert;
>> it does not take a lot of effort or doing something original.
> 
> Your authorship is fine.
> 
> Since this patch depends on the first one, it should go together with
> that one either to NVMem tree or Thunderbolt tree. Either is fine by me
> but if I take them then I need an ack from Srinivas.
> 

I applied 2/3 patch which should show up in next 5.7-rc1 release, with 
that in place you can revert this patch. Please take this patch via 
respective tree, it does not make much sense for me to apply this as its 
not going to break any build.


--srini
