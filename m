Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF1C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AF12467F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDkIqyvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgCDSUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:20:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388130AbgCDSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583346006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sc0Xcmlskdb745JmJFxuE7AmsaR9eAsu+qMPQfvgRAA=;
        b=eDkIqyvjUnm9dj3Lgoxc/HLfoyUR55xFutBY1nqTxiVrgkQ+3fKHlh5aKxJgtZzw3c45ub
        FvTdmkHXd6kMbT5wgxUy8gBbUh2NL8WTpfPZKtnjb2NxL/YwMeolu3u51PVJDq+3uNCqEx
        u4HzOeJe7c2o/XZlFChTY17v8rfxo54=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-PMmpI1QpMeWuAf14S2_6CQ-1; Wed, 04 Mar 2020 13:20:02 -0500
X-MC-Unique: PMmpI1QpMeWuAf14S2_6CQ-1
Received: by mail-wr1-f69.google.com with SMTP id w6so1176088wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sc0Xcmlskdb745JmJFxuE7AmsaR9eAsu+qMPQfvgRAA=;
        b=R2d3FtM6U1BEe62D7p8w53Zvqn1i0hLL0nE2/7vNzE0OrJjC1Yhyhg43H70zGJYQux
         f4A9glTH5MBq6Kau81hBGBEFxpqhCGLGPJoMToQgQJpB4FTINp4mb3cI5jIF+phsElFm
         ow4oJ4auXRrdfxi1U8sm7MlGCrONV0/wuQA5QXLruBmIhPhy/vq1tp2+EX4tEFmWf2+g
         SFoDTbmGUziPDVVNhKb50YtTpnQLyispSmn2wBt13vxDSQhgKKPqrBCfpnYtsbcqs/4+
         QeOHz+3Fbc5lYGNwP7a9W5v+b/XteI1lZpVMAp2LWFZN0ewaBMdkY3TwRE9qHzd4rP5S
         3t0Q==
X-Gm-Message-State: ANhLgQ3KHoDx84Kh1LmHLsuPDYuxmE26RlafTH0M2BWCDORe/kKakthn
        pNStYXmZkVif9qozIqdOoO2T1L0JhZbE26pidi3HtTNixulsn0SMTy15iim4GWbqDejxw/0x4Px
        RmYVYKSMUImetEZLpl4iM5daM
X-Received: by 2002:a5d:4043:: with SMTP id w3mr5385371wrp.139.1583346001108;
        Wed, 04 Mar 2020 10:20:01 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvMvPx30AeZ0XZ0GMLVOfVyfATjiiWEyIm29aWaWBtqZT4tOSR60u07P5jBLCYTmV38Q30pcw==
X-Received: by 2002:a5d:4043:: with SMTP id w3mr5385363wrp.139.1583346000909;
        Wed, 04 Mar 2020 10:20:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id k66sm2769279wmf.0.2020.03.04.10.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:20:00 -0800 (PST)
Subject: Re: [PATCH] KVM: X86: Avoid explictly fetch instruction in
 x86_decode_insn()
To:     Peter Xu <peterx@redhat.com>, linmiaohe <linmiaohe@huawei.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <05ca4e7e070844dd92e4f673a1bc15d9@huawei.com>
 <20200304153253.GB7146@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad023c34-9a08-7d61-22de-911c4e8760ba@redhat.com>
Date:   Wed, 4 Mar 2020 19:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304153253.GB7146@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/20 16:32, Peter Xu wrote:
>> Looks good, thanks. But it seems we should also take care of the comment in __do_insn_fetch_bytes(), as we do not
>> load instruction at the beginning of x86_decode_insn() now, which may be misleading:
>> 		/*
>>          * One instruction can only straddle two pages,
>>          * and one has been loaded at the beginning of
>>          * x86_decode_insn.  So, if not enough bytes
>>          * still, we must have hit the 15-byte boundary.
>>          */
>>         if (unlikely(size < op_size))
>>                 return emulate_gp(ctxt, 0);
> Right, thanks for spotting that (even if the patch to be dropped :).
> 
> I guess not only the comment, but the check might even fail if we
> apply the patch. Because when the fetch is the 1st attempt and
> unluckily that acrosses one page boundary (because we'll only fetch
> until either 15 bytes or the page boundary), so that single fetch
> could be smaller than op_size provided.

Right, priming the decode cache with one byte from the current page
cannot fail, and then we know that the next call must be at the
beginning of the next page.

Paolo

