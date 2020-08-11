Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02246C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDAA20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 05:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtnKpYG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHKFKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgHKFKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:10:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:10:42 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k12so9199180otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5+wURy/A4YDS6wY0fj6phgud0oJQCJ/wIqXX3evj+A=;
        b=rtnKpYG9jAlOJVwzxSln8VyBNjJz+m/vn647OUluBdYK1NY5fXDUCLgn2oEKaONZif
         tbTmdRM9PxEUZm+kG2N9r2ci6m8E/3g/kDZvhzSXWN+HGnJ5Ffxwfxsnwfo7PulcpF8Q
         okHQFEu/zhkWj+L4+vmpBiS7ZDNtxK2as0U+JZ8Z/rjHK0A0c/T2kB9ZqBSOExMcxB60
         lXs4EwYaZTApDk/pHrtmR0e3Kjzvx/RnCn1yVNgtLWQIY2yglzlRapH9QIB98YHUXfWZ
         rNCLfMQLA7aU1fFDTou0jij4LXwGnLXsU79wV+Ir/a0wulzaPbM9TG6Xp8pHvlDaRI/N
         fB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5+wURy/A4YDS6wY0fj6phgud0oJQCJ/wIqXX3evj+A=;
        b=mdQmiElU7Qv6tGJNbYmD4qTK+kZvCqpiNqlosCdX1FS9p4MXu7fgnsYPHxo5Gsmm6a
         6AyAJnLcY7SHheVRLlVtnm0aarvOCfjcr1peKXe2xR5Wob2VXh6ATqS1H2qxNQ/Q6uHk
         Qu5ODsYp9r7a9ts1xFPeFPJd3iEj4X0+KOuBjyG3AOzW0nIjyvKMqFTNfB6gE+z4gPZs
         gXCp1c1wZCvy9V1voBSwikeLe1ePJDrBil5Y2oqhmXizVjzeXZhtJ7c+3LGVpiz9ROTU
         IDA3yZOkniiouP9lhS06CIbhfi7338codxT7uexwgsTwIAvJ2T+yB16djE7xYWraZ6ez
         R+Yg==
X-Gm-Message-State: AOAM5310lYnsTQWVMzYgdb5bBZ5sp50p/Ha01JwG3FueLjCkcUP2RLMe
        S3dLg6CgxVeB/s+1LlzWYrihVYdupfPmbeesRYPtaQ==
X-Google-Smtp-Source: ABdhPJw1n2sMR8gGKJ8k77vVLh7KbEuxWhsMdLj6KzhGYsJhLFgzZFWS0dVXhxSZopgfBzYdBjc+kTtrhLhL8dw0glc=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr3417697otq.221.1597122641623;
 Mon, 10 Aug 2020 22:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <s5hbljocbxl.wl-tiwai@suse.de> <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
 <4f3ead7e-992e-edec-e7b4-31566fc5e583@linaro.org>
In-Reply-To: <4f3ead7e-992e-edec-e7b4-31566fc5e583@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 10 Aug 2020 22:10:30 -0700
Message-ID: <CALAqxLVn2MBp8fy6RFLfWTFNj4X4Wm4JraFWtr3k5aU38X92qw@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 5.9
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:06 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Hi John,
> Thanks for reporting this.
>
> On 08/08/2020 01:23, John Stultz wrote:
> > q6routing remoteproc-adsp:glink-edge:apr:apr-service@8:routing: ASoC:
> > error at soc_component_read_no_lock on
> > remoteproc-adsp:glink-edge:apr:: -5
>
> This is an -EIO error which is reported when the ASoC component driver
> does not have both regmap and read callback and someone is trying to
> read a register!
>
> In q6routing case all the dapm widgets reuse reg field in
> snd_soc_dapm_widget to store offset information or routing table indexs
> or some DSP related id and so on... These are not real registers.
>
> I think the core is trying to read the state of these widgets during
> startup, Which will fail in qdsp6 case as we do not have any regmap or
> read callback associated with this ASoC component.
>
> Previously we never had chance to see these messages so we did not
> implement any dummy read callback.
>
> Adding a dummy callback to q6routing and q6afe-dai ASoC component will
> fix this issue at-least in Qualcomm case!

Yea, just to confirm.  The patch you sent me privately that does the
above seems to work!

Thanks so much!
-john
