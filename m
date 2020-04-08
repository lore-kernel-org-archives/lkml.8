Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488FDC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DB820730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586315705;
	bh=tJ1Hg9pk+pGor4vfzjsuhm82oemxgV81E6FGH9Fqlj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=utJRDrIGcu+tMolX9zG/CO71bkWk/NGPdg9PW8IIwnFm0lwoVGBqQ3gj1BSJG0AAs
	 0jF5ZHhpJsTqMNEZX7txK7zdp19aj3R90yc7+PelBsSHZgTZGA1psx1ndnszedyJup
	 9vEWL/OVcU0Lo7/QTDadrlS55aQPk2f8gE5RxheA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDHDPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:15:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42581 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDHDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:15:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id s13so3987008lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=az2sCBqHUEAw3ueI0a9zrJDzRaG8GZZBQbnmAG/MSZ4=;
        b=FglOBtsNuLq+9GUpr/NY/r5GUPdDlvwYlg/tbeOzEec4q0XyXYKwy52RCXUcXpPDaf
         uuZhdH9FQL3hZa384XMQhKS8IfoixmWL1SmoOyCkNNfdFHdekQDtOcGMtihZUM/E4b1+
         sa0pwFzO9ISDjuBzkEVhtwRBTppJfMRC8j2C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=az2sCBqHUEAw3ueI0a9zrJDzRaG8GZZBQbnmAG/MSZ4=;
        b=MWBC9wlHYrM9IHoEqo3zJ2qyMOk08W2gwNhDtdfCiTqKOorHQtDlRt5Jsk9SM8mrsM
         FVMT2Dxi47IRVEw065nF3Ljz/3ypdZTddt0ynsk8CwtYXfK8ePDFD+8aSgCy0AXDLxJN
         FM3UdDolvYpsJpFMASS88hBJdjA60ZXbF+H8zPq8RE6/RmehMHDz6iZmHJ1pcrL0N7gw
         /aZPxo8rUgFhgorzNtjYAd56ggdQ5g+JoVLB+8h0yRmaVwNg1i0jbK4KPIhs1/ip1b3/
         IZtwGO29H96mWImtGx3PZFwogaGq9iQCc1imCESDFANsEwUz3z5ljUJ263jImMCgUNM3
         DfNQ==
X-Gm-Message-State: AGi0PuaQnuvLsWPXS+R0VUwEPSI+WZAdEpST0/JLvjQo1nmAmz9zM2Mp
        9FQe9klCY2AVB41jE2TgY1CsoQ5vIP4=
X-Google-Smtp-Source: APiQypIrHc2fYOun6STp5cJpkr2VDxqqXya1UfFnR920sAVsMJAIJjEyPBxLLHqnHd56shFIRNKElA==
X-Received: by 2002:ac2:414f:: with SMTP id c15mr3201225lfi.2.1586315700146;
        Tue, 07 Apr 2020 20:15:00 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q30sm17589640lfn.18.2020.04.07.20.14.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 20:14:58 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v16so6034909ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 20:14:58 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr3602189ljm.201.1586315697874;
 Tue, 07 Apr 2020 20:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
In-Reply-To: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 20:14:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkEYLViZ6zBLaWaiTXZ4RqcR4DHkkY_PKJZ2-0HAX_Pw@mail.gmail.com>
Message-ID: <CAHk-=wjkEYLViZ6zBLaWaiTXZ4RqcR4DHkkY_PKJZ2-0HAX_Pw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.7-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 4:26 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.7-rc1

Ho humm.

This caused a conflict between commit

  f12e4f66ab6a ("thermal/cpu-cooling: Update thermal pressure in case
of a maximum frequency capping")

that came in through the scheduler updates from Ingo Molnar, and commit

  ff44f672d741 ("thermal/drivers/cpufreq_cooling: Fix return of
cpufreq_set_cur_state")

from the thermal tree.

The conflict wasn't complicated, but the reason I mention it is that I
resolved it in a way that neither of those commits had done.

In particular, the thermal tree did

  ret = freq_qos_update_request(..)
  return ret < 0 ? ret : 0;

where that whole "return negative or zero" logic is new (it used to
return positive values, the fix was to return zero instead).

The scheduler tree did

  ret = freq_qos_update_request(..)
  if (ret > 0) {.. do thermal pressure thing ..}
  return ret;

which obviously still returns that positive value.

My resolution to the conflict was to not take that return with a
conditional operation, but instead just add a

  ret = 0;

to inside that thermal pressure if-statement, and avoid returning a
non-zero positive value that way.

I just wanted both sides to be aware of my non-traditional merge
resolution, and take a look.

               Linus
