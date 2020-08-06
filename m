Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2407C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FF62086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Q0Vkd8f+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgHFQzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgHFQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:55:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A388C0A8896
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 07:46:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so9097129wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLXqGFGiHgPstKedhUHjfysLbjGakCzVB3i4zDx+oWw=;
        b=Q0Vkd8f+xEGj7g+Tfc/bf7PgGTANOuxb8H/vt4RA8nQe0K9jblkNaMap5vDZwOxwRH
         jtVczWc4chEpp+xh4NPMhlEUHFF83KX3i+4LOutvQnN1JiU9nq85rZ0MbqjQMUtAK/yf
         1aI0JEz98Tx2V1OOL9Blul3Bt50mZ7MHmN4yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLXqGFGiHgPstKedhUHjfysLbjGakCzVB3i4zDx+oWw=;
        b=Od0O4XFKOCkv4XGA7V/aPlKEj2QNB3thi2PL7CpGIS3SuUS6WiBd+ggCo6vfUF07LB
         3mC5qdGDBI9RXpLPIjT9X/d9rdsvLTCznJiQKa6btTKMQQ4eU0p11BBFWRIqPq8LcCYS
         G8SWh4+fgLmcsCPnv8OTY/HGRy8Yr9f98k9V9us3vh1tiV2lFmlvhRqK0/vlsqgwpQoO
         IAF1bg4nNKoDfUWgyksImhimPHP7ORq7BYGYnMmVHavN/+sZESr5aEog/9Un+EZk15Eu
         sGOzRU3/jrSsz5t5/g5k/hs2Mbu4TucNF6YW6LKukaZ8/rgIExsCJ8gJqkagSU2bpfaj
         OChg==
X-Gm-Message-State: AOAM5311DvGp2IuYyB2/MfzOJLcvnn59Aof1RDMCn0oJd6j/kui0Hs8f
        szhIQ5Vq4hJiV9zDX8Pw9C9fsEbCylbxQ/OYpOfO8Q==
X-Google-Smtp-Source: ABdhPJyRPdnu/4oes4dUWniKCpXd9HW462x3vl7mDrEPqKHwTpf2ehRX8ZMMFSRZUR47QXpMdE14WQ64HNIMpiKFVSE=
X-Received: by 2002:a1c:2646:: with SMTP id m67mr8832227wmm.137.1596725171925;
 Thu, 06 Aug 2020 07:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200805110052.2655487-1-daniel@0x0f.com> <20200805110052.2655487-2-daniel@0x0f.com>
 <CAL_JsqK5YWe71HU+bSMG2uNZOgFN85x4zatuiS-fkUYKXHDs-w@mail.gmail.com>
In-Reply-To: <CAL_JsqK5YWe71HU+bSMG2uNZOgFN85x4zatuiS-fkUYKXHDs-w@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 6 Aug 2020 23:46:16 +0900
Message-ID: <CAFr9PXn_RSwWoaWEmW5m1pBVgo5c41KfEy0db-cgt0+v_sv5Ww@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt: bindings: interrupt-controller: Add binding
 description for msc313-intc
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 6 Aug 2020 at 23:15, Rob Herring <robh+dt@kernel.org> wrote:

> Why are you sending another version? You ignored the errors and my
> questions on the RFC.

Sorry I didn't think I got any responses RFC but after searching it looks
like the email from your bot and your question about the two custom
properties went into a folder I wasn't looking at.

Based on Marc's feedback (that there should be an static irqchip
struct for each variation)
I'm going to drop the custom properties and make the metadata they had
part of the driver. They were basically there to try to make the
driver universal.

Again sorry for my mishap.

Daniel
