Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE70BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 14:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE102070E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 14:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8Rmefqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgFTOZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgFTOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 10:25:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7F2C06174E;
        Sat, 20 Jun 2020 07:25:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so14611899ljh.7;
        Sat, 20 Jun 2020 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ruHPIPmurC463vAz1hNjJEMuv6zaWYHauq5gA/bN+8=;
        b=o8RmefqnB3QnbzCaoilt6Q+DIwbaOTaooiCT6fcwTWK3RuwWSjCg6rWT3TBjMADEja
         THzMgKgvRqC55inPhtupe5VG/ZiBQbXmnk84U9/laDe+MdJg5gRwFxbictKDo1CBDKi4
         GCJ9MOXK47onfMJukkmhDnJDPEojIp7toWb1/QOSJLy/6NBdVJt1NfW6HFhJmrv4h7BF
         2//TnZY6oqrq8fJU6YGQoehIRNuQRdzT7r3Smvwh8KRvUt0F128kYt8+YDpioENS0cnK
         L7UDGW+3RawaCCX5OuZ1/Hnq44dzU/GtZqK5B4IiEiqBkUFK2F6/yAPsKJcnPNbCZw8p
         VRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ruHPIPmurC463vAz1hNjJEMuv6zaWYHauq5gA/bN+8=;
        b=jHp05Qncp/aYJSWNH7vM30NgZuELcy2NuMDsT4P/hcK2GG4xWfVPoZJ0tkEJ7R2K6X
         ZYZR1BU4O2zOMWUWuaAe5VLiTV69yAT1Co8lyyDArrQcFRTMyvLeL0UVy1jCHnWXASJe
         UgpLit5pXymrulf1ZovKBEcR89jUOE6loflp6Gq94TvEv3K1p/gRx6ocyv8KSFPM/hK6
         j3SnaRmMwZOX2tgtrt1Lr2f7MBSzvFGCt+qxaAopBWGbpY+SJiF18bZJn0KO0ixXAOZw
         HrA8kt+01rElI2mE1PJX5BtHeOoAX48IjvVbznoh6hkIPu2E5PxevOgfPD0/zBP9kuVY
         d9Zg==
X-Gm-Message-State: AOAM532xdQ4dL3c3h66+FvJtD5xN7YvZNNdWN4l+zH6/hMC/scJV/msE
        DKdWnoeAARiBKN9pB5fJrZleAkbW
X-Google-Smtp-Source: ABdhPJyL6c94yYxmHLSrUkUoz370hw8tQobE6KtcyRTGoCUSZpYbUBqJF9dHlMa7CO3rluQkOE3K4w==
X-Received: by 2002:a2e:751a:: with SMTP id q26mr3979522ljc.258.1592663127861;
        Sat, 20 Jun 2020 07:25:27 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id c20sm2106687lfb.33.2020.06.20.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 07:25:27 -0700 (PDT)
Subject: Re: [PATCH v11 1/4] drm/panel: Add helper for reading DT rotation
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200617231842.30671-1-digetx@gmail.com>
 <20200617231842.30671-2-digetx@gmail.com>
Message-ID: <0626524c-eab6-c01b-63e1-91e1f0827831@gmail.com>
Date:   Sat, 20 Jun 2020 17:25:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200617231842.30671-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.06.2020 02:18, Dmitry Osipenko пишет:
> From: Derek Basehore <dbasehore@chromium.org>
> 
> This adds a helper function for reading the rotation (panel
> orientation) from the device tree.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---

My t-b accidentally got lost after rebase, here it is:

Tested-by: Dmitry Osipenko <digetx@gmail.com>
