Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A07CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D30B20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Txlkrdy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCQW7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:59:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59460 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQW7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:59:03 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A811F9;
        Tue, 17 Mar 2020 23:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584485941;
        bh=aEEqAUWAnsfPAycSCi+/qR+dKHnW9AR75G0CU/nwNm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Txlkrdy9KZngVUCDAsBDGq39lpJ4CZj2kMoeLA5bL0I3Zwdjj/MMndCoAHEUBFKwm
         oxRvwU2zuhp9a3OXxYFjtEakLYsoDwyUVuLO+k77zwiiVY6Lbvsu1a6XQdvoosIN8f
         erfMvF0r0+yUZYDMT/8BdD341DLS0jyYaknH8upE=
Date:   Wed, 18 Mar 2020 00:58:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Message-ID: <20200317225856.GL2527@pendragon.ideasonboard.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

Thank you for the patch.

On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> Add the description of PWM_POLARITY_NORMAL flag.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> index 084886bd721e..440c6b9a6a4e 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -46,6 +46,7 @@ period in nanoseconds.
>  Optionally, the pwm-specifier can encode a number of flags (defined in
>  <dt-bindings/pwm/pwm.h>) in a third cell:
>  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity

With the previous line mentioning that the pwm-specifier can encode a
number of *flags*, this becomes confusing: reading the documentation
only and not pwm.h, one could wonder what happens if none or both of
PWM_POLARITY_INVERTED and PWM_POLARITY_NORMAL are specified :-(

>  
>  Example with optional PWM specifier for inverse polarity
>  

-- 
Regards,

Laurent Pinchart
