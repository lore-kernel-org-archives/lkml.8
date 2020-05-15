Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D439C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F71D2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PY8rmKLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgEOTYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEOTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:24:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC40C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:24:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so3150019ejd.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a36hrCvkPbUg843/bSmumOn78+ipKHZWMg5XvSohP3o=;
        b=PY8rmKLsoOIAWMnudxgpiJvpNf1j1UsqVeSDR8qlbXb2PjKGGE3Wy9ytx1c5odlDP2
         Y7jk9kBiWi7s1ZLcWH8gNy4I4cxa944o1z8d63G/2gVgyWoKuFjsq31zCukSiMz9oVQ/
         q8mhT3nJbRKKl9LI8v8k8kBSrTeWoVS362oOdyavmXQbvC38loTmUXVsni8RSKwK5Cyw
         D2iY8jmZ9218Wo/3qB8puStPuHYFj0i0Zknw9HkhR3zgwqCCuOP12NAqbL4BZqQX6tJu
         ADQT2pCL13mYBwfnUOewfIEfVDaXhfsbM/h3ASSw7rt+zEL5wAewbqddkbJ4mno36n7h
         pQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a36hrCvkPbUg843/bSmumOn78+ipKHZWMg5XvSohP3o=;
        b=XAXE623cOxbFS119N5TYnXHmOhKEZTHndoY2Kfvni6malhy93ikvUiEUpneHdYbOf/
         Ow1EV7N1D5U+nIFzt3bEym4ZaWZI9i8pVWDOxAcrD/PRGZ1OF+DPghvy7v7b3yu12z0O
         htzoBXSrmtzEj4vif2RKhGyXH1jXcdPZoCEPWeFC5wHAI3QOmajwq3Y4ZzCeAXQHxs74
         d2iZVFX305/AXYkOwbYhwp9mwNZKvZhTZFHEs+pyfoURyH2Nm+jfC4LRMWmQjSCwsgnN
         n88aIpweE6P5ZTiBKbo+OcWGeGLudyxRnKsPQ2kK0464UQQM+hF0Vq1UkBTqhog/qCrd
         zs/g==
X-Gm-Message-State: AOAM531qYRhZjRi4/iXq16JPl/5pFk6VUNawA2kpNL8B8YqJ420FBSP7
        UD6K3cZIw1tiBCI4T90/IcBQaAzv8wsCEiYh6v0Iuw==
X-Google-Smtp-Source: ABdhPJzjo4HsWFSrpU7PHPWN+VC1EtmQWOEZbJjdzveuqDK930f9zFXRjleWAFRW4YK8ia6ElnSqJyxhw48h+Oaon94=
X-Received: by 2002:a17:906:aed2:: with SMTP id me18mr4576716ejb.283.1589570668270;
 Fri, 15 May 2020 12:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200515184434.8470-1-keescook@chromium.org> <20200515184434.8470-4-keescook@chromium.org>
In-Reply-To: <20200515184434.8470-4-keescook@chromium.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 15 May 2020 15:23:52 -0400
Message-ID: <CA+CK2bDvsoOMKb_1Q1eAy4mcrDs6hUOtkr+3AM2nXoJD2+q93g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] printk: Introduce kmsg_dump_reason_str()
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 2:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> The pstore subsystem already had a private version of this function.
> With the coming addition of the pstore/zone driver, this needs to be
> shared. As it really should live with printk, move it there instead.
>
> Link: https://lore.kernel.org/lkml/20200510202436.63222-8-keescook@chromium.org/
> Acked-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
