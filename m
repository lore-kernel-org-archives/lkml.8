Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26012080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BuM3Qstq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgGUGo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGUGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:44:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D125C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:44:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so19912408wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLBH/lbG1JbNPQLhLMpr3SrlFtcwyho8npoZGQi+xP8=;
        b=BuM3Qstq98QzNt6F6557hx6512dd4iOZTH4thAXryG44zbI+lvZd5+QoVZbTSqDBMP
         93zrlUiVHzVjzkZXnqixGeMLr8mYZbxkniN2HeI12MrVNA9hJlgFl08gS1UfZ/FUgxET
         QackozUdZsBf0DC0Rnj9uBlkyblIgKnaHlpPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XLBH/lbG1JbNPQLhLMpr3SrlFtcwyho8npoZGQi+xP8=;
        b=Pwm8ge8Kdx7DJ+NmRM5U08Vxte3LVDOM/FL/Bqg688tVjvqMTYfjU7Bp4B2ruIBtFr
         ADI7+39h5fUp0VGu9X956KXO3yukqmvZskryCYNwT5nMW2l6p0/jl5Kh2ZQZZxhYtd4G
         pP5iZo+J0BlgUj0oKG/BW/KvG87aKI7QPVduofQLRpryzAtD23xINRU/ZFp/h7zaw/JX
         fZv+45z8HZa7qJGZn8RQl6uyYZzxiE3ZAlMSl2SStE6/r0XlW5/5UJ5bet3Y1FO+7H6E
         Z349D8M1RjHQ4dcy7CtTA1zhd6k1Jz0VSHa9jNzXjiRY1tY+zQqDV5fMAWZlVHPlMDp/
         r/Ww==
X-Gm-Message-State: AOAM532UPkqMUawI9RrhoVSnVum38fepekdeZsyYIWpumqD1Qq8ymFzT
        5i7wZ1i3k6zNuNGep9iR3EIbhQ==
X-Google-Smtp-Source: ABdhPJx+1B27Md5ydM87FoadIhvwV71ppyIKT5LibLTn5acfdCI2eItikuk2Fwco1jPIYmE9L30yRw==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr25441574wrc.260.1595313865141;
        Mon, 20 Jul 2020 23:44:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w2sm35779083wrs.77.2020.07.20.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:44:24 -0700 (PDT)
Date:   Tue, 21 Jul 2020 08:44:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Message-ID: <20200721064422.GZ3278063@phenom.ffwll.local>
Mail-Followup-To: Sidong Yang <realwakka@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200713160621.GQ3278063@phenom.ffwll.local>
 <20200714102009.4qxgdq5bkpwhhhio@smtp.gmail.com>
 <CAJeY4oF9k--dGOYaC9qAXiVbx6aX2a6isXpfOg+JV2s+UskKGA@mail.gmail.com>
 <20200714140904.GF3278063@phenom.ffwll.local>
 <20200714183513.6zah7wqlo2bpalum@smtp.gmail.com>
 <CAKMK7uFF=CuuTQQJ+MSZD-7+gDzcN-jKB3Uojgps+hY0jdz1bg@mail.gmail.com>
 <20200715124337.GA18441@realwakka>
 <20200715155715.73zaveklxrakib37@smtp.gmail.com>
 <CAKMK7uFLwyLgP3tAmw3s-PC0m_1CaNKR1aLvO3ES1PrTAdX-6A@mail.gmail.com>
 <20200721053300.GA2338@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721053300.GA2338@realwakka>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:33:00AM +0000, Sidong Yang wrote:
> Hi, Daniel and Melissa
> 
> I tested some code for this problem trying to find the code that make problem in igt test.
> kms_cursor_crc test in igt test has 3 steps (preparation, test, cleanup). I check each steps
> and I found that without cleanup step, the problem solved.
> In cleanup step, igt test code seems like this.
> 
> drmModeSetCrtc(display->drm_fd, crtc_id, 0 /* fb_id */, 0, 
> 		0 /* x, y */, NULL /* connector */, 0, NULL /* mode */)
> 
> I commented out this function call and there is no problem in executing tests repeatedly.
> I'm trying to find out what's happen in this call. but don't know until now
> I hope this information help to solve the problem.

Ah yes that fits the evidence we have from Melissa pretty well: Not
turning off the CRTC means the next test wont have to turn it back on
again. And the vblank bug seems to be in the code which turns the crtc
back on. At least inserting a vblank wait in there is enough to paper over
all the issues, per Melissa's testing.

So at least we're now fairly confident where the bug is, that's some solid
progress.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
