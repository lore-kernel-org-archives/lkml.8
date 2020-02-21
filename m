Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DAC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D4920679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ssZzuQGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBUJLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:11:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42965 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgBUJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:11:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so1087246wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bPRVDNf5EPTvnMzKVRTHHqZyhdLMgs7p0iBBHW7uiTM=;
        b=ssZzuQGpLfeHgihL58P5xu4tWSyUfdVL9znvDpf+p+w2Vbtg+/gy3OFTHUIy0FVl3Z
         nTqurvRNfuGRKk4nEbR3X0dLm0hXIYKjvcubJAvlO8mjBwRJUGMQz3zolH3d1MNW1EED
         UebTR/hxU6fiLVVj1cEoRKhgzZcLIEk5SawD+6Z1UF+oconbCWdbWFZRqKSynpe7mIq4
         rnTl1o/jLqQpbPJM/72EazeMWNitApzCK5NNP0XyOoGV/dvgfUCdP6mXLRJO0auuslYm
         siPLOtIFXDWWF/mA5Ss/uDMTppDONPEtjUmYTiClcovej5kqJIhmnUZIiFxFl/OqyRjU
         QhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bPRVDNf5EPTvnMzKVRTHHqZyhdLMgs7p0iBBHW7uiTM=;
        b=GWHHIXi8M88uFKftlTsraqGO+pGuAc5bbfWORLgg3wkxS8DEETFI193+hZp52r1Yu/
         6exur3bSWCl9QJcaAyoCbBSgXcKmQW+PnNZCjSd+U3EPlDmwCWbRBkYCwY3BUZUyhfH8
         Sxz5PvUAKw8xdLIFtcLwPBboIWvRinht90zeE5ND0uV53O8RfP7lPo4SwdMS0WiG5Qls
         rliWPvXTnJxAKx4SHRr975dAULcP59cVg1hallOJNdHOK9UpJXcMSkCOvy7eKjRUNjGs
         5IoTz3gfxYq5F3vv6hx7ztnsSAnfRyX4adlSEe14izhuj1EXBX9v6ODFHDL9kxkOnX3m
         PibA==
X-Gm-Message-State: APjAAAVBtewoE5rqmoqi6a4rq6i96PkfeI+rEe4IhPXN01PjlJWYkY2r
        xvnL3TwTLJUHNpb1061mXUYx/jp0ALbPVA==
X-Google-Smtp-Source: APXvYqxQun4CWpSZd1jZWXivvInYvIwhuPcvu38YVhSy/L5i7QKdCZh2Bc7Vg0S6JsKNyNDvUMrhbQ==
X-Received: by 2002:adf:81e3:: with SMTP id 90mr45436302wra.23.1582276296008;
        Fri, 21 Feb 2020 01:11:36 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:4ca8:b25b:98e4:858? ([2a01:e35:2ec0:82b0:4ca8:b25b:98e4:858])
        by smtp.gmail.com with ESMTPSA id h5sm3183515wmf.8.2020.02.21.01.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 01:11:35 -0800 (PST)
Subject: Re: [PATCH v3 0/3] usb: dwc3: parkmode_disable_ss_quirk on DWC3
 controller
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200219141817.24521-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <72443f63-d2fa-8eb5-ef56-98844bc59d55@baylibre.com>
Date:   Fri, 21 Feb 2020 10:11:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219141817.24521-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 15:18, Neil Armstrong wrote:
> In certain circumstances, the XHCI SuperSpeed instance in park mode
> can fail to recover, thus on Amlogic G12A/G12B/SM1 SoCs when there is high
> load on the single XHCI SuperSpeed instance, the controller can crash like:
> xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
> xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
> xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
> xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
> hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
> xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
> usb 2-1.1-port1: cannot reset (err = -22)
> 
> Setting the PARKMODE_DISABLE_SS bit in the DWC3_USB3_GUCTL1 mitigates
> the issue. The bit is described as :
> "When this bit is set to '1' all SS bus instances in park mode are disabled"
> 
> The bug has been reproduced by Jun Li <lijun.kernel@gmail.com> and confirmed
> by Thinh Nguyen <Thinh.Nguyen@synopsys.com> with the explanation:
>> The GUCTL1.PARKMODE_DISABLE_SS is only available in dwc_usb3 controller 
>> running in host mode. This should not be set for other IPs.
>> This can be disabled by default based on IP, but I recommend to have a 
>> property to enable this feature for devices that need this.
> 
> Changes since v2 at [2]:
> - rebased on v5.6-rc2
> 
> Changes since v1 at [1]:
> - added rob review tag
> - added Thinh Nguyen in commit log
> 
> [1] https://lore.kernel.org/linux-amlogic/20191014141718.22603-1-narmstrong@baylibre.com
> [1] https://lore.kernel.org/linux-amlogic/20200109101535.26812-1-narmstrong@baylibre.com
> 
> Neil Armstrong (3):
>   doc: dt: bindings: usb: dwc3: Update entries for disabling SS
>     instances in park mode
>   usb: dwc3: gadget: Add support for disabling SS instances in park mode
>   arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3
>     controller
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt    | 2 ++
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
>  drivers/usb/dwc3/core.c                           | 5 +++++
>  drivers/usb/dwc3/core.h                           | 4 ++++
>  4 files changed, 12 insertions(+)
> 

Please ignore this serie, the patch 3 subject is wrong.

Neil
