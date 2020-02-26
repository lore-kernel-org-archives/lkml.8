Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A885C4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421BC21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TP4r/v/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBZOqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:46:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52272 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgBZOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:45:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so3376558wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rmFUzbibCiaXG6y+WhAW4WtcoKQ1GCoHlB1PKQP/KH4=;
        b=TP4r/v/1/xAS5Y9v1p3YSuePjMFCb5d4uqBwxGHhXYofmQ7l8Ah0Xu3bTban2pVopK
         Ph6qbApCk8ty7YyCCi/wZQ0OVnN2AYiCLOt6+VTnDYiByqVlPx3moghBIWkWApqUtOWv
         Fy4dA1tl9cqVufQsGLNDDYsjmAjrP5Cx0BuPU4rPsz00CFjhonUzQB7/ZJcPfEUXcb6h
         yNEv8cNcS2IT98bWyvWaP53VgIKy+KV6EJxMWIZa5WZrPcvGy6KT4x4WJ7rDZIr2Kdlz
         kxVhGrKm+i67DX4errOF37XQ9sXKcw1Wh0BV5BLOof8GjFvb85lkQQI766Zn0MBs5r9E
         nnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rmFUzbibCiaXG6y+WhAW4WtcoKQ1GCoHlB1PKQP/KH4=;
        b=pzBQo3WFl7ftsveNxrTx5vRO/FKlgDCKG1lpoKgJ6josi+x0v25lbfnGyc0md/XGUr
         dS/3hOof9pbUPuKzN1tFPsVhJP2+61rSmquGlIA2P0SJ/Ybt7YU4WfgSLnfgmNhWVYbu
         fmd+NVkAx7ZOWqHc6+RM37RX4dAJtAZAUHU9AEb4N0CEu/qPrh90KoQ0sfKaMJH8DJAx
         orrGLXB+2FIMOcTeCitR9F72WDDSNC+TO1km0G6mdMnQSBLAufWpdM4UF9QwF822qcx+
         tVsuBzKhQkJfvrh4KS2pHU164mwrYcR+hdiJeUdl3NgoTXwWsj07U2WK/H9Qoo1H7MV8
         BLJQ==
X-Gm-Message-State: APjAAAVXZVE2PO4ufErx7ctMi9Q8WdCprS0EfRlBuRI8fuZJip/4otJf
        EoADDW2e7t35qOmVtE9TvyG/7w==
X-Google-Smtp-Source: APXvYqyKBdXVbAfPB7pW4Qb5VP8WgNQGGiJWo2E5P6iNx6zYlTjQX9ijukw84Updx6ZUqWnlWGXhTA==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr5956258wmg.34.1582728357318;
        Wed, 26 Feb 2020 06:45:57 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id r5sm3326553wrt.43.2020.02.26.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 06:45:56 -0800 (PST)
Date:   Wed, 26 Feb 2020 14:46:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "H. Nikolaus Schaller" <hns@computer.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v5 0/5] Add rtc support for rn5t618 mfd
Message-ID: <20200226144629.GP3494@dell>
References: <20191220122416.31881-1-andreas@kemnade.info>
 <6FE7F4B7-7D81-4005-A765-2B447B757B53@computer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6FE7F4B7-7D81-4005-A765-2B447B757B53@computer.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, H. Nikolaus Schaller wrote:

> Hi,
> 
> > Am 20.12.2019 um 13:24 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > In the variant RC5T619 the mfd has an RTC. This patchset adds
> > support for it. To do so it adds the missing register defines in 
> > rn5t618.h and general irq handling for that.
> > It seems that the irq definitions are the same except missing RTC
> > but due to missing ability to test that I do not add them here.
> > 
> > The rtc driver itself is based on 
> > https://github.com/kobolabs/Kobo-Reader/blob/master/hw/imx6sll-clara/kernel.tar.bz2
> > but heavily reworked.
> > 
> > It was tested on the Kobo Clara HD.
> > 
> > For cleaning up there is a separate off-topic patch:
> > mfd: rn5t618: cleanup i2c_device_id
> > 
> > Changes in v5:
> > - static rn5t618_irq_init
> > - PLATFORM_DEVID_NONE
> > - added some Acked-Bys
> > 
> > Changes in v4:
> > - use macros for IRQ definitions
> > - merge rn5t618-core.c and rn5t618-irq.c
> > 
> > Changes in v3:
> > - alignment cleanup
> > - output cleanup, remove useless toggling of alarm flag in rtc probe
> > - updated bindings description, so patch 1/5 becomes 2/6 and so on
> > 
> > Changes in v2:
> > - no dead code in irq code
> > - various improvements and cleanups in rtc driver itself
> > 
> > Andreas Kemnade (5):
> >  dt-bindings: mfd: rn5t618: Document optional property interrupts
> >  mfd: rn5t618: add IRQ support
> >  mfd: rn5t618: add RTC related registers
> >  mfd: rn5t618: add more subdevices
> >  rtc: rc5t619: add ricoh rc5t619 RTC driver
> 
> what has happened to this series?
> It looks like something got lost so that it has not yet arrived in linux-next.

It won't show up in -next until it's been reviewed/applied.

If it's not been touched for a few weeks/months, assume it's slipped
through the gaps, collect all of the *-bys and submit a [RESEND].

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
