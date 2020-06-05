Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2680C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899B12074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591390026;
	bh=D93s/YAsjytOZdzDY+lPWqKvRnzFpkW02n9Nech1UY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LsFwNLrjUXFdr6RwO3y+lP6rdPS3DB2JngZ6JHyaYPwfTOJQdqeegeMx9iTnBz7rP
	 /cHNVdKsIglZNPEYkjlvSCvVKRW8uRBF/3t7mj4VJP57PeGjkMuUqhjrySl8lpLH24
	 WdlqlEOZ0CCNd1wb4mpUe7dOO4tJxyQrSsrsvR5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgFEUrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgFEUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:47:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9802C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:47:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r125so6555891lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btvXfnuEAjD4kLhsbVECxPeDIX3MJO7Sa6WfZsjNgXo=;
        b=B6W5m6j+cZHJNZdgx0W0rJ+39fcaKelRyishfeMcT8KqWrAIccDyAjE+ycWtGmULCB
         pR48rNllHfUj5ka9C1AXN1J8MTKTztwL+FAZ0ZtPMj1iVV6erGACm3phNMSDdV7ST1cJ
         w4nYXvtf4TzUclzecPqcMHU2PZKcmzewEm3Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btvXfnuEAjD4kLhsbVECxPeDIX3MJO7Sa6WfZsjNgXo=;
        b=LHdCzkypahRUcxp0OsQhBlpnAamO1lzc1A9/3kwx5+r4IRvMLB/MfVSPagwTK9kP+2
         pxxsJcliE9jadYN/0lYVgKD78brnbwC5DbANMQAS+Qk+kx4GZy+19ofXEmbgMvsEspwz
         Jnvf/mjXppuA0zFPBdrYNLHF7c0FMiRgZImqCswxm7Q0cbQ4DhD8h547PuRP3pqJxn4a
         JulNPnO+RRTTYOC6e+jUXv4Cu5Hn0TfelmEDRmnwWDzTb/67xFaX87p2eOH3kHBLcEWb
         TgXD0FPU9kHUs402y4fKAC7I7uVAZI4oJ95aV2+28q2vcMalQ4zrVPb5jSSX8TwOWKkR
         OPQg==
X-Gm-Message-State: AOAM531CVRVgBt3GFvCQMo+hlyG1zdOab/LwvkQYafI1WNlyKBa+7AXf
        bBqDqNMfEqKjIcFZRNE4GulhGwOQpoQ=
X-Google-Smtp-Source: ABdhPJxFcU8L8t8N9uZS+Dryv3BBmjRKQrZNUcVUIRhABggLjYgVN/zriN3soKHAbepnlIkRy5q8og==
X-Received: by 2002:a05:6512:110d:: with SMTP id l13mr6374447lfg.93.1591390022623;
        Fri, 05 Jun 2020 13:47:02 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s18sm1440215ljj.63.2020.06.05.13.47.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:47:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id n23so13362997ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:47:01 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr4962486lji.421.1591390021360;
 Fri, 05 Jun 2020 13:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200603213452.GG19667@zn.tnic>
In-Reply-To: <20200603213452.GG19667@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 13:46:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifs5DF9HaqqXdpZ0FpkJOSyZ7gPmB3kOyWBXK7sTOGOg@mail.gmail.com>
Message-ID: <CAHk-=wifs5DF9HaqqXdpZ0FpkJOSyZ7gPmB3kOyWBXK7sTOGOg@mail.gmail.com>
Subject: Re: [GIT PULL] core/core updates for v5.8
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 2:35 PM Borislav Petkov <bp@suse.de> wrote:
>
> please pull the set disabling automatic READ_IMPLIES_EXEC on x86-64 and
> arm64.

Ok, let's see if anybody hollers...

               Linus
