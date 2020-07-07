Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53205C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3854720739
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGGQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:16:21 -0400
Received: from mleia.com ([178.79.152.223]:40318 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGGQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:16:21 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 8251B3F31DE;
        Tue,  7 Jul 2020 06:16:19 +0000 (UTC)
Subject: Re: [PATCH 12/32] usb: gadget: udc: lpc32xx_udc: Staticify 2 local
 functions
To:     Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kevin Wells <kevin.wells@nxp.com>,
        Roland Stigge <stigge@antcom.de>
References: <20200706133341.476881-1-lee.jones@linaro.org>
 <20200706133341.476881-13-lee.jones@linaro.org>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <c8ae6ed2-8739-e2fb-729a-872d38256ac8@mleia.com>
Date:   Tue, 7 Jul 2020 09:16:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200706133341.476881-13-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200707_061619_555379_BBAB11ED 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 4:33 PM, Lee Jones wrote:
> These are not used outside of this sourcefile, so make them static.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/gadget/udc/lpc32xx_udc.c:1929:6: warning: no previous prototype for ‘udc_send_in_zlp’ [-Wmissing-prototypes]
>  1929 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>  | ^~~~~~~~~~~~~~~
>  drivers/usb/gadget/udc/lpc32xx_udc.c:1943:6: warning: no previous prototype for ‘udc_handle_eps’ [-Wmissing-prototypes]
>  1943 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>  | ^~~~~~~~~~~~~~
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Kevin Wells <kevin.wells@nxp.com>
> Cc: Roland Stigge <stigge@antcom.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
