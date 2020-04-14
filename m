Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E7BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1442076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cErN2yOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633752AbgDNVSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633733AbgDNVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:18:26 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58983C061A0C;
        Tue, 14 Apr 2020 14:18:26 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z26so1359498ljz.11;
        Tue, 14 Apr 2020 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g8YK8Lbyd3hvMNISbiGFEPKMhHRXs5WoA60P149Mcrg=;
        b=cErN2yOHH5SBoupwFvHZogLHDfIKyyYE4LjQNM7u+2LIgcwcJxP4PSNVBXTTZKN+Wr
         XALSVvkRqv6okm2cNEKWANnEGAd04xTBZxxzTHHzNLYwKXttjUEQtuGmfn+6OtiikQQn
         uu28iqF6RwrfbJFMMdD9jR4/MNlbmpk6TNAcFEWDBi0iWHvhb7Gr6bYc2dmd/C0zufCA
         eAjfslZNIN0Pnlx6ZDmDQ8rYjhmNuP8R6YnnWeld9LeXjN4COFVRIi6xDh5iKIORhBb1
         K3/ipwo9jcqCRpqTfoVhMVdA5TehmCIIfh5DcxstBFT9XUzJtYi43aG1F0jaI/CpwLTc
         kQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8YK8Lbyd3hvMNISbiGFEPKMhHRXs5WoA60P149Mcrg=;
        b=XDqcAH9yI0k5c8EqB9WcU58pXrg2W9sHndcLB7LmBzgc7OTndGsmy5xr4QH90m6PFA
         1Fk5pQ3nJDFBZ+NyXELdKajxhe2Y74zby88kbg9ArCvtP2ULSnCgl+IKSZw0nt94P6d+
         LI1kNS6G23K/7LraJAM0tnTcuLrHYQi8PTPMuL+Fl5a15RhTTstZIO4K0x7mmz6MhOAW
         SKUMzh9nbHE0vgH9KUQgcBdYC0E1NWWVUpBH2kdLPignjnKLbTL2tCkjJQME5A14VeDZ
         vRRrtwSfaXonSU84NPaIZsjIvRrBdOqVVlR3L9YNP/xqQNyo6gWI2dM/cjfHxkuu8LdS
         B9kA==
X-Gm-Message-State: AGi0PuZ5L70V53cE7HkwkU+G67rOTQ+F6S99wOQoSfMOm/aNHIoRfAJa
        MS12m5rNuirJ2vNSn3I8xi94JPEe
X-Google-Smtp-Source: APiQypIKJXbnoz9FpvP6EK0YwaiUXODte4gWCNlr6uzGHBOxnFXozla9YJ9UIMYj5jKlBwyZTkT7eA==
X-Received: by 2002:a2e:85da:: with SMTP id h26mr1211049ljj.260.1586899104864;
        Tue, 14 Apr 2020 14:18:24 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id n9sm9686106ljo.89.2020.04.14.14.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 14:18:24 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Panel rotation patches
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20200306002112.255361-1-dbasehore@chromium.org>
 <ecbfb5f8-615a-4a88-5dac-de17158125bf@gmail.com>
 <CAGAzgsqpjZxh7PEL_Dy7HrFeFGm7+=F6cL3QG9KmK9CHvDWZ9g@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6dc9ef16-9671-6ce8-27e6-aa1f4c009ee2@gmail.com>
Date:   Wed, 15 Apr 2020 00:18:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGAzgsqpjZxh7PEL_Dy7HrFeFGm7+=F6cL3QG9KmK9CHvDWZ9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.04.2020 22:32, dbasehore . пишет:
> Hi Dmitry, sorry for the late reply.
> 
> On Sun, Mar 8, 2020 at 12:25 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 06.03.2020 03:21, Derek Basehore пишет:
>>> This adds the plumbing for reading panel rotation from the devicetree
>>> and sets up adding a panel property for the panel orientation on
>>> Mediatek SoCs when a rotation is present.
>>
>> Hello Derek and everyone,
>>
>> I'm looking at adding display rotation support to NVIDIA Tegra DRM
>> driver because some devices have display panel physically mounted
>> upside-down, and thus, display controller's scan-out needs to be rotated
>> by 180° in this case.
>>
>> Derek, yours panel-rotation patches add support for assigning panel's
>> orientation to the connector, but then only primary display plane
>> receives rotation value in [1], while rotation needs to be applied to
>> all available overlay/cursor planes and this should happen in other
>> places than [1] as well.
> 
> This is intended. We don't correct the output in the kernel. We
> instead rely on notifying userspace that the panel is rotated, then we
> handle it there.
> 
>>
>> [1] drm_client_modeset_commit_atomic()
>>
>> Please also note that in a case of the scan-out rotation, plane's
>> coordinates need to be changed in accordance to the display's rotation.
>>
>> I looked briefly through the DRM code and my understanding that the DRM
>> core currently doesn't support use-case where scan-out needs to rotated
>> based on a panel's orientation, correct? Is it the use-case you're
>> working on for the Mediatek driver?
> 
> Yes, we rely on userspace to rotate the output. The major reason for
> this is because there may not be a "free" hardware rotation that can
> be applied to the overlay. Sean Paul and others also preferred that
> userspace control what is output to the screen instead of the kernel
> taking care of it. This code just adds the drm property to the panel.
> 

Could you please explain what that userspace is?

AFAIK, things like Xorg modesetting don't support that orientation property.
