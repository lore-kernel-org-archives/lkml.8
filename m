Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DCCC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92A32067C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U72MCeQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHTZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:25:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41577 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHTZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:25:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id q10so5123290lfo.8;
        Sun, 08 Mar 2020 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxZYFn4zeJMpwkX6vuh6I8IQU6SvLZUc8s3XS8zSKTE=;
        b=U72MCeQCix41eb3o4rWSARF6wTqWl1S639veM4bjWY7kuPO7vldX0Qdhu35y4PWhju
         5X0vkP0tbgXTpHkFgYsfkumKAQLNAEJ/mdLJHsD0/FIInxSWYrZFYHHA1bFsOHjfKe8J
         ze8lWJILtx9zmcpLxtKzPVJPWyx52Gc2jXlIOYzZyqlSk/f1JfTP4/9cHMLQ06xP0Cw/
         qWmzN/ebKthDbQxQIPAj5A8tCj0MAPe+W6oLWgkMx0bzFaTA0IUzebJmHtISiXIlcOWd
         Pm1m1ePAEf/fbO8qljMlx/sfX9OV5DX4IBv+m/QbksoFPzG0Rd0kz/WSsJM/G9mY0n0W
         Kn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxZYFn4zeJMpwkX6vuh6I8IQU6SvLZUc8s3XS8zSKTE=;
        b=K9bIeyI7ptk+JXMeAWFAnADETPE4/fPKhq9fwt+iEp5WTjP/mcla5hTTQQRQi3twCn
         0AJ61fjAEIszuB3QYCeGEBJw7SdzbwgO8856p87ORQBL1Bk28YDdZxhhQDZEpCcBC0rH
         Z/F3pHg+efdRghgJaNLo2cDRdHVnviLPc+RLqBnEWxVzxN6i+gFsZyFxOsWHTAUHX77M
         DhUCbxXZPeyXAhSTKyVoJNAu9zaD8UbOnbbX2aFFWV9PUof71JGXYigKl9NaJUEdSxzx
         gK8gorbGL/e4NLIsI/8n2AIuR/WdapOmLhtWN+5ndknQqLwRvRoY+pna9TWr+XJXwnWj
         YLDQ==
X-Gm-Message-State: ANhLgQ1Wz01XhUonQgmDe9Pi0bU6XnZR9qaGNtdkNgU5ouNl1X/r4mxY
        MzyGIa/n5RrGhuRHUgu9lwYfidMR
X-Google-Smtp-Source: ADFU+vv6EXBzesa1UohyZfW57/Zw7JVhLpGkJ6whXSKyCZiygwRlWd8TmnbSR4Kzrlv/OWKXDs+a1Q==
X-Received: by 2002:ac2:52b1:: with SMTP id r17mr7528524lfm.205.1583695532480;
        Sun, 08 Mar 2020 12:25:32 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id j12sm2543932lfp.23.2020.03.08.12.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 12:25:31 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Panel rotation patches
To:     Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200306002112.255361-1-dbasehore@chromium.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com>
Date:   Sun, 8 Mar 2020 22:25:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306002112.255361-1-dbasehore@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.03.2020 03:21, Derek Basehore пишет:
> This adds the plumbing for reading panel rotation from the devicetree
> and sets up adding a panel property for the panel orientation on
> Mediatek SoCs when a rotation is present.

Hello Derek and everyone,

I'm looking at adding display rotation support to NVIDIA Tegra DRM
driver because some devices have display panel physically mounted
upside-down, and thus, display controller's scan-out needs to be rotated
by 180° in this case.

Derek, yours panel-rotation patches add support for assigning panel's
orientation to the connector, but then only primary display plane
receives rotation value in [1], while rotation needs to be applied to
all available overlay/cursor planes and this should happen in other
places than [1] as well.

[1] drm_client_modeset_commit_atomic()

Please also note that in a case of the scan-out rotation, plane's
coordinates need to be changed in accordance to the display's rotation.

I looked briefly through the DRM code and my understanding that the DRM
core currently doesn't support use-case where scan-out needs to rotated
based on a panel's orientation, correct? Is it the use-case you're
working on for the Mediatek driver?
