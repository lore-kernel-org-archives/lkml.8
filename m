Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98184C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6910F20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWxMGUFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgH0HtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0HtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:49:24 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40298C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:49:24 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v12so2395987lfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lElIBShK3Hp7NMxxbsrQqbzfkPcAAq5ICVuJ1mMPOCE=;
        b=JWxMGUFmaxfU3ly/x3p4my4tdIgRs0RsCQLtN6ezg8b6eMHKZEds0Jj5fMDi4bX4Fb
         zj1iKGc8eaOM/PITn4uff+Uzeev9nW0jBeZV/UTnwPmeL9vfF7E/NYAu2hWDpp9UNRZz
         PIzYceRCwp+3d00tDnc1YBXOOlvfeew4cSrr2UVkZlDmDNBhWl7yDrr9oByjBpiXyJ8n
         65y5M9BCQDNyO1sxC70TYy+I2K+yNvN1au7o11PnhcKmzruWjvQ6zHWGrbH+5U/XRTTe
         6pmSCn2VV7T1EfBi5yW+85hE8WUieZn5+VU8RzW2ZR4FC9RIOlafdBbS0w3pytkfK96u
         H1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lElIBShK3Hp7NMxxbsrQqbzfkPcAAq5ICVuJ1mMPOCE=;
        b=bZbbZIrf/+iQW0OG7Il0FFfLTe1sGWily7st3+HtfiHlZONXkEJ/VMkSHDTGuU0ilg
         s6xBeEUQY+hKU3mPRUdEavv8SQr++EarwbCg4/fp6qWzLMBLD6+axb6+L/79tdEl5d0Q
         Yyg8oZcn9nwbZHHBZ/ZIHOrMpN9JTCOWlqa28LaMoR0B1gNWmpNhg1PjEjxa6xY+iBPB
         ba48/8TthS5IDlrZgtfWtf3+qVVMNApIAvtCZFQYgNoBy6BBQPhptS3wlrYJIYPuSVZZ
         NVEeIbuI9uW2h4y4XKUs+oh8zdL65NjBgGx/iKyam6Hq3ugosL3wn0+i4OkIDDeqaoxN
         uFfw==
X-Gm-Message-State: AOAM530OW23ZmyrmM1E+JIUZLGriEPWjuqQkoI8w3aYAqmxD6zZL8+43
        IcXRe5U5qiPiY36bZYR+Bn84sEXILDGiC6fCrjo=
X-Google-Smtp-Source: ABdhPJyAzOca9gSV+IpIgIEFzJODabWI4uw61tDKkkKZgLWmurp0tXP+OWS/LvPvAuV6QNjFjl7rUODcmADUuVU5vyk=
X-Received: by 2002:a19:7d04:: with SMTP id y4mr9303618lfc.51.1598514562719;
 Thu, 27 Aug 2020 00:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200824232511.16485-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200824232511.16485-1-luc.vanoostenryck@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Aug 2020 09:49:11 +0200
Message-ID: <CANiq72muR=59yG16-0d2gNuOZbHJYiDhRKTfKAvh9-i2NJMAHg@mail.gmail.com>
Subject: Re: [PATCH] remove comment about sparse not supporting __has_attribute
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Tue, Aug 25, 2020 at 1:25 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Sparse supports __has_attribute() since 2018-08-31, so the comment
> is not true anymore but more importantly is rather confusing.
>
> So remove it.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks! Queuing it.

Cheers,
Miguel
