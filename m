Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2405C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1AB21739
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEJ34Y6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgBJTQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:16:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34066 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBJTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:16:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so4190173pfc.1;
        Mon, 10 Feb 2020 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FR5Haon15BG7fZreS9CoW6URIzJo2qBtC7hHF2/jroU=;
        b=fEJ34Y6BdA6w6G5S2Jhq1WIaZBcBZl0N1iHwv29/wstPx85iA7k/XQuCVR0ogOx1rM
         CyCAPsaV9pFqXT17ET1G1SSpmC5y7bHHsRRVLu3db4hLyVQdfq/crCKdsMtmlkKW6yrN
         cv9QaAcAKSqGCAf+m9F+bzSOVnTVajmt5aJo1ft0ViBAusQlf7gxEKgroFK5ocp0+pJ6
         fME7BZW/0CGHztYJCLOHUWJNT/Vnjb2qIhUmHKCHOrvupR3Al2yRErRrtd9pLWvv0sxT
         GK0V02k2wJ8MdtNyYltsbxXKMvWyGEhoy5SC7o0n4vj/Y5UwN8TDl3w/f/4Ix5zPQOrb
         eSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FR5Haon15BG7fZreS9CoW6URIzJo2qBtC7hHF2/jroU=;
        b=qStadNzm0DbOmcK1W3TbS5mej7e7JvkUVKchEnTdZUwq5GYzOfV2yX0lruzfkybaUX
         6h5EIlx1S0DOcLKjkk2rwEx6PhZcD33OBkOTMEy1yy+Btm3CQq1YwD/tXoH18B91s43O
         ZStdU6u12vyZHEqhhoHGCrTHfvmJKftPtF9CbXAMAqNiteDxA7+4RnzSkV4k4wPqNWS8
         f7ODv2ttLPfBfMXg8ekyO2lpIAz5rxR1KCIFdlnwZIRWn0+XtiHEFyWejZuc/lX7YO8T
         ZB6Ond9+l2WqOORje6ZFOcm+Ovyvi52vdU6YEGCxdpDpka7KkFap17orEQRjtrYES6vX
         CoEQ==
X-Gm-Message-State: APjAAAX6+yeoSnWqtkrfCap3/l+hfOMQxIAip5XiPl8BlBxxLNtgjRmZ
        tgx2zI6fvU9N33Q8Cins4u8=
X-Google-Smtp-Source: APXvYqwPiKX4wT4FkdKVUqaP0LU+nKJY5DjilOXG82qBEoG10vdlSb+ndGb96C5hXAksxQfSq6VqJQ==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr2597823pfl.32.1581362193401;
        Mon, 10 Feb 2020 11:16:33 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::2:87f0])
        by smtp.gmail.com with ESMTPSA id i9sm1168592pfk.24.2020.02.10.11.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 11:16:33 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:16:30 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] usb: gadget: aspeed: read vhub config from
 of_device_id
Message-ID: <20200210191629.GB5346@taoren-ubuntu-R90MNF91>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
 <20200131222157.20849-2-rentao.bupt@gmail.com>
 <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xe0b+zVNqf8v5YXOLkzqDeb4JHqec-bqFpaVFGTwHThhA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:47:02AM +0000, Joel Stanley wrote:
> On Fri, 31 Jan 2020 at 22:22, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch moves hardcoded vhub attributes (maximum downstream ports and
> > generic endpoints) to "ast_vhub_config" structure which is attached to
> > struct of_device_id. The major purpose is to add AST2600 vhub support
> > because AST2600 vhub provides more downstream ports and endpoints.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> This looks generally okay. We should wait for Ben's ack before applying.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks Joel for reviewing the patches.

Cheers,

Tao
