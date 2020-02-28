Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324EEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA032469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Brro0fFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1XfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:35:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38730 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:35:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id w22so2327899lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/B5228hYgmRnxW8FEHOYujtnQcsBZ77HbLjTHiA6bU=;
        b=Brro0fFLV4c6/pXJd1+hFk6W9NV+ug7bE06T2TmOrgmvdQNQmIHOeP8hNZE3verTb2
         Z1xvznUr/tTzwRtmCictcI8nYLahoAUKP3smcP9eoJQJXlhivQwZ97Nd5M41jI1LvEI2
         sAu+Arvz/7O2UqvHXdBTNBG9F0OFJiAvAsHpKlIuyeS4kFl5QMkS+8Uog7v3wSBScmE6
         D+ecYEzqsZXuMo8HKqofIW34z14M9sPH/0/n0WO70cHns3wrwJyII54liXRp2aXgPwlL
         +pHMoVyEqy9t81esObV7+mOyDDb0H21IWltmPhtToX37PUYJmY8oCBmPyMHnuwEQgqct
         SwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/B5228hYgmRnxW8FEHOYujtnQcsBZ77HbLjTHiA6bU=;
        b=JZeOdI0qQ1JvKN+pHCHSxmAaFrQXtsJ56NtW2TU1H79kVSUvTd+qv7grWqNQZnkIJ+
         nEBrPdspE4J6PQ5Tybcq5PN/TkcYjNTLNbYUz4vc3pPgUsDFEkscN46ojbkHWZTGPYSq
         wubxx5AY/QVG8Z0UnY+4QAMPw7b63LYW4KmrVcVcibjBQ5hhyLlbyrpWu9fyv2jI2fXl
         bSB8Mf+Kq7pc3iiTTsLAfP7lf9/hjzlkC9MOLSYd+ZmOLXdEYLk93dUItFDXBcE3vgT5
         gK2w0WZaCbNuTKi+Jg1ccDsnCJS6UiwLyJTdejAYT9NyhF18VCTFM5CIG73FeOz9fR6r
         sCQw==
X-Gm-Message-State: ANhLgQ1YqzCRxryp6pWBF5p281h3zrfP/6u+3pLo5ASbD/zV8BnXSMpB
        LeDam6kM5b470U8ryMzdZ2B69NhyhywVOPB9nMBJCA==
X-Google-Smtp-Source: ADFU+vtIuJIvzeEGPCQJOCDVjdIQb9RIh3ENTmdzT57F23IJUb/aLmCkOO1feAaP/Yzj/kZWNt7ItmP7C6O/LKrqjeE=
X-Received: by 2002:ac2:5499:: with SMTP id t25mr3829568lfk.194.1582932915370;
 Fri, 28 Feb 2020 15:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20200228154214.13916-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20200228154214.13916-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:35:04 +0100
Message-ID: <CACRpkdbhy+n-hMW8k+nWWMWgd4p3QFEJ-Ha5H1mSnuPkSfeFtA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: madera: Add missing call to pinctrl_unregister_mappings
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 4:42 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> pinctrl_register_mappings is called in the pdata case, however a call to
> pinctrl_unregister_mappings is missing causing the mappings to be leaked
> on driver unbind. Add the missing call to correct this issue.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Patch applied for fixes.

Yours,
Linus Walleij
