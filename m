Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029CCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E912072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C77CODst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFBSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:46:27 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E0C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:46:27 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c194so8162862oig.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hl9GTMfiZFweYcD3SG7WaF/Uh/wZehheCxG9u8jMv4=;
        b=C77CODstej+JC4+nEjoQSO9xLprvsTzSiXSOsyt3KKeu42YO5QpNTmwkvs1GTBHnYc
         MH1YHzRsNspD5lS9cDjf57NxJzchEstVbwlnYO5jSs54qPxo9ErBxe67wPQtCoCatRZ4
         pg4lZMkLEgJIsCulXb6lECkm3R/it4LLgfHXDVJspaMwQqsegfWat1VzdSljDYadUHXA
         mNsliZEawtYVSUMKR2xKItNRgwn9r6muLISW/t4h/EpEzPBkZ96eAIAPX/i2+U/v9Alv
         wlmqisfoX1ePG+sNHmDmQ59XahgTjM550eourPUrXlOD8jzrUVuu84fbFmLNg1kB10l+
         41cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hl9GTMfiZFweYcD3SG7WaF/Uh/wZehheCxG9u8jMv4=;
        b=U4BvI3Q9FOLkh71NLyy5HK8G2vDvpe2Mtj9tuwUwKBcBPo9Qdgm96XA4Wg9PHZev19
         lR9xnBrxVmH9KsuGI6EViGM5zKQIz08iODFh3sZI45xg8D+VGy1tzuZ8eFYdgu2h27Lz
         hhqFLwPXSlLJk/SCoXJ/GX4BbgtIPk/VdqwCC2fxhGcRC+Cm6q/uyHpazBG7r+XDzCEo
         8rqDViGxcPhph/QfTAFvKqKgyr0zBYP8H6IL8rw2mnfPMxa94tXI3AuveBl6U6QrcvFc
         jT0R/Gmd8+FqibgZ4vSUcO1g3AqJCOuXe8TKojnXR+VymRlvwt7yl5O9r92LBAPL//ef
         tqTA==
X-Gm-Message-State: AOAM5335HRsa5LLk7xkLiQL9BQLAB0eT4JAhPGDsVbrRTJnVB5wZVjl/
        ljYEl0gaP4QzJoKZjmiZABdOqc4QBpWIVWPa/R4oUg==
X-Google-Smtp-Source: ABdhPJzK3dNhccwWzVhIvcR4/ISG4K9H2kJKvuT0ZLAPGtQbynawAZTi78HodWQOEidrT2chca3PicPXWRsTiGLF4Qs=
X-Received: by 2002:a05:6808:3ac:: with SMTP id n12mr2284273oie.172.1591123586643;
 Tue, 02 Jun 2020 11:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200602173103.931412766@infradead.org>
In-Reply-To: <20200602173103.931412766@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Jun 2020 20:46:15 +0200
Message-ID: <CANpmjNP20SZH+ORhmSGdv=96FaJPOYfH1pEYRtgBGs2U=cOcsQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] KCSAN cleanups and noinstr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 19:34, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi all,
>
> Here's two KCSAN cleanups and the required noinstr change for x86.

Thank you!

Reviewed-by: Marco Elver <elver@google.com>

As promised, here are the patches that would take care of KASAN and
UBSAN, rebased on the patches here:
https://lkml.kernel.org/r/20200602184409.22142-1-elver@google.com

Thanks,
-- Marco
