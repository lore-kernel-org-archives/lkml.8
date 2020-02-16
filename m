Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF5C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC8B20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 10:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f+V+tJ++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBPKdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 05:33:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:32873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPKdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 05:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581849184;
        bh=n6eEdEk02lW7Xt/XB5651S3Ui2/aB1gpBA9ygHK1Qjs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f+V+tJ++I8muR/OBb2MzsvNkfvmKoBxUNyNww/VhQyXO38bhvy6XYa5OPj2o65rf+
         W8k8cr5cswBC1L7624bik39PwgZ41N+jAS49MIIbhJTrcZSY55SorFMzSqUkhst1q8
         oBaENn+/c9hRPjUqIBP8YmGDs8rcKr+GZ6Ii7QHE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.0.113.245]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1jARxq2aNO-00BadG; Sun, 16
 Feb 2020 11:33:04 +0100
Subject: Re: kernel 5.5.4: BUG: kernel NULL pointer dereference, address:
 000000000000000
To:     Hillf Danton <hdanton@sina.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200216032625.11452-1-hdanton@sina.com>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <978318e5-0d39-0e65-dab8-9d5f63073300@gmx.de>
Date:   Sun, 16 Feb 2020 11:33:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200216032625.11452-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYJ8OxhIr14hMqWHeOr4ArnsK5ejW5X2OzgF9SmjKltpfWPSxiI
 IkSvTMKNmv92C5g6YklVvZTDoej0BnNK7yK+x/4nxXL+FD8+1kX1maRbKE1KtYobwOfIsHN
 OBxP24HJT+8DklNFDCQPVQwbjgzll3F8C9NnZ1bCF3KAgE5I4hMWk56O6oKaG29Cxwfe+HK
 UykhFif4+HR5cESGeusfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w3ohf42TjUk=:jw+xkR353bBOwP/k730Zuu
 jKcoEvteimOjgyJ5HVILDhXIV/50CaFGkqgEif47RBWnUE88wRM5RmQwC9bUDTrLFOpqRlCQG
 jSrJ0n69/CkVUvYWdg9VSKPUtYSWYRjnnvSudzV7InSGN/xVpctgEKRV82OotX8YNLQ7ZS4r8
 NqJbdDhkwj2MKhl2oGLQRN+hU185R/AH0TGxlk6muTRQDAJh3xx2lIJ1SoAABtH49ipWMIIzc
 EzV9ryhjpaTgbDnS4RQbHPd+Xq4sYdq7qChsarzKjskzqeIlFEB5ZTbOMcQVcLqladVcVflO5
 cyEt0lyPkYsNDXK8bOCMSb5q3gpUC/5IWGYvRQWeFhXqo2E++8qZ/MndooGzZk1mo98K/lcAV
 vthVE6fExg1gWVhCXe14aS5tDgp88R5qJMMFg4S/XPjxRvz13xiMF4K2kkx8KhZ4fTlYOiQQm
 zypNVlq/i1+RmYk+9fQ8U/1JDUiFRGZGO/r/jgR3Rhih2ntbp0FuQQQ4y+h12PyMg6cOHz/qh
 VHb+IxEhsWjmMmSRlqeb/Bjb09yiU0IRzvf26RZAH12ZqCGWMFVE36bsRdHWcTqJgn6iXMdsR
 Sp2zxSQTgzDy4eccvbxlh4Og27s3+VDECFCFvOIoD5Qn5UgMSwF8dYcSxJ2cwIouItmBmpSj6
 4NhQXLaOUvHwmUmeEbyNVxy9hLjW78XCf8/ot4YWhd4/dlCzRmyeYfHotHADMKOQ0NtE1XDNY
 grlNycjzF7BqImpGDHl+focy/HMxOgNaKgobI+WwN6rJmMwCoAtA0R/Xi6ElDnufnpD1CSCEE
 xwj3Nzpxs0zaQ07tMzKTpgV8vFs4V7XAI+6JscjCdOz3eraz3UG6fQglTWUYUmQLaXyQU1p1k
 HOKsJwvIAt0MdhU5rPbakEms/Q5NZ4cwPEO3IU6JU+Cb1LLQ0w/xvcNcNU6hJvvgcK1nmxo4r
 Gi/Kj77lDDaQXWhklVD4Bu0h6rgyFSzbgjX6k60QUU12gMScmdqln+UODkTdoYTJU1wRVvqD6
 W7RXNIgE7lwda+ugcxPM5gjSvLD+dfrFjxmWYKXIJ6IqdM1MiNskIKPjvJhCk1IzUNJ5Kcl/5
 /i88F/fxeRsrTGHorh32+wYz+Ksdc12i8Bti+LKMtXSqlAfwTAaqy9vTOTRieOte1xTV/kqZI
 SNgyMt10Z0eMAKq2A6G0fLHrXgBwS7IIJZ0VbqC6Rxn/lLU0huNbpY7LKCtBggq1WUBI1FUcu
 DYw3im3k5ba6DvfVP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/20 4:26 AM, Hillf Danton wrote:
> Looks like a stray lock counts for the above NULL dereference.
Hi, the patch applied on top of 5.5.4 breaks the internal display now even=
 in the boot phase.
Gert just a black screen after few seconds, nothing in the logs except:

Feb 16 11:21:57 t44 kernel: elogind-daemon[1431]: Removed session c15.
Feb 16 11:21:57 t44 start-stop-daemon[6462]: Will stop PID 1431
Feb 16 11:21:57 t44 start-stop-daemon[6462]: Sending signal 15 to PID 1431
Feb 16 11:21:57 t44 kernel: elogind-daemon[1431]: Received signal 15 [TERM=
]
Feb 16 11:21:57 t44 kernel: elogind-daemon[1431]: segfault at 56264c000000=
 ip 00007fddfcf76882 sp 00007ffc98c721b0 error 4 in libc-2.29.so[7fddfcf0c=
000+15a000]
Feb 16 11:21:57 t44 kernel: Code: a8 02 75 4c 48 8b 15 05 e5 13 00 64 48 8=
3 3a 00 0f 84 f2 00 00 00 48 8d 3d 2b f2 13 00 a8 04 74 0c 48 89 f0 48 25 =
00 00 00 fc <48> 8b 38 48 8b 44 24 18 64 48 33 04 25 28 00
00 00 0f 85 f8 00 00
Feb 16 11:21:57 t44 start-stop-daemon[6549]: Will stop /usr/sbin/dnsmasq
Feb 16 11:21:57 t44 start-stop-daemon[6549]: Will stop PID 2764
Feb 16 11:21:57 t44 start-stop-daemon[6549]: Sending signal 15 to PID 2764


>
> Btw, send pure text message please.

Ick, I do sned plain text to LKML, or?

>
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -254,8 +254,7 @@ bool i915_request_retire(struct i915_req
>
>  	spin_lock_irq(&rq->lock);
>  	i915_request_mark_complete(rq);
> -	if (!i915_request_signaled(rq))
> -		dma_fence_signal_locked(&rq->fence);
> +	dma_fence_signal(&rq->fence);
>  	if (test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &rq->fence.flags))
>  		i915_request_cancel_breadcrumb(rq);
>  	if (i915_request_has_waitboost(rq)) {
>


=2D-
Toralf
