Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D32C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5920674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFu51PxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCIMUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:20:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43096 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCIMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:19:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id c144so4736963pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ej6XSzJLYzxEyi6Ocy5OL+BE9DVMwhDVxnF5ycV3aIk=;
        b=PFu51PxIgJeDVhu7L9GMap2eWWU3fBEtgaGKiFxkIIxq2NO0AqSLX0NdoR2iMu7YsY
         khArj/LGCX97paN9bCCLIdFaV5ZJcY16Ae0m2/SaTJw7xSNOpr6ob7BoMPo+2JbLokMa
         SwMbwkdpWLLoGYPbO9xaYGa5dywKXY4hYWhz0djBT9V98DZUBkI02C5ph3O7NPw7ePpm
         mPD6txkpShzFOePuw/uPXOoaFXOhji2K0WFH5qtoQPAsPk/oUseWFw4A3ep51e65iGNv
         6+taN+BFCB8Ki3+pJetpYCGI7KdhrK8ZSZRaFbWvHWnEDl7he+acJHa1Ve8LrcmMcjYn
         RMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ej6XSzJLYzxEyi6Ocy5OL+BE9DVMwhDVxnF5ycV3aIk=;
        b=pemUawJ99lQPWfW7yvZzbXuhqevLBxVug3jrm5njK/8HF+eyYVBwrj+1fSlrlKoBT6
         UCycCnCRAU+727oiEhtSwNYnQNYawvzm/9C+HjDyi9WbeKuCGrSrfvtHwSTD5BbPb77P
         ewwecqeSS1NI19QdKJb9F533DvBAJHclJ5J7GhIEbIz9Vi3URnekLseJK144UCRTS5oE
         LkaFILWtEFvDgOfaMIYqH3hS2MPi04u5/aw1qEcshIATCyGPx9Yx6JT+/fzHlxFxWzsz
         tyC2yZMn5SWpJG+C2ick0k4oRAnDB90rgwGbSueYmQB3Ku3pk9A2rUFFlvX5QY3/BoTI
         yfYA==
X-Gm-Message-State: ANhLgQ0/5GeUTMw310W409yM45o27ZsOX56ml0PGzD3/jB0+pprPlV4m
        HtVgVFUfWny420VARkEfwOo=
X-Google-Smtp-Source: ADFU+vtClGXedATmMO0ze3AXltE9YTnUAE5pH/7dif6BPipMZxsEXrF9KLZksP0HB/4yi1AHbw0Y4Q==
X-Received: by 2002:a63:445:: with SMTP id 66mr15727738pge.351.1583756397519;
        Mon, 09 Mar 2020 05:19:57 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id p21sm44552991pfn.103.2020.03.09.05.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 05:19:56 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:49:55 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: mmp: replace setup_irq() by request_irq()
Message-ID: <20200309121942.GA10426@afzalpc>
References: <20200301122243.4129-1-afzal.mohd.ma@gmail.com>
 <20200308145348.GA7062@afzalpc>
 <20200308161903.GA156645@furthur.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308161903.GA156645@furthur.local>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubo,

On Sun, Mar 08, 2020 at 05:19:03PM +0100, Lubomir Rintel wrote:

> It has been
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>
> Tested-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks

> (afzal; I believe I've responded with the Tested-by before; please don't
> forget collect those when resubmitting patches in future. Thanks!)

The reason was a few minor changes in v3 vs v2, as that was the case i
was unsure whether to keep it or not, so went conservative & removed it.

Regards
afzal
