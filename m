Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B875C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1B420714
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="DsNwuT5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCSHHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:07:39 -0400
Received: from canardo.mork.no ([148.122.252.1]:41195 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSHHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:07:39 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 02J77Bpc005985
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 19 Mar 2020 08:07:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1584601632; bh=r/4K24OT0deWd8YUUm6JdctYt4wSWEamTge4QGcoXFc=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=DsNwuT5pO1BrL2BJt+8dt8/hxLnv6e8aJ6OSS+rCJcULtKttn9aJVMLAp8E8NS132
         xJxIHf+6F2qX++qhgbXkkbz276F1Ity6MWljxSQIjxFyWrD5KgKu6ROh+vWAymNU9f
         qbNC343wi1uvKdf82/lF0ayv7yAV9W6iLDMmWgHQ=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1jEpGp-0003ku-CW; Thu, 19 Mar 2020 08:07:11 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linux-usb@vger.kernel.org, Cezary Jackiewicz <cezary@eko.one.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qmi_wwan: add support for ASKEY WWHC050
Organization: m
References: <20200319055845.6431-1-paweldembicki@gmail.com>
Date:   Thu, 19 Mar 2020 08:07:11 +0100
In-Reply-To: <20200319055845.6431-1-paweldembicki@gmail.com> (Pawel Dembicki's
        message of "Thu, 19 Mar 2020 06:58:45 +0100")
Message-ID: <87sgi4257k.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.102.1 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Dembicki <paweldembicki@gmail.com> writes:

> [add commit message]

Forgot to delete that line? :-)

> ---
>  drivers/net/usb/qmi_wwan.c  | 1 +
>  drivers/usb/serial/option.c | 2 ++
>  2 files changed, 3 insertions(+)

You need to split this in two patches.  The drivers are in two different
subsystems.

> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 5754bb6ca0ee..6c738a271257 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -1210,6 +1210,7 @@ static const struct usb_device_id products[] =3D {
>  	{QMI_FIXED_INTF(0x1435, 0xd182, 5)},	/* Wistron NeWeb D18 */
>  	{QMI_FIXED_INTF(0x1435, 0xd191, 4)},	/* Wistron NeWeb D19Q1 */
>  	{QMI_QUIRK_SET_DTR(0x1508, 0x1001, 4)},	/* Fibocom NL668 series */
> +	{QMI_FIXED_INTF(0x1690, 0x7588, 4)},    /* ASKEY WWHC050 */
>  	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
>  	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
>  	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */

I know it isn't perfect as it is, but please try to sort new entries by
vid/pid if possible.  Keep any logical grouping of entries though, of
that applies.

Thanks


Bj=C3=B8rn
