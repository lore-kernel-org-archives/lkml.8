Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52103C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23082206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pewx+Ujw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHHU1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 16:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 16:27:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235ADC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 13:27:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z20so2803480plo.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yuWM4DIUwQmPQT7Mh/C4UCJ0P+zz+HJ6Yw1Tj1RgIH8=;
        b=Pewx+UjwaR5478j7M2UM4nexiXMCwf1ZLb/0YNsySuIWgtC/2CGq8F7lwS+HpomAOv
         TgFGxy9C/6/vxRxaJK9hchgHIC/UnP3YMyrMHKScQ3l/7xQkfbGbpswRyFZDcSHgqGDT
         IKCU48/UyzlXWY0szuy97s2hUWIipQJ7qukqtsfwwLU9OXWXiNHYbUuqCG3ZmQ+exCfT
         D3O6Vo2wzphIy91c+qCJhylZ4wPW73zdM4uUsTn/c7eugE3f9ZIh8u7MPuiTeQOjbHRj
         V4+zMRiPB1PmVK9+EST6rs8dT48v0VR0ejkF6Gb1HdpuPSEDWJ5Gzc6ipo/V2m/UN+DR
         bKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yuWM4DIUwQmPQT7Mh/C4UCJ0P+zz+HJ6Yw1Tj1RgIH8=;
        b=CR5/M2hN17m5jCirs9IvjDStQlG+9QqWv3WzP4lokJkBmLvVbi6tr0kVfjK01+ao4t
         47aWTa/uOC7XHmxRldfkQahE2hxGG+ILjU5nEgrEhfKmh+Uc9Ma1DGFx2aPgHj1Y5J/C
         tR/NmFNip+xeF2TXb/czstHFfbP51wuYF0TuNVi8mLXytGordKXEYtQEz1PTzflaxQSM
         j5Xoo0mTl1AtQMx+nIwDQ+D+/84/mF1CdhyXGlIo61QERcmcCw0cXwpbgxgynczepIpY
         mqFLxKfe8zzlUOq6n6pj6BGaKrQ1JbFGNtZW4qIZzWfsxBJaXkHDznZcxnIKpGKg0yXz
         6HoA==
X-Gm-Message-State: AOAM531gxYJMDAEmok2ZeUAVfiCGByytjgIexyzgkL6D99M7DHXSwYXY
        h6RuRTffLyq7IJ1u8X/6Xk8=
X-Google-Smtp-Source: ABdhPJzuPBhn7v/lPaIPGv5raUAXmDi+JjhwpKI0vY9OxOKrZRfxJrI26g9Csvb6pVSpmdt7w1mXWw==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr18892707plr.194.1596918473959;
        Sat, 08 Aug 2020 13:27:53 -0700 (PDT)
Received: from thinkpad ([69.172.171.109])
        by smtp.gmail.com with ESMTPSA id e3sm14936263pgu.40.2020.08.08.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 13:27:53 -0700 (PDT)
Date:   Sat, 8 Aug 2020 13:28:22 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     xujialu <xujialu@vimux.org>, masahiroy@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: realpath "No such file or directory" warnings when building
Message-ID: <20200808202822.GA597061@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tags from KBUILD_OUTPUT directory
Reply-To: 

running 'make ARCH=x86_64 COMPILED_SOURCE=1 cscope tags' in
KBUILD_OUTPUT directory produces lots of "No such file or directory"
warnings from realpath

it seems like commit 4f491bb6ea2a greatly improved tags generation when
COMPILED_SOURCE=1 is set, but should we add "-q" flag for realpath in 
all_compiled_sources() or probably it would be better to fix root cause
and make sure that for example we don't try to find objtool sources and
exclude other similar dirs during tags generation? what do you think?

...
realpath: special.h: No such file or directory
realpath: warn.h: No such file or directory
realpath: sigchain.c: No such file or directory
realpath: sigchain.h: No such file or directory
realpath: orc_gen.c: No such file or directory
realpath: objtool.c: No such file or directory
...
