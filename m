Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519A4C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D62206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVvceTad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD0U0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0U0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:26:04 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6CC0610D5;
        Mon, 27 Apr 2020 13:26:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s63so19506172qke.4;
        Mon, 27 Apr 2020 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbxuSmRMpEVjcFcUWX8/U4mbuyvHeWXNoUh+2G3pNgI=;
        b=VVvceTad5m1fz+NDeD0kkzZb5AzjBz0vCPLleFr14kF+joywaYU8GITJ60UTPIot9f
         IZHXaUO1XcTE1Ht5K7/FUPDiMPrtc+x2fl7cbqG4fY+bHiBajZ2WG27y4Gb2mj5iKWkK
         d8aVl9cPzgjaube2OtVUTg/1o5VWP2+ANhsuoQpErKrHcwAixwpmxaH0rzsu6SY5Aads
         XpE4pXG63X6jf3UdPo/6tSYdTuIfEBuTZJTWkwHxOjSSrsafyJ92LbTawabjtukUUS1p
         Hjf0TMlT3LjEEmBROBvWJAoyAFSDTbGlG9wOQfejX4y8+p9c4fRhF3u309RD7lB26JTt
         eXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbxuSmRMpEVjcFcUWX8/U4mbuyvHeWXNoUh+2G3pNgI=;
        b=Ji0rZ+qRbYsEEruibPS8hty06HI7LF+9dFZWEjz892yXqNJdCg5rEbCydrDTc9+MyR
         crw/QrqFq8tDvcN2dXpwWXMpvdzz4u2xsGHbGpMbpon+cevBjHjoXhHT2/HawxNixJcp
         12FTrw/ra1jm8u3v2OkPwtiJLOp0WjF+b3rVAZoxY8Dy5FSXMGG803qSC0EQve/IDq2z
         sMKAv1D5mVvHaIfnDQhbcpe2bSuNu5w37C2SmvDb9djl+Bw3/SITNt3xgUGmz0H1AHNW
         lQZxVzM7dQI0s+lPACJvb8trBT79jyi2alCzbmK5j9NUDIVbFVb9qj49WyfvAZ6Ybfda
         S7Vg==
X-Gm-Message-State: AGi0PuZ6+nIgyJTJ8dyicgSMZT0ZlG8rq9BOvUB6IJcyGqA5h6Ag0Cr6
        SgY57Hcf0/jPaPplkcbL/Q4=
X-Google-Smtp-Source: APiQypKCgKltuhPhW+aTgmBRGXJBLWWTu7vVvYfrto4NVsaJVk1Pdv0jkBvHXbaMKRyn3o04bQQvXg==
X-Received: by 2002:a05:620a:541:: with SMTP id o1mr22112341qko.89.1588019163280;
        Mon, 27 Apr 2020 13:26:03 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a65sm10476688qke.74.2020.04.27.13.26.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:26:02 -0700 (PDT)
Subject: Re: [Q] devicetree overlays
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e5f05ee3-515b-7b13-5125-b6d7a03ac031@gmail.com>
Date:   Mon, 27 Apr 2020 15:26:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/20 9:46 AM, Sven Van Asbroeck wrote:
> Pantelis, Frank,
> 
> A quick question about the state of devicetree overlays. There don't seem to
> be many in-kernel overlay users (rcar and fpga only?). Does it make sense for
> new projects to use them?

Run time overlay apply and run time overlay remove from user space are not
supported in the mainline kernel.

rcar is grandfathered in.  fpga use is very careful and done in a somewhat
restricted manner.

There is a desire for run time overlay apply and run time overlay remove
to become more complete and more robust.  Improvements are slowly moving
forward.

The best way to use overlays at the moment is to apply them before booting
the Linux kernel, such as having u-boot apply them.

My opinion is that run time overlay apply and run time overlay remove will
always be more fragile and less well supported than pre-boot overlay apply,
and thus run time usage should be avoided if possible.

You can read more details about the status and direction of overlays at:

   https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts


> 
> My situation is this: I have hardware which consists of several modules.
> Knowledge about the type and location of these modules is located in an
> on-board eeprom.

Does the eeprom provide an ID, from which an overlay blob can be inferred?
Or is "the type and location of these modules" more explicit, such as
path of the blob in a filesystem?

> 
> So now I need to assemble a devicetree, by puzzling various 'blobs' together.
> This could be done in the bootloader,

Do this, if at all reasonably possible.

> but also by a rcar-like driver, which
> queries the eeprom and inserts devicetree fragments/overlays into a live kernel.

Don't do this.

> 
> A couple of questions:
> - are devicetree overlays here to stay? (given that there are 2 in-kernel users)

I expect devicetree overlay run time support to remain for fpga.  I am optimistic
that we will add support for other use cases in an incremental roll out of
functionality.  But this is not happening quickly.


> - does it make sense to solve the modular devicetree problem in a rcar-like
>   fashion?

No.

> - is there perhaps a more canonical / idiomatic way to solve this?

Yes, apply the overlays before booting.

> 
> Sven
> 

