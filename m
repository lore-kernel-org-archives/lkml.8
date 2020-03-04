Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF9C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29BA20842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrHN3aiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgCDAXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:23:45 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46668 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgCDAXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:23:44 -0500
Received: by mail-ot1-f47.google.com with SMTP id g96so267531otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HRI/UCetIuEw6fsNtr1gF3bvRaS3a3x9kBHEepTcA9E=;
        b=ZrHN3aiC0qKtz2ZiKMVRxXepRZIBShrajfzWKJKlpCVaRqrwSvMO9db0zUltv4I/Oq
         mMJ+ooreI1P4VJfBawRJ7aXw586KoZhEVRgk5UjEQhM68ChKCr7CXAYErMqv9DgriHNR
         gGxwHEvCXVE3Q0Ei0VTipQQHs+05dw3d4ZGe5MtJ1uBtsW0nF9rZH1+a4+SmGnkDqc97
         aXO1pvnJ+T5FM41OOEsLqnt9wCsAre5WxpzBuWDgKD1R1uZ5sgzA3kmv/3qks21QhE9k
         NikiBNx6oLnkIXUiKGA5U8FXKvd437Aq3XTOYmgCfZUkCCMHemUqKyXuyo/u0k342c8c
         ZTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HRI/UCetIuEw6fsNtr1gF3bvRaS3a3x9kBHEepTcA9E=;
        b=mXN40jjbMT5HG05kEVgyRrgE2LiuVoj+jPHy0OrezJT+XC2yKzYYoSHzhDa/YmL088
         7JFaRq2Fz1Ao2YIcmAr7d4BCslIdyOgsn5qtsFRXl6tw2UYjRB9MWrWXbG+WNtiaiqWx
         cIV/P0ZZgyYWgB8BTUWWrOv5063jcFfyQTGzHNAsG9N0a/+JXBXSM/cXz3+++mHVfTBc
         gQLM09iV/zd1nCENg0HxyBF8lmPKxdGzvUBFQdIkp4f0M0VyrhGZLVvMJIIHcnyvR+nP
         YEgZiQbU9FxFLPLCq7xS3SIeLgAAQp2S64U8ymSeQPwWXcMhc2UVdJ+8gI0HSTrW/vkX
         tgZA==
X-Gm-Message-State: ANhLgQ39X/bCFvgVNhZUyQUdlGiMrk/Hwh+1mMtg1v4n82zHTxz6/zcL
        nBZkHmPfF45swmGlrMHDWvaw0Kr7e8ysJIQrLmfz+A==
X-Google-Smtp-Source: ADFU+vvIohn7Qz0HBRoIIEdmpGWQfjX0kxm4uACoCe0vWQpOTFM/KmLIFOaUpZccyY80QE6+/hTs0rDxFCiqcc0R+QQ=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr409896otl.110.1583281423538;
 Tue, 03 Mar 2020 16:23:43 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Wed, 4 Mar 2020 01:23:17 +0100
Message-ID: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
Subject: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

FYI, I noticed that if you do something like the following as root,
the system blows up pretty quickly with error messages about stuff
like corrupt freelist pointers because SLUB actually allows root to
force a page order that is smaller than what is required to store a
single object:

    echo 0 > /sys/kernel/slab/task_struct/order

The other SLUB debugging options, like red_zone, also look kind of
suspicious with regards to races (either racing with other writes to
the SLUB debugging options, or with object allocations).
