Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E13C4724C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E446821655
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxvGAhT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgECOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgECOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 10:50:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8EC061A0E;
        Sun,  3 May 2020 07:50:02 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y26so9699304ioj.2;
        Sun, 03 May 2020 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1Ggi2tOtn6fWjPzvZwzQsgJOov1/FsKi8Om8sDMRcA=;
        b=HxvGAhT9OTNgDUFLYzZZRcoKMfhGjPBshUnyOSIlMXSNcv9h4/Oz/o13+7VqT8UxVr
         GLfT479WXZaLdb87jHp9szW1ydM+olqSwgfBXwJ/1wmNMXmE0eBqXLRAO4FvulgdYqmW
         OqykNoHblX1DfvOOlq1bWLPODvfKm6n0lvVq5BSgvedpNbZ5xaGzPHcNW/2sEUN26Mtt
         vGNHfaV62vuJTeeqDlXRNnLOMKS0dsoNIiO4FxiI6Uy+y5A6x/8Hx5JZWzTdryi0MqLC
         6EEGCwRbLB1XNl4ntFaKq2KatDVLf0NPst2/NeJErdUgW4GqlCVe6u01dG5Jh5Xxt0yp
         GcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1Ggi2tOtn6fWjPzvZwzQsgJOov1/FsKi8Om8sDMRcA=;
        b=OxTpmYXZ14wAdNvgouYEeAovjxiFzFgTq4j3/IhxLwCn5ZOwn39iu0V8san0d+SJ0I
         5M3ZUzWCqheCC1NUg9jryjoYnTk5H46t8QqwNguLRAZ6Vn8FNK+Xccxg2LdKm+lPl8YQ
         n37A3B1msmmHEgiLd7MPgPDAr6MfwqGGW6YYkIn72d6DlvYQazYhwWM5GbViqmHZjVo5
         TTlSKRPU3UHMbRF3yKBDAtZdnGkV5LirccpVyrYDFpwR4/PHsGEEiMJNV5deQtQxN1Eu
         8I3ag8BoGBO0fkl03X6ONYlfj/AnhcQGywv8bY7dpfrg9lC1ELh7R+ttx/bAnYv/Bs6C
         Zq+Q==
X-Gm-Message-State: AGi0PuaOLfALvoE0LXnwLtJrTtBrvaW8AFqNfsLx6xMA/yVKsCGs5NYp
        meUjvB1arUeEtu3u3llZZEpN8EShuU6nMRbplbQ=
X-Google-Smtp-Source: APiQypLbcKgX3zhmAur79Vn+sc0A1kneTzi/1Vo1IHxvDZMcqShXBChBJ4soO8y6+dAipoLOjkTP4D38bcG/hwiWprc=
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr11782741ioc.178.1588517401325;
 Sun, 03 May 2020 07:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200430124602.14463-1-frieder.schrempf@kontron.de> <20200430124602.14463-5-frieder.schrempf@kontron.de>
In-Reply-To: <20200430124602.14463-5-frieder.schrempf@kontron.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 3 May 2020 09:49:50 -0500
Message-ID: <CAHCN7xJ=srZxygtG6hW_+us=qH1heY-k=EosavYH9tDk-KG0Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] arm64: dts: imx8mm: Add GPU nodes for 2D and 3D
 core using Etnaviv
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 7:46 AM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> According to the documents, the i.MX8M-Mini features a GC320 and a
> GCNanoUltra GPU core. Etnaviv detects them as:
>
>         etnaviv-gpu 38000000.gpu: model: GC600, revision: 4653
>         etnaviv-gpu 38008000.gpu: model: GC520, revision: 5341
>
> This seems to work fine more or less without any changes to the HWDB,
> which still might be needed in the future to correct some features,
> etc.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
Since not everyone uses the 3D or 2D, would it make sense to mark them
as disabled by default and let people who need the 3D and 2D enable
them at their respective board files?

adam

> 2.17.1
