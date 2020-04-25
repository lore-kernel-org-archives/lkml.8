Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD98C55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 21:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EC820714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctifTUoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDYVwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgDYVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 17:52:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DB8C09B04D;
        Sat, 25 Apr 2020 14:52:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so13645646ljn.7;
        Sat, 25 Apr 2020 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WTFn6rB9HKermcvkoC+LjOH1uLnCCCkq/7Yk0Bhk1hY=;
        b=ctifTUoW5D6cpHfjxDauyqzluTWYK6w53t0tAtbRJh/7mTvp5osgtao5DHPC2ZCsfy
         0F7bv5j5gdNFDHjT3Uljtsok3FdmdMmVROA9Fh3bFVTvCQM9oCZCHJrh7xinj+xzJ5mf
         2LaIJ7d+q8TCT4nIn5Yk75z0c9HdCZISgMTC9sTxoEu/tUFN6ei8hIOQEPcOqN2ZOU5c
         PPq9FFYlXI8ygNSc62Zt5sDTjtVkX1aKDRXyHxX/54Cf2UDmDH1TSv4KWjf1aL0CMtvF
         PZRZywh0se+wPkMcMPh7zjCzqv7Z2p3H95x9ZIn61s8p3su56DYqCSA9VM9SBo0wbzc4
         hqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTFn6rB9HKermcvkoC+LjOH1uLnCCCkq/7Yk0Bhk1hY=;
        b=YTF+Byc7sD4N/ZhacjDt21TQjaHK8z7Xq/kuaVaI7RuuzjFKV8Ly2gtSD6d0Icms12
         70BnoSTeq6Y0GumsnAhbFiRAZublShuDEZgCF8UrBYIhEy39oFN9C1/V9ORiSL0wiDOQ
         jRgnxX4lMxH6Nz3rTEyYhbY0SfbjuEqM9MAO1pAoiGCWfl0hHXKIM+CfoxrhzikPguCh
         /4Ym22HJ9xu/Undof25Ic5lkw5g/J8+W7Np14SGoklsAt+STjJFldt/9G+5WdAhZfVRP
         S23zEWDpoa8TQ1QPHJ5+LkMuU0+FzlcObDLf+JVaVZhdWIIUDKUMRSmGE8gLQOt7Ux5X
         kblg==
X-Gm-Message-State: AGi0PubWSRFoD4WbI6t1GA2XuQPbvSPXU5UcN7rjlrOaCOfTleb8AjsS
        3bvPlKDU1XRZqBqFo21UP7M=
X-Google-Smtp-Source: APiQypJYgN8HmjiAC+Az+JE+6s5LC3yyQ5KUiUc+DMuLZfUfxWBQXCbPiBkO2LCclFex5yr8qn5c0g==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr9632764ljg.204.1587851520651;
        Sat, 25 Apr 2020 14:52:00 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id a26sm7599728lfl.66.2020.04.25.14.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 14:51:59 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] drm/tegra: output: rgb: Wrap directly-connected
 panel into DRM bridge
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200418170703.1583-1-digetx@gmail.com>
 <20200418170703.1583-7-digetx@gmail.com>
 <20200425170237.GA20498@ravnborg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f03c260b-54ae-93ed-69e8-de434e74ed82@gmail.com>
Date:   Sun, 26 Apr 2020 00:51:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425170237.GA20498@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.04.2020 20:02, Sam Ravnborg пишет:
> Hi Dmitry
> 
> On Sat, Apr 18, 2020 at 08:07:03PM +0300, Dmitry Osipenko wrote:
>> Currently Tegra DRM driver manually manages display panel, but this
>> management could be moved out into DRM core if we'll wrap panel into
>> DRM bridge. This patch wraps RGB panel into a DRM bridge and removes
>> manual handling of the panel from the RGB output code.
>>
>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> This resulted in the expected simplifications - good.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Hello Sam,

Thank you for taking a look at this patch! :)
