Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C3C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C167922CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347645;
	bh=4Ii0UAX9xYXRoxt9jj5DGM4xtBxju1hoL0KGKo0sJQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxcTnoR4hwMeamgqTnl8t1Md8v1n7wpwg+AsCupZ7OGrk05GLRPDcmCTQK6Oh0cLa
	 c26CPF2Kutj9gbQere2XBf3ky4Qcl2H+IJZsWWvG04YTPSlYgDRo6j0YG1vVdxlO/P
	 FiBieXbWRmuq+hpqkFBYpx5Y08C00MsBqjuT2Pxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgGUQHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:07:24 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36957 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgGUQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:07:22 -0400
Received: by mail-il1-f195.google.com with SMTP id r12so16882261ilh.4;
        Tue, 21 Jul 2020 09:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AWT6HTVnGa5OoA145kFbOVcYaqGdpzuCOlaAtGKUKy8=;
        b=HLFzFucJPUm0vBdRj8rnp6obmcT9PtQJ7t+APoiRNAIUsWroNRA12R4ucsVdgml5xR
         GXbbnk6YjsrxvQZdq0Py8zK/lluzgR78qxmaVhYboPqTaJRTSxOWntLpHvhCUR06VPdP
         aBINVQoxpACptLAkuiNp7r4O4V65fKcuUVg/jR39SehWg/Ee6zwPY4q8f9VrTbdHU2xs
         GxYPJ2cfiam1n+TOGRwmyJRqevEQx655kcb+72AGtJvTcJEgy0sJ7qmNQB7oi3NtFXOT
         McXA8HOr1eT+Rj67qiQHIlZDZ2Z2L/k/KeYWRPa5o6smRFhL04vJEyRtrlN89BF7/qzS
         Wz8A==
X-Gm-Message-State: AOAM530HLUzYJSF4Ag9lG1q9SbNENJwU7mVAuytsrcoIFSbO1hoA9meF
        pPU0RYvwiyfL3GlUZbFBGg==
X-Google-Smtp-Source: ABdhPJxk0ryfRp5Ip5DVR+SmEj772J0qYAPqjLlJ2FWea2yXLBozmmKfdjVr2hzURUDYB/jA3x3ozg==
X-Received: by 2002:a05:6e02:4ca:: with SMTP id f10mr28975574ils.291.1595347640457;
        Tue, 21 Jul 2020 09:07:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m6sm11123394ilb.39.2020.07.21.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:07:18 -0700 (PDT)
Received: (nullmailer pid 384253 invoked by uid 1000);
        Tue, 21 Jul 2020 16:07:13 -0000
Date:   Tue, 21 Jul 2020 10:07:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, b.zolnierkie@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH for v5.9] ARM: dts: mxs: Replace HTTP links with HTTPS
 ones
Message-ID: <20200721160713.GA382903@bogus>
References: <20200719101008.57623-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719101008.57623-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:10:08PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  arch/arm/boot/dts/imx23-pinfunc.h     | 4 ++--
>  arch/arm/boot/dts/imx28-pinfunc.h     | 4 ++--
>  arch/arm/boot/dts/imx53-tx53-x13x.dts | 4 ++--
>  arch/arm/boot/dts/mxs-pinfunc.h       | 4 ++--
>  include/video/imx-ipu-v3.h            | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23-pinfunc.h b/arch/arm/boot/dts/imx23-pinfunc.h
> index 5c0f32ca3a93..f9d7eb6679de 100644
> --- a/arch/arm/boot/dts/imx23-pinfunc.h
> +++ b/arch/arm/boot/dts/imx23-pinfunc.h
> @@ -7,8 +7,8 @@
>   * License. You may obtain a copy of the GNU General Public License
>   * Version 2 at the following locations:
>   *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> + * https://www.opensource.org/licenses/gpl-license.html
> + * https://www.gnu.org/copyleft/gpl.html

Replace the license text with SPDX tags instead.

>   */
>  
>  #ifndef __DT_BINDINGS_MX23_PINCTRL_H__
> diff --git a/arch/arm/boot/dts/imx28-pinfunc.h b/arch/arm/boot/dts/imx28-pinfunc.h
> index e11f69ba0fe4..ffd5412b70ae 100644
> --- a/arch/arm/boot/dts/imx28-pinfunc.h
> +++ b/arch/arm/boot/dts/imx28-pinfunc.h
> @@ -7,8 +7,8 @@
>   * License. You may obtain a copy of the GNU General Public License
>   * Version 2 at the following locations:
>   *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> + * https://www.opensource.org/licenses/gpl-license.html
> + * https://www.gnu.org/copyleft/gpl.html
>   */
>  
>  #ifndef __DT_BINDINGS_MX28_PINCTRL_H__
> diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> index 6cdf2082c742..a34d98cf6ed4 100644
> --- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
> +++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
> @@ -41,8 +41,8 @@
>   * License. You may obtain a copy of the GNU General Public License
>   * Version 2 at the following locations:
>   *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> + * https://www.opensource.org/licenses/gpl-license.html
> + * https://www.gnu.org/copyleft/gpl.html
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/mxs-pinfunc.h b/arch/arm/boot/dts/mxs-pinfunc.h
> index c6da987b20cb..6766292eee30 100644
> --- a/arch/arm/boot/dts/mxs-pinfunc.h
> +++ b/arch/arm/boot/dts/mxs-pinfunc.h
> @@ -7,8 +7,8 @@
>   * License. You may obtain a copy of the GNU General Public License
>   * Version 2 at the following locations:
>   *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> + * https://www.opensource.org/licenses/gpl-license.html
> + * https://www.gnu.org/copyleft/gpl.html
>   */
>  
>  #ifndef __DT_BINDINGS_MXS_PINCTRL_H__
> diff --git a/include/video/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
> index 06b0b57e996c..749490e3c66e 100644
> --- a/include/video/imx-ipu-v3.h
> +++ b/include/video/imx-ipu-v3.h
> @@ -5,8 +5,8 @@
>   * Public License.  You may obtain a copy of the GNU Lesser General
>   * Public License Version 2.1 or later at the following locations:
>   *
> - * http://www.opensource.org/licenses/lgpl-license.html
> - * http://www.gnu.org/copyleft/lgpl.html
> + * https://www.opensource.org/licenses/lgpl-license.html
> + * https://www.gnu.org/copyleft/lgpl.html
>   */
>  
>  #ifndef __DRM_IPU_H__
> -- 
> 2.27.0
> 
