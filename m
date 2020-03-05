Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D2C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AF320838
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uE5L3OIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCECgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:36:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34199 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCECgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:36:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id f2so3174083pjq.1;
        Wed, 04 Mar 2020 18:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vq5qjs7qz67UNM1UqkjHI/TeAVWlJM1Ckq9qqFzOF58=;
        b=uE5L3OIFH7hgJXdE2xCGSnwOEDkEdOH6qfYcBHj7RrpUuVb8NudQzuYzTLzNigApeY
         xobwj3AdEYtxjBRciNj1RXv+Qnem14byPSHBdlQcEErL8Dxx25Orm2wuubO/5QumyzO5
         zgN0+CUWswBgTFj0daaQ2uMSjwp+6ucbZkxp4g+BLqqsemJCNXTDjsienFBprKW2wgsk
         fo1whqLhoCLPykP2ghqcoFgLOPuhiiybH5KKwGp0bH7/6lQ3Qyygp6OJRjkPrLUElinK
         yP+ZWBnjOtFegqqs54R0PVV4caZaYQbjqsQtShhCVSGY0pv0enLCA7MU50OpdnfIEPDt
         bdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vq5qjs7qz67UNM1UqkjHI/TeAVWlJM1Ckq9qqFzOF58=;
        b=hxeQSfXQKwn2oMozb9RVOyBzhAk8XtCqGHvUpQAtehoXW93kQ7OGdJgyQ5L6gejotv
         5+DfaYDKhrmRdBz4ggmeMeZTV1j46ALDDwgwUG8VT7bG8BoIwsRd41SjyHG/wXdPEsjP
         BNUwn82RVHJw6f2MY/F56iA4xBha1iy1/GCCt9/yFHhMVKWaqnezjJwHdCvM17C6f2wv
         xkebmGVXqr9SEp+LiEvPC/X+VE2NCi8o5RwyDTKfOqm8r9be3WKPYWLuGifDOFz+K629
         1I+To9hkZidRumNQfnLBivS43kRCRPzsJcd4ttbDt0zlfpu00b29++Xhynz8g0RLotwy
         yW8g==
X-Gm-Message-State: ANhLgQ2GrQS0GjP+nA5jT941vB3UyrHxp9HjDLQ6gJfqBjpBpiv6QYzC
        dMqtrYT3HB5iwaKbKSdpoFw=
X-Google-Smtp-Source: ADFU+vtegKp7SsWIhtQi5FLswdvNjiO6nAc+nLdA+8v8NJ3m8Z1MDgeAPG6oduDk7/r++EGg7Ok6bA==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr6165058pjn.141.1583375780299;
        Wed, 04 Mar 2020 18:36:20 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::5:7dc6])
        by smtp.gmail.com with ESMTPSA id b3sm3961744pjo.30.2020.03.04.18.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 18:36:19 -0800 (PST)
Date:   Wed, 4 Mar 2020 18:36:11 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v7 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200305023609.GA15787@taoren-ubuntu-R90MNF91>
References: <20200303062336.7361-1-rentao.bupt@gmail.com>
 <20200303062336.7361-8-rentao.bupt@gmail.com>
 <20200304161610.GA26873@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304161610.GA26873@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:16:10AM -0600, Rob Herring wrote:
> On Mon,  2 Mar 2020 22:23:36 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add device tree binding documentation for the Aspeed USB 2.0 Virtual HUb
> > Controller.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  Changes in v7:
> >    - updated to dual license.
> >    - removed description for "reg" and "clocks" properties.
> >    - Added constraints (minimum/maximum/default) for vendor specific
> >      properties.
> >  Changes in v6:
> >    - added 2 required properties into example and passed "make
> >      dt_binding_check".
> >  Changes in v5:
> >    - updated maintainer to Ben.
> >    - refined patch description per Joel's suggestion.
> >  No change in v2/v3/v4:
> >    - the patch is added to the patch series since v4.
> > 
> >  .../bindings/usb/aspeed,usb-vhub.yaml         | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

Cheers,

Tao
