Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91772C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD58206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkf5YXbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgFNTge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:36:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4EC08C5C2;
        Sun, 14 Jun 2020 12:36:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so16597864ljb.12;
        Sun, 14 Jun 2020 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1oH7NEv4PmtGLNbJThmXxcB8UaLcSHXncndfYE40f7s=;
        b=bkf5YXbqGdwW6lPc/1SSSWgymcELeJyDmOtK7/kYlJc/HWU2UIcK60fCWIwvN9PkGX
         74iIUMnv/pCLXNK8YRnSObP4mmegyxoB8efjFVhVCmt7WVLqOzbrJHe5rhRCEMLOnOnn
         bTxEE500hpm00IDWiEV2WbODS835j702vjOJKke0bwrlidMjYQTIW+RsFKOMqkfdOkAK
         iuPtDGP9GM7W30IWtxUv9Bxo3JXXUcF5Ic3csiHpWKivQwE+EGjEDXekfQKB0zwMQDgA
         bw+KmqYR5MpvdWfzS6+jBNyerfNWPCFdozk6p7wZE185FiksqVqG+ADprFDulpj0HPnx
         XNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1oH7NEv4PmtGLNbJThmXxcB8UaLcSHXncndfYE40f7s=;
        b=Tb6JqEf/FchmhqJJ/e/ae2aoEl3ZXI/0P6Nt+n0EcaENC8MesGHkLytzcnysJN9/KX
         5jqS6EY2hfG5YAr761OVB+ALZilAl3/wvzmCXrscjbSxcyOXDILAhuGp8TnGFxJGxXCb
         2QMBGIboz+SpJCs+OZdesQ5NwHe5SNCQE0ffmz4f6yHybIxFkmuchKl2MKS2KbrvUGam
         MRhEqy427fMzUfMFrsjI7qA/ziz2aBmiHKvXKULspjEslTSF4fSfLOVerTKWDVcWXvW8
         ZVUtKNfHCJWHrcpnEVSA98OuDwTVLRTSuBLSRwXq0AG9SPTWamXQB63UfGY86zLQLspo
         yW9A==
X-Gm-Message-State: AOAM530oo9YWQqLUI8DBG2v4k4FwfBs09tCVXHEcoIHjRWB9JBJI4qUJ
        kugG+kWSB+i6nxufg7qiy1UMV5p+
X-Google-Smtp-Source: ABdhPJyl6Ol7cj6oCxj3XNEdTRqr/duhC5G7MTmnjBSgNWPgoRcc5u81BoYLmHaL3Z+LaswrxAaSsg==
X-Received: by 2002:a2e:7e08:: with SMTP id z8mr10385946ljc.339.1592163389586;
        Sun, 14 Jun 2020 12:36:29 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id s25sm3418494ljj.119.2020.06.14.12.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 12:36:28 -0700 (PDT)
Subject: Re: [PATCH v1 2/6] drm/panel: Set display info in panel attach
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200614190348.12193-1-digetx@gmail.com>
 <20200614190348.12193-3-digetx@gmail.com>
Message-ID: <81b3ed4b-5cf1-0b61-1457-b07e8d8a2de3@gmail.com>
Date:   Sun, 14 Jun 2020 22:36:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200614190348.12193-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.06.2020 22:03, Dmitry Osipenko пишет:
> From: Derek Basehore <dbasehore@chromium.org>
> 
> Devicetree systems can set panel orientation via a panel binding, but
> there's no way, as is, to propagate this setting to the connector,
> where the property need to be added.
> To address this, this patch sets orientation, as well as other fixed
> values for the panel, in the drm_panel_attach function. These values
> are stored from probe in the drm_panel struct.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Ah, I just realized that this patch is obsolete now! I also got email
bounces saying that some email servers didn't like the UTF symbol in
name of the first email, so will make a v2 shortly.
