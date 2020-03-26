Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B38120409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCZRVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:21:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:21:32 -0400
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mw8gc-1jXo3W1X9Q-00s2X0; Thu, 26 Mar 2020 18:21:18 +0100
Subject: Re: [PATCH] drm/vc4: Fix HDMI mode validation
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     maxime@cerno.tech, linux-rpi-kernel@lists.infradead.org,
        f.fainelli@gmail.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200326122001.22215-1-nsaenzjulienne@suse.de>
 <c4b3e083-ac6e-b321-f0eb-f20e8ec3b1a6@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <f254992a-9155-5c89-03d0-f47faeb0d6d2@i2se.com>
Date:   Thu, 26 Mar 2020 18:21:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c4b3e083-ac6e-b321-f0eb-f20e8ec3b1a6@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:vZ5W2Ull3DrNqrvVl2ue5tBHz9cnkfxb/KktYk9S4NXWVYN9GmA
 wy420AOIutME3rLBn0jrjKXMOvgP9osuLF9J6+Ymqe2xa81xbNRhiQR8ApVnpb1rlU4driw
 LZp8x4PNRUII1EEsctlLWkgNpz+AjrVEs/5jQWYvuWAoCEOrlr+bjlSfFFpoG8yIMvuKEPr
 X1wy1rEGEhrLp2Sn13elQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MH05hupqrqo=:IPon17ZJwRyB3EOAuRu6YA
 WY6fTXa8Xv2qP+0y2/zav3X4tENeSMZfcsDM4rRoMDXrJfEV1lTBh4V9Fd4TSz+R9jDnWfcww
 SQkCsAqqhUOVL7F3dYisXlNL7X1zTWDrLw4hTn6brmiKGyGIY94RQflNE/nBE00BeKozAknPb
 fBXx7XJuEz8tE6jRsdWUcePgzBDx8SlE/cV3NyQ2C3JzAT1Wxo/fW5HXQgH8Q5yvh5KvgP2lL
 4Q/62DkRxICfZd3Ags37UXZqMkHx0AmNtbmw/h/inOEzf0YcMeLpP2qbx87bQh5c1aZIWFMOq
 XuJNZWn/wY2ZiMLzFGIvh+26ff2Vf1FwT1wO4HNHsG+RaUuUcmGC6ZkQb1CvU/Ou3GI93GWsJ
 zPneI9CJyOOT7k0nSpbZHeMDLoz6QT4nvaiqf6waSnjUgess2oqt8XjNZesAJePYqGXIH+bIE
 k9PFE7qNB2IIaaQOPqplyyA9KoKGbtOangQgc9PqQEomwv9BDdfq7+WevC3wi6oE/5/5jfB4K
 yjpvQinhq9Mvipgxe1owkDuXQULJCHOKO+kmawKNkwt7q2COMZo/ifqs/+lixFokFzNNJ10AS
 XHsknjjvl50tTn4qb0JuL7W1bXCj0F4KkvSnaQjwqYMBRxnkUffUYJASD1PVaYLMzj0N3SwfO
 jW1rfeif8Sl6zgfKU9e9dm1cTXTc0P0fKWeA24qDt+gHO5NqVaqZV0QraXqEs6XQNXvKbWlex
 snZOOfK0XUTjRtDfzEcz2sNSCXFJFXyKKKU0uKUgXcAOHsNlzq3gCez8ZytbCIr7bBT9hs2cU
 al5LMpTyueDfhc8OxujdthjAJKpOlfm3WReAeYNCguvACCULikzDnDaSC+/4mc+/cnp+6o7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.03.20 um 18:19 schrieb Stefan Wahren:
> Am 26.03.20 um 13:20 schrieb Nicolas Saenz Julienne:
>> Current mode validation impedes setting up some video modes which should
>> be supported otherwise. Namely 1920x1200@60Hz.
>>
>> Fix this by lowering the minimum HDMI state machine clock to pixel clock
>> ratio allowed.
>>
>> Fixes: 32e823c63e90 ("drm/vc4: Reject HDMI modes with too high of clocks")
>> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> ---
>>  drivers/gpu/drm/vc4/vc4_hdmi.c | 20 ++++++++++++++++----
>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> index cea18dc15f77..340719238753 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -681,11 +681,23 @@ static enum drm_mode_status
>>  vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
>>  			    const struct drm_display_mode *mode)
>>  {
>> -	/* HSM clock must be 108% of the pixel clock.  Additionally,
>> -	 * the AXI clock needs to be at least 25% of pixel clock, but
>> -	 * HSM ends up being the limiting factor.
>> +	/*
>> +	 * As stated in RPi's vc4 firmware "HDMI state machine (HSM) clock must
>> +	 * be faster than pixel clock, infinitesimally faster, tested in
>> +	 * simulation. Otherwise, exact value is unimportant for HDMI
>> +	 * operation." This conflicts with bcm2835's vc4 documentation, which
>> +	 * states HSM's clock has to be at least 108% of the pixel clock.
>> +	 *
>> +	 * Real life tests reveal that vc4's firmware statement holds up, and
>> +	 * users are able to use pixel clocks closer to HSM's, namely for
>> +	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
>> +	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
> s/RPi0-3/bcm2835/ ?
>
> Beside this nit:
>
> Tested-by: Stefan Wahren <stefan.wahre@i2se.com>
>
> Thanks

Sorry typo in the mail address:

stefan.wahren@i2se.com

