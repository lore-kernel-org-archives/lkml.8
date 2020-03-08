Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003C820684
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="molc4fTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCHWcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 18:32:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40274 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgCHWcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:32:47 -0400
Received: by mail-yw1-f65.google.com with SMTP id c15so3739535ywn.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XiIHjbFXRu9GcpXHs973G3osab43809kvN7/VuRkTY=;
        b=molc4fTTx3EfNQFKqa2kGZbynhI0XqbMtvU3KV/NnQYHLWP3KSAfZxKeGAf94F+czz
         WQ1J6XiWfxc6DHDUwdDizKyFCOlmf8xFJ+aNZnTY0qVTUFnu2seFDXR6Y7fWVTZHU+QC
         DfvvUTIaFfGCbWiqBais34Qzfthsy+xqafc5SYH9Kt/jqtWQA72Hs/EXA1zlH+fbTFr9
         INOTuFkuhE/yFrIr/T3XGsGGGOPPMUbuXKLCytRfNUW2HH+utuS3s1sdARIs3szpQ809
         3vLhCYJhBEkXXPv5PtkUjt912ld3d2zP1bUoz0QlWaxSuavUQ0E7LL1GB+EbzT48E/JY
         tlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XiIHjbFXRu9GcpXHs973G3osab43809kvN7/VuRkTY=;
        b=Pa0ei49venpdVCnh5iLwB+CL2orZoNoLKlH6mm6mXosuKiu0oSD4bVYoiiKlgL37tE
         1RsKVm8vTNB19hmK473OIQ9NZs51oPv5DF5VVw3zbGVbl0Hi6aNEcPNQ1pR3JWMpik5f
         QATpNXAJMLBHcMnTU49w7PAMsO3ddz5HGbJx0MDLcWTS4VILB6/f5ziSOKb083kvORB6
         XilgNYtWNI+VOVz7eJoSSKclfU2tGbGntZ64me7RBNDDl8EfxkZUrtiOk2bdzzzOLoVE
         54LlhbkRRMh5HkZ68KHK8mogL3S7jah0AZgCZBZYmPcsCdLzdghinxdElxNSQmiylBaG
         T5Vw==
X-Gm-Message-State: ANhLgQ0I149ph5MckNLpqjRg5jpDIaPhrEnlhSxb9qwMtkN+nzb3ZUuv
        8AENv2MlNz621qChNQirdosT9Fzw1k18oO514bY9SQ==
X-Google-Smtp-Source: ADFU+vtxmx0EG4Cfm3oOUDllyASyoOmKq37AYtRDE8dVdXlGvQv7BYpHkU2WzolcnOtFY2aPYOfFjkzpWOGvEjaaFDU=
X-Received: by 2002:a25:3255:: with SMTP id y82mr14227923yby.208.1583706765900;
 Sun, 08 Mar 2020 15:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Sun, 8 Mar 2020 15:32:35 -0700
Message-ID: <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 12:51 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> All files in drivers/firmware/google/ are identified as part of THE REST
> according to MAINTAINERS, but they are really maintained by others.
>
> Add a basic entry for drivers/firmware/google/ based on a simple statistics
> on tags of commits in that directory:
>
>   $ git log drivers/firmware/google/ | grep '\-by:' \
>       | sort | uniq -c | sort -nr
>      62     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      13     Reviewed-by: Guenter Roeck <groeck@chromium.org>
>      12     Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>      11     Reviewed-by: Julius Werner <jwerner@chromium.org>
>
> There is no specific mailing list for this driver, based on observations
> on the patch emails, and the git history suggests the driver is maintained.
>
> This was identified with a small script that finds all files belonging to
> THE REST according to the current MAINTAINERS file, and I investigated
> upon its output.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a0f8115c92c..ed788804daab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7111,6 +7111,14 @@ S:       Supported
>  F:     Documentation/networking/device_drivers/google/gve.rst
>  F:     drivers/net/ethernet/google
>
> +GOOGLE FIRMWARE
> +M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +M:     Stephen Boyd <swboyd@chromium.org>
> +R:     Guenter Roeck <groeck@chromium.org>
> +R:     Julius Werner <jwerner@chromium.org>
> +S:     Maintained
> +F:     drivers/firmware/google/
> +

FWIW, I would not mind stepping up as maintainer if needed, but I
think we should strongly discourage this kind of auto-assignment of
maintainers and/or reviewers.

Guenter

>  GPD POCKET FAN DRIVER
>  M:     Hans de Goede <hdegoede@redhat.com>
>  L:     platform-driver-x86@vger.kernel.org
> --
> 2.17.1
>
