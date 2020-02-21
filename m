Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8234C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6AB206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxldTl8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgBUB7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:59:52 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39156 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBUB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:59:52 -0500
Received: by mail-ua1-f67.google.com with SMTP id 73so118710uac.6;
        Thu, 20 Feb 2020 17:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RdVfbVZXGWk8XlFb7DhCE4Y68FuCmDQuU4O4AdDKTpI=;
        b=UxldTl8dDH1NqcSIeaVFSZzPy9UhFBhamL5nZKIoaU/4voigaEGYM3gJ2kZMebhFcC
         4rvHBYGaWgaqLi6zDYbkq4fepTTp/7+178uwwDcerCbttbmdP5NL+7tJ3V0XmXqHINO5
         5aJxH66aC/qNywwe6zkoOcKwd7XL+BohbIIEaxboom3xq3xcMqIj9BpHB+xehNPAXleC
         TOxOUnlglbo9B5jh0r9CATQZRmT+A74oAyFHOMjcFTU9v4xN8uG9FWfS1Bk8CNQKOL4L
         B7nzHeymtwVjoCCRMnb5vLvd+cT7ykgpO1nb1jKUyB9izHbT7R8s67+HlyVl2AW5h1jE
         wSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RdVfbVZXGWk8XlFb7DhCE4Y68FuCmDQuU4O4AdDKTpI=;
        b=YUWgCmyqt9picJKOBKCVn+irfCJ82ypdA9oqRjrYChSItQXOpwjQYs3vXFYkNPgIEv
         Fqrz48y9zD29pYBqNvdR3DfzClUilrLUU+f6Af6SCaJZIQB3PsPmiGUHfqRPCLO4QUSw
         dYZ+Ja0Bxh9ejtCTdEzd9S6mP2HlLVemIrTgtzQd8PeFdfpW6cQAHhq1vPYC7Wcxdhza
         NwJirE1M3ZB+h/OxHTZ/FCx0ifHr5HrSz3QKzQYqbBVNdcAq514oiw4PqrrzOuVaznqt
         G76MV9MJc/P+Aml412N5/O3MH1m2vNUsPdV2qRuFjYD1tEe3bPaEUMctWgDWSlYS6WcR
         Pnyw==
X-Gm-Message-State: APjAAAU+D2UkTgC+C9DW16WWApUK8jESoqnvIvzU6lvLylyvdAYvj2RE
        6BOEIgiulY62yDhSc4v+5kuTuEngscpPgRHBfaY=
X-Google-Smtp-Source: APXvYqzvAhgnhGuKxVxgEOOU/vbidi82mqkro09LPprbwsqNGz7iD8xA6ZnCMsiJGe/Wa6C7yJZ5/FYSF/VqcRCFL/s=
X-Received: by 2002:ab0:45f2:: with SMTP id u105mr17834631uau.115.1582250389422;
 Thu, 20 Feb 2020 17:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20200219141817.24521-1-narmstrong@baylibre.com> <20200219141817.24521-3-narmstrong@baylibre.com>
In-Reply-To: <20200219141817.24521-3-narmstrong@baylibre.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Fri, 21 Feb 2020 09:59:38 +0800
Message-ID: <CAKgpwJXVo_Psyu45+KfRKsTRBc6LRWSvUw2CWdUQseAoKd2p9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] usb: dwc3: gadget: Add support for disabling SS
 instances in park mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Felipe Balbi <balbi@kernel.org>, khilman@baylibre.com,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thinh Nguyen <thinhn@synopsys.com>, Tim <elatllat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> =E4=BA=8E2020=E5=B9=B42=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:18=E5=86=99=E9=81=93=EF=BC=
=9A
>
> In certain circumstances, the XHCI SuperSpeed instance in park mode
> can fail to recover, thus on Amlogic G12A/G12B/SM1 SoCs when there is hig=
h
> load on the single XHCI SuperSpeed instance, the controller can crash lik=
e:
>  xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint comm=
and.
>  xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
>  xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume de=
ad
>  xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint comm=
and.
>  hub 2-1.1:1.0: hub_ext_port_status failed (err =3D -22)
>  xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
>  usb 2-1.1-port1: cannot reset (err =3D -22)
>
> Setting the PARKMODE_DISABLE_SS bit in the DWC3_USB3_GUCTL1 mitigates
> the issue. The bit is described as :
> "When this bit is set to '1' all SS bus instances in park mode are disabl=
ed"
>
> Synopsys explains in [1]:
> The GUCTL1.PARKMODE_DISABLE_SS is only available in
> dwc_usb3 controller running in host mode.
> This should not be set for other IPs.
> This can be disabled by default based on IP, but I recommend to have a
> property to enable this feature for devices that need this.
>
> [1] https://lore.kernel.org/linux-usb/45212db9-e366-2669-5c0a-3c5bd06287f=
6@synopsys.com

This is not for gadget, patch title should be:

usb: dwc3: core: add support...

Li Jun
