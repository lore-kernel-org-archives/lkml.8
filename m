Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1AEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E0C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pK0YzL/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGQC2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQC2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:28:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:28:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y2so8800592ioy.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwKnezkZmfj9xSK2I7Np/Cq9fStgMNgGCEPRKMrkZgg=;
        b=pK0YzL/+VoEc9RbtIE4MAdPH6e/eRtYLdOsJ17ftSBoq+EC7O8ZhuWfsLPHDHrum2c
         5+/6iKaTc+7nr4WpOApibTRbkHGe67pbIy8Wr8MnLqmdzldYIWQ562489SNqWGEXg9sY
         9PKj0RH4KB0YBotDm5jyoBdsmTFucgtBrylogM0a6D0j4aN2ELWDR6ifYCaz2NAkIzc9
         bGCLyqe7OTJWxYM1QZfHDFZ7dMasGvjiROrF1ROv4JeULqBTb+YNS4XkUsgX3Sk8oF6+
         dcja/vjVwcoPV2z1wGuwyo0FqBycG2HWV16BSgJIobQhXbSgx7diq1588VJuQ/8AFOcO
         yIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwKnezkZmfj9xSK2I7Np/Cq9fStgMNgGCEPRKMrkZgg=;
        b=a69JRuG76WmXxCncTkUPicvl0HB6mga/dhq2REZmAPOr7gW0WC9dY9h2aI7BvztxS9
         LKxel+xkmFSVQ+qqJfrdFUrqWKZIFJlAnKWD39lz/02XlGuwO5xyKrQSBnPpmvDJqU3I
         ravONPPn1RjZenJNP6xO7eFFMLs5ZLPymN5gPM91zPErBi7l5LXHqS3pc5WtOcqeoeQM
         44tu9w5NtfsKxK95CTma0/E+cJzBU+rjv/Gu5ozxrPT2m09PTE8W6VgTQfZKRLDc8Um5
         kaxjBt+k/4HnbKj72IUMM6nrT1O9Qc1rPuKMHRv0N4M9sWZdbmFUcpq9u08PbcguuiRI
         YwPg==
X-Gm-Message-State: AOAM5318tlrxsz3UNXmuxqt5KcRPBmLbqBWXghkifFHfPmT0JDy8TBnT
        z3VKmBRKPouZerzal4sleSf6oY/ZoPM6A/JfNVenEg==
X-Google-Smtp-Source: ABdhPJwA/sVne09DkT+LeHF8Jc0F1elpnQ4UzEIOk1KUc0aKKTxI2tLk0/2H+Qv+UAbF+LC1ffXV/3jL+0/3EGvt9Ws=
X-Received: by 2002:a6b:d301:: with SMTP id s1mr7361674iob.146.1594952882572;
 Thu, 16 Jul 2020 19:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <f2ca985f-7dbd-847a-1875-dd0e1044ef02@gmail.com>
In-Reply-To: <f2ca985f-7dbd-847a-1875-dd0e1044ef02@gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 17 Jul 2020 10:27:51 +0800
Message-ID: <CA+Px+wU1S1EqtW-yZH9z9aCF3ggSriBqy73SRYy8q61x0GkdQQ@mail.gmail.com>
Subject: Re: Speaker pops with max98357a on rk3399-gru-kevin since v5.7
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 7:49 PM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
> I have been getting "pop" sounds from the speaker on my rk3399-gru-kevin
> for a while, and bisected it to 128f825aeab7 ("ASoC: max98357a: move
> control of SD_MODE to DAPM"), but looks like the pops were somewhat
> expected:

I am not convinced the pop comes from 128f825aeab7.

> As of v5.8-rc5 I'm still getting the speaker pops. More info below, but
> not all pops coincide with "set sdmode" messages, and vice versa.
> Reverting that commit stops the pops, but then the "Speakers Switch" can
> no longer mute the speakers.

(I don't have a rk3399-gru-kevin so I got another test machine with MAX98357A.)
(I was testing with and without an audio server.)
Observations:
- I can hear the pop either with or without 128f825aeab7 (with and
without sdmode-delay).
- The pop noise is not always.  Higher probability after stopping
playback than before starting.
- As you also mentioned, the pop noise is not directly related to
SD_MODE transition.
