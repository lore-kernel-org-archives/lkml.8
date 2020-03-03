Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C90C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2262064A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj7clo3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgCCOer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:34:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgCCOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:34:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so1555174pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A9r1rdjgxdujZHKdyrajsLeH9QBeHgW4Z+0FAe0pOxM=;
        b=Wj7clo3bjugnZLLN8cUphbm9TO23s/7v9ldR/lHR892/Nl683ZqPpvT2w4auQw4BVK
         /h5o2JcYFH/nx5+tY8XkcUgV7oD/OnLEg4HJOrTVPl5IdKkj31qvttGeKv4cK8v8XLx6
         yLZRzLwLfTVd3agskOtEJ3eMAEruzXKCvcYwrk/C43G5YDsoKzDBoLNgaQcP3HhFQyuu
         fdfoLh8C5/jqtkWa+vZJgSOXpwpPnMRezM6JO0cmuByL0BFMKeb7QRx6X1RbPm6eUUPL
         ywwi2qJzPm23k/NyJ0gK5zepUy7PNG/Pd/p6X6XNqzH5yz47gKjzX1ZwMXOEmkUcQoyZ
         9jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A9r1rdjgxdujZHKdyrajsLeH9QBeHgW4Z+0FAe0pOxM=;
        b=b8Ngqy0sjR+N7ezT3mdKpbfyhVtc4bSlc8NK5J0XgJgFxQ1P8gLA/Wu9LYF4TPKrSh
         p6ywmEK8kOsP8bFOqiiDqGEDlIWxUpVBdwLKYV5XXbqd1sHAUr2Jnjq4w0ab3la3P0vE
         qO+zz6V7sJySWypJbDHopWXanZXPlL8Evy8NxRFxlbKSlNY11IkeV6tMxn9QXBQN10aj
         W6l3977NffpbJCNH5KXIO14Pf+uNAU9LBA0sKrG8I/98lrFOMtoqmwtG29nhlB/XqjWY
         XqZy8uhlXJ6fKyv8E6z7UhHQM8GFaJlvfJE3D6pf06OE55XrJThQU8TbMtmdie+khHgP
         fZIA==
X-Gm-Message-State: ANhLgQ08n/+566Eni1URBOB7XXuY9hjwJo6XXe/UbWQu4E7lkIYRwNDk
        /zk/nPvAhAYN9B3zzxJdyMU=
X-Google-Smtp-Source: ADFU+vvSX/wgDsqEEwAqbDZltsO3GyJEnBAqz5YJ8pdU+azKUfszCRTdwImCImdr9VODUOMIAe/W5Q==
X-Received: by 2002:aa7:86cd:: with SMTP id h13mr349892pfo.252.1583246086518;
        Tue, 03 Mar 2020 06:34:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15sm23947712pgh.80.2020.03.03.06.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 06:34:45 -0800 (PST)
Date:   Tue, 3 Mar 2020 06:34:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
Message-ID: <20200303143444.GA25683@roeck-us.net>
References: <20200224112537.14483-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224112537.14483-1-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:25:37PM +0100, Geert Uytterhoeven wrote:
> On i386 randconfig:
> 
>     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
>     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
>     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
>     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
>     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
>     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
> 
> Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
> 

With this patch applied, arm:pxa_defconfig reports a variety of unmet
SND_SOC dependencies, and it fails to build.

ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9713.ko] undefined!
ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!
ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9705.ko] undefined!

Reverting this patch fixes the problem.

Guenter
