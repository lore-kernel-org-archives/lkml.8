Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4CCC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7120752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L3V4zgLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgEFNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728738AbgEFNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:50:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A1C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:50:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so2695144wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=I/qG/Ox9dCbdx5Qwe5iyaFRLkkPugTYpk411h+gVkoI=;
        b=L3V4zgLgR3PEs4EfZbCdU/LZ6RsghbYvTAgfaDCCQS5tt5+XvqAR3zlTPxnSzV7/tm
         IjcJAwPeyneoAtS3npxUG/3wsZyKdf7/Y2z2V+UEf0MIHgrB11T/6mC89nq6cC+L8fXr
         lNoFeKxvIytrvvbCIW+ZBLrd2ldiwYmgnhM9l6TzsiV3KdzfdflEoLzFzzOp0PSGewfe
         1zDcytVUzXM4pdZbPRPfXQareLPB2SygRzfgA/hajBRCiWFj3bkwHZtLITbBoRSBsBMj
         NgJ52EtnXNnQMGSVfKsHb0bKp6DyODz42UmSUN8cryQZydwPlqOFVu1E71HXpuNVHnrM
         KYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=I/qG/Ox9dCbdx5Qwe5iyaFRLkkPugTYpk411h+gVkoI=;
        b=eQQxJ1jNCHkPJK460W7zp4tk8Ay17+bhAVhAPaVUmVH9429DNPgtrbUqYgRe3btBdE
         akm/E0ZAAype0ZHbEJ8WxcvOWQ4P1W6pWvDt3Va0OixNv3XqNlCUQNiQS9aNEk/UIcrQ
         g6lTrEoItAsb5Yyfm1cmw0NKSScZ1WXkDT3DwVdcNa2zLACEQ+aaZZm98hsWn5TGmhkh
         qU5t4gsPR5KbLp+irAH/6ZslmDL6PolTsMQ9cLCUGiW0Oc8SvjC+XG4RdiWwG0ysuEWP
         wUiGEG4HiqhDeYBPrgdXF6TjAaedtYf5nZKvJ5+8VQ6IGDEfd0shUvxdIZSDZMNFevbu
         ezOQ==
X-Gm-Message-State: AGi0PubKD8L9QdU6v3wfeJQ/Uwgn6pDq6dxADApxNZtfatL2G7ha1cUN
        yVzmvpSGB9p/vRDCsjsA/jLGEQ==
X-Google-Smtp-Source: APiQypJYkQsg7V5Lp/ORrO0FfGs/HMwOchKbXYQOh9lEmsS29K376blp3Us4qv4u4RPPv/hkLROiZw==
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr4385872wmf.141.1588773049725;
        Wed, 06 May 2020 06:50:49 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id n6sm2939428wrs.81.2020.05.06.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 06:50:48 -0700 (PDT)
References: <20200122092526.2436421-1-jbrunet@baylibre.com> <6f661498f58c6a519095d0657413f4b89d3ef21e.camel@pengutronix.de> <1jimi2tqsn.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: meson: add gxl internal dac reset
In-reply-to: <1jimi2tqsn.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 06 May 2020 15:50:47 +0200
Message-ID: <1jy2q5f9zc.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 14 Apr 2020 at 10:28, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Thu 23 Jan 2020 at 11:13, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
>> On Wed, 2020-01-22 at 10:25 +0100, Jerome Brunet wrote:
>>> Add the reset line of the internal DAC found on the amlogic gxl SoC family
>>> 
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>  include/dt-bindings/reset/amlogic,meson-gxbb-reset.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>>> index ea5058618863..883bfd3bcbad 100644
>>> --- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>>> +++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>>> @@ -69,7 +69,7 @@
>>>  #define RESET_SYS_CPU_L2		58
>>>  #define RESET_SYS_CPU_P			59
>>>  #define RESET_SYS_CPU_MBIST		60
>>> -/*					61	*/
>>> +#define RESET_ACODEC			61
>>>  /*					62	*/
>>>  /*					63	*/
>>>  /*	RESET2					*/
>>
>> Thank you, applied to reset/next.
>
> Hi Philip,
>
> It seems reset/next has not made it to v5.7-rc1
>
> Would it be possible to provide an immutable branch with this change, or
> maybe let Kevin apply this change through the amlogic tree ?
>
> It would allow us to progress on some DT changes during this new cycle.
>
> Thanks
> Jerome

Hi Philip, how can we move forward on this ?

>
>>
>> regards
>> Philipp

