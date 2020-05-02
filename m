Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF762C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD94C21835
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YJr5Y8af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgEBOwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgEBOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:52:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA21C061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 07:52:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so3233223wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=eUmO9lFyYnSEUotvSkDdW7nX84l9YUGsDR7MyoCN3CU=;
        b=YJr5Y8afBHWlluBWUgx/5EYN6hyE6dcLw2z1n9vRkLHzQbpSGBhpcOfqygIy3U0gu3
         ZU0X0/T6IEfb9apK8ibAiOkQJB8QlmXhpHVMRe9jOCvalPLCRrcDaDdUz7BHVGmDsBdG
         u0quqzJnaF5I8H1s35iZ55qzUq6QYCjn4YnQcYk32wqe6fgKXVJnpcLkiex+yTPHan9n
         mVgx3/aJ99LjjauFWmgwTQallkMJgpWyd89bUQVy+MrLy5YJ3z9ta+ZgPG+Kt5yzEzD+
         h/CVwqzTMwVfGsIiYzVW3V/WuilTmu0Zdf20RW+WSqc2FJpiUV/KjciIkYOVE8Y0RaLJ
         nMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=eUmO9lFyYnSEUotvSkDdW7nX84l9YUGsDR7MyoCN3CU=;
        b=NzzM/oSkkWQ+HzMQ8CvraLfNv29oTiihUuQhOYngK2S01xW+eLmFhM8h//2laDXCLw
         FvtIG6Wrwpca1+ryymiCendNf2VrQXVXcTals8XgvIzBXvOMAnUj+fd28VFo0uQb1CC2
         Y0kClrLUUKR2ottLRJNa1tPHL18vlJPabvL7vhj7MzBFmgDUcZw47zWS/jWswiFj5/Gb
         6hcKd+hQFmbJUl3HpkglsVlDXe/oypsYADuDuZSM97lRl3HxJQR4Quo/Rd65PiHp4VKl
         3lJPUm9c2MlsHu2z6pEqYF8bpoSZQ/IP1RseDeOrjDlsNwBfvK02XdFZU35xUVvQ8Jbb
         tG2Q==
X-Gm-Message-State: AGi0Puak4ILtPRv5CME96o2IPhclWRYA5f719/NhsN0AXzt0RFWiTtd6
        ivzRoHq2FmDTncQ7fNZi2cfn7g==
X-Google-Smtp-Source: APiQypLQZrhbbLoB4l9/FVLUeKO9DpS30JZtXUoebbOs+GhYQzJCdHKM8cIDEnbn665XnkBqaQKeSA==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5212531wmb.155.1588431136061;
        Sat, 02 May 2020 07:52:16 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id 92sm10023040wrm.71.2020.05.02.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 07:52:15 -0700 (PDT)
References: <5eabecbf.1c69fb81.2c617.628f@mx.google.com> <cc10812b-19bd-6bd1-75da-32082241640a@collabora.com> <20200501122536.GA38314@sirena.org.uk> <20200502134721.GH13035@sasha-vm> <20200502140908.GA10998@kroah.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci@groups.io, Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: stable-rc/linux-5.4.y bisection: baseline.dmesg.alert on meson-g12a-x96-max
In-reply-to: <20200502140908.GA10998@kroah.com>
Date:   Sat, 02 May 2020 16:52:14 +0200
Message-ID: <1jd07mie3l.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 02 May 2020 at 16:09, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Sat, May 02, 2020 at 09:47:21AM -0400, Sasha Levin wrote:
>> On Fri, May 01, 2020 at 01:25:36PM +0100, Mark Brown wrote:
>> > On Fri, May 01, 2020 at 12:57:27PM +0100, Guillaume Tucker wrote:
>> > 
>> > > The call stack is not the same as in the commit message found by
>> > > the bisection, so maybe it only fixed part of the problem:
>> > 
>> > No, it is a backport which was fixing an issue that wasn't present in
>> > v5.4.
>> > 
>> > > >   Result:     09f4294793bd3 ASoC: meson: axg-card: fix codec-to-codec link setup
>> > 
>> > As I said in reply to the AUTOSEL mail:
>> > 
>> > | > Since the addition of commit 9b5db059366a ("ASoC: soc-pcm: dpcm: Only allow
>> > | > playback/capture if supported"), meson-axg cards which have codec-to-codec
>> > | > links fail to init and Oops:
>> > 
>> > | This clearly describes the issue as only being present after the above
>> > | commit which is not in v5.6.
>> > 
>> > Probably best that this not be backported.
>> 
>> Hrm... But I never queued that commit... I wonder what's up.
>
> I saw the Fixes: tag, but missed the changelog text.  My fault.
>
> I'll go drop it from everywhere, sorry about that.
>
> greg k-h

Hi everyone,

Sorry for the mess this seems to have triggered.

Indeed, with the Fixes tag, I understand why the patch has been picked
up. Even I thought that a backport would be OK, since the mistake was
quite old.

If I had wrote it correctly from the start, I would have found the
problem that was waiting for us in ASoC ... but the 2 errors cancelled
each other out.

It is only now that ASoC has been fixed that we found my mistake.

Again, sorry for the mess.
Thanks a lot for your time and effort on this
