Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E25FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7EF20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BRCqH2cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDGQot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:44:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:33707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgDGQot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277879;
        bh=CVWZqr0vbdI4BRGrrC+O1eafu/NT+eXgog9BjZh2TZ0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BRCqH2crnhHi6WRZe7jJDU02MnXOewXSmfYF+iiSwVyPgsnn0Bo0LuSkQb5JyckWJ
         GHDzfQJHgndLK4Y3+C7hKwLam7bvEatmkXyLRtit7wqKMjiUDkSaWHxrqKYU8D8ahk
         MEE07IfRTls8tK4NoO4WAcKtG4iAkEjHTkP1cMgI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUUm-1iwOPC35Nk-00prOD; Tue, 07
 Apr 2020 18:44:38 +0200
Date:   Tue, 7 Apr 2020 18:44:36 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: vt6656: Cleanup of the
 vnt_get_frame_time function
Message-ID: <20200407164436.GB3495@ubuntu>
References: <20200407162959.7318-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407162959.7318-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:foOI2ujcSFfDqvVtgUQuxBq7VpIRd5USMGWw0NS8au++8K+eKYv
 syu2X6epxKsPRZXlp6bn4GgoY32QcUBZQNlA4Paz/U3NO7n7NzQEmj8EOG5vrlg720hL1wb
 RFFCnhZRBRjQAd1uFaTXuU97tXOpPqvXjDRrzfGV2dWu3tvmQazisCzFadx/I415O0mN7qY
 A03KI1FrXTw6wYWJ56Ddw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5+T77fietFc=:rlohqya9KKLUCHck893yKz
 +6f4faj+56xUP2I0E3UsnGhIpzDCi4bZ8+R3IN2pj7bi592oqm97s0uGK50j9+oprv5KigEZD
 dQ49nnl+9h/XXYKC7J6myYtIkI3NhgFj/9WgVtyCVKo987phiti/7a88w8ZRwnHjoce+REKee
 QJSoq1SdFYJHpXxozgmRZ/hRMcVZ7qrUOmvl45YpsjKVaVIgaLtPICeqGR12av+Hs0fAKvP0D
 UdyBjOqfcQMRs6w9mu2wsy7cJxRwDCeygRMJ2en25L71CwcdOAFa/fJFHF2Im+WDJ3aMdq/7A
 WiNZtVW3TxQp7MoAc1nwP/PpmjKjkNOOz8s4mQ+xx0co6L16rfFRdqGg2UBwVpoZ9xxf/gaX7
 q9vXSiCb/a9XSj4sNNhgmLfRXHd4X4sGpfiOZi/077VXYkgbxwJdjxx0rEPr3Y60LXkKbrjcB
 Hm6Z2DW70luSHktVmDcwOcc6BEQRegodF6lvVShDiEspM1/f/GMEJBRUnX7U0S2moIq8jtyYp
 p9Hcf9W0fPORHz9Sy/q93pb2hZRzrCe90fDE0Q1j72IWUCzIYshn9xfHc1inET8/lFEd892Hn
 vhUZYSgB4UAjnDWTz6FwLgz0LkdrKi+c/oQR8cVSVW3B+mG3oR8FtjkJbBaQthCNzIDe+Yutx
 AoeuZHT1HpnLjNOjbektaSTSglHG4KAqs/DQOmqXKy/GZ1TPiMlRozd1mJTjqhQV4ehISiKf7
 zO2q5ETpqUdHLRemAN77l03RF0nY5bsGUnBSVtMCJH+6yrzdSy7p1tSUtZJjLOY2Xzh8QVf45
 7Lsn/L0t3A7RnlVJIE4mxckPRYXKpI0+1C+Kz6ZrzykFlYCCGkvgFaap7sgANKDO3tS/y/eGO
 m3ryTtyjpybG04+gbAlG6wnBIIZ4CFaX1ten0aKPQigAp/oB28QfYebSi8hib4+urlr474075
 PSC54vpy/EwvFh+tVQs1mHI8oWNwMR5Ij0/jsR77MYEO058iwr7kYJI/HuT4DwSJlsOkKbXnm
 MhJggQS+IGh6Lfnjg+YhlHa6ZpqIJsKdx/cf35jQeZ8MyHog72T1tNL5kWoR44Bu2RAC9KudT
 iSeeo2MEOjkgN/Bw5YTNU4xPmXVMzKEaL1lvSqz023QHncgZoM/dKvRMIUnkw5Tw4tDN/uxPH
 6g1Y/76XArKZtFb0ysPEXnokjGbKVheJI55v/7A4/MRUcmApzVs+slyPzZoBe+Hb5XbqZK+mI
 kwwH3kaB4OqAbDiKy
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:29:57PM +0200, Oscar Carter wrote:
> This patch series makes a cleanup of the vnt_get_frame_time function.
>
> The first patch makes use of the define RATE_11M instead of a magic
> number. The second patch remove unnecessary local variable initializatio=
n.
>
> Changelog v1 -> v2
> - Not use the ARRAY_SIZE macro to compare against the tx_rate variable.
>
> Oscar Carter (2):
>   staging: vt6656: Use define instead of magic number for tx_rate
>   staging: vt6656: Remove unnecessary local variable initialization
>
>  drivers/staging/vt6656/baseband.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>
Don't review this patch series as I have sent a new version. Sorry.

Thanks
Oscar Carter
