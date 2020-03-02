Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82298C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2C020866
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV325Q2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBVKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:10:53 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40502 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBVKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:10:52 -0500
Received: by mail-yw1-f67.google.com with SMTP id t192so1237770ywe.7;
        Mon, 02 Mar 2020 13:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsLGA7VM5zD0pkOH4WpVsNnCZyTuYfAztq4xUCBtVfU=;
        b=dV325Q2NNUNsrNeDLidC+3jVqSgtjbI0RdPnb5MUISJlbECCniWUtfT4YF87fJ+e75
         3qMTxC9hG/R7eYTRQJld1l6fgUAYmZKX88NrGUyplIrPpH41tbln7y3QiPouWrxjzJoF
         BrcPul0rdd/d9VlpYum1Nqggx3PfWwH26WueRp29znkQFgBy0JkYzziWlWwXN8tFwlxa
         ob0mt+5wQkEQAw44K7iFsJecyDF28BwxF+wC28ajYVe3epEdL+o6NS5kCb+Ecj/2b9I1
         k0okj15XPdr92HxAYMrvh8+y+SQLIehiuNbFxYqRF1zAxGc4oUyTSjOEe0eQIioWxosh
         aLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsLGA7VM5zD0pkOH4WpVsNnCZyTuYfAztq4xUCBtVfU=;
        b=BhX13dh2/5I3kXEnzLsTPP1oyoVhh7gTfulu/AY4Ujdoe7XhwuVSAuxmctF06UcGi/
         aYSQArntmKf0jpKgWEviCDQPN9D4tkhmqg2xsFhLI8rm7izJm/stBXgMEUKhlt9HzsgI
         jXNi6WcIUTxH3RdUeGduFaaGq6P49sLQw2Lumv9nG25fBjXhyENuSE7NRECO/lqogZw8
         YnCaN9vWpsnqBEVYVH+eOqg4wreXslkxWJvjHjchcCvkRWNllWUYaJ7/iiGtXOAwTpKT
         J4cGHUMM9Q+A37n4Txh+FV1egV+AE4tpr8MJ42T/BHX0uK7EjVPCc6ydeJF8ZR3QbXoi
         VKUg==
X-Gm-Message-State: ANhLgQ3cFaJ42anNtgQVUhBSRAHolWCxWNdB9uwLiVMz8xwcKSv25DFC
        OzRZat7sFMU9pyAt4oxCxsDCiACM
X-Google-Smtp-Source: ADFU+vv1Rz8atppAhpK1WNyETD2r3gJ234q42uB5+UxLVFgAcj8SR45Lt8X9KZBMuVg/l0Ku2ZQypA==
X-Received: by 2002:a25:384e:: with SMTP id f75mr1019604yba.224.1583183451135;
        Mon, 02 Mar 2020 13:10:51 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id l16sm2400001ywl.33.2020.03.02.13.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:10:50 -0800 (PST)
Subject: Re: [PATCH v2 00/12] Convert some DT documentation files to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <75901744-c4d3-d8a9-09d8-fc994c736e71@gmail.com>
Date:   Mon, 2 Mar 2020 15:10:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> While most of the devicetree stuff has its own format (with is now being
> converted to YAML format), some documents there are actually
> describing the DT concepts and how to contribute to it.
> 
> IMHO, those documents would fit perfectly as part of the documentation
> body, as part of the firmare documents set.
> 
> This patch series manually converts some DT documents that, on my
> opinion, would belong to it.
> 
> If you want to see how this would show at the documentation body,
> a sneak peak of this series (together with the other pending
> doc patches from me) is available at:
> 
> 	https://www.infradead.org/~mchehab/kernel_docs/devicetree/index.html
> 
> This series is available on this devel branch:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=dt-docs-20200228
> 
> and it is based on next-20200228

Thanks for doing all of this work!  It llooks nice.

-Frank

> 
> -
> 
> v2: Fixed my email address and removed extra wrong SoB on all patches.
> 
> 
> Mauro Carvalho Chehab (12):
>   docs: dt: add an index.rst file for devicetree
>   docs: dt: convert usage-model.txt to ReST
>   docs: dt: usage_model.rst: fix link for DT usage
>   docs: dt: convert booting-without-of.txt to ReST format
>   docs: dt: convert changesets to ReST
>   docs: dt: convert dynamic-resolution-notes.txt to ReST
>   docs: dt: convert of_unittest.txt to ReST
>   docs: dt: convert overlay-notes.txt to ReST format
>   docs: dt: minor adjustments at writing-schema.rst
>   docs: dt: convert ABI.txt to ReST format
>   docs: dt: convert submitting-patches.txt to ReST format
>   docs: dt: convert writing-bindings.txt to ReST
> 
>  Documentation/arm/booting.rst                 |   2 +-
>  Documentation/arm/microchip.rst               |   2 +-
>  .../devicetree/bindings/{ABI.txt => ABI.rst}  |   5 +-
>  .../devicetree/bindings/arm/amlogic.yaml      |   2 +-
>  .../devicetree/bindings/arm/syna.txt          |   2 +-
>  Documentation/devicetree/bindings/index.rst   |  12 +
>  ...ing-patches.txt => submitting-patches.rst} |  12 +-
>  ...ting-bindings.txt => writing-bindings.rst} |   9 +-
>  ...-without-of.txt => booting-without-of.rst} | 299 ++++++++++--------
>  .../{changesets.txt => changesets.rst}        |  24 +-
>  ...notes.txt => dynamic-resolution-notes.rst} |   5 +-
>  Documentation/devicetree/index.rst            |  18 ++
>  .../{of_unittest.txt => of_unittest.rst}      | 186 +++++------
>  .../{overlay-notes.txt => overlay-notes.rst}  | 143 +++++----
>  .../{usage-model.txt => usage-model.rst}      |  35 +-
>  Documentation/devicetree/writing-schema.rst   |   9 +-
>  Documentation/index.rst                       |   3 +
>  Documentation/process/submitting-patches.rst  |   2 +-
>  .../it_IT/process/submitting-patches.rst      |   2 +-
>  Documentation/translations/zh_CN/arm/Booting  |   2 +-
>  MAINTAINERS                                   |   4 +-
>  include/linux/mfd/core.h                      |   2 +-
>  scripts/checkpatch.pl                         |   2 +-
>  23 files changed, 446 insertions(+), 336 deletions(-)
>  rename Documentation/devicetree/bindings/{ABI.txt => ABI.rst} (94%)
>  create mode 100644 Documentation/devicetree/bindings/index.rst
>  rename Documentation/devicetree/bindings/{submitting-patches.txt => submitting-patches.rst} (92%)
>  rename Documentation/devicetree/bindings/{writing-bindings.txt => writing-bindings.rst} (89%)
>  rename Documentation/devicetree/{booting-without-of.txt => booting-without-of.rst} (90%)
>  rename Documentation/devicetree/{changesets.txt => changesets.rst} (59%)
>  rename Documentation/devicetree/{dynamic-resolution-notes.txt => dynamic-resolution-notes.rst} (90%)
>  create mode 100644 Documentation/devicetree/index.rst
>  rename Documentation/devicetree/{of_unittest.txt => of_unittest.rst} (54%)
>  rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)
>  rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)
> 

