Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA22467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACx1kSV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgA1SDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:03:30 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37655 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1SD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:03:29 -0500
Received: by mail-wm1-f50.google.com with SMTP id f129so3601720wmf.2;
        Tue, 28 Jan 2020 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VXoUKEceorTW6ScEpqCWxfy3mB4kZy23/BiHUKjgXwU=;
        b=ACx1kSV9A6il1lbZug/Dlz+lYwQ2D1wO1ovfj1F2S6H7CrDZt7o2fzAVu57z6h9r/w
         wV8ZB2Pw6KXYVBdDk/flKfKMR//nZ1uI1+89aZcloTNXtgNROsden/Fjj2qdXCVTJTz2
         xTln8QvXWu1uSq50cbKSEJBnaG24VVcoIY3FkpTbOLcYSH6emMrLvlMXGBHP+d7JgOer
         ur/qaT/FcPZntUCrVqjMpduOnN93QyPjhKKpCHN3KaqGYsJoGo14GeSgYMdyHYiUNoSS
         Qk5SraxLBKMU/9T+bkbHphFnzaxJojtPyYJvegdWX/uxTRAopbArxMiHQEpJe1lBPVe0
         BKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VXoUKEceorTW6ScEpqCWxfy3mB4kZy23/BiHUKjgXwU=;
        b=flHSKHWMB1mahsYE8NctN/Wxpe01HDRf8+bK0gK+rCinMFJmwPck0rFWirfrzk4hlr
         P+DP8Fjavyjpir++hGVAOj7z0cpUFS+XA4yKD/Czp+z00PpVQhAFdCuu48KnDAQwKVu8
         x9nDbfI66p1LsliqwVzaA8cIucVX9vXSyV6YOGfBMs8BSLGAnCZy6FA/9GFjmBv+OMY9
         jrxC6LUI/8tBMKhKzrEdCwUDqRGwzdRQSFE2xtO+SoV8jn2YLRhn55cpHE6UMPjX/ilS
         V+6RQFTKhDpqEUuGgiWGtX/6wclrKh5w2Gui3f6JHDMZc0tQSH57u9wRq1KoL0V+bI9F
         aS7A==
X-Gm-Message-State: APjAAAVI5tWCL5jAUPRJa1hixQ15f5rt/7CWWSPkgH5KGDSAVHY7EHMZ
        EM0sEs9Qoe5svmrp/l8KgmU=
X-Google-Smtp-Source: APXvYqx2QmMDdsP86IUY6Z6v6kjmqIFgnrNrg0fg4uJ7kTjSJgWI2WKSJ+NbMw8aCa73r+xl/eUG5w==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr5995465wmi.146.1580234607028;
        Tue, 28 Jan 2020 10:03:27 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id 18sm2104507wrc.13.2020.01.28.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:03:25 -0800 (PST)
Date:   Tue, 28 Jan 2020 19:03:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 11/18] usb: gadget: tegra-xudc: use phy_set_mode to
 set/unset device mode
Message-ID: <20200128180324.GI2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-12-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-12-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2019 at 04:39:48PM +0530, Nagarjuna Kristam wrote:
> When device mode is set/uset, vbus override activity is done via

s/vbus/VBUS/

> exported functions from padctl driver. Use phy_set_mode instead.

Nit: phy_set_mode() to make it clearer that this is a function getting
called.

Thierry

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wd2wACgkQ3SOs138+
s6Gq7g/+Il1WuIahxBUiaNO+QsJjKN7QMFuayEBntEui5lNyGV9fIu0NhHznvi6m
KEX3m//OAllxiYLeXSepChA90p5sHS/jFojlEZZ9waoMf/d+W60+gc3V8Lbai9wp
ynceTr9jv3gzuF35ANHni73ohl8FU7VLVr84tpqaGxuiRk2pnReohZ8Bq4ifRG3W
pF2qcorXmAv2UwGd3PbPwqrnFzmjNd5h8lBOq8XMUgV+abLHlpugaUFFFA1TaWKU
Eejpj4yLnYQjzHuO5wn/i0nOGv0FqvAQiQdFFEasUVJHMOmXj4M6Wf5lD/Mke0/y
jlLCfBBEq2fhgnrErOQDYkSyDw/t4zCLuAOpN8ezPui+nvTga87IKV+wDWIzd9LR
d1qRP7Np0S9pY7c+YIzeIBWlW9zskLU31N4cO6mF87XLyENbiZhkR8OSFGakzocT
/O9fS0bwX9P86+/S3pVfAT17ahEULkhqPZSY8OcafJwg1NJhIeCkMKf3v3sW+0HH
bvMu+ShmG8AkPAt7rTOIezlx2tHfdBFMsyxF5fIWnnO7JC61EgDLGl3S3GWyJ0X/
Je1KUzhK4PdqJwkRvoSgATib8CrMfgy3UeRznUxHiaU6rlXfg+F1cQhKHHUhdA0G
aRfxLm/eskm/8CC6gHhUYDTExAF+W6HRhGyh9ME64P/yKFQO7wo=
=SwjF
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
