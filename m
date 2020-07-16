Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1F42071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pp0OOmet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGPICk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgGPICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:02:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC8C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:02:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so4700213qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cw3GUMPATHvcre91PrkdEqA4LChZAUyOWgRKc6fMd3g=;
        b=Pp0OOmetcPJXIPMDP1xz5qLv2FI/ipLD4jr7oR/anFU6pD5fHABKlB3Ia8Jp0JuQJN
         RD6SihtDkOi9cemx3q72J9IgD1VSE/9o/kBervi5qBd9CTqa0RASiaY3c0pGLQgQmJHu
         1ghTRVGe/m3LPdWXV7dQzpXsLM4aiJG+KEKvzUD+xLqKAHdLkYALo5u40Ir4cdpQOMfR
         RBxmSpDbEBW7mBE0pUa/IMYYCzHUdYdmComVyh41jn8JWL+l2uE1RBG5qOPSmolSdF7m
         1aBoa5KVtGBuvB5OptH0Tnl4fTBd+mmA5WeJCGT/wb2/zRNGErAdgMcxaBeiMPYaxmOQ
         QVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cw3GUMPATHvcre91PrkdEqA4LChZAUyOWgRKc6fMd3g=;
        b=kfY/OItiXNH/5Ta026Bz9U/hLdTRV5VV4sVpPl7QCD9aSnXXWz2P+p3Z6VXwAxkit7
         Wn3Fyq6whIKlTJ5OIsjnf1Mp1ZbFIWed/c6p/Eqb/kwRRPSBU6wkaXoA4BYJURsmifU1
         KXbNeHnJNR4Na3hrEkP4SpNVOZYY84Km+959Gc1TxyKSY+vrKYCHVO5vH8YJRmLaIkso
         Ycv1Q3m4IsdRDNUeATVjQMHilAgy5MdgXtYgwM6ZHHesW9iBNhvRMI2rTXJ3siUdOKpV
         VXe1UjSyx9cJE6USBOU0L0bAm5OtEriWvvYwFRsL3ivDNs3xDlTXPWv6x9wXM33LTLeD
         x0VQ==
X-Gm-Message-State: AOAM532KbBqexX95UfpzSaNtHKZuB/9q9kbhaEGDtbi1Xs6dqva/XjCu
        L6pkwvTcAh1USUnEVylliR6RPjZfuZN+oWLEsMjWGw==
X-Google-Smtp-Source: ABdhPJw9To9HhFwU3duxkt3EvlkQrR+eoiqlyrEu6foV4P95lSwEfe4qR3tJJYJd0iEPUAPr/L+aHXiPiRqhNfUSG7U=
X-Received: by 2002:a37:7741:: with SMTP id s62mr2485109qkc.263.1594886555696;
 Thu, 16 Jul 2020 01:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com> <20200715124839.252822-2-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20200715124839.252822-2-kieran.bingham+renesas@ideasonboard.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 16 Jul 2020 10:02:24 +0200
Message-ID: <CAMpxmJXhRX1Gpxg2iqX2XXy67BhGrgrqchJb6OOoDz8POo0sgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arch: arm: mach-davinci: Fix trivial spelling
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Jiri Kosina <trivial@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM SUB-ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:48 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> The word 'descriptor' is misspelled throughout the tree.
>
> Fix it up accordingly:
>     decriptors -> descriptors
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index a273ab25c668..1076886938b6 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -266,7 +266,7 @@ static struct mtd_partition da830_evm_nand_partitions[] = {
>         }
>  };
>
> -/* flash bbt decriptors */
> +/* flash bbt descriptors */
>  static uint8_t da830_evm_nand_bbt_pattern[] = { 'B', 'b', 't', '0' };
>  static uint8_t da830_evm_nand_mirror_pattern[] = { '1', 't', 'b', 'B' };
>
> --
> 2.25.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
