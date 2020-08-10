Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D892070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJCkJkb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHJLZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:25:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbgHJLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597058494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wbjRsGzwJSEIgmC6+jZ5HmKMMdsjr2TIwdTADa3P68=;
        b=KJCkJkb0jjDc5tCbiZLFEeDefar3p3nzvGoOgPEWWPsPSYw1iTonmAL1/i0LKaFlUhuRDp
        BzCNj8XPpltMuGLEmHlfsB5xA4rQ584zPNRdKJES/b5h2q3ISLXVEVr73Ia4+E5L7G3HIa
        PR7lGCi5k69zElt5JvmEhT8rf1EyyFE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-GCjHInxFMtC3DKVzcmohmA-1; Mon, 10 Aug 2020 07:21:32 -0400
X-MC-Unique: GCjHInxFMtC3DKVzcmohmA-1
Received: by mail-wm1-f69.google.com with SMTP id c124so2659656wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 04:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wbjRsGzwJSEIgmC6+jZ5HmKMMdsjr2TIwdTADa3P68=;
        b=qzzvTsO7FtJEFc6SxJ1AkASIsfH3SOhBkqofQWoNGF41fkvfm/YdPONW9m6NgiR3w2
         MB/xgS85IzB+JTk/rFXY3leTcwYUFmSwH/LJfOTYIf16kmKN+2WX3nXOG/0JVSTaP7Fa
         pDEhFwOw8pY0d40cnXdxnlWichfxGoBij8ypDHEUwBW5dvVBU1g7uedpfyOm1il8I1UQ
         Bazn6YC+4MmJbUjX9ja1LVholVLnN7GQCmd1fb0lYDyU+bEdx9nRHMKCd7uuLrZMO7XI
         e+/I6QGeETH7QOUIdIav/y8kFoCy2QbsDp6UARqEGGRGoMw01Lcc5ZMLicrWEgw8qx4u
         iMVw==
X-Gm-Message-State: AOAM5314c3U7pZGZ1ekf9JQlfW9ScEVTmQ6EBuNDeaqmOyuIuGh5uEWb
        H2lKnIqlsKokhtFIMFOeMrxjk/sTqpq+gqfiNnTLkONeAwiFkRPp1JJZ9BJTTzYThLvtFKkQC9W
        JDjM13YRgjHwzGD7n9k4tq3pY
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr24714534wmh.55.1597058491550;
        Mon, 10 Aug 2020 04:21:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4UxkLVkYR0qaII68uf1rniVKRN+p8dcjGLxPoccx8ZjhNhB4Iqyr7JqQEeHpxQbiDZVqm6Q==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr24714515wmh.55.1597058491320;
        Mon, 10 Aug 2020 04:21:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103? ([2001:b07:6468:f312:5d6c:f50:4462:5103])
        by smtp.gmail.com with ESMTPSA id o125sm23557595wma.27.2020.08.10.04.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 04:21:30 -0700 (PDT)
Subject: Re: [PATCH] kvm: selftests: fix spelling mistake: "missmatch" ->
 "missmatch"
To:     Colin King <colin.king@canonical.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200810101647.62039-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb65571b-555d-c5e6-1242-a12881a13e01@redhat.com>
Date:   Mon, 10 Aug 2020 13:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810101647.62039-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/20 12:16, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/kvm/lib/sparsebit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
> index 031ba3c932ed..59ffba902e61 100644
> --- a/tools/testing/selftests/kvm/lib/sparsebit.c
> +++ b/tools/testing/selftests/kvm/lib/sparsebit.c
> @@ -1866,7 +1866,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
>  		 * of total bits set.
>  		 */
>  		if (s->num_set != total_bits_set) {
> -			fprintf(stderr, "Number of bits set missmatch,\n"
> +			fprintf(stderr, "Number of bits set mismatch,\n"
>  				"  s->num_set: 0x%lx total_bits_set: 0x%lx",
>  				s->num_set, total_bits_set);
>  
> 

If you have a script that generates the commit message, that needs a
fix. :)  Queued though.

Paolo

