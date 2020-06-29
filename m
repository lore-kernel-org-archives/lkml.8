Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E490A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiObvsFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbgF2VSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7DC02E2C7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so9150019lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdM2w64gWRdB5OaPu2OfO505k9M/DLrx4Gj5g+0KkHM=;
        b=NiObvsFRAfhCHcKIZJxxITl4aTiQKwfL1u+ntTGZvpEuV/9T5kPnWzHj4jzMajVBWD
         3sldeMpZn0s2E2a78m73hbUe+N1n2Da/hXYA8IGcRmQjHQBn2Rw1efawF/AC8Nv+sXxT
         yUQd36RQMomGdUmWEOo7F+QSauo3UhrOKnp/GBAYP3niFWgiG43uSP+7DZ4vh/Mtb9y+
         cOQ3TFyWZSOocEqraEQkqP4EAUx/GvFcFJmmrlCeTAL1Ceq+EKdEP0y31kFIi4EwiyBA
         AkZ0hGNsnifC20CQzF3nvb0cfW921DcGW67ej9IJUH2bi/76VDkYyORJcq0BL7RgX88x
         b1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdM2w64gWRdB5OaPu2OfO505k9M/DLrx4Gj5g+0KkHM=;
        b=jQ200iKrtz5y2jZcT+tC120sQ+s5fPwh3fx8ctmQLfe0Z7LM7BHCiRfK/DSg1OMPYO
         Gxw3DiWUGlKWaDVsxGFb9qfKVVtsSAO+/9ISHnbl7xmZSLbeGnKfe8+IyYT+YljmTP2R
         bWj7CWdbUKQs6/XmKRsuQA1svdjO4FbYyOQzxxVzsxyjtpF2OfMaUwWu3ijzYGvnHU5M
         ho+Q7T2jm8FnVkZZ4TUUh6B0IZQXwNPctkktra8W0xjvvUK8im1t81MeySibN0pYM8FM
         gdW/IQ0p+56RvsRVrdlLFDyVTnMbLe2uXA9rpzHaWzxSNFl6N9IAlDKLB0rrvWYeXuQd
         z+tw==
X-Gm-Message-State: AOAM530eiHfVmJLENutVBYHl5OksG8wwmFK/hRBzd3tdKKAST8G4BOVw
        5wxsyuY7OyEzuLFeh9W/LR7PWsWfOXJvD7VZ3zo=
X-Google-Smtp-Source: ABdhPJzx9CClLEmRBgiQDyVnGWmmPmAYo5tJMvnl6sYOxCuC3YGuGckclarIt5klHUynM2zoK9eikriIhKQxYAU31Uc=
X-Received: by 2002:ac2:5962:: with SMTP id h2mr9106265lfp.66.1593439461261;
 Mon, 29 Jun 2020 07:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com> <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
In-Reply-To: <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jun 2020 11:04:09 -0300
Message-ID: <CAOMZO5BgKNKceJmvX+ayeB_z9YWMcJMJmOX7Uf81HTeZ-t7_fQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Fugang Duan <fugang.duan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Mon, Jun 29, 2020 at 10:40 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> I'm sure you've checked that sabresd ethernet works ok on mainline
> even without this patch?

Yes, I have tested several times: without this patch series, DHCP works fine.

Applying this series causes DHCP to fail. The test is 100% reproducible.

Cheers
