Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A0920702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbgF3Sii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:38:38 -0400
Received: from mleia.com ([178.79.152.223]:44394 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgF3Sig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:38:36 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 14:38:35 EDT
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 5D86B3F1545;
        Tue, 30 Jun 2020 18:32:34 +0000 (UTC)
Subject: Re: [PATCH] udc: lpc32xx: mark local function static
To:     Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200630115836.1283978-1-arnd@arndb.de>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <a6812131-1b40-a5bf-ede5-07a1ecde57dd@mleia.com>
Date:   Tue, 30 Jun 2020 21:32:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200630115836.1283978-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200630_183234_408698_0977D780 
X-CRM114-Status: GOOD (  11.11  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, thank you for the patch.

On 6/30/20 2:58 PM, Arnd Bergmann wrote:
> The kernel test robot reports two functions that should be marked
> static:
> 
>>> drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous prototype for 'udc_send_in_zlp' [-Wmissing-prototypes]
>     1928 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
>>> drivers/usb/gadget/udc/lpc32xx_udc.c:1942:6: warning: no previous prototype for 'udc_handle_eps' [-Wmissing-prototypes]
>     1942 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
> 
> This showed up after my commit 792e559e94bc ("udc: lpc32xx: fix 64-bit
> compiler warning") made it possible to build the driver on x86-64.
> 
> Fix the warning as suggested.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
