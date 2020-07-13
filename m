Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAF8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5FE20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594676390;
	bh=agAsipOozBPukSLhCM4m4vjLI/D7R1E+uScF3vXv/tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KQoODGmH/VspxZXASmDnt+yzdTfSLfVHMAHKGodB1gSOyru23xvLPmxw7wi0D6aF5
	 nai6mbJkPJTkROeFdJmwaHPdN0zPwt6qDOcV4vfx52vdPiCKzHjzDPbkUqf/UnZjCe
	 HvId7/6DefrY4bMXyhiymr3xYLwMT9ZSmo2TbNG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGMVjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:39:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33412 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGMVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:39:48 -0400
Received: by mail-io1-f66.google.com with SMTP id d18so15176303ion.0;
        Mon, 13 Jul 2020 14:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEcm7UlnpLxi1nja2AkUVi4pjG1g2ySwAI8pwvIKG8c=;
        b=ft4cXyPXoYMS9G7q0WHWN0cm4tq8tIHkZdgsYhoZ8+qqMh9x+1CwXztsQNE0oL8dPc
         XlUZjkfMKKFr9drnrPNmmlh9w/1eTmarfBt+jTzDHAGYv4cypuGDHmfucWxvHyU7qjuK
         8QMVy8iw+goGm7z+aXyHQj8+t8pN6XshhiC5TmLwaELe/lPcvkjuGrK/14SL3/QcmJjq
         4bbW1hd2JR7SvVCqnVjy//ern+ftYUdN2OFPjlBQdTXd5D1XEvnNddR2mNe9oUPEYFYl
         g9tR+yBEKZm8gMvgAauM1y1ImvfljCSkQvp+jpFW1ZYS/oTFStB+lBjqFBM5jpiaZT+L
         vWZg==
X-Gm-Message-State: AOAM533q2oDB05litIAOScI1zqtol9Ke7qnpqEe7jy4jALao27nNVNp5
        bywKqDMQgZIdQJIlhcn2+w==
X-Google-Smtp-Source: ABdhPJxyncAsqE/oRaGZKws0ZzryaZj/+lu/e8IRy1d+IxsmK90AXDKTJkJUTjqo8Y/Px0bpUP70Vg==
X-Received: by 2002:a6b:ee15:: with SMTP id i21mr1820321ioh.25.1594676387812;
        Mon, 13 Jul 2020 14:39:47 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s190sm9365357ilc.28.2020.07.13.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:39:47 -0700 (PDT)
Received: (nullmailer pid 774524 invoked by uid 1000);
        Mon, 13 Jul 2020 21:39:46 -0000
Date:   Mon, 13 Jul 2020 15:39:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-actions@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 4/6] dt-bindings: reset: Add binding constants for
 Actions S500 RMU
Message-ID: <20200713213946.GA774478@bogus>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
 <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 20:05:10 +0300, Cristian Ciocaltea wrote:
> Add device tree binding constants for Actions Semi S500 SoC Reset
> Management Unit (RMU).
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes in v3:
>  - Added Philipp's Acked-by tag
> 
> Changes in v2:
>  - None
> 
>  .../dt-bindings/reset/actions,s500-reset.h    | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 include/dt-bindings/reset/actions,s500-reset.h
> 

Acked-by: Rob Herring <robh@kernel.org>
