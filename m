Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F62FC3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778352073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRNT606Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgBMJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:54:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729440AbgBMJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581587681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ez44N34m1PHTjtAxByIbkjxOsH6Q8Xfjl62Un4eIlPE=;
        b=MRNT606QWflaL85Ok9xCt16vX7+7rckREsN17pDO8D0VL6skVH98zPOhmuWxmi+AB9+f20
        FP89iMn8VBM8UK+d2HpgN4jOHEfX2tujkwVzt7D8k3LIvhNz6nC1/5ImIcoXQpkv+vqVyo
        ruyWlmVrB+k9+4WRsNVFVakbfjvSHhA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-VFZp81C1PWyMM5rgKF0cOg-1; Thu, 13 Feb 2020 04:54:39 -0500
X-MC-Unique: VFZp81C1PWyMM5rgKF0cOg-1
Received: by mail-wr1-f71.google.com with SMTP id w6so2111019wrm.16
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ez44N34m1PHTjtAxByIbkjxOsH6Q8Xfjl62Un4eIlPE=;
        b=H3nTZ86raiIokM2DwKDnG1iKMVWMYSWOqlsVmqhvjnRZAx8cxpVqo8+W2PPrBgKUux
         fxBcqiWSvp7AKVwSOj+q6iy454u+Ij18xaesgsXUgbHcVaLw+ZCehnApcEsawdRDFQZm
         /UY0irQvkcxSuRxSFnng9V0BA/5GCogaYC9lgycEECLWwrfmDwK18Sg6KQyH3UaRBnnW
         UJrluro2b0DmqbRdYNubM+iAZA2aeJXAKR+SinV9DpeE/uIqwA5HiP6YjlVu31RH/p85
         ppgxoIm9I/pcpBEDS24ylXGK6XOn8hDy2xbgal9UvCLG3YVrHGXGIsXKW2ShX86hmWAt
         szxQ==
X-Gm-Message-State: APjAAAWgnHI9jxO18GG/GMrzSbE+CwmC7Ev2jvtsBP11Oo4vcAG5F7wx
        RseZenIauBo3UAG1rET8CA8ZnUdCW93azAC0ISbXD0kQDS96+jHdVoggGFJdmJh2/mOIU5PZmZK
        dEgMTcRMRFnI5iou1AOeFrGFl
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5213062wmj.54.1581587678272;
        Thu, 13 Feb 2020 01:54:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4Fq3M8a40Fwp+Pl2CcItRt8aHeoE6SL80Nlz6KbnNbOf6qcxWgFwi+XXod3UC9586V1UZ+Q==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr5213036wmj.54.1581587678038;
        Thu, 13 Feb 2020 01:54:38 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k16sm2259120wru.0.2020.02.13.01.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 01:54:37 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: enable -Werror
To:     Joe Perches <joe@perches.com>, linmiaohe <linmiaohe@huawei.com>,
        Linus Walleij <linux.walleij@sterricsson.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <12259a951c5e47359c46f7875e758d41@huawei.com>
 <71b3bf53c0fc3c68b10368092022e3bf2cffc506.camel@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <249ec0c0-10fb-52df-0c81-2ec28ecae32b@redhat.com>
Date:   Thu, 13 Feb 2020 10:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <71b3bf53c0fc3c68b10368092022e3bf2cffc506.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/20 04:31, Joe Perches wrote:
> On Thu, 2020-02-13 at 01:40 +0000, linmiaohe wrote:
>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Avoid more embarrassing mistakes.  At least those that the compiler can catch.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
> 
> I think adding -Werror is a bad idea as new versions of compilers can
> create additional compilation warnings and break builds in the
> future.
Seems like cargo culting (in the reverse) to me.  We can cross the
bridge when we get there.

Paolo

