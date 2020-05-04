Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184CC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A34206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aL4lyj4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgEDQgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:36:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23506 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728655AbgEDQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588610159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGQgxhZuStGNIik/5wRjRbyRSeqnbfltE4LxfFjoEOA=;
        b=aL4lyj4iqVcGMhQBKJXequ8aII5y0XvbB6qBZoj2bVET+vCyTAuVYMP+9mdbxH9HWoKNuN
        kE86PCgqbOzHefubsLnmaZUgubn1/yj28f3Xi5ayFKed5qmvHQBk1hmTBpdmllb0Yk8yXm
        6TBTe3E411mYppsVpSMRVD6NiykU2l0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-OkzRpTapPlipuC3bHWG_Ug-1; Mon, 04 May 2020 12:35:55 -0400
X-MC-Unique: OkzRpTapPlipuC3bHWG_Ug-1
Received: by mail-wm1-f69.google.com with SMTP id t62so94111wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zGQgxhZuStGNIik/5wRjRbyRSeqnbfltE4LxfFjoEOA=;
        b=N3KCDQ3jMrSTm/51keF7qZWAhGifACMpYmyQBE7i2KfVuHdurJC+EybaiJIGlUAHpu
         Rp39ODzkeBESpOfQR3nxWwjzRTGPYCsVffrIONwqyrRFnZDDI1M2i1TqYSlPKa3eVO9o
         jkdZNlvNMKdcQNVOoFS8Ruwb56ZJnCRNIUTgjrgrDsYx4HKklJS5w28Ry8IVLmYwHPIW
         P8oZMo/a00B0daV2vtCQsv+dlXr5oi7t3Fll69je6e0MKeXcLA1FaZDS0OZpEg620Mqx
         f6L89aufa5clPKxm4LId0LtgbTm8I1Q9HC65WdPetMdYGj7hVlO/Zxr6Sspc3Ip+8cX6
         tQhA==
X-Gm-Message-State: AGi0Pua2N+kCiRfrvFB4gxKkYarz3FEpBSs/9SS/WpXO/4gfVgO3QSno
        Cff0CnpVNpCVWWmOSGHJdDVKFz3IiFbxDgMOuy7n+QR6q1WvkMAPxqrJ2OHFB01DGko8MT7/wui
        5O5ofLpXyvLvAnrQh5J4ymNLW
X-Received: by 2002:a5d:5082:: with SMTP id a2mr160603wrt.224.1588610154552;
        Mon, 04 May 2020 09:35:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIp2UyN429DvfosgwsSLLhqzlALwieFhFzafW/enJ4dikF9voaJRJ8nPBD2lIZrSuvupZ/lFQ==
X-Received: by 2002:a5d:5082:: with SMTP id a2mr160582wrt.224.1588610154317;
        Mon, 04 May 2020 09:35:54 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id j10sm15302138wmi.18.2020.05.04.09.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:35:53 -0700 (PDT)
Subject: Re: [PATCH kvm-unit-tests] svm: Fix nmi hlt test to fail test
 correctly
To:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200428184100.5426-1-cavery@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <811b4acf-1356-1b82-edf3-29e73d2ed9d3@redhat.com>
Date:   Mon, 4 May 2020 18:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428184100.5426-1-cavery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 20:41, Cathy Avery wrote:
> The last test does not return vmmcall on fail resulting
> in passing the entire test.
> 
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
>  x86/svm_tests.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index 2b84e4d..65008ba 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -1480,6 +1480,7 @@ static void nmi_hlt_test(struct svm_test *test)
>      if (!nmi_fired) {
>          report(nmi_fired, "intercepted pending NMI not dispatched");
>          set_test_stage(test, -1);
> +        vmmcall();
>      }
>  
>      set_test_stage(test, 3);
> 

Queued, thanks.

Paolo

