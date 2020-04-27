Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C309C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6916F2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyRo4nU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgD0GBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:01:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9DC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:01:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 71so13338142qtc.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGFl2uS3f+5RhP1jpZPcJAcfmonJZTFWwEebr4DUxFY=;
        b=UyRo4nU5c3POIrn+bZNVgt6vTDruBvL+THYSpR5jUEZZLvf83LrK3lhS32ufRmvIuZ
         j+p0QDq8tiRsO/i7/BbTZt+KQnXxVxGMIcXKxLkgYnTHILV/QflQyc3LOUCSX/j8RH9B
         HqjbXO3I7wsSKeQBXxBxS6w/Lqlwgw3tUuFnaj/+EkR7nnxhgiS0rjU1y/MyrHrnYdAa
         z3m9Gu1qnyQ9j2RHohDO9UfdkJlg62SgSkrBc5g7LfpEcLqpwxvb29YXpNsnBUHi3XYQ
         nK4zBoGZFxPKFm3/6Rw8+ToQ98up3xbuv0qg1BFYyuT4g04WSLG+ELflaQcjzRES2Uv7
         ZjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGFl2uS3f+5RhP1jpZPcJAcfmonJZTFWwEebr4DUxFY=;
        b=LvdQ6aqNXOzLorvD335rOY4IugElnjNKskIHpw2qF3iQx9pFhuoOHuP1i4wpUPpiqs
         raNQ7Jg1MQC4kjzIV1jcsUymazDK1MRovSc6U8O/e9ekJkk9gEnwOtNOfpeUnJDg9rQ5
         6q9qS4P4ulBOguXCdna+PaXUWBw4DdxVlKW8lR+M4BYvuTp/36F0g+PGBpvVsEFzo6PX
         orFJQSwUkGaZ6kPOiT+VvbJaQkqQX4DMnDf0BWneIVjWEQqIS/2pnXl+ghi8LRTe9BcL
         JCMkSBP7rdz3g2axyCXZZRlbk+NERvSiwagbL//NJW5g/A2N5072iatrIzJv5dG8bdaL
         xYCA==
X-Gm-Message-State: AGi0PuZ1crSGo25rp/xcgX+EmxNvHpQSqMTqGHQ+KSgGOis3JGj0Ofyv
        F7RPTgw8m858fI5Vk0nSC7rZ78PB37FthX5ZKC0Iaw==
X-Google-Smtp-Source: APiQypLsDEJUKDwWhUb0HcitD6LTYrZxucNft/F+aO2VwcOAWSNRFoEXi3bGQvQKjWbUhypkIAgG5fdIBm8Q2V74QlI=
X-Received: by 2002:ac8:22ad:: with SMTP id f42mr20964483qta.292.1587967298448;
 Sun, 26 Apr 2020 23:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com> <20200424091533.GA8856@Asurada>
In-Reply-To: <20200424091533.GA8856@Asurada>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 27 Apr 2020 14:01:27 +0800
Message-ID: <CAA+D8AMgenpGapp3fbZVvswPOKDLZXZE0KaPK7Js41xSDhG9wQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Remove the tasklet
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 5:17 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 02:54:06PM +0800, Shengjiu Wang wrote:
> > Remove tasklet for it may cause the reset operation
> > can't be handled immediately, then there will be
> > endless xrun interrupt.
>
> The reset routine is really long and expensive, so not sure
> if it'd be good to do it completely inside HW ISR. Have you
> tried to clear xEIE bits to disable xrun interrupts, before
> scheduling the tasklet? If that does not solve the problem,
> we may go for this change.

Good idea, will send v2

best regards
wang shengjiu
