Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79046C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D363206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9a8PxIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgD1XC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1XC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:02:58 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83DDC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:02:58 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id m9so184601uaq.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rseuUntF/+U+N/+xHdLPAE++j42wC+S3/o0SkJMlafY=;
        b=f9a8PxIRI/5QonHE5BNzluyGyxbL7GXfP1yD7pTQwJDNRp7HjPkfUBD3Jyi9l/Wq3B
         CSLnYWWi66zCaieBmpWF+SFpnyOzX0CJlEtRsYy189kqLTOAlDS3+1YQ2DmlPwm9EQDI
         KgxfkjBQd8EyKUkvzdjU7V+hZD0SkOdVYfV50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rseuUntF/+U+N/+xHdLPAE++j42wC+S3/o0SkJMlafY=;
        b=ntpW2Pliq/aqXo+ypS0Zd5WGrPL4CgJECzHIjJi3wKPGgoJZrjRrEz3dpMkAwpJoBs
         0EZoNdzgLC0NpqHuIRxRvbU2ncQJTTdEbrGTihlUtwgr/5P3yOYY104bOSp8f4+YIu2k
         cmOHWXqBzUE4DsZ6TXYVTee2qT9Lms2l7mc5Di1jh6LF7DZK3ThlttHleL/DQk6POHxJ
         FHQQIEQrbkjBgk/4xvzbv+cfl4yr4Q6txcdf6WF1VftmNbenffn4TYFPCWkFUNUK6Y6i
         Vz2lmbUOGzLQtGOJkftTLQvfrsrpRtm+BYuFibk9D/Aatvw1cdy2rgsrFz8HStyx6jiW
         R9ow==
X-Gm-Message-State: AGi0Pua2mOzT3geqUonggk8Mmq+0EUo4pLf3goyLIbmtIPyR7voSrQXC
        iD9OP5PhPT/6RP8Y8mZs5maAAIFrGYs=
X-Google-Smtp-Source: APiQypKXQFJv/WQOMECs45BLfB0DmDaET/Tyuji6JJN0Wg5byGLpXw/f3TMmQfW6XJ7B0jP2XX+hoQ==
X-Received: by 2002:ab0:408a:: with SMTP id i10mr10055784uad.80.1588114977280;
        Tue, 28 Apr 2020 16:02:57 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id d184sm4932669vkf.37.2020.04.28.16.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 16:02:56 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id e22so92455vsa.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:02:56 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr23547785vsk.106.1588114975891;
 Tue, 28 Apr 2020 16:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200427225902.30404-1-gwendal@chromium.org>
In-Reply-To: <20200427225902.30404-1-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Apr 2020 16:02:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XE5US4B3VE1OuF+bHTJc8QGG-c3PgQvT9KmPa-Hucoqw@mail.gmail.com>
Message-ID: <CAD=FV=XE5US4B3VE1OuF+bHTJc8QGG-c3PgQvT9KmPa-Hucoqw@mail.gmail.com>
Subject: Re: [PATCH] platform: chrome: Allocate sensorhub resource before
 claiming sensors
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 27, 2020 at 3:59 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Allocate callbacks array before enumerating the sensors:
> The probe routine for these sensors (for instance cros_ec_sensors_probe)
> can be called within the sensorhub probe routine
> (cros_ec_sensors_probe())
>
> Fixes: 145d59baff594 ("platform/chrome: cros_ec_sensorhub: Add FIFO support")
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_sensorhub.c   | 80 +++++++++++--------
>  .../platform/chrome/cros_ec_sensorhub_ring.c  | 73 ++++++++++-------
>  .../linux/platform_data/cros_ec_sensorhub.h   |  1 +
>  3 files changed, 93 insertions(+), 61 deletions(-)

I haven't done any review of this patch, but before this patch on my
hardware enabling 'CONFIG_IIO_CROS_EC_SENSORS_CORE=y' would cause a
NULL pointer dereference at boot.  After picking this patch the NULL
pointer dereference is gone.  The details were in
<https://crbug.com/1074471>.  I haven't done any other testing than
that, though.  ;-)  If it's useful:

Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
