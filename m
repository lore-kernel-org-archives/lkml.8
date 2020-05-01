Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E16C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94B720857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UjUbSxR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgEAWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgEAWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:00:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:00:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w29so9121194qtv.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CH/D4ZOJbtfLog2S9ZgsPl3JnZhPyLEBOTg/2pqHG4s=;
        b=UjUbSxR4CkN0dsMB4lUnUbpCfb/B83H/J96d7x6w6a+orTJZzQuZGtWc5bX6scCV6K
         j1wL/cfYp/JZKfXoT/LUQDjgWlKAdizAv1eYmsQWL5yLrRVW3rSCjkCc/KBvQYejwpH9
         fwRSvAP3VpqDTWhvFeG1eYyu8GfI62Hm9FgkPNENHKif9OS2KkNjQPDDsShTpok4tmh3
         o0fddNDxJLMqDl9JlEaxQ/zEjDVpJF7GWg0mzxPVzQgnA9VpC87yZoLOGtF2LASuoLOD
         Tgfou3UJWsp2nFIQ8tT+hMygZ1NtEqCN7nyq0XdpI31yqmcqXolqZIbkUrCHX9WnAf5d
         yLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CH/D4ZOJbtfLog2S9ZgsPl3JnZhPyLEBOTg/2pqHG4s=;
        b=oBEAIK8QXTZX1dLWqy1VNeMA7BQ8eOwhoj7KI8MDzCug+1Cv2cDleGiee2NbRLknYm
         +RYEupqNsQ2+e/2f6IgF/mEeb5/5zqxGB7wAhSkspVHP/D4reUeBoHymstWMVGoijyEh
         0aS9w7z5xxKS6WCHuvIEI9WY0nkkwRx/+zGX/iDtRdNLwDYoswgMXKHMmgVXRz02wzuj
         ho3t/sdwtp99gsMx/oPCMKJyHoBKAfIfetvTQQ23pyQ2Mzfu9hRIbb9WLMlJfKO6n3dC
         2P3fUEyUAXUHQHwbtDjlnwSUAA82NVm8DN8Y4lRQgaK6hOvfu6WqgsCmqpLaVRGtcaQ6
         6uWg==
X-Gm-Message-State: AGi0PuaQQzBLhWQXh9L4UI+0UrZoc8IAsZ4UEM8YnVyftLgW0haHvp32
        ielTgn0tSE47AtVKTPZaFUGLGg==
X-Google-Smtp-Source: APiQypLtgqTqjWBD0ylKQTcpVr2rnu/Xgi4jxQWDf5+wA1VDmBV/4/IQUAbN9+zwVLeFI6Zfb+V2nA==
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr5953950qtv.142.1588370448431;
        Fri, 01 May 2020 15:00:48 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c11sm3622843qkj.78.2020.05.01.15.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 15:00:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200501215441.GE27720@optiplex-lnx>
Date:   Fri, 1 May 2020 18:00:45 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>, cl@linux.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <995A3749-4BC9-4217-8BAF-F10A13208F63@lca.pw>
References: <20200501211540.71216-1-aquini@redhat.com>
 <21CF143C-B9D1-4D3F-A875-370924265593@lca.pw>
 <20200501215441.GE27720@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 1, 2020, at 5:54 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> On Fri, May 01, 2020 at 05:29:19PM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On May 1, 2020, at 5:15 PM, Rafael Aquini <aquini@redhat.com> wrote:
>>>=20
>>> Sometimes it is desirable to override SLUB's debug facilities
>>> default behavior upon stumbling on a cache or object error
>>> and just stop the execution in order to grab a coredump, at
>>> the error-spotting time, instead of trying to fix the issue
>>> and report in an attempt to keep the system rolling.
>>>=20
>>> This patch introduces a new debug flag SLAB_PANIC_ON_ERROR,
>>> along with its related SLUB-machinery, in order to extend
>>> current slub_debug facilites and provide the aforementioned
>>> behavior override.
>>=20
>> Instead of adding those things everywhere. How about adding something =
like panic_on_taint? Then, you could write specific taint flags you are =
interested in to that file because slab_bug() will taint it =
TAINT_BAD_PAGE.
>>=20
> It seems like a good idea which also would required "adding things"
> elsewhere, but doesn't look mutually exclusive with the approach here.

No, it is mutually exclusive because panic_on_taint would do this same =
thing but saner.

The thing is that this request came up over and over again where people =
may want to panic the kernel because of TAINT_BAD_PAGE or some other =
places due to tainted.=
