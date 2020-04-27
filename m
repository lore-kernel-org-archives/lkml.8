Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD6AC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222992072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD0HYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:24:03 -0400
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:55596 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgD0HYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:24:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C0E98837F24D;
        Mon, 27 Apr 2020 07:24:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: story74_22f7f5c60c81e
X-Filterd-Recvd-Size: 2270
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 07:24:00 +0000 (UTC)
Message-ID: <d80d0862bd73bb17b8e840771ae7b27fe7447734.camel@perches.com>
Subject: Re: [RESEND PATCH V11 1/3] MAINTAINERS: da7280 updates to the
 Dialog Semiconductor search terms
From:   Joe Perches <joe@perches.com>
To:     Roy Im <roy.im.opensource@diasemi.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
Date:   Mon, 27 Apr 2020 00:23:59 -0700
In-Reply-To: <3e4e181ae9b25b51298b90be43396f46c91e2ea9.1587949032.git.Roy.Im@diasemi.com>
References: <cover.1587949032.git.Roy.Im@diasemi.com>
         <3e4e181ae9b25b51298b90be43396f46c91e2ea9.1587949032.git.Roy.Im@diasemi.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 09:57 +0900, Roy Im wrote:
> This patch adds the da7280 bindings doc and driver to the Dialog
> Semiconductor support list.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -4944,6 +4944,7 @@ S:	Supported
>  W:	http://www.dialog-semiconductor.com/products
>  F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
>  F:	Documentation/devicetree/bindings/mfd/da90*.txt
> +F:	Documentation/devicetree/bindings/input/dlg,da72??.txt

trivia:

Please keep the file lists in alphabetic case sensitive order
so please move this new line up one entry.

>  F:	Documentation/devicetree/bindings/regulator/da92*.txt
>  F:	Documentation/devicetree/bindings/regulator/slg51000.txt
>  F:	Documentation/devicetree/bindings/sound/da[79]*.txt
> @@ -4954,6 +4955,7 @@ F:	drivers/gpio/gpio-da90??.c
>  F:	drivers/hwmon/da90??-hwmon.c
>  F:	drivers/iio/adc/da91??-*.c
>  F:	drivers/input/misc/da90??_onkey.c
> +F:	drivers/input/misc/da72??.[ch]

Up one here too.

>  F:	drivers/input/touchscreen/da9052_tsi.c
>  F:	drivers/leds/leds-da90??.c
>  F:	drivers/mfd/da903x.c

