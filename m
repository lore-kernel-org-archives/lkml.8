Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B5FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB1E208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlO3Og2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEF4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:56:36 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53895 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgCEF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:56:36 -0500
Received: by mail-pj1-f65.google.com with SMTP id cx7so2004484pjb.3;
        Wed, 04 Mar 2020 21:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kM7p6iQbBTR9YfCmEPNGr14KUbGdbLJ4CLDWGt5kFJE=;
        b=HlO3Og2d5uy8+jp2KNfqeoyI4ZzMgtcXv4THIEFH85qz7Iq3CW0zjGMg2ETeHkdf0V
         VfmgUBsyW7Jv13z0mcKXYBkdDBaLI54IS0UyeQlJLstHLl5tFiobCZpnJiZsTvjy/xtr
         IitH9OrIam7YtS4J0jySlx3bJ1+oRszQjn4O1QAdYKQURxzKhQyUjCew0o5yCHtWSLGB
         8P/iAqypxNaRFRkV7JXfP/9XozHsM7QnUa4ZQTnBpz3bMdPFKA5pQbcbOsUCeBNzBmzZ
         ElL/a94ot2WKiPA5nfZj8I7tze2spp6X99eodAnnRLaPSfDMrPH245IVIILue0GP4HdF
         Qp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kM7p6iQbBTR9YfCmEPNGr14KUbGdbLJ4CLDWGt5kFJE=;
        b=VVR/Aj5nIMGjFoQhMTk3zN+7nJIp/NWUdZk+pAj9VF/RrBnEVO4gNfkAFnp39DNh5Y
         g5tEu0kUQChkJRQzYl4UVU4S97GsSG3TAJzabkp1/5JcsBLmOJD++UaWdl7WfxNcp2mc
         4k6qABmOXZP19ycEN4YB28BSiYHQ7PWxRzanj3mHoKWRFC72hR18SYj+bFfNCSWR3UVH
         7GQvu5yw/FNGVOgxUb68ZeKE/Bm/2RsW+IIvtnB+GsIyHr0lfaV0E6zfY9GBIowf2Ipc
         cr4w6J8T/0EgoJ2PpkkHbWCQmVGeyJvCeZL3azZdoWZsWogfLMC74NpJe/LFIh+dNZrD
         EntA==
X-Gm-Message-State: ANhLgQ0rrlg/lT4chDDqK9C/Gax4iU9gEfvEZYBWuuwKfty3HlM4ZOr6
        WC545tnFHB4HgCUvt60b5xI=
X-Google-Smtp-Source: ADFU+vuE/IWJczM8wvkwqfTmwzFsFPEGEEsXubYB4VEY+7Kg1OaMFur89CTyXpNeC1VHckqxBzMhmA==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr6325624plb.219.1583387794925;
        Wed, 04 Mar 2020 21:56:34 -0800 (PST)
Received: from taoren-ubuntuvm (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id m59sm4784883pjb.41.2020.03.04.21.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 21:56:34 -0800 (PST)
Date:   Wed, 4 Mar 2020 21:56:27 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH] usb: gadget: aspeed: improve vhub port irq handling
Message-ID: <20200305055627.GA2296@taoren-ubuntuvm>
References: <20200305023859.21057-1-rentao.bupt@gmail.com>
 <8a9033d5e76951f5bec39531c5d0e0d6ef963ee5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9033d5e76951f5bec39531c5d0e0d6ef963ee5.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:35:08PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2020-03-04 at 18:38 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch evaluates vhub ports' irq mask before going through per-
> > port
> > irq handling one by one, which helps to speed up irq handling in case
> > there is no port interrupt.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Looks reasonable, but did you try a find_next_bit() loop and whether
> that's faster ?

Make sense. It should be more efficient especially when most ports are
idle (and I guess it's a common case). Will try and send out v2 soon.


Cheers,

Tao
