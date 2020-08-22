Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888FA2078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598114787;
	bh=1ohyST/PuDoCW74MHk6Nw9LjHmwd0LxLYntnLLQG21U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jLKbfH3JGRUUCaeGhomeBULM7JHcBPRhCjZ1gr16CVqX4TXZLOjE2YA5ewuiHJDNb
	 kcjgzV61m9OrkyPDM6fkChHgaqUbjiE1Ao+nivW0EmtEGVUy/asxHZuDhCB5mo2CQi
	 i3DxrfVJjVx/+k3KShGhAwP8rAuJ2KuHiVLLILVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHVQqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:46:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgHVQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:46:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so658117wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5R45WyIAnbqcbbG55mI98dayf3fujaKdC3EcpGTogHM=;
        b=AZyowdGGbEfBnvVtt7LvbL2HHfACQvs94ZCrb2bUb7rINl9UGGTau7RglXZ9G83XAm
         +Bs5zV9XAGOQWhjgISlCog25p0lh/taU+KpnSpVJpIWARTrrkVsYSJBEm0Lig/5Ca/B3
         WfBNI6f3sP9iStSK6drK1Ax4PoFE3mY8NBplXBdyPEispkaDroCKy0DP8vmkaaLE6nlK
         KNgGTV/gV45HnIvtPBRhWYq1Nqa65Y8FlgRWFXZPKZFP32F5LN5gofX7FCucczdvzEJQ
         YFgueOBU1WIpR0dV4v+XnOFzfBIpgHQwK+0u5bn0wp8MUU+TsgTsyBOdlU7ZcLYxgO8o
         0lbg==
X-Gm-Message-State: AOAM531WFO+9LzrEgkk2GRUg+Ej7Qz1G/1DnZNSs8inzwbiwxjn5G5Qf
        d39yFN6M8a1MtYImXKIe29Y=
X-Google-Smtp-Source: ABdhPJwrLlDLzKRAEQOAmkFk//RPAmiqV9qKTB3cvU2qzDP1KwESo/2+/t7CkhIrX4XhQve2+P3TPA==
X-Received: by 2002:a5d:5485:: with SMTP id h5mr2710942wrv.247.1598114782209;
        Sat, 22 Aug 2020 09:46:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id z207sm14816477wmc.2.2020.08.22.09.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 09:46:21 -0700 (PDT)
Date:   Sat, 22 Aug 2020 18:46:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
Message-ID: <20200822164619.GA24669@kozik-lap>
References: <20200821165221.32267-1-mmayer@broadcom.com>
 <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
> On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> > > We would overrun the error_text array if we hit a TIMEOUT condition,
> > > because we were using the error code "ETIMEDOUT" (which is 110) as an
> > > array index.
> > >
> > > We fix the problem by correcting the array index and by providing a
> > > function to retrieve error messages rather than accessing the array
> > > directly. The function includes a bounds check that prevents the array
> > > from being overrun.
> > >
> > > This patch was prepared in response to
> > >     https://lkml.org/lkml/2020/8/18/505.
> > >
> > > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >
> > Your Signed-off-by does not match From field. Please run
> > scripts/checkpatch on every patch you send.
> >
> > I fixed it up, assuming markus.mayer@broadcom.com is the valid email
> > address.
> 
> No. I have always been using mmayer@broadcom.com since it is shorter.
> That's also what's in the MAINTAINERS file. Please change it back. I
> accidentally used the long form for one of my e-mail replies which is
> where the confusion must have originated.

I'll drop the patch then. You need to resend with SoB matching email.

Best regards,
Krzysztof

