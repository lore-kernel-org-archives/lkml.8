Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B365C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C51E2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMSqR4BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgCCTvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:51:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27360 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731209AbgCCTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583265092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvNuRsgrlwxpJev5Ji+2rDTX8ckqvUS3GRbdlLRF5QE=;
        b=hMSqR4BKUgl5kkqZUJru4eKb6ewI8rLuZPCPoDYeL+iDK5zzwW6pcYz/l7CZk9yZZZ0rqe
        pV2JgMgdm2WDYOPiJpzPHQNDn4X02zbeHrtgdBM8EI2WVzXa+vsq8yIOtOBuqAygY+oAS6
        j2+Q6NXkzmVqcEnynqNQe+L8tFQKMgs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-vMyZjn2cMMqU7vI7bzYn4g-1; Tue, 03 Mar 2020 14:51:31 -0500
X-MC-Unique: vMyZjn2cMMqU7vI7bzYn4g-1
Received: by mail-qv1-f71.google.com with SMTP id s5so2800388qvr.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DvNuRsgrlwxpJev5Ji+2rDTX8ckqvUS3GRbdlLRF5QE=;
        b=XsJIOMGKxHwhExluYC+Gx1nOZTHnOv9KnNKqvSRKhRBE871ftiwAxiNv9Q27lSwfqD
         uZ0oJr2bst4bHEf1th3xRO82zkJjeWKKsxRzk5fTc9PQhgqkfsu8w6a1GWuQtTB09Auf
         JkOxA7yreGehfab30FSSYhCd6jagrTZN94yULKvgp7RWdR/unuAHjaizVBefWpH1fx9Z
         bSOQRYFZwU3kqYXHXgh93gfOYAL67rCNkYhkFycX/zA+MakgHvZHsevmCqeRp8upD+zn
         uKJnEKrIwdXS87deP9LNqQHgpJFlkRX+vXQfcvvQPtue+IbKMt4NjdMbT7oyTof8GmxU
         CLfA==
X-Gm-Message-State: ANhLgQ3EkmJ6mSVejhcKYZJI0a+49T9lgwbiNdFoF+CmkPFvfRhTZnpR
        8uc8hwSd9RGgMGARwuE4VaUdOaUgDhgVGHgk39yT83+AyeymgS9YLXyBNR1V91zq97/oHSKRVyU
        k3K5+WmtSnxaF/92dIMDE+Kz0
X-Received: by 2002:a05:6214:144b:: with SMTP id b11mr4109936qvy.108.1583265089583;
        Tue, 03 Mar 2020 11:51:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsspg8JhI5ihzXhOt6OuWIKvJocilynLOdCC5Pvwbi3gxDK6VrQZDaw5zx7MH666d9ns8TkKg==
X-Received: by 2002:a05:6214:144b:: with SMTP id b11mr4109928qvy.108.1583265089398;
        Tue, 03 Mar 2020 11:51:29 -0800 (PST)
Received: from desoxy ([2600:380:8e4d:1b16:f190:533c:5a8b:4a57])
        by smtp.gmail.com with ESMTPSA id h25sm2767037qtn.30.2020.03.03.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:51:28 -0800 (PST)
Message-ID: <faad55e121f844d9b47afa603ad09641a58957b5.camel@redhat.com>
Subject: Re: [v2,1/3] drm/dp: Introduce EDID-based quirks
From:   Adam Jackson <ajax@redhat.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>
Date:   Tue, 03 Mar 2020 14:51:27 -0500
In-Reply-To: <20200211183358.157448-2-lyude@redhat.com>
References: <20200211183358.157448-2-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 (3.34.0-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-11 at 13:33 -0500, Lyude Paul wrote:
> The whole point of using OUIs is so that we can recognize certain
> devices and potentially apply quirks for them. Normally this should work
> quite well, but there appears to be quite a number of laptop panels out
> there that will fill the OUI but not the device ID. As such, for devices
> like this I can't imagine it's a very good idea to try relying on OUIs
> for applying quirks. As well, some laptop vendors have confirmed to us
> that their panels have this exact issue.
> 
> So, let's introduce the ability to apply DP quirks based on EDID
> identification. We reuse the same quirk bits for OUI-based quirks, so
> that callers can simply check all possible quirks using
> drm_dp_has_quirk().

With the bug URL fixed in 2/3, series is:

Reviewed-by: Adam Jackson <ajax@redhat.com>

- ajax

