Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A1C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352BD2495B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpYauYeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEHOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726951AbgEHOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:21:35 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C3C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 07:21:34 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so1557081ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sa2y3Vsz+nSSLviY6v0J1Z5uZej9gf62ErMnBZQNmgc=;
        b=fpYauYeqMsxG1c9KBx3mvZ4WY30g6xzonh5CRRzMyitgtYpfvVnXYFRt/SWssct/dB
         yZ7Nzzf7rskACjYW76Bl+hRNV3VmMiln/EvuuTiuSmBh/60gm67z/o9EHfb6BPvE3EEl
         sUFhvV4JJncAKrYPCOzxVgRyD0oElBcch572SAJNF1TV6sm6g9yOA4/p0+C4KTTYVw8v
         hceyf6qy5SCv43536lzHTkKkGfEbkmQdmxf894Cp1rgpsb58FSSmbHKVJEhyVuyszDy+
         GHCflZiqx69Uvgp37gJAQ4oS8FpR0FD8dJ33wWc+YlpWPiMpl7PvdfvlInLYqsOd2CAY
         MVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sa2y3Vsz+nSSLviY6v0J1Z5uZej9gf62ErMnBZQNmgc=;
        b=TVJV9WTXLA46Z6ibSZKnd/dfEo69/yHd5v4Ku4t+VUuvES1bJU1FIdUnozPYDpgBFw
         3p4D1fAPBheTowN1vorL1W2P2fsn8ZP2inCOyH3n0XwdkNwm5TRPkGyd6u0kKtdCL0zS
         mS/xP/ng0UpE+DpN4w453ZQwzfxLn+OerYCAOoDpRv6+xE7Wz6RZ2LFVMxNEVRUBkAfJ
         OHhyL69pFpWAOeoO53/4dWpy0gUsZGsfAJ9lQY1Iim96M5ay6lqL3xBjGtWe1uUK0P5I
         dGaVbXGkO0WQDInPtyhtN11/8htPZ5lVojSqUBWTHur+L4sCfMZNG80W4qcyzxKTHq86
         ZnqQ==
X-Gm-Message-State: AGi0PuY2vyQOOzImrYanQf1LwtoIgq4G+nYaZd6c4+4go7OFmtF6Vr7V
        buoCraFE2iabxTNDgh3+yELvsk/9eGzOLiGCSEG/bw==
X-Google-Smtp-Source: APiQypK68Y7JBW5h/XyV80owNQq+vD5J11YiWs5xFaln8HLPwuTdMvXcZnWkZdNUdfERvAr7jiy3rcNpoDx0AqYX/hI=
X-Received: by 2002:a92:1d4e:: with SMTP id d75mr3111178ild.235.1588947692733;
 Fri, 08 May 2020 07:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200507213405.1869430-1-arnd@arndb.de>
In-Reply-To: <20200507213405.1869430-1-arnd@arndb.de>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 8 May 2020 22:21:21 +0800
Message-ID: <CA+Px+wWPi7bNWm9UaO3K8Lt9n-XxPjVGAD2N9XQYq6KM5DCqRg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: allocate shash_desc dynamically
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 5:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
> Fixes: b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

LGTM.  Thanks for the fix.
