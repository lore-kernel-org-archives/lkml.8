Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17384C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC48620838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596010324;
	bh=DXMnIM2lxopueDbqtGFRiyGMJKbn/YREHCzSD2g2sA4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nDEdWX5BeAtJGR2oQ3ciE8AZSSpmzeGZw5CXBNpxa7BbcUIhHIlxX4nNn86tj/f/Y
	 0Zo7XrTZXlGMVu35sQWhACivBkJDfdvSHIp6r+sFtKa1xdrhc0HvMahvFz7Cq+Qh54
	 GgrwSacNmvWnX7nwM1sCOBJYcGeEr774hjkauGB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgG2IMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:12:02 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44043 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2IMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:12:02 -0400
Received: by mail-ej1-f66.google.com with SMTP id bo3so740260ejb.11;
        Wed, 29 Jul 2020 01:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9KrD0P0TVKXN8xABDByJtLIfvKgiQPv5ea3HEknvYc=;
        b=tUSXL2HexAAc4EJDrrzkWjv4wlUjnExRu6mgbOeiBnMc5zQPm8QavGLM8OZ6vR/09J
         ZgSncbTfxEIUkKHJ5bFeATvJqw9urR0fClr0w21DjVHq8tPb3/Sr7zggLnLRsmGZ9c2v
         tYsOuoldvho9MNdYLb6HyewHQhBdqrqCZ48Cr0zCWtW7nW0ML6RkMtg+6FbXn4OgEqt5
         rz550qVJI5vmVohJbDJzzQ/6sb6nbd1h2YfhFgj/jV3wPio6x3Q2Gq311QmIg/oOdrly
         FjnPMbf9xtrV42DsAFWjYMPOaSP+4viJmyrBJeJOLw9H5Fae597/beeSPJGQ3A31F1Xh
         NNYQ==
X-Gm-Message-State: AOAM530LQrEqqAlqHstQtCYRjGFy1m/JaPyuWPP0QyoxSASATPsHXV/1
        CSVOl2gDGQKYShWxP1Nt+dxxrrvW
X-Google-Smtp-Source: ABdhPJxiFig6WkqMe0S5Eyvxajz0KruotGDPWnuD6S9N6TWvqRnUc8Vm47L/P81vDiZav887EZuhrw==
X-Received: by 2002:a17:906:a3d5:: with SMTP id ca21mr13368266ejb.453.1596010319874;
        Wed, 29 Jul 2020 01:11:59 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a16sm961567ejy.78.2020.07.29.01.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 01:11:59 -0700 (PDT)
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        b.zolnierkie@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        Security Officers <security@kernel.org>,
        linux-distros@vs.openwall.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20200729070249.20892-1-jslaby@suse.cz>
 <55075898-bf95-1805-3358-b0d1438feaa9@nsfocus.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
Date:   Wed, 29 Jul 2020 10:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55075898-bf95-1805-3358-b0d1438feaa9@nsfocus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29. 07. 20, 9:53, 张云海 wrote:
> This patch dosen't fix the issue, the check should be in the loop.
> 
> The change of the VT sze is before vgacon_scrollback_update, not in the
> meantime.
> 
> Let's consider the following situation:
> 	suppose:
> 		vgacon_scrollback_cur->size is 65440
> 		vgacon_scrollback_cur->tail is 64960
> 		c->vc_size_row is 160
> 		count is 5
> 	
> 	Reset c->vc_size_row to 200 by VT_RESIZE, then call
> vgacon_scrollback_update.
> 	
> 	This will pass the check, since (vgacon_scrollback_cur->tail +
> c->vc_size_row)
> 	is 65160 which is less then vgacon_scrollback_cur->size(65440).
> 
> 	However, in the 3rd iteration of the loop, vgacon_scrollback_cur->tail
> is update
> 	to 65360, the memcpy will overflow.

But the loop checks for the overflow:
  if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
        vgacon_scrollback_cur->tail = 0;

So the first 2 iterations would write to the end of the buffer and this
3rd one should have zeroed ->tail.

thanks,
-- 
js
suse labs
