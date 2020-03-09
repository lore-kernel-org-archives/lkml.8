Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1871C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38902465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583770411;
	bh=TDYkvlAtzA2lzY6sB568qu7yfstDt1b6Pf/NGw0g3Ik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zmFjeauq7Nz6zUOfbj6TohKHJZHodhPoHMeUpQnpeWidizj65TUZ8jRfu/L8nWktt
	 5ke9vM559BB0F47XWnn0vNTJglGVWbUSRZqbPzSMMeQNAOrpQJUKamcE8lRABksInx
	 GUVDp4FnmE3QhGbvxJt+abBR2VvMJY87ywHZ9WfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgCIQNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCIQNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:13:30 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D492464B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583770409;
        bh=TDYkvlAtzA2lzY6sB568qu7yfstDt1b6Pf/NGw0g3Ik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wh5E4EmggfrL0sJx1hV8ccYd4hFSjQI8d7JR1kSiQzgxvJ0Lmn/fEG1BgOANbd+At
         TI7rMIxz5G6VnC/kaUEtnDjlYvgRVgqWL/g+eERlc/IOrOdG1BPaFGB5PvFbn2H9x+
         wowoEC9t+eQieL6ajNCTFYp1o4jEbznVQeRG9elk=
Received: by mail-qk1-f178.google.com with SMTP id f3so9786074qkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:13:29 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2R53tx1g/eRVlffL0uxKxnThb5//P9d4+wILIf8h+TFwKdasd6
        TDtPCR2FJOimvcg16WXFhYOa1MIi/PnclICEvw==
X-Google-Smtp-Source: ADFU+vti6dm4SjcS2tHbnND5IzeOR9gQBTGuWnGy5VnX2ldt8PCue3Qg/463FA7FHvkIa8BkEmE7fqJHaHpSawMO+y0=
X-Received: by 2002:a37:aa92:: with SMTP id t140mr14351690qke.119.1583770408632;
 Mon, 09 Mar 2020 09:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200219080024.4002-1-lkundrak@v3.sk> <20200308140434.18b0f947@why>
In-Reply-To: <20200308140434.18b0f947@why>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Mar 2020 11:13:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+cVWTAa8GwfrDhmNHoVauT61oYnpMNpY1N0Bz-bMutHg@mail.gmail.com>
Message-ID: <CAL_Jsq+cVWTAa8GwfrDhmNHoVauT61oYnpMNpY1N0Bz-bMutHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] irqchip/mmp: A pair of robustness fixed
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 9:04 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 19 Feb 2020 09:00:22 +0100
> Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> [+RobH]
>
> Lubomir,
>
> > Hi,
> >
> > please consider applying these two patches. Thery are not strictly
> > necessary, but improve diagnostics in case the DT is faulty.
>
> Can't we instead make sure our DT infrastructure checks for these? I'm
> very reluctant to add more "DT validation" to the kernel, as it feels
> like the wrong place to do this.

We don't really have a way to say a binding can only occur once or N
times in a DT. We'd have to have an SoC schema that listed out all the
nodes in the DT and forbid any additional nodes. I don't think that's
too useful as if there's only 1 instance for a given schema, then the
schema is not too useful as the schema has a equal chance of being
wrong.

Is there something inherent about the h/w that prevents more than one
instance? If support of more than one instance is a kernel limitation
(because no current SoC needs more than 1), then shouldn't the kernel
protect against this?

Rob
