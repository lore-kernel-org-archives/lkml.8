Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7887C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A620838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo8zTNll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBZMcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:32:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44249 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:32:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id f140so1776345qke.11;
        Wed, 26 Feb 2020 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MRsXhRp3E6rh2+qvZmIeFVHR93AAhtRNYB0tmbFEVY=;
        b=Vo8zTNllfC4o6nND7kLPoDV7V03+PGLD04JqV7MNWSx0oObQWxHlaEfGIBrdyHaRvJ
         ww2vSmC4bRv8i6hcU8VBeY2YhfMDKdaS6MfQUPq1T7fZxrXW5NTcxlG8C521XtoJJQOx
         AlBGmyqtGt3YFgb2TnObOZnHZNWjm9XEp7X9sF25doQduHp62/V02ifg2v+zkJGjLGie
         X240XCgFRjloBM3RFAwEtFylPsHPRhwNYVxOXI3L4Uz4qTKOe116ebQmBoaKfuWsL/+e
         cjoSbJV9c9LPLH4pAIgZn619ZEH4FQ8oRR3Ud3Vo+NF1ywIf8ZBsAIOqEb9XriCWX05L
         N/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MRsXhRp3E6rh2+qvZmIeFVHR93AAhtRNYB0tmbFEVY=;
        b=iogNJU8fTzrdz78Xczh7Hvi/BUO1Y6/TTBfZsEO3j/Pape5YAvGSkVm8/MpmF4x6rm
         bVk5Yh0ifKXdCseQKZsDPwE3f92f0Bqj+a0klaNfFZMzcuxReHRERwGIWzYLD5rXuSdK
         TT4DB3UXSvs86BoScprvpQDkhTf+k8qLfCZLjwE28peZDt8FSfoWz0jmHKKQMYaegEjD
         35NzqKjSnWEeb4Da5nSQ7syWr30Mv1jmhHX/W2cafXDJKNYSsrpm7vLzSgFgn9Emv0+D
         /ouK14rFjc7lIwZiiVhJXUW9SocsdFR94FrYginoeKNj673oDgAaXoWWGMnt5lok4JpA
         uEig==
X-Gm-Message-State: APjAAAUD9vLATiCzM3AZSOvB3wEYQPkbWU225g0MaDtKiZA33UUuWR4w
        3s7vcHLNNGhSXq+ADgjZydRuD2Egtzp6nYSD8B2/Rzso
X-Google-Smtp-Source: APXvYqzT0QOBpKRKbC4kcg/YNxuLy3cnTrGuXc9LH9ek2oNBn/hVko38x0Hlgj0xhIw5szgawcSuZNLgT142188LFQs=
X-Received: by 2002:a37:a8c3:: with SMTP id r186mr5306087qke.37.1582720319288;
 Wed, 26 Feb 2020 04:31:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582007379.git.shengjiu.wang@nxp.com> <a02af544c73914fe3a5ab2f35eb237ef68ee29e7.1582007379.git.shengjiu.wang@nxp.com>
 <20200219203706.GA25618@bogus>
In-Reply-To: <20200219203706.GA25618@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 26 Feb 2020 20:31:48 +0800
Message-ID: <CAA+D8AMrHHZ3U66z+jroZqLK8pnn7xF0A9MCzxAqdqDfUHxf2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Feb 20, 2020 at 4:38 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 02:39:36PM +0800, Shengjiu Wang wrote:
> > EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> > IP module found on i.MX8MN.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
>
> Bindings are now in DT schema format. See
> Documentation/devicetree/writing-schema.rst.
>
Thanks, will switch to .yaml format.

best regards
wang shengjiu
