Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E73EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7718620732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585503390;
	bh=6wxbCjirdqbP/pGYVxk7caFB7gSjiRZxZxMElokEkBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w9hiw4dUn2alf4f5S72JKugu+yAdvetIXr4PKVnyybC3XbKZU49VNz3XVRm5UjYw1
	 rfebxWvFTRmL+KT6hs3HXg3HOa6KBiYfkozn+j7+MKkq1SM0QyVvBB+5ghCu673n2q
	 h5C6OYp9A9mYxjzI0F133x5HhFtl6jShJq0fY+xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgC2Rg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:36:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34132 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgC2RgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:36:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10so15257255ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcQyEoLt4UUXsWctY014kOQhUrjNRd8NgK7mJY68Kfo=;
        b=c4S1GUo66CLKHtqWZrJ08l45GfFbSoNmJq7+Mk864e3HFM1z96Vt0icYOjO/zZ3OFq
         dBmL3o8LzCXTrZx1pkWS9af6uT+g/QoAwSjdZAillv4v0C46jeVFnvQdf6JM3fhEQtpr
         cGu5GjFuFXwCQ6z4lyM8GSScBIie8CSmYDIeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcQyEoLt4UUXsWctY014kOQhUrjNRd8NgK7mJY68Kfo=;
        b=sw6baUC3oi4bufpBH71TWGnvGICpNo+uuYK8l+kY1Ep2QOWvXzFRXvtxi1JVfygz3I
         kkru/arMnPFGk6XOQLBmQXtUO/myq4oR8nkn3H/pEnsX0xJCbQlT5sytgmFK3oBgtmBD
         G4N7yzldWx/ucVyeXxDR8ka9c1l2ccoUgMc1a6uRngaw2mb40DadaovnFOXHbTXt5MQF
         nyXSOtWt9TdaNwxuz6g5REp0HXXwaVhaQpixXFXMvh7CP3Uqp5S/cQeOlOtpDdnllpBO
         xrmynNz2Es48F9aFbWhLW23EtN54I+MGhIrkPmdKjrcRrLe+mueE9Qb0F0VvMW5GMPxq
         idxQ==
X-Gm-Message-State: AGi0PuapUVj8rbBuaGzNJSDZMw8ePXp4Q0LqwZlNavAFuCoiXzHUoDHC
        F73g+9Y0Nc+5MphYjDBX390VIMXtyL8=
X-Google-Smtp-Source: APiQypIJxFJLQ06KVHcT7Kj5e5Z2mhcURiIiR5AzVE3k6e/W52jp0CMvsEJvZSJ+wZ/7eH9f1h8tfw==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr5244710ljo.44.1585503379745;
        Sun, 29 Mar 2020 10:36:19 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l21sm7460542lfh.63.2020.03.29.10.36.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 10:36:19 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id g27so15418496ljn.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:36:18 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr4888740ljp.241.1585503378519;
 Sun, 29 Mar 2020 10:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
 <158549780514.2870.16142335615120539835.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158549780514.2870.16142335615120539835.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 10:36:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0fy5-mMkfVTLd4thU7R28Zp5rFGQBLWeqbd_7PyD=hg@mail.gmail.com>
Message-ID: <CAHk-=wj0fy5-mMkfVTLd4thU7R28Zp5rFGQBLWeqbd_7PyD=hg@mail.gmail.com>
Subject: Re: [GIT pull] perf/urgent for v5.6
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 9:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest perf/urgent branch from:

Also already sent and merged on Tuesday (commit 76ccd234269b).

             Linus
